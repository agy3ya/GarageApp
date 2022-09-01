//
//  CarTableViewCell.swift
//  Garage App
//
//  Created by Ankit Singh on 02/09/22.
//

import UIKit

class CarTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carMakeLabel: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var addCarImageButton: UIButton!
    @IBOutlet weak var deleteCarButton: UIButton!
    
    private var car: Car?
    
    weak var delegate: DeleteCarDelegate?
    weak var addCarImageDelegate: AddCarImageDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.carImageView.contentMode = .scaleAspectFit
        self.addTargets()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    private func addTargets() {
        self.deleteCarButton.addTarget(self, action: #selector(didTapOnDeleteCar), for: .touchUpInside)
        self.addCarImageButton.addTarget(self, action: #selector(didTapOnAddCarImage), for: .touchUpInside)
    }
    
    @objc private func didTapOnDeleteCar() {
        self.delegate?.deleteCar(car: self.car ?? Car())
    }
    
    @objc private func didTapOnAddCarImage() {
        if let car = self.car {
            self.addCarImageDelegate?.addCarImage(withCar: car)
        }
    }
    
    func setData(data: Car) {
        self.car = data
        self.carMakeLabel.text = data.make
        self.carModelLabel.text = data.model
        self.carImageView.image = UIImage(data: data.image as Data)
    }
    
}


protocol DeleteCarDelegate: AnyObject {
    func deleteCar(car: Car)
}

protocol AddCarImageDelegate: AnyObject {
    func addCarImage(withCar: Car)
}
