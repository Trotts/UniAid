//
//  CourseInfo.swift
//  UniAid
//
//  Created by Loai L. Felemban on 2016-04-01.
//  Copyright © 2016 igor epshtein. All rights reserved.
//
//

import UIKit

class CourseInfo: UITableViewCell {
  @IBOutlet var courseInfo: UILabel!

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