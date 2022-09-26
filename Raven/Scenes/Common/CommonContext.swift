//
//  CommonContext.swift
//  Raven
//
//  Created by Jorge Torres on 24/09/22.
//

import UIKit
import Swinject

class CommonContext: Assembly {

    private let assembler: Assembler
    private let uiEntryPoint: UIEntryPoint

    init(assembler: Assembler, uiEntryPoint: UIEntryPoint) {
        self.assembler = assembler
        self.uiEntryPoint = uiEntryPoint
    }

    func assemble(container: Container) {
        container.register(NavigationController.self) {
            r in NavigationController()
        }

        container.register(ViewControllerFactory.self) { r in
            ViewControllerFactoryImpl(assembler: self.assembler)
        }

        container.register(UIEntryPoint.self) { r in
            self.uiEntryPoint
        }.inObjectScope(.container)

        container.register(AlertService.self) { r in
            AlertServiceImpl()
        }
    }
}
