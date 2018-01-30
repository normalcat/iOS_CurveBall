//
//  ViewController.swift
//  CurveBall
//
//  Created by Chao-I Chen on 1/24/18.
//  Copyright © 2018 Chao-I Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var switchLabel: UILabel!
    
    @IBAction func switchButton(_ sender: UISwitch) {
        if sender.isOn == true{
            switchLabel.text = "Switch is on"
        }else{
            switchLabel.text = "Switch is off"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

