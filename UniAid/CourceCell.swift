//
//  CourceCell.swift
//  UniAid
//
//  Created by igor epshtein on 2016-03-23.
//  Copyright © 2016 igor epshtein. All rights reserved.
//

import UIKit

class CourceCell: UITableViewCell {
    @IBOutlet var courseName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        let view = UIView()
        view.backgroundColor = UIColor.orangeColor()
        selectedBackgroundView = view
        
        
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
