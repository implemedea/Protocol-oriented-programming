//
//  ViewController.swift
//  ProtocolProgram
//
//  Created by Sebastin on 17/10/20.
//  Copyright © 2020 Sebastin. All rights reserved.
//

import UIKit

struct LoginDataModel: LoginDataSource {
    var userName: String
    var password: String
    var loginTitle: String
    var buttonTitle: String
}

class ViewController: UIViewController {
    let loginCellId = "LoginTableCell"

    @IBOutlet weak var tableview: UITableView! {
        didSet {
            tableview.register(UINib(nibName: loginCellId, bundle: nil), forCellReuseIdentifier: loginCellId)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        addLoginView()
    }
    
//    func addLoginView() {
//        let loginView = LoginTableViewCell()
//        //        let loginDataSource = LoginDataSource
//        //        loginV_LoginModel(loginDataSource: LoginDataSource(buttonTitle:"adad"))
//        if let loginView = LoginTableViewCell.loadViewFromNib() {
//            self.view.addSubview(loginView)
//        }
//    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LoginTableCell = tableView.dequeueReusableCell(withIdentifier: loginCellId, for: indexPath) as! LoginTableCell
            cell.delegateLoginAction = self
            cell.configureLoginModel(loginConfiguration: self)
//            loginView.frame = CGRect(x: 0, y: 0, width: 200, height: cell.bounds.height)
            
            cell.backgroundColor = UIColor.green
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: LoginAction, LoginConfiguration {
    func loginAction() {
        
    }
    
    func configureLoginDataSource() -> LoginDataSource {
        return LoginDataModel(userName: "test", password: "test", loginTitle: "Login page", buttonTitle: "Login")
    }
}
