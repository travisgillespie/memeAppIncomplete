//
//  TableViewController.swift
//  DeletePickImage
//
//  Created by Travis Gillespie on 8/5/15.
//  Copyright (c) 2015 Travis Gillespie. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    var memes: [MemeObject]!

    override func viewWillAppear(animated: Bool) {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        
//        if self.memes.count == 0 {
//            performSegueWithIdentifier("segueTableToViewController", sender: self)
//        }
        
        println("tableViewController \(memes)")
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println (memes)
        println("getting the count")
        return self.memes.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCellWithIdentifier("memeObjectTableCell") as! memeObjectTableCell
        //make a subclass of UITableView http://stackoverflow.com/questions/30272253/how-to-change-custom-cells-uilabel-text
        println("object prepping for cell")
        let cell = tableView.dequeueReusableCellWithIdentifier("memesObjectTableCell", forIndexPath: indexPath) as! MemesObjectTableCell
        let specificMeme = self.memes[indexPath.row]
        
        //set the name and image
        cell.memesLabel?.text = "\(specificMeme.topText) \(specificMeme.bottomText)"
        cell.memesImage?.image = specificMeme.memedImage
        println(memes)
        
////        var memeForRow = self.memes[indexPath.row]
    return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("segueTableToViewController", sender: self)
        
        
    }
    
    @IBAction func addMemeButton(sender: AnyObject) {
        performSegueWithIdentifier("segueTableToViewController", sender: self)
    }
    
}