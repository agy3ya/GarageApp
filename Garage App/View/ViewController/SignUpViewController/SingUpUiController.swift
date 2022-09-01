//
//  SignUpUiController.swift
//  Garage App
//
//  Created by Ankit Singh on 02/09/22.
//

import UIKit

class SingUpUiController: NSObject {
    weak var view: SignupView? {
        didSet {
            setupAddTargets()
        }
    }
    weak var delegate: SingupUserDelegate?
    
    private func setupAddTargets() {
        self.view?.signUpButton.addTarget(self, action: #selector(didTapOnSignupButton), for: .touchUpInside)
        self.view?.loginButton.addTarget(self, action: #selector(didTapOnloginButton), for: .touchUpInside)
    }
    
    @objc private func didTapOnSignupButton() {
        if self.view?.userNameTextField.text != "" && self.view?.passwordTextField.text != "" {
            self.delegate?.signup()
        } else {
            (self.view as? UIViewController)?.showAlert(title: Constant.alert, message: Constant.enterUserDetailsErrorMsg, comletion: nil)
        }
    }
    
    @objc private func didTapOnloginButton() {
        let vc = view as? UIViewController
        vc?.presentVC(storyBoard: Constant.storyboardName, identifier: Constant.loginVCIdentifier)
    }
}


extension SingUpUiController: UserSignUpDelegate {
    func success() {
        let vc = view as? UIViewController
        (self.view as? UIViewController)?.showToast(message: Constant.SignupSuccess)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            vc?.presentVC(storyBoard: Constant.storyboardName, identifier: Constant.dashboardVCIdentifier)
        }
    }
    
    func error(message: String) {
        (self.view as? UIViewController)?.showAlert(title: Constant.alert, message: message, comletion: nil)
    }
}

protocol SingupUserDelegate: AnyObject {
    func signup()
}
