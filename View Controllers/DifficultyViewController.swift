//
//  DifficultyViewController.swift
//  DDAR1
//
//  Created by Neel Gajjar on 4/3/21.
//

import UIKit
var difficulty: Int = 0

class DifficultyViewController: UIViewController {
    
    
    var titles: String=""
    
    @IBAction func easyPressed(_ sender: Any) {
        difficulty = 0
    }
    @IBAction func medPressed(_ sender: Any) {
        difficulty = 2
    }
    @IBAction func hardPressed(_ sender: Any) {
        difficulty = 5
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destVC = segue.destination as! ViewController
                
        
        destVC.difficulty = difficulty
        destVC.titles = titles
    }
    

}
