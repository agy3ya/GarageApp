//
//  DasthBoardViewModel.swift
//  Garage App
//
//  Created by Ankit Singh on 02/09/22.
//

import UIKit



class DashboardViewModel: NSObject {
    
    weak var view: DashboardView? {
        didSet {
            self.fetchCarMakeDataFromAPI()
            self.fetchCarListFormDB()
        }
    }
    weak var delegate: DashboardDropDownDataFetched?
    weak var carlistDelegate: CarListDataFetched?
    
    private func fetchCarMakeDataFromAPI() {
        CarRestManager.shared.getCarsMake { result in
            switch result {
            case .success(let response):
                if response.count > 0 {
                    self.view?.carMakeResponse = response
                }
            case .failure(let error):
                self.delegate?.error(message: error.localizedDescription)
            }
        }
    }
    
    private func fetchCarModelDataFromAPI(makeID: Int) {
        CarRestManager.shared.getCarsModel(makeID: makeID) { result in
            switch result {
            case .success(let response):
                if response.count > 0 {
                    self.view?.carModelResponse = response
                }
            case .failure(let error):
                self.delegate?.error(message: error.localizedDescription)
            }
        }
    }
    
    private func fetchCarListFormDB() {
        self.view?.carList = []
        for car in CarManager.shared.getCar() {
            self.view?.carList?.append(car)
        }
        self.carlistDelegate?.success()
    }
}

extension DashboardViewModel: DropDownDelegate {
    func fetchCarModelData(makeID: Int) {
        self.fetchCarModelDataFromAPI(makeID: makeID)
    }
}

extension DashboardViewModel: FetchCarListDelegate {
    func fetchCarList() {
        self.fetchCarListFormDB()
    }
}

protocol DashboardDropDownDataFetched: AnyObject {
    func error(message: String)
}

protocol CarListDataFetched: AnyObject {
    func success()
}
