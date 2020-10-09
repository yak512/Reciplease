//
//  NavigationViewController.swift
//  Reciplease
//
//  Created by yakoub on 28/09/2020.
//  Copyright © 2020 Yakoub. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        setFont()
        super.viewDidLoad()

    }
    
    func setFont() {
        let navigation = UINavigationBar.appearance()
        let navigationFont = UIFont(name: "Chalkduster", size: 25)
        navigation.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: navigationFont!]
    }
}
