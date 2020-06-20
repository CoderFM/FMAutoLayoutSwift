//
//  FMCMVTarget.swift
//  FMAutoLayout
//
//  Created by 郑桂华 on 2019/9/14.
//  Copyright © 2019 周发明. All rights reserved.
//

import Foundation
import UIKit

public protocol FMCMVTarget {
    @discardableResult
    func calculate(_ currentFMCMAttributes: FMCMAttributes, relation: FMCMRelation) -> FMCMACalculate
}

extension UIView : FMCMVTarget {
    public func calculate(_ currentFMCMAttributes: FMCMAttributes, relation: FMCMRelation) -> FMCMACalculate {
        return FMCMACalculate(current: currentFMCMAttributes, targetView: self, relation: relation)
    }
}

extension FMCMATarget : FMCMVTarget {
    public func calculate(_ currentFMCMAttributes: FMCMAttributes, relation: FMCMRelation) -> FMCMACalculate {
        return FMCMACalculate(current: currentFMCMAttributes, target: self, relation: relation)
    }
}

extension CGFloat : FMCMVTarget {
    public func calculate(_ currentFMCMAttributes: FMCMAttributes, relation: FMCMRelation) -> FMCMACalculate {
        let cal = FMCMACalculate(current: currentFMCMAttributes, relation: relation)
        cal.constant(self)
        return cal
    }
}

extension Double : FMCMVTarget {
    public func calculate(_ currentFMCMAttributes: FMCMAttributes, relation: FMCMRelation) -> FMCMACalculate {
        let cal = FMCMACalculate(current: currentFMCMAttributes, relation: relation)
        cal.constant(CGFloat(self))
        return cal
    }
}

extension CGSize : FMCMVTarget {
    public func calculate(_ currentFMCMAttributes: FMCMAttributes, relation: FMCMRelation) -> FMCMACalculate {
        let cal = FMCMACalculate(current: currentFMCMAttributes, relation: relation)
        cal.size(self)
        return cal
    }
}

extension UIEdgeInsets : FMCMVTarget {
    public func calculate(_ currentFMCMAttributes: FMCMAttributes, relation: FMCMRelation) -> FMCMACalculate {
        if let target = currentFMCMAttributes.current.superview {
            let cal = FMCMACalculate(current: currentFMCMAttributes, targetView: target, relation: relation)
            cal.edge(self)
            return cal
        }
        let cal = FMCMACalculate(current: currentFMCMAttributes, hasConstant: true)
        return cal
    }
}
