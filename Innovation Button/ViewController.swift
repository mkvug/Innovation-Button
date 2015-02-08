//
//  ViewController.swift
//  Innovation Button
//
//  Created by Chris Neigh on 2/6/15.
//  Copyright (c) 2015 Chris Neigh. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var innovativeIdeas: UILabel!
    
    var audioPlayer = AVAudioPlayer()
    
    let innovationSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("innovation", ofType: "mp3")!)
    let url = NSURL(string: "http://www.innovationbutton.com/?innovation=1")
    let countURL = NSURL(string: "http://www.innovationbutton.com/json")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: innovationSound, error: nil)
        audioPlayer.prepareToPlay()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playInnovationClip(sender: AnyObject) {
        audioPlayer.play()
        
        let request = NSURLRequest(URL: url!)
        let connection = NSURLConnection(request: request, delegate:nil, startImmediately: true)
        let countRequest = NSURLRequest(URL: countURL!)

        NSURLConnection.sendAsynchronousRequest(countRequest, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
            let json = JSON(data: data)
            let count = json["count"].stringValue
            
            self.innovativeIdeas.text = "\(count) Innovative Ideas"
        }
    }
}

