//
//  ViewController.swift
//  DeletePickImage
//
//  Created by Travis Gillespie on 8/3/15.
//  Copyright (c) 2015 Travis Gillespie. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var pickerImageView: UIImageView!
    @IBOutlet weak var textFieldTop: UITextField!
    @IBOutlet weak var textFieldBottom: UITextField!
    
    //text field delegate objects
    let textFieldTopDelegate = TextFieldTop()
    let textFieldBottomDelegate = TextFieldBottom()

    
    //http://databasefaq.com/index.php/answer/81969/ios-swift-cocoa-touch-uitextfield-nsforegroundcolor-turns-transparent-after-screen-rotation-swift
    //https://www.invasivecode.com/weblog/attributed-text-swift/
    let TextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 24)!,
        NSStrokeWidthAttributeName : 3.0
    ]

    
//https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UITextField_Class/index.html#//apple_ref/occ/instp/UITextField/defaultTextAttributes
//    var defaultTextAttributes: [String : AnyObject]
    
    //http://stackoverflow.com/questions/24074257/how-to-use-uicolorfromrgb-value-in-swift
    var greenColor = UIColor.greenColor()
    let appRedColor = UIColor(red: 200.0/255.0, green: 16.0/255.0, blue: 46.0/255.0, alpha: 1.0)
    let appSilverColor = UIColor(red: 236.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1.0)
    let appWhiteColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let appNavyColor = UIColor(red: 19.0/255.0, green: 41.0/255.0, blue: 75.0/255.0, alpha: 1.0)
    
    
    func textFieldLayouts(name : UITextField!, position : String, color : UIColor){
        //http://webindream.com/how-to-customise-uitextfield-swift/  customize text fields
        name.text = position
//        name.textColor = color  
        name.defaultTextAttributes = TextAttributes
        name.textAlignment = NSTextAlignment.Center
        name.autocapitalizationType = UITextAutocapitalizationType.AllCharacters

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//      centers text
      var alignText = NSTextAlignment.Center
        self.textFieldTop.delegate = textFieldTopDelegate
        self.textFieldBottom.delegate = textFieldBottomDelegate

        textFieldLayouts(textFieldTop, position:"TOP", color: greenColor)
        textFieldLayouts(textFieldBottom, position:"BOTTOM", color: appRedColor)
}

    override func viewWillAppear(animated: Bool) {
        println("start viewWillAppear")
        super.viewWillAppear(animated)
        
        //suscribe to the keyboard notifications, to allow the view to raise when necessary
        subscribeToKeyboardNotifications()
        println("end viewWillAppear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        println("start viewWillDisappear")
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        println("end viewWillDisappear")
    }

    @IBAction func pickAnImage(sender: AnyObject) {
        //http://www.codingexplorer.com/choosing-images-with-uiimagepickercontroller-in-swift/
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        self.presentViewController(pickerController, animated: true, completion: nil)
    
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[
            // TODO: Dictionary Key Goes Here
            UIImagePickerControllerOriginalImage
            ] as? UIImage{

            //resources for resizing images
            //http://nshipster.com/image-resizing/
            //http://stackoverflow.com/questions/24109114/set-contentmode-of-uiimageview
            //pickerImageView.contentMode = .ScaleAspectFit
            pickerImageView.contentMode = UIViewContentMode.ScaleAspectFill
            pickerImageView.image = pickedImage
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        println("allow editing")
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        println("began editing")

    }

    func textFieldDidEndEditing(textField: UITextField) {
        println("editing is done")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        println("enter was pressed")
        return true
    }
    
    
    func subscribeToKeyboardNotifications(){
//        println("subsribe")
//    if textFieldBottom == becomeFirstResponder(){
//        println("subsribe first responder")
        var firstResponderStatus = resignFirstResponder()
        if textFieldBottom == firstResponderStatus {
            println("keyboard is 0")
        }
        
        //http://www.andrewcbancroft.com/2014/10/08/fundamentals-of-nsnotificationcenter-in-swift/
        //http://nshipster.com/nsnotification-and-nsnotificationcenter/
        //http://stackoverflow.com/questions/25874975/cant-get-correct-value-of-keyboard-height-in-ios8
        //http://stackoverflow.com/questions/25987592/ios8-uikeyboardwillshownotification-third-party-keyboard-height
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
//    } else if textFieldBottom == resignFirstResponder() {
//        println("subsribe resign responder")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
//        }
}
    
    //Move the view when the keyboard covers the text fieldl
    func keyboardWillShow(notification: NSNotification) {
        println("start keyboardWillShow")
//        self.view.frame.origin.y -= getKeyboardHeight(notification)
        var keyboardHeight = getKeyboardHeight(notification)
        
        if keyboardHeight > 0 {
            self.view.frame.origin.y = 0
            self.view.frame.origin.y -= keyboardHeight
            println("if keyboardWillShow")
        } else {
            self.view.frame.origin.y -= keyboardHeight
            println("else keyboardWillShow")
        }
            println(self.view.frame.origin.y)
            println("end keyboardWillShow")
    }
    
    func keyboardWillHide(notification: NSNotification) {
        println("start keyboardWillHide")
//        self.view.frame.origin.y += getKeyboardHeight(notification)
        self.view.frame.origin.y = 0
        println(self.view.frame.origin.y)
        println("end keyboardWillHide")
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue //of CGRect
        println("getKeyboardHeight: userInfo -> \(userInfo) AND keyboardSize -> \(keyboardSize)")
        return keyboardSize.CGRectValue().height
    }
    
    
    func unsubscribeFromKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    //resizing??? http://stackoverflow.com/questions/31451798/new-generated-image-quality-is-low-ios-swift
    func generateMemedImage() -> UIImage {
        //TODO: hide toolbar and navbar hideToolbars()
        //render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //TODO: show toolbar and navbar showToolbars()
        
        
        return memedImage
    }

    
    @IBAction func shareMemeActivityButton(sender: UIBarButtonItem) {
        println("activity button pressed")
        
        let generatedImage = generateMemedImage()
        
        //http://www.codingexplorer.com/sharing-swift-app-uiactivityviewcontroller/
        //http://nshipster.com/uiactivityviewcontroller/
        let activityViewController = UIActivityViewController(activityItems: [generatedImage], applicationActivities: nil)

        //example of completionWithItemsHandler https://github.com/mattneub/Programming-iOS-Book-Examples/blob/master/bk2ch13p635activityView/ch26p901activityView/ViewController.swift
//                Create the meme

        
        println("check to see if Meme Object should print")
        activityViewController.completionWithItemsHandler = { (
            type: String!,
            completion: Bool,
            items: [AnyObject]!,
            err: NSError!) in
            
            if completion {
                
                //TODO: remove if statement if this print lines don't work inside
                if self.pickerImageView.image != nil {
                    println("inside completion")
                    var newMeme = MemeObject (
                        topText: self.textFieldTop.text!,
                        bottomText: self.textFieldBottom.text!,
                        image : self.pickerImageView.image!,
                        memedImage : generatedImage
                    )
                    println("saved string should print below")
//                    println(newMeme.topText)
    //              TODO: save newMeme Object
                    newMeme.save()
                    println("saved string is done")
                    self.dismissViewControllerAnimated(true, completion: nil)
//                    println(newMeme.save())
//                    println("saved string is done")
                } else {
                    
                    //TODO: romove else statement if this doesn't work
                    //alert: http://www.appcoda.com/uialertcontroller-swift-closures-enum/
                    let alertController = UIAlertController(title: "Choose A Photo", message: "don't forget the picture", preferredStyle: .Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                }

            }
            }


        println("out present view controller")
        //TODO: remove and try inside completionWithHandler
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }

}