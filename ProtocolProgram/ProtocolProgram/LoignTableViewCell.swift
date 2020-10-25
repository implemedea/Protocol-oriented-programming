//
//  LoginViewModel.swift
//  ProtocolProgram
//
//  Created by Sebastin on 17/10/20.
//  Copyright © 2020 Sebastin. All rights reserved.
//

import UIKit

protocol LoginDataSource {
    var userName: String { get }
    var password: String { get }
    var loginTitle: String { get }
    var buttonTitle: String { get }
    var disclaimer: String { get }
}

protocol LoginAction {
    func loginAction()
}

protocol LoginConfiguration{
    func configureLoginDataSource() -> LoginDataSource
}

class LoginTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var passwordTextFld: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var usernameTextFld: UITextField!
    @IBOutlet weak var disclaimer: UILabel!
    
    var delegateLoginAction: LoginAction?
    
    @IBAction func login(_ sender: Any) {
        delegateLoginAction?.loginAction()
    }
    
    func configureLoginModel(loginConfiguration: LoginConfiguration) {
        let loginModel = loginConfiguration.configureLoginDataSource()
        self.loginTitle.text = loginModel.loginTitle
        self.loginBtn.setTitle(loginModel.buttonTitle, for: .normal)
        self.disclaimer.text = loginModel.disclaimer
        self.usernameTextFld.text = loginModel.userName
        self.passwordTextFld.text = loginModel.password
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public class func loadViewFromNib() -> LoginTableViewCell? {
          let nib = UINib(nibName: "LoignTableViewCell", bundle: nil)
          guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? LoginTableViewCell else {
              return nil
          }
          return view
      }
}
