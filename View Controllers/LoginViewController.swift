//
//  LoginViewController.swift
//  DDAR1
//
//  Created by Neel Gajjar on 4/15/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailAddressText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        initializingElements()
        //make text fields look nicer
        let lowerUILineEmail = CALayer()
        lowerUILineEmail.frame = CGRect(x: 0, y: emailAddressText.frame.height, width: emailAddressText.frame.width-25, height: 2)
        lowerUILineEmail.backgroundColor = UIColor.init(red: 48/255, green: 48/255, blue: 49/255, alpha: 1).cgColor
        
        // clean up borders
        emailAddressText.borderStyle = .none
        emailAddressText.layer.addSublayer(lowerUILineEmail)
        
        let lowerUILinePW = CALayer()
        lowerUILinePW.frame = CGRect(x: 0, y: passwordText.frame.height, width: passwordText.frame.width-25, height: 2)
        lowerUILinePW.backgroundColor = UIColor.init(red: 48/255, green: 48/255, blue: 49/255, alpha: 1).cgColor
        
        // clean up borders
        passwordText.borderStyle = .none
        passwordText.layer.addSublayer(lowerUILinePW)
        view.backgroundColor = .gray
    }
    
    func initializingElements() {
        errorLabel.alpha = 0 //To hide "error" label in view.
        signInButton.backgroundColor = UIColor.init(red: 255/255, green: 10/255, blue: 10/255, alpha: 1)
        signInButton.layer.cornerRadius = 25.0
        signInButton.tintColor = UIColor.white

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func confirmFields() -> String? {
        if emailAddressText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please input your password and email"
        }
        
        return nil
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        //make sure text is present before logging in.
        let error = confirmFields()
        if error != nil
        {
            errorLabel.text = error!
            errorLabel.alpha = 1
        }
        else
        {
            //no errors so enter into else statement
            let email_address = emailAddressText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().signIn(withEmail: email_address, password: password) { (AuthDataResult, Error) in
                if Error != nil
                {
                    //Error?.localizedDescription
                    self.errorLabel.text = "Incorrect email or password"
                    self.errorLabel.alpha = 1
                }
                else{
                    
                    self.segueToHomePage()
                }
            }
        }
    }
    func segueToHomePage(){
        let homePageViewController = storyboard?.instantiateViewController(identifier: "HomepageView") as? TabBarController
        view.window?.rootViewController = homePageViewController
        view.window?.makeKeyAndVisible()
    }
}
