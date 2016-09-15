//
//  SettingsViewController.swift
//  TipCal
//
//  Created by Surbhi Singhal on 9/14/16.
//  Copyright © 2016 Surbhi Singhal. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultPercentageSelectSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let defaultPercentage = defaults.integerForKey("user_selected_index")
        
        defaultPercentageSelectSegment.selectedSegmentIndex = defaultPercentage


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

     @IBAction func onTap(sender: AnyObject) {
     }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func settingsOnTap(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(defaultPercentageSelectSegment.selectedSegmentIndex, forKey: "selected_index")
        
        defaults.synchronize()
    }

}
