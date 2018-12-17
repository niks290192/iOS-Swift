//
//  AttachmentTableViewController.swift
//  EmailAttachment
//
//  Created by Simon Ng on 21/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit
import MessageUI

class AttachmentTableViewController: UITableViewController, MFMessageComposeViewControllerDelegate {

    let filenames = ["10 Great iPhone Tips.pdf", "camera-photo-tips.html", "foggy.jpg", "Hello World.ppt", "no more complaint.png", "Why Appcoda.doc"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return filenames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 

        // Configure the cell...
        cell.textLabel?.text = filenames[indexPath.row]
        cell.imageView?.image = UIImage(named: "icon\(indexPath.row).png");

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedFile = filenames[indexPath.row]
        sendSMS(selectedFile)
    }
    
    // MARK: - SMS Methods
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        
        switch(result.rawValue) {
        case MessageComposeResultCancelled.rawValue:
            print("SMS cancelled")
            
        case MessageComposeResultFailed.rawValue:
            let alertMessage = UIAlertController(title: "Failure", message: "Failed to send the message.", preferredStyle: .Alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alertMessage, animated: true, completion: nil)
            
        case MessageComposeResultSent.rawValue:
            print("SMS sent")
            
        default: break
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sendSMS(attachment:String) {
        
        // Check if the device is capable of sending text message
        guard MFMessageComposeViewController.canSendText() else {
            let alertMessage = UIAlertController(title: "SMS Unavailable", message: "Your device is not capable of sending SMS.", preferredStyle: .Alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alertMessage, animated: true, completion: nil)
            return
        }
        
        // Prefill the SMS
        let messageController = MFMessageComposeViewController()
        messageController.messageComposeDelegate = self
        messageController.recipients = ["12345678", "72345524"]
        messageController.body = "Just sent the \(attachment) to your email. Please check!"
        
        // Adding file attachment
        let fileparts = attachment.componentsSeparatedByString(".")
        let filename = fileparts[0]
        let fileExtension = fileparts[1]
        let filePath = NSBundle.mainBundle().pathForResource(filename, ofType: fileExtension)
        let fileUrl = NSURL.fileURLWithPath(filePath!)
        messageController.addAttachmentURL(fileUrl, withAlternateFilename: nil)
        
        // Present message view controller on screen
        presentViewController(messageController, animated: true, completion: nil)
    }

}
