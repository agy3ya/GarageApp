//
//  SingUpViewModel.swift
//  Garage App
//
//  Created by Ankit Singh on 02/09/22.
//

import UIKit

class SignUpViewModel: NSObject {
    weak var view: SignupView?
    weak var delegate: UserSignUpDelegate?
    var userName: String?
    var password: String?
    
    
    private func saveUserToDB() {
        guard let userName = userName else {
            return
        }
        let user = RealmManager.shared.realm.objects(User.self).filter("username == %@", userName).first
        if user != nil {
            self.delegate?.error(message: Constant.userExistErrorMesssage)
        } else {
            UserLoginManager.shared.saveUserToDB(user: User(username: self.view?.userNameTextField.text ?? "", password: self.view?.passwordTextField.text ?? ""))
            UserLoginManager.shared.currentLoggedInUserName = self.view?.userNameTextField.text
            self.delegate?.success()
        }
    }}


extension SignUpViewModel: SingupUserDelegate {
    func signup() {
        self.saveUserToDB()
    }
}


protocol UserSignUpDelegate : AnyObject {
    func success()
    func error(message: String)
}
