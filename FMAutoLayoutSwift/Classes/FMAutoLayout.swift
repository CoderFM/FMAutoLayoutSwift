//
//  FMAutoLayout.swift
//  SwiftSQLite
//
//  Created by 周发明 on 17/6/20.
//  Copyright © 2017年 周发明. All rights reserved.
//

import Foundation
import UIKit

public class FMConstraintMaker: NSObject {
    
    var currentMakerView: UIView
    
    init(currentView: UIView) {
        currentView.translatesAutoresizingMaskIntoConstraints = false
        self.currentMakerView = currentView
    }
    
    public lazy var left: FMCMAttributes = {
        return FMCMAttributes(attribute: .left, current: self.currentMakerView)
    }()
    
    public lazy var right: FMCMAttributes = {
        return FMCMAttributes(attribute: .right, current: self.currentMakerView)
    }()
    
    public lazy var top: FMCMAttributes = {
        return FMCMAttributes(attribute: .top, current: self.currentMakerView)
    }()
    
    public lazy var bottom: FMCMAttributes = {
        return FMCMAttributes(attribute: .bottom, current: self.currentMakerView)
    }()
    
    public lazy var width: FMCMAttributes = {
        return FMCMAttributes(attribute: .width, current: self.currentMakerView)
    }()
    
    public lazy var height: FMCMAttributes = {
        return FMCMAttributes(attribute: .height, current: self.currentMakerView)
    }()
    
    public lazy var center: FMCMAttributes = {
        return FMCMAttributes(attribute: .center, current: self.currentMakerView)
    }()
    
    public lazy var centerX: FMCMAttributes = {
        return FMCMAttributes(attribute: .centerX, current: self.currentMakerView)
    }()
    
    public lazy var centerY: FMCMAttributes = {
        return FMCMAttributes(attribute: .centerY, current: self.currentMakerView)
    }()
    
    public lazy var size: FMCMAttributes = {
        return FMCMAttributes(attribute: .size, current: self.currentMakerView)
    }()
    
    public lazy var edge: FMCMAttributes = {
        return FMCMAttributes(attribute: .edge, current: self.currentMakerView)
    }()
}

public class FMConstraintMakerConstruction: NSObject {
    
    var currentView: UIView
    
    init(_ currentView: UIView) {
        self.currentView = currentView
    }
    
    private static let fm_association = ObjectAssociation<NSObject>()
    
    var isUpdateConstraint: Bool {
        get {
            return (FMConstraintMakerConstruction.fm_association[self] as! Bool)
        }
        set {
            FMConstraintMakerConstruction.fm_association[self] = newValue as NSObject?
        }
    }
    
    public func makeConstraint(constraint: (FMConstraintMaker) -> ()) -> Void {
        if self.currentView.superview == nil {
            fatalError(String(format: "%@ is no superView, please first add to superView", self.currentView))
        }
        self.isUpdateConstraint = false
        constraint(FMConstraintMaker(currentView: self.currentView))
    }
    
    public func updateConstraint(constraint: (FMConstraintMaker) -> ()) -> Void {
        self.isUpdateConstraint = true
        constraint(FMConstraintMaker(currentView: self.currentView))
    }
    
    public func removeConstraint() -> Void {
        self.currentView.removeConstraints(self.currentView.constraints)
        var rmCons = [NSLayoutConstraint]()
        for cons in (self.currentView.superview?.constraints)! {
            if ((cons.firstItem as? UIView == self) || (cons.secondItem as? UIView == self)) {
                rmCons.append(cons)
            }
        }
        self.currentView.superview?.removeConstraints(rmCons)
    }
}

public extension UIView {
    
    private static let fm_maker_association = ObjectAssociation<NSObject>()
    
    var fm_maker: FMConstraintMakerConstruction {
        if (UIView.fm_maker_association[self] as? FMConstraintMakerConstruction) != nil {
            return (UIView.fm_maker_association[self] as! FMConstraintMakerConstruction)
        }
        let maker = FMConstraintMakerConstruction(self)
        UIView.fm_maker_association[self] = maker
        return maker
    }
    
    var fm_left: FMCMATarget {
        return FMCMATarget(target: self, attribute: .left)
    }
    
    var fm_right: FMCMATarget {
        return FMCMATarget(target: self, attribute: .right)
    }
    
    var fm_top: FMCMATarget {
        return FMCMATarget(target: self, attribute: .top)
    }
    
    var fm_bottom: FMCMATarget {
        return FMCMATarget(target: self, attribute: .bottom)
    }
    
    var fm_width: FMCMATarget {
        return FMCMATarget(target: self, attribute: .width)
    }
    
    var fm_height: FMCMATarget {
        return FMCMATarget(target: self, attribute: .height)
    }
    
    var fm_center: FMCMATarget {
        return FMCMATarget(target: self, attribute: .center)
    }
    
    var fm_centerX: FMCMATarget {
        return FMCMATarget(target: self, attribute: .centerX)
    }
    
    var fm_centerY: FMCMATarget {
        return FMCMATarget(target: self, attribute: .centerY)
    }
    
    var fm_size: FMCMATarget {
        return FMCMATarget(target: self, attribute: .size)
    }
    
}

public final class ObjectAssociation<T: AnyObject> {
    
    private let policy: objc_AssociationPolicy
    
    public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        
        self.policy = policy
    }

    public subscript(index: AnyObject) -> T? {
        
        get { return objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as! T? }
        
        set { objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, policy) }
    }
}

