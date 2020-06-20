//
//  FMCMEnum.swift
//  FMAutoLayout
//
//  Created by 郑桂华 on 2019/9/14.
//  Copyright © 2019 周发明. All rights reserved.
//

import Foundation
import UIKit

// MARK 与目标控件的关系
enum FMCMVRelation {
    case FatherAndSon // 父子
    case SonAndFather // 子父
    case Equative // 相同等级
    case BeMySelf // 就是自己
    case Unrelated // 不是上面的任何情况
}

// MARK 与目标控件的关系
public enum FMCMRelation {
    case Equal // 等于
    case LessThan // 小于等于
    case MoreThan // 大于等于
    
    func ConstraintRelation() ->  NSLayoutConstraint.Relation{
        switch self {
        case .Equal:
            return .equal
        case .LessThan:
            return .lessThanOrEqual
        case .MoreThan:
            return .greaterThanOrEqual
        }
    }
}


enum FMCMAttribute: Int {
    
    case left, right, top, bottom, width, height, center, centerX, centerY, size, edge
    
    func ConstraintAttr() ->  NSLayoutConstraint.Attribute{
        switch self {
        case .left:
            return NSLayoutConstraint.Attribute.left
        case .right:
            return NSLayoutConstraint.Attribute.right
        case .top:
            return NSLayoutConstraint.Attribute.top
        case .bottom:
            return NSLayoutConstraint.Attribute.bottom
        case .width:
            return NSLayoutConstraint.Attribute.width
        case .height:
            return NSLayoutConstraint.Attribute.height
        case .centerX:
            return NSLayoutConstraint.Attribute.centerX
        case .centerY:
            return NSLayoutConstraint.Attribute.centerY
        default:
            return NSLayoutConstraint.Attribute.notAnAttribute
        }
    }
}
