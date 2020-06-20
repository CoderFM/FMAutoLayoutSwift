//
//  ViewController.swift
//  FMAutoLayoutSwift
//
//  Created by zhoufaming251@163.com on 06/20/2020.
//  Copyright (c) 2020 zhoufaming251@163.com. All rights reserved.
//

import UIKit
import FMAutoLayoutSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view1 = UIView()
        view1.backgroundColor = UIColor.red
        self.view.addSubview(view1)
        view1.fm_maker.makeConstraint { (maker) in
//            maker.left.top.equal(self.view)
//            maker.size.equal(CGSize(width: 100, height: 100))
            maker.edge.equal(UIEdgeInsets(top: 50, left: 30, bottom: 50, right: 30))
        }
        
//        view1.fm_maker
        
//        let view2 = UIView()
//        view2.backgroundColor = UIColor.orange
//        self.view.addSubview(view2)
//        view2.fm_maker.makeConstraint { (maker) in
//            maker.left.right.bottom.equal(self.view)
//            maker.top.equal(view1.fm_bottom).constant(50)
//        }
        
//        view2.removeConstraint()
        
//        view2.fm_maker.updateConstraint { (maker) in
//            maker.top.equalTo(self.view).constant(200)
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

