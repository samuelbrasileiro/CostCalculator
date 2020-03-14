//
//  SystemTableViewCell.swift
//  Cost Calculator
//
//  Created by Samuel Brasileiro on 12/03/20.
//  Copyright © 2020 Samuel Brasileiro. All rights reserved.
//

import UIKit

class SystemTableViewCell: UITableViewCell, UITextFieldDelegate{
    
    @IBOutlet var icone: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var textField: UITextField!
    
    override func awakeFromNib() {
        icone.layer.masksToBounds = false
        icone.layer.backgroundColor = CGColor(srgbRed: 158/256, green: 189/256, blue: 221/256, alpha: 1)
        icone.layer.cornerRadius = self.icone.frame.height/4
        icone.clipsToBounds = true
        textField.delegate = self
        textField.keyboardType = UIKeyboardType.decimalPad
        textField.addDoneButtonToKeyboard(myAction: #selector(self.textField.resignFirstResponder))
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension UITextField{
    
    func addDoneButtonToKeyboard(myAction:Selector?){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Retornar", style: UIBarButtonItem.Style.done, target: self, action: myAction)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
}
