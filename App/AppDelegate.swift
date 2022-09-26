//
//  AppDelegate.swift
//  Raven
//
//  Created by Jorge Torres on 23/09/22.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UIEntryPoint {

    var window: UIWindow?
    var assembler: Assembler?

    var rootViewController: UIViewController? {
        get { return self.window?.rootViewController }
        set {
            self.window?.rootViewController = newValue
            self.window?.makeKeyAndVisible()
        }
    }

    func initWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
    }

    func initDependencyInjection() {
        self.assembler = Assembler([
            LaunchScreenContext(),
            HomeScreenContext(),
            DetailsScreenConext(),
        ])
        self.assembler?.apply(assembly: CommonContext(assembler: self.assembler!, uiEntryPoint: self))
    }

    func initUI() {
        let rootViewController = assembler?.resolver.resolve(LaunchScreenViewController.self)!
        self.rootViewController = (rootViewController as! UIViewController)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initWindow()
        initDependencyInjection()
        initUI()

        return true
    }

}

