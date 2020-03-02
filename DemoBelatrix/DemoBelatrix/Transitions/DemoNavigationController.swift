//
//  AnimationNavigationController.swift
//  Demo
//
//  Created by everis on 2/28/20.
//  Copyright © 2020 everis. All rights reserved.
//

import UIKit

class DemoNavigationController: UINavigationController {

    private var navigationDelegate : DemoNavigationControllerAnimated?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationDelegate = DemoNavigationControllerAnimated()
        self.delegate = navigationDelegate
    }
}
