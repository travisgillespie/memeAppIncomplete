//
//  MemeObject.swift
//  DeletePickImage
//
//  Created by Travis Gillespie on 8/5/15.
//  Copyright (c) 2015 Travis Gillespie. All rights reserved.
//

import Foundation
import UIKit

struct MemeObject {
    var topText : String = ""
    var bottomText : String = ""
    var image : UIImage
    var memedImage : UIImage
    
    
//TODO: move back to view controller Change code in the Activities section to reflect save() being in view controller
    func save() {

        var meme = MemeObject (topText: topText, bottomText: bottomText, image : image, memedImage : memedImage)
        println("memeObject Save Function")
        println("saveFunction \(meme.topText)")
        //Add it to the memes array on the Application Delegate

        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
//        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
        println("Save Function Invoked MemeObject:\n\(topText)\n\(bottomText)\n\(image)\n\(memedImage)")

    }
}