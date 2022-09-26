//
//  UIEntryPoint.swift
//  Raven
//
//  Created by Jorge Torres on 25/09/22.
//

import UIKit

protocol UIEntryPoint: AnyObject {
    var rootViewController: UIViewController? { get set }
}
