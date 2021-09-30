//
//  AppEntranceOptionViewController.swift
//  DDAR1
//
//  Created by Neel Gajjar on 4/15/21.
//

import UIKit
import AVKit

class AppEntranceOptionViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBOutlet weak var homePageImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializingElements()
        signInButton.backgroundColor = UIColor.init(red: 255/255, green: 10/255, blue: 10/255, alpha: 1)
        signInButton.layer.cornerRadius = 25.0
        signInButton.tintColor = UIColor.white
        createAccountButton.backgroundColor = UIColor.init(red: 10/255, green: 10/255, blue: 255/255, alpha: 1)
        createAccountButton.layer.cornerRadius = 20.0
        createAccountButton.tintColor = UIColor.white
        view.backgroundColor = .black
    }
    }
    
func initializingElements() {
        //Do styling for text fields here.

    }
