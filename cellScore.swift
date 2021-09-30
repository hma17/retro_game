//
//  cellScore.swift
//  DDAR1
//
//  Created by codeplus on 4/11/21.
//

import UIKit

class cellScore: UITableViewCell {

    
    @IBOutlet var songName: UILabel!
    @IBOutlet var highestScore: UILabel!
    @IBOutlet var songTitle: UIImageView!
    
    
    
    @IBOutlet var albumCov: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
