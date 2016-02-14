//
//  ViewController.swift
//  WirestormChallenge
//
//  Created by Yaxin Liu on 2/14/16.
//  Copyright © 2016 Yaxin Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSURLSessionDelegate {
    
    var coreTableView: UITableView!
    var coreTableViewData: [AnyObject] = []
    var coreTableViewCellIdentifier = "tableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.coreTableView = UITableView(frame: CGRectZero, style: .Plain)
        self.coreTableView.delegate = self
        self.coreTableView.dataSource = self
        self.coreTableView.registerClass(TableViewCell.self, forCellReuseIdentifier: self.coreTableViewCellIdentifier)
        self.coreTableView.rowHeight = 66.0
        self.coreTableView.tableFooterView = UIView()
        self.coreTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.coreTableView)
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[tableView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["tableView": self.coreTableView]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[tableView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["tableView": self.coreTableView]))
        
        // Load tableView data
        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/wirestorm/assets/response.json")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
            if data != nil {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    if let results = json as? [AnyObject] {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.coreTableViewData = results
                            self.coreTableView.reloadData()
                        })
                    }
                }
                catch {
                    // NO JSON Data
                }
            }
            else {
                //error: HTTP Request Failed
            }
        }
        task.resume()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coreTableViewData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.coreTableViewCellIdentifier, forIndexPath: indexPath) as! TableViewCell
        cell.nameLabel.text = self.coreTableViewData[indexPath.row]["name"] as? String
        cell.positionLabel.text = self.coreTableViewData[indexPath.row]["position"] as? String
        cell.smallImageView.image = nil
        
        if let imageURLString = self.coreTableViewData[indexPath.row]["smallpic"] as? String, imageURL = NSURL(string: imageURLString) {
            let task = NSURLSession.sharedSession().downloadTaskWithURL(imageURL, completionHandler: { (url, response, error) -> Void in
                if url != nil {
                    if let data = NSData(contentsOfURL: url!) {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            cell.smallImageView.image = UIImage(data: data)
                        })
                    }
                }
            })
            task.resume()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let imageURLString = self.coreTableViewData[indexPath.row]["lrgpic"] as? String {
            let imageURL = NSURL(string: imageURLString)!
            let viewController = LargeImageViewController(imageURL: imageURL)
            self.navigationController!.pushViewController(viewController, animated: true)
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

