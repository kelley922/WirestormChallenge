//
//  LargeImageViewController.swift
//  WirestormChallenge
//
//  Created by Yaxin Liu on 2/14/16.
//  Copyright © 2016 Yaxin Liu. All rights reserved.
//

import UIKit

class LargeImageViewController: UIViewController {
    
    var imageURL: NSURL!
    var imageView: UIImageView!
    
    convenience init(imageURL: NSURL) {
        self.init()
        self.imageURL = imageURL
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.imageView = UIImageView()
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.contentMode = .ScaleAspectFit
        self.view.addSubview(self.imageView)
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-44-[imageView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView": self.imageView]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[imageView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView": self.imageView]))
        
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        activityView.frame = UIScreen.mainScreen().bounds
        activityView.startAnimating()
        self.view.addSubview(activityView)
        
        //Load large image
        let task = NSURLSession.sharedSession().downloadTaskWithURL(self.imageURL) { (url, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                activityView.stopAnimating()
                activityView.removeFromSuperview()
            })
            if url != nil {
                if let data = NSData(contentsOfURL: url!) {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.imageView.image = UIImage(data: data)
                    })
                }
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
