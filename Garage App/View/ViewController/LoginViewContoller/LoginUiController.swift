//
//  LoginUiController.swift
//  Garage App
//
//  Created by Ankit Singh on 02/09/22.
//

import UIKit

class LoginUIController: NSObject {
    
    weak var view: LoginView? {
        didSet {
            setupAddTargets()
        }
    }
    
    weak var delegate: FetchLoginDetails?
    
    private func setupAddTargets() {
        self.view?.signUpButton.addTarget(self, action: #selector(didTapOnSignupButton), for: .touchUpInside)
        self.view?.loginButton.addTarget(self, action: #selector(didTapOnloginButton), for: .touchUpInside)
    }
    
    @objc private func didTapOnSignupButton() {
        let vc = view as? UIViewController
        vc?.presentVC(storyBoard: Constant.storyboardName, identifier: Constant.signupVCIdentifier)
    }
    
    @objc private func didTapOnloginButton() {
        self.delegate?.checkUser()
    }
    
}

extension LoginUIController: LoginDetailsFetched {
    func success() {
        let vc = view as? UIViewController
        (self.view as? UIViewController)?.showToast(message: Constant.LoginSuccess)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            vc?.presentVC(storyBoard: Constant.storyboardName, identifier: Constant.dashboardVCIdentifier)
        }
    }
    func error() {
        (self.view as? UIViewController)?.showAlert(title: Constant.alert, message: Constant.noUserErrorMesssage, comletion: nil)
    }
}


protocol FetchLoginDetails: AnyObject {
    func checkUser()
}
    
