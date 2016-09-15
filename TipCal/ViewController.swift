//
//  ViewController.swift
//  TipCal
//
//  Created by Surbhi Singhal on 9/13/16.
//  Copyright © 2016 Surbhi Singhal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var splitLabel: UILabel!
    
    @IBOutlet weak var splitSlider: UISlider!
    
    @IBOutlet weak var numSplitLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let defaultPercentage = defaults.integerForKey("selected_index")
        
        tipSegmentControl.selectedSegmentIndex = defaultPercentage
        
        calculateTip(NSNull)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapdone(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        let tipPercentages = [0.15, 0.20, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipSegmentControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        calculateSplit(sender)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(tipSegmentControl.selectedSegmentIndex, forKey: "user_selected_index")
        
        defaults.synchronize()
        
        
    }
    
    @IBAction func calculateSplit(sender: AnyObject) {
        let numberOfSplit = Int(splitSlider.value)
        
        var way = "ways"
        
        if numberOfSplit == 1 {
            way = "way"
        }
        
        numSplitLabel.text = String(format: "%d " + way, numberOfSplit)
        
        let totalText = totalLabel.text!
        let totalTextAmt = String(totalText.characters.dropFirst())
        let totalAmt = Double(totalTextAmt) ?? 0
        let splitVal = Double(totalAmt/Double(numberOfSplit))
        
        splitLabel.text = String(format: "$%.2f", splitVal)
        
        
        
    }

}

