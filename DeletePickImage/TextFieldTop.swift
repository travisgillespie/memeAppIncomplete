//
//  TextFieldTop.swift
//  DeletePickImage
//
//  Created by Travis Gillespie on 8/3/15.
//  Copyright (c) 2015 Travis Gillespie. All rights reserved.
//

import Foundation
import UIKit

class TextFieldTop: NSObject, UITextFieldDelegate {
//@IBOutlet weak var textFieldTop: UITextField!

//    self.textFieldTop.delegate = self
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP"{
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}