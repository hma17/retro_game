//
//  SigningUpViewController.swift
//  DDAR1
//
//  Created by Neel Gajjar on 4/15/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

class SigningUpViewController: UIViewController {

    @IBOutlet weak var firstNameText: UITextField!
    
    @IBOutlet weak var lastNameText: UITextField!
    
    @IBOutlet weak var emailAddressText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var createAccount: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //emailAddressText.backgroundColor = .white
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
        
        //make text fields look nicer
        let lowerUILineFirst = CALayer()
        lowerUILineFirst.frame = CGRect(x: 0, y: firstNameText.frame.height, width: firstNameText.frame.width-25, height: 2)
        lowerUILineFirst.backgroundColor = UIColor.init(red: 48/255, green: 48/255, blue: 49/255, alpha: 1).cgColor
        
        // clean up borders
        firstNameText.borderStyle = .none
        firstNameText.layer.addSublayer(lowerUILineFirst)
        
        let lowerUILineLast = CALayer()
        lowerUILineLast.frame = CGRect(x: 0, y: lastNameText.frame.height, width: lastNameText.frame.width-25, height: 2)
        lowerUILineLast.backgroundColor = UIColor.init(red: 48/255, green: 48/255, blue: 49/255, alpha: 1).cgColor
        
        // clean up borders
        lastNameText.borderStyle = .none
        lastNameText.layer.addSublayer(lowerUILineLast)
        view.backgroundColor = .gray
    }
    
    func initializingElements() {
        errorLabel.alpha = 0 //To hide "error" label in view.
        createAccount.backgroundColor = UIColor.init(red: 10/255, green: 10/255, blue: 255/255, alpha: 1)
        createAccount.layer.cornerRadius = 25.0
        createAccount.tintColor = UIColor.white
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //Ensure the data is correct or else send error.
    func confirmFields() -> String? {
        if firstNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailAddressText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Incorrect text field input"
        }
        
        return nil
    }

    @IBAction func CreateAccountPressed(_ sender: Any) {
        //Confirm fields, create user and go to the homepage
        let error = confirmFields()
        if error != nil
        {
            errorLabel.text = error!
            errorLabel.alpha = 1
        }
        else
        {
            //no errors so enter into else statement
            let first_name = firstNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let last_name = lastNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email_address = emailAddressText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email_address, password: password) { (AuthDataResult, Error) in
                if Error != nil
                {
                    //Error?.localizedDescription
                    self.errorLabel.text = "Error in creating the account"
                    self.errorLabel.alpha = 1
                }
                else
                {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["first_name" : first_name, "last_name" : last_name, "uid" : AuthDataResult!.user.uid]) { (Error) in
                        if Error != nil {
                            self.errorLabel.text = "Error in saving name of user"
                            self.errorLabel.alpha = 1
                        }
                        
                    }
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
