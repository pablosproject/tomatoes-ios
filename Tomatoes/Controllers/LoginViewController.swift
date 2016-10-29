//
//  LoginViewController.swift
//  Tomatoes
//
//  Created by Paolo Tagliani on 29/10/16.
//  Copyright © 2016 Tomatoes. All rights reserved.
//

import UIKit
import PKHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func loginPressed(_ sender: AnyObject) {
        guard let username = usernameTextField.text else {
            //TODO: warn user
            return;
        }
        guard let password = passwordTextField.text else {
            //TODO: warn user
            return;
        }
        
        HUD.show(.progress)
        ServiceProvider.sharedInstance.networkService.login(username: username, password: password) { success in
            HUD.hide()
            if  success {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                //TODO: warn the user that something went wrong
            }
        }
    }
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
