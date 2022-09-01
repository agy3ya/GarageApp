//
//  DashboardViewController.swift
//  Garage App
//
//  Created by Ankit Singh on 01/09/22.
//

import UIKit

class DashboardViewController: UIViewController, DashboardView {
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var selectMakeDropDowntextField: MyCustomTextField!
    @IBOutlet weak var selectModelDropDownTextField: MyCustomTextField!
    @IBOutlet weak var addCarButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    private var dashboardUiController: DashboardUiController?
    private var dashboardViewModel: DashboardViewModel?
    var carMakeResponse: CarMakeData?
    var carModelResponse: CarModeldata?
    var carList: [Car]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dashboardUiController = DashboardUiController()
        dashboardUiController?.view = self
        self.dashboardViewModel = DashboardViewModel()
        dashboardViewModel?.view = self
        dashboardUiController?.delegate = dashboardViewModel
        dashboardViewModel?.delegate = dashboardUiController
        dashboardUiController?.fetchCarListDelegate = dashboardViewModel
        dashboardViewModel?.carlistDelegate = dashboardUiController
        
    }
    

}



protocol DashboardView: AnyObject {
    var logoutButton: UIButton! { get set }
    var selectMakeDropDowntextField: MyCustomTextField! { get set }
    var selectModelDropDownTextField: MyCustomTextField! { get set }
    var addCarButton: UIButton! { get set }
    var tableView: UITableView! { get set }
    var carMakeResponse: CarMakeData? { get set }
    var carModelResponse: CarModeldata? { get set }
    var carList: [Car]? { get set }
}
