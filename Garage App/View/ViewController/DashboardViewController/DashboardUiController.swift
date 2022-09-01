//
//  DashboardUiController.swift
//  Garage App
//
//  Created by Ankit Singh on 02/09/22.
//

import UIKit


class DashboardUiController: NSObject {
    weak var view: DashboardView? {
        didSet {
            self.setupTextFields()
            self.setupAddTargets()
            self.setupPickerView()
            self.setupTableView()
            self.setupImagePickerController()
        }
    }
    private var carUpdateDetails: Car?
    private var isSelectMakeDropDown: Bool?
    private let pickerView = UIPickerView()
    private let imagePickerController = UIImagePickerController()
    private var carImage: UIImage?
    private var makeID: Int?
    private var makeName: String?
    private var modelName: String?
    
    weak var delegate: DropDownDelegate?
    weak var fetchCarListDelegate: FetchCarListDelegate?
    
    private func setupImagePickerController() {
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.mediaTypes = [Constant.imageType]
    }
    
    private func setupAddTargets() {
        self.view?.logoutButton.addTarget(self, action: #selector(didTapOnLogoutButton), for: .touchUpInside)
        self.view?.selectMakeDropDowntextField.addTarget(self, action: #selector(didTapOnSelectMakeTextField), for: .touchDown)
        self.view?.selectModelDropDownTextField.addTarget(self, action: #selector(didTapOnSelectModelTextField), for: .touchDown)
        self.view?.addCarButton.addTarget(self, action: #selector(didTapOnAddCarButton), for: .touchUpInside)
    }
    
    private func setupTableView() {
        self.view?.tableView.register(UINib(nibName: Constant.carTableViewCell, bundle: nil), forCellReuseIdentifier: Constant.carTableViewCell)
        self.view?.tableView.delegate = self
        self.view?.tableView.dataSource = self
        self.view?.tableView.separatorStyle = .none
        self.view?.tableView.showsVerticalScrollIndicator = false
    }
    
    private func setupTextFields() {
        self.view?.selectMakeDropDowntextField.delegate = self
        self.view?.selectModelDropDownTextField.delegate = self
        self.view?.selectMakeDropDowntextField.setTextFieldRightView()
        self.view?.selectModelDropDownTextField.setTextFieldRightView()
        if self.view?.selectMakeDropDowntextField.text?.count ?? 0 < 1 {
            self.view?.selectMakeDropDowntextField.text = Constant.selectMake
        }
        if self.view?.selectModelDropDownTextField.text?.count ?? 0 < 1 {
            self.view?.selectModelDropDownTextField.text = Constant.selectModel
        }
    }
    
    private func setupPickerView() {
        self.pickerView.isHidden = true
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.backgroundColor = .white
        self.view?.selectMakeDropDowntextField.inputView = pickerView
        self.view?.selectModelDropDownTextField.inputView = pickerView
        (self.view as? UIViewController)?.view.addSubview(pickerView)
    }
    
    private func setupPickerViewFrame() {
        if self.isSelectMakeDropDown ?? false {
            self.pickerView.frame = CGRect(x: self.view?.selectMakeDropDowntextField.frame.origin.x ?? 0, y: (self.view?.selectMakeDropDowntextField.frame.origin.y ?? 0) + (self.view?.selectMakeDropDowntextField.frame.size.height ?? 0.0), width: self.view?.selectMakeDropDowntextField.frame.width ?? 100, height: 155)
        } else {
            self.pickerView.frame = CGRect(x: self.view?.selectModelDropDownTextField.frame.origin.x ?? 0, y: (self.view?.selectModelDropDownTextField.frame.origin.y ?? 0) + (self.view?.selectModelDropDownTextField.frame.size.height ?? 0.0), width: self.view?.selectModelDropDownTextField.frame.width ?? 100, height: 155)
        }
    }
    
    @objc private func didTapOnLogoutButton() {
        let alert = UIAlertController(title: Constant.alert, message: Constant.logoutMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constant.okTitle, style: .default, handler: { _ in
            UserLoginManager.shared.currentLoggedInUserName = nil
            let vc = self.view as? UIViewController
            vc?.presentVC(storyBoard: Constant.storyboardName, identifier: Constant.loginVCIdentifier)
        }))
        alert.addAction(UIAlertAction.init(title: Constant.cancelTitle, style: .cancel, handler: { _ in
            (self.view as? UIViewController)?.dismiss(animated: true, completion: nil)
        }))
        (self.view as? UIViewController)?.present(alert, animated: true, completion: nil)
    }
    
    @objc private func didTapOnSelectMakeTextField() {
        self.isSelectMakeDropDown = true
        self.setupPickerViewFrame()
        self.pickerView.reloadAllComponents()
        self.pickerView.isHidden = false
    }
    
    @objc private func didTapOnSelectModelTextField() {
        if self.view?.selectMakeDropDowntextField.text == Constant.selectMake {
            (self.view as? UIViewController)?.showAlert(title: Constant.alert, message: Constant.selectMakeErrorMsg, comletion: nil)
        } else {
            self.isSelectMakeDropDown = false
            self.setupPickerViewFrame()
            self.pickerView.reloadAllComponents()
            self.pickerView.isHidden = false
        }
    }
    
    @objc private func didTapOnAddCarButton() {
        if self.view?.selectMakeDropDowntextField.text == Constant.selectMake && self.view?.selectModelDropDownTextField.text == Constant.selectModel {
            (self.view as? UIViewController)?.showAlert(title: Constant.alert, message: Constant.selectMakeAndModelErrorMesssage, comletion: nil)
        } else if self.view?.selectMakeDropDowntextField.text != Constant.selectMake && self.view?.selectModelDropDownTextField.text == Constant.selectModel {
            (self.view as? UIViewController)?.showAlert(title: Constant.alert, message: Constant.selectModelErrorMessage, comletion: nil)
        } else {
            CarManager.shared.saveCarToDB(car: Car(make: self.makeName ?? "", model: self.modelName ?? "", image: UIImage()))
            self.view?.selectMakeDropDowntextField.text = Constant.selectMake
            self.view?.selectModelDropDownTextField.text = Constant.selectModel
            (self.view as? UIViewController)?.showToast(message: Constant.carAddToastMsg)
            self.fetchCarListDelegate?.fetchCarList()
        }
    }
    
}

extension DashboardUiController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.isSelectMakeDropDown ?? false {
            return self.view?.carMakeResponse?.count ?? 0
        } else {
            return self.view?.carModelResponse?.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.isSelectMakeDropDown ?? false {
            return self.view?.carMakeResponse?.results[row].makeName
        } else {
            return self.view?.carModelResponse?.results[row].modelName
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.isSelectMakeDropDown ?? false {
            self.pickerView.isHidden = true
            self.makeID = self.view?.carMakeResponse?.results[row].makeID
            self.makeName = self.view?.carMakeResponse?.results[row].makeName
            self.view?.selectMakeDropDowntextField.text = self.view?.carMakeResponse?.results[row].makeName
            self.view?.selectModelDropDownTextField.text = Constant.selectModel
            self.modelName = nil
            self.delegate?.fetchCarModelData(makeID: self.makeID ?? 0)
        } else {
            self.pickerView.isHidden = true
            self.modelName = self.view?.carModelResponse?.results[row].modelName
            self.view?.selectModelDropDownTextField.text = self.view?.carModelResponse?.results[row].modelName
        }
    }
}

extension DashboardUiController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.view?.carList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.carTableViewCell, for: indexPath) as? CarTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.addCarImageDelegate = self
        cell.setData(data: self.view?.carList?[indexPath.row] ?? Car())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension DashboardUiController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.view?.selectModelDropDownTextField || ((self.view?.selectMakeDropDowntextField) != nil) {
            textField.endEditing(true)
        }
    }
}

