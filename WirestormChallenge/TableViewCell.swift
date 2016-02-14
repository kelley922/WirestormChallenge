//
//  TableViewCell.swift
//  WirestormChallenge
//
//  Created by Yaxin Liu on 2/14/16.
//  Copyright © 2016 Yaxin Liu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var smallImageView: UIImageView!
    var nameLabel: UILabel!
    var positionLabel: UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.smallImageView = UIImageView()
        self.smallImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.smallImageView)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[imageView]-8-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView": self.smallImageView]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[imageView(50)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView": self.smallImageView]))
        
        self.nameLabel = UILabel()
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.nameLabel)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[label(25)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["label": self.nameLabel]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-66-[label]-8-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["label": self.nameLabel]))
        
        self.positionLabel = UILabel()
        self.positionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.positionLabel)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[label(25)]-8-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["label": self.positionLabel]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-66-[label]-8-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["label": self.positionLabel]))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
