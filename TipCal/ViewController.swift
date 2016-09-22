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
    
    @IBOutlet var firstView: UIView!
    
    var currencyFormatter: NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter
    }
    
    var totalBill:Double = 0.0
    var billAmt:Double = 0.0
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let defaultPercentage = defaults.integerForKey("selected_index")
        
        tipSegmentControl.selectedSegmentIndex = defaultPercentage
        
        calculateTip(NSNull)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billField.becomeFirstResponder();
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func encodeRestorableStateWithCoder(coder: NSCoder) {
        super.encodeRestorableStateWithCoder(coder)
        coder.encodeDouble(billAmt,forKey:"bill")
    
    }
    
    override func decodeRestorableStateWithCoder(coder: NSCoder) {
        super.decodeRestorableStateWithCoder(coder)
        billField.text = String(coder.decodeDoubleForKey("bill"))
        
    }

    @IBAction func tapdone(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onPercentageChange(sender: AnyObject) {
        view.endEditing(true)
        calculateTip(NSNull)
    }
    @IBAction func calculateTip(sender: AnyObject) {
        let tipPercentages = [0.15, 0.20, 0.25]
        billAmt = Double(billField.text!) ?? 0
        let tip = billAmt * tipPercentages[tipSegmentControl.selectedSegmentIndex]
        let total = billAmt + tip
        totalBill = total
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)
        totalLabel.text = currencyFormatter.stringFromNumber(total)
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
        
        let splitVal = Double(totalBill/Double(numberOfSplit))
        
        splitLabel.text = currencyFormatter.stringFromNumber(splitVal)
        
    }
}

