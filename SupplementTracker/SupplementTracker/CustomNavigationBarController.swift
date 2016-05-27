//
//  CustomNavigationBarController.swift
//  Nutriments
//
//  Created by Debbie Moon on 5/25/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import UIKit

class CustomNavigationBarController: UINavigationController{
    override func viewDidLoad() {
        self.navigationBar.barTintColor = UIColor.nutrimentsPrimaryBlue()
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
}
