//
//  CityNameCell.swift
//  Weather
//
//  Created by Cat on 1/21/19.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

class CityNameCell: UITableViewCell {
  @IBOutlet weak var cityNameLabel: UILabel!
  @IBOutlet weak var roundView: UIView!
  @IBOutlet weak var rightRoundViewConstraint: NSLayoutConstraint!
  @IBOutlet weak var leftRoundViewConstraint: NSLayoutConstraint!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let radius = self.roundView.frame.height/2
    roundView.layer.cornerRadius = radius
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    cityNameLabel.textColor = UIColor.white
    rightRoundViewConstraint.constant = 50
    leftRoundViewConstraint.constant = 50
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
