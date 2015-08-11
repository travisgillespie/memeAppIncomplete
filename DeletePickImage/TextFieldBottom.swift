//
//  TextFieldBottom.swift
//  DeletePickImage
//
//  Created by Travis Gillespie on 8/3/15.
//  Copyright (c) 2015 Travis Gillespie. All rights reserved.
//

import Foundation
import UIKit

class TextFieldBottom : NSObject, UITextFieldDelegate {
    
    //http://rshankar.com/textfieldshouldreturn-uitextfielddelegate-method-in-swift/
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}