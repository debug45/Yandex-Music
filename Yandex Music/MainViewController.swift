//
//  MainViewController.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 11.02.2022.
//

import Cocoa
import WebKit

final class MainViewController: NSViewController {
    
    @IBOutlet private weak var webView: WKWebView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Functions
    
    private func configure() {
        webView.uiDelegate = self
        
        if let url = URL(string: "https://music.yandex.ru") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
}

// MARK: WebKit UI Delegate

extension MainViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        return nil
    }
    
}
