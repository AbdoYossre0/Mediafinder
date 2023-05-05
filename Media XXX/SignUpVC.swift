//
//  SignUpVC.swift
//  Media XXX
//
//  Created by abdoyossre on 8/18/20.
//  Copyright © 2020 abdoyossre. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var labelValidationMessage: UILabel!
    
    var gender = Gender.mail
    var user: User?
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        labelValidationMessage.isHidden = true
    }
    
    @IBAction func genderSwitch(_ sender: UISwitch) {
        if sender.isOn {
            gender = .mail
        } else {
            gender = .femail
        }
    }
    
    @IBAction func addressButton(_ sender: UIButton) {
        let mainStorebord = UIStoryboard(name: "Main", bundle: nil)
        let mapScreen = mainStorebord.instantiateViewController(withIdentifier: ViewController.mapscreen) as! MapScreen
        mapScreen.delegate = self
        self.present(mapScreen, animated: true, completion: nil)
    }
    
    @IBAction func imageButton(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    private func isVaildData() -> Bool {
        guard nameTextField.text != "" else {
            labelValidationMessage.isHidden = false
            labelValidationMessage.text = "Enter Name ??!"
            return false
        }
        
        guard emailTextField.text != "" else {
            labelValidationMessage.isHidden = false
            labelValidationMessage.text = "Enter Email ??!"
            return false
        }
        
        guard addressTextField.text != "" else {
            labelValidationMessage.isHidden = false
            labelValidationMessage.text = "Enter Address ??!"
            return false
        }
        
        guard phoneNumTextField.text != "" else {
            labelValidationMessage.isHidden = false
            labelValidationMessage.text = "Enter PhoneNum ??!"
            return false
        }
        
        guard passwordTextField.text != "" else {
            labelValidationMessage.isHidden = false
            labelValidationMessage.text = "Enter Password ??!"
            return false
        }
        return true
    }
    
    private func isValidRegax() -> Bool {
        labelValidationMessage.isHidden = true
        guard isValidEmail(email: emailTextField.text) else {
            labelValidationMessage.isHidden = false
            labelValidationMessage.text = "Enter Vaild Email !"
            return false
        }
        guard isValidPassword (password: passwordTextField.text) else {
            labelValidationMessage.isHidden = false
            labelValidationMessage.text = "Enter Vaild Password !"
//            print("Password need to be: \n at least one uppercase \n at least one digit \n at least one lowercase \n 8 characters total")
            return false
        }
        return true
    }
    
    private func goTosignInVC() {
        let mainStorebord = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = mainStorebord.instantiateViewController(withIdentifier: ViewController.signInVC) as! SignInVC
        let user = User(name: nameTextField.text!, email: emailTextField.text!, image: CodableImage(withImage: userImageView.image!), password: passwordTextField.text!, address: addressTextField.text!, gender: gender, phoneNum: phoneNumTextField.text!)
        UserDefultsManger.shared().user = user
        
//        signInVC.user = user
//        dismiss(animated: true, completion: nil)
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        if isVaildData() {
            if isValidRegax() {
                goTosignInVC()
            }
        }
    }
}

extension SignUpVC: AddressSendingDelegate {
    func sendAddress(_ address: String) {
        addressTextField.text = address
    }
}

extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImageView.contentMode = .scaleAspectFit
            userImageView.image = pickedImage
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
