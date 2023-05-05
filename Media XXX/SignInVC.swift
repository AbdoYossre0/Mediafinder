//
//  SignInVC.swift
//  Media XXX
//
//  Created by abdoyossre on 8/18/20.
//  Copyright © 2020 abdoyossre. All rights reserved.
//

import UIKit

let defaults = UserDefaults.standard

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var labelMessege: UILabel!
    
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        defaults.set(false, forKey: UserDefaultsKey.isLogedIn)
        UserDefultsManger.shared().isLoggedIn = false
        user = UserDefultsManger.shared().user
        labelMessege.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func isVaildData() -> Bool {
        
        guard emailTextField.text != "" else {
            labelMessege.isHidden = false
            labelMessege.text = "Enter Email "
            return false
        }
        
        guard passwordTextField.text != "" else {
            labelMessege.isHidden = false
            labelMessege.text = "Enter Password "
            return false
        }
        return true
    }
    
    private func isValidRegax() -> Bool {
        guard isValidEmail(email: emailTextField.text) else {
            labelMessege.isHidden = false
            labelMessege.text = "Enter Vaild Email "
            return false
        }
        guard isValidPassword (password: passwordTextField.text) else {
            labelMessege.isHidden = false
            labelMessege.text = "Enter Vaild Password "
//            print("Password need to be: \n at least one uppercase \n at least one digit \n at least one lowercase \n 8 characters total")
            
            return false
        }
        return true
    }
    
    
    private func goToSeriesVC() {
        let mainStorebord = UIStoryboard(name: "Main", bundle: nil)
        let seriesVC = mainStorebord.instantiateViewController(withIdentifier: ViewController.mediaVC) as! MediaVC
//        profileVC.user = user
        navigationController?.pushViewController(seriesVC, animated: true)
    }
    
    @IBAction func createNewAccountBtn(_ sender: UIButton) {
        defaults.removeObject(forKey: UserDefaultsKey.isLogedIn)
        defaults.removeObject(forKey: UserDefaultsKey.user)
        let mainStorebord = UIStoryboard(name: "Main", bundle: nil)
        let signUp = mainStorebord.instantiateViewController(withIdentifier: ViewController.signUpVC) as! SignUpVC
//        signUp.user = user
         navigationController?.pushViewController(signUp, animated: true)
//        present(signUp, animated: true,completion: nil)
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        if isVaildData() {
            if isValidRegax() {
                if user?.email == emailTextField.text! && user?.password == passwordTextField.text! {
                    goToSeriesVC()
                } else {
                    labelMessege.isHidden = false
                    labelMessege.text = "wrong in email or password"
                }
            }
        }
    }
}
