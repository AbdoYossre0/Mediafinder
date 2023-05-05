//
//  ProfileVC.swift
//  Media XXX
//
//  Created by abdoyossre on 8/18/20.
//  Copyright © 2020 abdoyossre. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var user: User? = UserDefultsManger.shared().user

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
//        defaults.set(true, forKey: UserDefaultsKey.isLogedIn)
//        UserDefultsManger.shared().isLoggedIn = true
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    private func setUpData() {
        nameLabel.text = user?.name
        emailLabel.text = user?.email
        genderLabel.text = user?.gender.rawValue
        addressLabel.text = user?.address
        userImageView.image = user?.image.getImage()
        phoneNumLabel.text = user?.phoneNum
    }
    
    private func goTosignInVC() {
        let mainStorebord = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = mainStorebord.instantiateViewController(withIdentifier: ViewController.signInVC) as! SignInVC
        signInVC.user = user
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        UserDefultsManger.shared().isLoggedIn = false

//        defaults.removeObject(forKey: UserDefaultsKey.isLogedIn)
//        defaults.removeObject(forKey: UserDefaultsKey.user)
        let mainStorebord = UIStoryboard(name: "Main", bundle: nil)
        let signIn = mainStorebord.instantiateViewController(withIdentifier: ViewController.signInVC) as! SignInVC
        navigationController?.viewControllers = [signIn]
//        present(signIn, animated: true,completion: nil)
        
    }
}
