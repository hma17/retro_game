//
//  ChooseSongTableViewCell.swift
//  DDAR1
//
//  Created by Alex Gorman on 4/17/21.
//

import UIKit

class ChooseSongTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UIImageView!
    @IBOutlet weak var artist: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
