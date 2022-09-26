//
//  LaunchScreenViewController.swift
//  Raven
//
//  Created by Jorge Torres on 24/09/22.
//

import UIKit

protocol LaunchScreenViewController: AnyObject {
    var interactor: LaunchScreenInteractor! { get set }
    var router: LaunchScreenRouter! { get set }
}

class LaunchScreenViewControllerImpl: UIViewController, LaunchScreenViewController {

    var interactor: LaunchScreenInteractor!
    var router: LaunchScreenRouter!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.router.navigateToStart(from: self)
    }
}
