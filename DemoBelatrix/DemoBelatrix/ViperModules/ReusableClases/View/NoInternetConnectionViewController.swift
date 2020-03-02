//
//  NoInternetConnectionViewController.swift
//  DemoBelatrix
//
//  Created by everis on 3/2/20.
//  Copyright © 2020 everis. All rights reserved.
//

import UIKit

protocol NoIntertConnectionViewDelegate : class {
    
    func tryAgainAction()
}

class NoInternetConnectionViewController: UIViewController {

    @IBOutlet weak var tryAgainButton : UIButton!
    
    weak var delegate : NoIntertConnectionViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tryAgainButton.layer.cornerRadius = 20.0
    }

    @IBAction private func tryAgainAction(_ sender : UIButton){
        self.delegate?.tryAgainAction()
    }

}
