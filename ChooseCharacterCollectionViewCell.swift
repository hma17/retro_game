//
//  ChooseCharacterCollectionViewCell.swift
//  DDAR1
//
//  Created by Alex Gorman on 4/17/21.
//

import UIKit

class ChooseCharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var CharPic: UIImageView!
    
    @IBOutlet weak var CharName: UIImageView!
    
    override func awakeFromNib() {
                super.awakeFromNib()
                    
                // Apply rounded corners to contentView
                contentView.layer.cornerRadius = 8
                contentView.layer.masksToBounds = true
                
                // Set masks to bounds to false to avoid the shadow
                // from being clipped to the corner radius
                layer.cornerRadius = 8
                layer.masksToBounds = false
                
                // Apply a shadow
            layer.shadowRadius = 8.0
                layer.shadowOpacity = 0.19
                layer.shadowColor = UIColor.systemPink.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 5)
            }


}
