//
//  HomePageViewController.swift
//  DDAR1
//
//  Created by Neel Gajjar on 4/2/21.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var titleScreen: UIImageView!
    var homePageImage: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleScreen.image = UIImage(named:"Game Title Screen")
        view.backgroundColor = .black
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destVC = segue.destination as! ViewController
        
        destVC.titles = "Latch"
    }
    

}
