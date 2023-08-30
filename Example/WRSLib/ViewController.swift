//
//  ViewController.swift
//  WRSLib
//
//  Created by jack on 08/30/2023.
//  Copyright (c) 2023 jack. All rights reserved.
//

import UIKit
import WRSLib

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      let networkType =  NetworkType.getNetworkType().rawValue
        print("networkType:\(networkType)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

