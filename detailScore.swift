//
//  detailScore.swift
//  DDAR1
//
//  Created by codeplus on 4/11/21.
//

import UIKit

class detailScore: UIViewController {
    
    @IBOutlet var songTitle: UILabel!
    @IBOutlet weak var bestScore: UILabel!
    @IBOutlet weak var playCount: UILabel!
    
    @IBOutlet var song: UIImageView!
    @IBOutlet var albCover: UIImageView!
    
    @IBOutlet var songAvg: UILabel!
    
    var avgScore = 0
    var songName = ""
    var HScore = 0
    var timesPlayed = 0
    var picture: UIImage!
    var songPicture: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        songTitle.text = songName
        bestScore.text = String(HScore)
        let songStats = getAvgForSong(songName: songName)
        playCount.text = String(songStats.timesPlayed)
        songAvg.text = String(songStats.average)
        albCover.image = picture
        song.image = songPicture

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
