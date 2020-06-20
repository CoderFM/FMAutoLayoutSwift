//
//  FMCMACalculate.swift
//  FMAutoLayout
//
//  Created by 郑桂华 on 2019/9/14.
//  Copyright © 2019 周发明. All rights reserved.
//

import Foundation
import UIKit

// FMCMAttributesCalculate
public class FMCMACalculate: NSObject {
    
    let current: FMCMAttributes
    let target: FMCMATarget?
    let targetView: UIView?
    private var hasAttribute = false
    private var hasConstant = false
    private var relation: FMCMRelation
    private var multiplier: Float = 1.0
    
    init(current: FMCMAttributes, target: FMCMATarget, relation: FMCMRelation) {
        self.current = current
        self.target = target
        self.hasAttribute = true
        self.targetView = target.target
        self.relation = relation
    }
    
    init(current: FMCMAttributes, targetView: UIView?, relation: FMCMRelation) {
        self.current = current
        self.targetView = targetView
        self.hasAttribute = false
        self.target = nil
        self.relation = relation
    }
    
    init(current: FMCMAttributes, relation: FMCMRelation) {
        self.current = current
        self.targetView = nil
        self.target = nil
        self.hasAttribute = false
        self.relation = relation
    }
    
    init(current: FMCMAttributes, hasConstant: Bool) {
        self.current = current
        self.targetView = nil
        self.target = nil
        self.relation = .Equal
        self.hasConstant = hasConstant
    }
    
    public var constant: (CGFloat) -> Void {
        return {
            (value) in
            self.hasConstant = true
            for attr in self.current.attributes {
                self.setAttribute(attribute: attr, constant: value)
            }
        }
    }
    
    public var size: (CGSize) -> Void {
        return {
            (size) in
            self.hasConstant = true
            self.setAttribute(attribute: .width, constant: size.width)
            self.setAttribute(attribute: .height, constant: size.height)
        }
    }
    
    public var edge: (UIEdgeInsets) -> Void {
        return {
            (edge) in
            self.hasConstant = true
            self.setAttribute(attribute: .left, constant: edge.left)
            self.setAttribute(attribute: .right, constant: -edge.right)
            self.setAttribute(attribute: .top, constant: edge.top)
            self.setAttribute(attribute: .bottom, constant: -edge.bottom)
        }
    }
    
    @discardableResult
    public func multiplier(_ multiplier: Float) -> FMCMACalculate {
        self.multiplier = multiplier
        return self
    }
    
    func setAttribute(attribute: FMCMAttribute, constant: CGFloat) -> Void {
        
        let cons: NSLayoutConstraint = self.layoutConstraint(attribute: attribute, constant: constant)
        
        var change: UIView?
        switch self.viewrelation() {
        case .FatherAndSon:
            change = self.current.current
            break
        case .SonAndFather:
            change = self.current.current.superview!
            break
        case .Equative:
            change = self.current.current.superview!
            break
        case .BeMySelf:
            change = self.current.current
            break
        default:
            change = nil
            break
        }
        
        if change != nil {
            if self.current.current.fm_maker.isUpdateConstraint { // 更新约束
                let consItems = change!.constraints
                if consItems.count == 0 {
                    return
                }
                
                var changeCon: NSLayoutConstraint?
                for con in consItems {
                    if con.firstItem as! NSObject == self.current.current && con.firstAttribute == attribute.ConstraintAttr() {
                        changeCon = con
                        break
                    } else {
                        continue
                    }
                }
                
                if changeCon != nil {
                    change?.removeConstraint(changeCon!)
                    change?.addConstraint(cons)
                }
                
            } else { // 添加约束
                change!.addConstraint(cons)
            }
        }
        
    }
    
    func layoutConstraint(attribute: FMCMAttribute, constant: CGFloat) -> NSLayoutConstraint {
        let attr = attribute.ConstraintAttr()
        let relation = self.relation.ConstraintRelation()
        if self.targetView == nil && self.target == nil {
            return NSLayoutConstraint(item: self.current.current, attribute: attr, relatedBy: relation, toItem: nil, attribute: attr, multiplier: 0, constant: CGFloat(constant))
        } else {
            if self.hasAttribute {
                switch (self.target!.attribute, attribute) {
                case (.center, .centerX):
                    return NSLayoutConstraint(item: self.current.current, attribute: .centerX, relatedBy: relation, toItem: self.targetView, attribute: .centerX, multiplier: CGFloat(self.multiplier), constant: CGFloat(constant))
                case (.center, .centerY):
                    return NSLayoutConstraint(item: self.current.current, attribute: .centerY, relatedBy: relation, toItem: self.targetView, attribute: .centerY, multiplier: CGFloat(self.multiplier), constant: CGFloat(constant))
                case (.size, .width):
                    return NSLayoutConstraint(item: self.current.current, attribute: .width, relatedBy: relation, toItem: self.targetView, attribute: .width, multiplier: CGFloat(self.multiplier), constant: CGFloat(constant))
                case (.size, .height):
                    return NSLayoutConstraint(item: self.current.current, attribute: .height, relatedBy: relation, toItem: self.targetView, attribute: .height, multiplier: CGFloat(self.multiplier), constant: CGFloat(constant))
                default:
                    return NSLayoutConstraint(item: self.current.current, attribute: attr, relatedBy: relation, toItem: self.targetView, attribute: (self.target?.attribute.ConstraintAttr())!, multiplier: CGFloat(self.multiplier), constant: CGFloat(constant))
                }
            } else {
                return NSLayoutConstraint(item: self.current.current, attribute: attr, relatedBy: relation, toItem: self.targetView, attribute: attr, multiplier: CGFloat(self.multiplier), constant: CGFloat(constant))
            }
        }
    }
    
    func viewrelation() -> FMCMVRelation {
        
        if self.target == nil && self.targetView == nil {
            return .BeMySelf
        }
        
        let view1 = self.current.current
        let view2 = self.hasAttribute ? self.target?.target : self.targetView
        if view1 == view2 {
            return .BeMySelf
        }
        if view1.superview == view2 {
            return .SonAndFather
        }
        if view2?.superview == view1 {
            return .FatherAndSon
        }
        if view1.superview == view2?.superview {
            return .Equative
        }
        return .Unrelated
    }
    
    deinit {
        if !self.hasConstant {
            self.constant(0)
        }
    }
}
