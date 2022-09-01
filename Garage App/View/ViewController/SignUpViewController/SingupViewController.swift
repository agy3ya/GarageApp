//
//  SingupViewController.swift
//  Garage App
//
//  Created by Ankit Singh on 01/09/22.
//

import UIKit

class SingupViewController: UIViewController , SignupView{


    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    private var signupUIController: SingUpUiController?
    private var signupViewModel: SignUpViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        self.signupUIController = SingUpUiController()
        self.signupUIController?.view = self
        self.signupViewModel = SignUpViewModel()
        self.signupViewModel?.view = self
        self.signupUIController?.delegate = signupViewModel
        self.signupViewModel?.delegate = signupUIController
        self.userNameTextField.addTarget(self, action: #selector(setUserNameInViewModel(textField:)), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(setPasswordInViewModel(textField:)), for: .editingChanged)
    }
    
    @objc func setPasswordInViewModel(textField: UITextField) {
        self.signupViewModel?.password = textField.text
    }
    @objc func setUserNameInViewModel(textField: UITextField) {
        self.signupViewModel?.userName = textField.text
    }
    
    

}


protocol SignupView: AnyObject {
    var userNameTextField: UITextField! { get set }
    var passwordTextField: UITextField! { get set }
    var loginButton: UIButton! { get set }
    var signUpButton: UIButton! { get set }
    
}
