//
//  DatePickerViewController.swift
//  CurveBall
//
//  Created by Chao-I Chen on 1/24/18.
//  Copyright © 2018 Chao-I Chen. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        shortLabel.text = dateFormatter.string(from: datePicker.date)
        dateFormatter.dateFormat = "MMM dd, YYYY"
        mediumLabel.text = dateFormatter.string(from: datePicker.date)
        dateFormatter.dateFormat = "MMMM dd, YYYY"
        longLabel.text = dateFormatter.string(from: datePicker.date)
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var shortLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        shortLabel.text = dateFormatter.string(from: datePicker.date)
        dateFormatter.dateFormat = "MMM dd, YYYY"
        mediumLabel.text = dateFormatter.string(from: datePicker.date)
        dateFormatter.dateFormat = "MMMM dd, YYYY"
        longLabel.text = dateFormatter.string(from: datePicker.date)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