extension DashboardUiController: DashboardDropDownDataFetched {
    func error(message: String) {
        self.view?.selectMakeDropDowntextField.isUserInteractionEnabled = false
        (self.view as? UIViewController)?.showAlert(title: Constant.errorTitle, message: message, comletion: nil)
    }
    
}

extension DashboardUiController: CarListDataFetched {
    func success() {
        self.view?.tableView.reloadData()
    }
}

extension DashboardUiController: DeleteCarDelegate {
    func deleteCar(car: Car) {
        CarManager.shared.deleteCarFromDB(car: car) {
            self.fetchCarListDelegate?.fetchCarList()
        }
    }
}

extension DashboardUiController: AddCarImageDelegate {
    
    private func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            self.imagePickerController.sourceType = UIImagePickerController.SourceType.camera
            self.imagePickerController.allowsEditing = true
            (self.view as? UIViewController)?.present(self.imagePickerController, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: Constant.warningTitle, message: Constant.noCameraErrorMesssage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constant.okTitle, style: .default, handler: nil))
            (self.view as? UIViewController)?.present(alert, animated: true, completion: nil)
        }
    }
    
    private func openGallery() {
        self.imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.imagePickerController.allowsEditing = true
        (self.view as? UIViewController)?.present(self.imagePickerController, animated: true, completion: nil)
    }
    
    private func choosePhoto() {
        let alert = UIAlertController(title: Constant.chooseImage, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Constant.camera, style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: Constant.gallery, style: .default, handler: { _ in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction.init(title: Constant.cancelTitle, style: .cancel, handler: nil))
        (self.view as? UIViewController)?.present(alert, animated: true, completion: nil)
    }
    
    func addCarImage(withCar: Car) {
        self.carUpdateDetails = withCar
        self.choosePhoto()
    }
}

extension DashboardUiController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            try? RealmManager.shared.realm.write {
                self.carUpdateDetails?.image = NSData(data: (pickedImage.pngData() ?? pickedImage.jpegData(compressionQuality: 0.9)) ?? Data())
            }
            self.view?.tableView.reloadData()
        }
        (self.view as? UIViewController)?.dismiss(animated: true, completion: {
            
        })
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        (self.view as? UIViewController)?.dismiss(animated: true, completion: nil)
    }
}


protocol DropDownDelegate: AnyObject {
    func fetchCarModelData(makeID: Int)
}

protocol FetchCarListDelegate: AnyObject {
    func fetchCarList()
}
