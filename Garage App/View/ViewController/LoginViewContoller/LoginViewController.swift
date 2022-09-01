//
//  ViewController.swift
//  Garage App
//
//  Created by Ankit Singh on 01/09/22.
//

import UIKit

class LoginViewController: UIViewController, LoginView {
    
    
    @IBOutlet weak var usernameTextField: MyCustomTextField!
    @IBOutlet weak var passwordTextField: MyCustomTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    private var loginUiController: LoginUIController?
    private var loginViewModel: LoginViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginUiController = LoginUIController()
        self.loginUiController?.view = self
        self.loginViewModel = LoginViewModel()
        self.loginViewModel?.view = self
        self.loginUiController?.delegate = loginViewModel
        self.loginViewModel?.delegate = loginUiController

    }


}

protocol LoginView : AnyObject {
    
    var usernameTextField : MyCustomTextField! {get set}
    var passwordTextField: MyCustomTextField! { get set }
    var loginButton: UIButton! { get set }
    var signUpButton: UIButton! { get set }
}

