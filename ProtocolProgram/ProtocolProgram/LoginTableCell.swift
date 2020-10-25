//
//  LoginTableCell.swift
//  ProtocolProgram
//
//  Created by Sebastin on 21/10/20.
//  Copyright © 2020 Sebastin. All rights reserved.
//

import UIKit

protocol LoginDataSource {
    var userName: String { get }
    var password: String { get }
    var loginTitle: String { get }
    var buttonTitle: String { get }
}

protocol LoginAction {
    func loginAction()
}

protocol LoginConfiguration{
    func configureLoginDataSource() -> LoginDataSource
}

class LoginTableCell: UITableViewCell {
    
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var passwordTextFld: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var container: UIStackView!
    @IBOutlet weak var usernameTextFld: UITextField!
    
    var delegateLoginAction: LoginAction?
    var delegateLoginConfiguration: LoginConfiguration?
    
    var privacyPolicyView: PrivacyPolicy? = PrivacyPolicy.loadViewFromNib()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBAction func login(_ sender: Any) {
        delegateLoginAction?.loginAction()
    }
    
    func configureLoginModel(loginConfiguration: LoginConfiguration) {
        delegateLoginConfiguration = loginConfiguration
        guard let loginModel = delegateLoginConfiguration else {
            return
        }
        self.loginTitle.text = loginModel.configureLoginDataSource().loginTitle
        self.loginBtn.setTitle(loginModel.configureLoginDataSource().buttonTitle, for: .normal)
        self.usernameTextFld.text = loginModel.configureLoginDataSource().userName
        self.passwordTextFld.text = loginModel.configureLoginDataSource().password
        guard let privacyPolicyView =  privacyPolicyView else {
            return
        }
        privacyPolicyView.setupPrivacyPolicy(self)
        container.addArrangedSubview(privacyPolicyView)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

struct PrivacyPolicyModel: PrivacyPolicyDataSource {
    var onlinePrivacy: String
    var copyRights: String
    var legalDisclosure: String
    var accessibility: String
}

extension LoginTableCell: PrivacyPolicyDelegate {
    func getPrivatePolicyConfiguration() -> PrivacyPolicyDataSource {
        return PrivacyPolicyModel(onlinePrivacy: "online private policy", copyRights: "@2020 implemedea", legalDisclosure: "Legal disclosure", accessibility: "Accessibility")
    }   
}
