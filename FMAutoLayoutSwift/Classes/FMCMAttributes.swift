//
//  FMCMAttributes.swift
//  FMAutoLayout
//
//  Created by 郑桂华 on 2019/9/14.
//  Copyright © 2019 周发明. All rights reserved.
//

import UIKit

public class FMCMAttributes: NSObject {
    var current: UIView
    init(attribute: FMCMAttribute, current: UIView) {
        self.current = current
        super.init()
        switch attribute {
        case .center:
            self.attributes.append(.centerX)
            self.attributes.append(.centerY)
            break
        case .size:
            self.attributes.append(.width)
            self.attributes.append(.height)
            break
        case .edge:
            self.attributes.append(.left)
            self.attributes.append(.right)
            self.attributes.append(.top)
            self.attributes.append(.bottom)
        default:
            self.attributes.append(attribute)
        }
    }
    
    @discardableResult
    public func equal(_ target: FMCMVTarget) -> FMCMACalculate {
        return self.toCalculate(target: target, relation: .Equal)
    }
    
    @discardableResult
    public func lessThan(_ target: FMCMVTarget) -> FMCMACalculate {
        return self.toCalculate(target: target, relation: .LessThan)
    }
    
    @discardableResult
    public func moreThan(_ target: FMCMVTarget) -> FMCMACalculate {
        return self.toCalculate(target: target, relation: .MoreThan)
    }
    
    private func toCalculate(target: FMCMVTarget, relation: FMCMRelation) -> FMCMACalculate {
        return target.calculate(self, relation: relation)
    }
    
    public lazy var left: FMCMAttributes = {
        self.attributes.append(.left)
        return self
    }()
    
    public lazy var right: FMCMAttributes = {
        self.attributes.append(.right)
        return self
    }()
    
    public lazy var top: FMCMAttributes = {
        self.attributes.append(.top)
        return self
    }()
    
    public lazy var bottom: FMCMAttributes = {
        self.attributes.append(.bottom)
        return self
    }()
    
    public lazy var width: FMCMAttributes = {
        self.attributes.append(.width)
        return self
    }()
    
    public lazy var height: FMCMAttributes = {
        self.attributes.append(.height)
        return self
    }()
    
    public lazy var center: FMCMAttributes = {
        self.attributes.append(.centerX)
        self.attributes.append(.centerY)
        return self
    }()
    
    public lazy var centerX: FMCMAttributes = {
        self.attributes.append(.centerX)
        return self
    }()
    
    public lazy var centerY: FMCMAttributes = {
        self.attributes.append(.centerY)
        return self
    }()
    
    public lazy var size: FMCMAttributes = {
        self.attributes.append(.width)
        self.attributes.append(.height)
        return self
    }()
    
    public lazy var edge: FMCMAttributes = {
        self.attributes.append(.left)
        self.attributes.append(.right)
        self.attributes.append(.top)
        self.attributes.append(.bottom)
        return self
    }()
    
    lazy var attributes: [FMCMAttribute] = {
        return [FMCMAttribute]()
    }()
}
