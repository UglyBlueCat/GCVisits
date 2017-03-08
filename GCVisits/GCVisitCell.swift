//
//  GCVisitCell.swift
//  GCVisits
//
//  Created by Robin Spinks on 08/03/2017.
//  Copyright © 2017 Robin Spinks. All rights reserved.
//

import UIKit

class GCVisitCell : UITableViewCell {
    
    
    var visitNumberLabel : UILabel!
    var siteIdLabel : UILabel!
    var clientLabel : UILabel!
    var siteLabel : UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.sizeObjects()
    }
    
    /**
     Set up objects in the cell..
     Separate from sizeObjects() so it can be called from initialisers.
     */
    func setupView() {
        
        visitNumberLabel = UILabel()
        self.addSubview(visitNumberLabel!)
        
        siteIdLabel = UILabel()
        self.addSubview(siteIdLabel!)
        
        clientLabel = UILabel()
        self.addSubview(clientLabel!)
        
        siteLabel = UILabel()
        self.addSubview(siteLabel!)
    }
    
    /**
     Change the size of objects in the cell.
     These are in a separate function so they can be called from layoutSubviews()
     */
    func sizeObjects() {
        
        let margin: CGFloat = 2.0
        let cellHeight : CGFloat = bounds.size.height
        let cellWidth : CGFloat = bounds.size.width
        let labelHeight : CGFloat = cellHeight/2 - 1.5*margin
        let leftLabelWidth : CGFloat = 150.0
        let bottomLabelYPosition : CGFloat = cellHeight/2 + margin/2
        let rightLabelWidth : CGFloat = cellWidth - leftLabelWidth - 3*margin
        let rightLabelXPosition : CGFloat = leftLabelWidth + 2*margin
        
        visitNumberLabel.frame = CGRect(x: margin,
                                        y: margin,
                                        width: leftLabelWidth,
                                        height: labelHeight)
        
        siteIdLabel.frame = CGRect(x: margin,
                                   y: bottomLabelYPosition,
                                   width: leftLabelWidth,
                                   height: labelHeight)
        
        clientLabel.frame = CGRect(x: rightLabelXPosition,
                                   y: margin,
                                   width: rightLabelWidth,
                                   height: labelHeight)
        
        siteLabel.frame = CGRect(x: rightLabelXPosition,
                                 y: bottomLabelYPosition,
                                 width: rightLabelWidth,
                                 height: labelHeight)
    }
}
