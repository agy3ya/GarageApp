//
//  UiViewController.swift
//  Garage App
//
//  Created by Ankit Singh on 02/09/22.
//

import Foundation
import UIKit
import RealmSwift


extension UIViewController {
    func showAlert(title: String, message: String, comletion : (() -> Void)?)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            comletion?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentVC(storyBoard: String, identifier: String ) {
        let secondVC = UIStoryboard(name: storyBoard, bundle: nil).instantiateViewController(identifier: identifier)
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.modalTransitionStyle = .crossDissolve
        self.present(secondVC, animated: true, completion: nil)
    }
    
    func showToast(message: String) {
        guard let window = UIApplication.shared.currentUIWindow() else {
            return
        }
        let toastLbl = UILabel()
        toastLbl.text = message
        toastLbl.textAlignment = .center
        toastLbl.font = UIFont.systemFont(ofSize: 16)
        toastLbl.textColor = UIColor.white
        toastLbl.backgroundColor = UIColor.black
        toastLbl.numberOfLines = 0
        let textSize = toastLbl.intrinsicContentSize
        let labelHeight = ( textSize.width / window.frame.width ) * 30
        let labelWidth = window.frame.width - 100
        let adjustedHeight = max(labelHeight, textSize.height + 30)
        toastLbl.frame = CGRect(x: 20, y: (window.frame.height - 50 ) - adjustedHeight, width: labelWidth, height: adjustedHeight)
        toastLbl.center.x = window.center.x
        toastLbl.layer.cornerRadius = 10
        toastLbl.layer.masksToBounds = true
        window.addSubview(toastLbl)
        UIView.animate(withDuration: 3.0, animations: {
            toastLbl.alpha = 0
        }) { (_) in
            toastLbl.removeFromSuperview()
        }
    }

}

public extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
        
    }
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}
