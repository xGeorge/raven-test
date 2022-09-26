//
//  DetailsScreenVC.swift
//  Raven
//
//  Created by Jorge Torres on 26/09/22.
//

import UIKit
import WebKit

class DetailsScreenVC: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
}
