//
//  FetchApiViewController.swift
//  fectchApiExample
//
//  Created by miguel toledo on 28/08/22.
//

import UIKit

class FetchApiViewController: UIViewController {
 
    private let presenter = ClientPresenter()
    

    @IBOutlet weak var getUserButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
    }
    
    @IBAction func getUserAction(_ sender: UIButton) {
        presenter.getUser()
    }
}

extension FetchApiViewController: ViewDelegate {
    func presentUser(user: UserData) {
        DispatchQueue.main.async {
            self.nameLabel.text=user.name
            self.genderLabel.text=user.gender
            self.ageLabel.text=user.age
            self.countryLabel.text=user.country
            self.emailLabel.text=user.email
            self.phoneLabel.text=user.phone
            self.idLabel.text=user.uuid
            self.userLabel.text=user.username
            self.passwordLabel.text=user.password
            self.mainImage.loadFrom(URLAddress: user.image)
        }
    }
    
    func enableGetUserButton(flag: Bool) {
        DispatchQueue.main.async {
            self.getUserButton.isEnabled = flag
        }
    }
    


}
