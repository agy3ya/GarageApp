//
//  LoginViewModel.swift
//  Garage App
//
//  Created by Ankit Singh on 02/09/22.
//

import UIKit

class LoginViewModel: NSObject {
    weak var view: LoginView?
    weak var delegate: LoginDetailsFetched?
    
    private func fetchUserFromDB() {
        let user = UserLoginManager.shared.getUser(username: self.view?.usernameTextField.text ?? "", password: self.view?.passwordTextField.text ?? "")
         if user != nil {
             UserLoginManager.shared.currentLoggedInUserName = user?.username
             self.delegate?.success()
         } else {
             self.delegate?.error()
         }
    }
}

extension LoginViewModel: FetchLoginDetails {
    func checkUser() {
        self.fetchUserFromDB()
    }
}

protocol LoginDetailsFetched: AnyObject {
    func success()
    func error()
}




