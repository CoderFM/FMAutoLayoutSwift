//
//  FMCMATarget.swift
//  FMAutoLayout
//
//  Created by 郑桂华 on 2019/9/14.
//  Copyright © 2019 周发明. All rights reserved.
//

import UIKit

public class FMCMATarget: NSObject {
    let target: UIView
    let attribute: FMCMAttribute
    init(target: UIView, attribute: FMCMAttribute) {
        self.target = target
        self.attribute = attribute
    }
}
