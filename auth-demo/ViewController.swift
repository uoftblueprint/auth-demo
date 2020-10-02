//
//  ViewController.swift
//  auth-demo
//
//  Created by Olivia Li on 2020-10-01.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var signupFirstName: UITextField!
    @IBOutlet weak var signupLastName: UITextField!
    @IBOutlet weak var signupEmail: UITextField!
    @IBOutlet weak var signupPassword: UITextField!
    
    @IBOutlet weak var loginError: UILabel!
    @IBOutlet weak var signupError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signup(_ sender: Any) {
        register()
    }
    @IBAction func login(_ sender: Any) {
        login()
    }
    
    func register() {
        Auth.auth().createUser(withEmail: signupEmail.text!, password: signupPassword.text!) { authResult, error in
            if error != nil {
                self.signupError.text = error!.localizedDescription
            }
            else {
                AppManager.addNewUser(uid: authResult!.user.uid, firstName: self.signupFirstName.text!, lastName: self.signupLastName.text!, email: self.signupEmail.text!)
                AppManager.getCurrentUser(uid: authResult!.user.uid)
                self.performSegue(withIdentifier: "registerToWelcome", sender: nil)
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: loginEmail.text!, password: loginPassword.text!) { [weak self] authResult, error in
            if error != nil {
                self!.loginError.text = error!.localizedDescription
                print(error.debugDescription.description)
            }
            else {
                AppManager.getCurrentUser(uid: authResult!.user.uid)
                self!.performSegue(withIdentifier: "loginToWelcome", sender: nil)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        if let welcomeVC = segue.destination as? WelcomeVC {
            welcomeVC.modalPresentationStyle = .fullScreen
        }
    }
    
    
}

