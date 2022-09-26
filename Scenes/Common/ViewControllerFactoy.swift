//
//  ViewControllerFactoy.swift
//  Raven
//
//  Created by Jorge Torres on 24/09/22.
//

import Swinject
import UIKit

protocol ViewControllerFactory {

    func navController() -> NavigationController

    func navigateMainPage() -> HomeScreenViewController

    func navigateDetailPage() -> DetailsScreenViewContoller

}

class ViewControllerFactoryImpl: ViewControllerFactory {

    private let assembler: Assembler

    init(assembler: Assembler) {
        self.assembler = assembler
    }

    func navController() -> NavigationController {
            return self.assembler.resolver.resolve(NavigationController.self)!
       }

    func navigateMainPage() -> HomeScreenViewController {
        return self.assembler.resolver.resolve(HomeScreenViewController.self)!
    }
    
    func navigateDetailPage() -> DetailsScreenViewContoller {
     return self.assembler.resolver.resolve(DetailsScreenViewContoller.self)!
    }
}
