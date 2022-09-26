//
//  AlertService.swift
//  Raven
//
//  Created by Jorge Torres on 26/09/22.
//

import UIKit

protocol AlertEmiiter {
    var alertService: AlertService! {get set}
}

protocol AlertService {

    func alertController(title: String, message: String) -> UIAlertController

    @discardableResult
    func alertController(
        title: String,
        message: String,
        preferredStyle: UIAlertController.Style,
        actions: [UIAlertAction],
        viewController: UIViewController) -> UIAlertController
}

class AlertServiceImpl: AlertService {

    func alertController(title: String, message: String) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }

    func alertController(
        title: String,
        message: String,
        preferredStyle: UIAlertController.Style,
        actions: [UIAlertAction],
        viewController: UIViewController) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for action in actions {
            alertController.addAction(action)
        }
        viewController.present(alertController, animated: true, completion: nil)
        return alertController
    }
}
