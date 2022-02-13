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
    
    @IBOutlet private weak var loadingIndicator: NSProgressIndicator!
    @IBOutlet private weak var errorView: NSView!
    
    private var isFirstAppearance = true
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        guard isFirstAppearance else {
            return
        }
        
        isFirstAppearance = false
        
        view.window?.delegate = self
        loadingIndicator.startAnimation(self)
        
        if let url = URL(string: "https://music.yandex.ru") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    // MARK: Functions
    
    private func configure() {
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        EventHelper.instance.addTarget(self)
    }
    
    private func reloadWebView() {
        webView.isHidden = true
        errorView.isHidden = true
        
        loadingIndicator.startAnimation(self)
        webView.reload()
    }
    
    private func clickWebButton(javaScriptClass: String, completion: ((Bool) -> Void)? = nil) {
        webView.evaluateJavaScript("""
            document.querySelector('.\(javaScriptClass)').click();
        """) { _, error in
            completion?(error == nil)
        }
    }
    
}

// MARK: - WebKit Navigation Delegate

extension MainViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        var result = WKNavigationActionPolicy.allow
        
        guard navigationAction.navigationType == .linkActivated, let url = navigationAction.request.url else {
            return result
        }
        
        if !["music.yandex.ru", "passport.yandex.ru"].contains(url.host) {
            NSWorkspace.shared.open(url)
            result = .cancel
        }
        
        return result
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loadingIndicator.stopAnimation(self)
        webView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        loadingIndicator.stopAnimation(self)
        webView.isHidden = true
        
        errorView.isHidden = false
    }
    
}

// MARK: - WebKit UI Delegate

extension MainViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        return nil
    }
    
}

// MARK: - Event Helper Target

extension MainViewController: EventHelper.Target {
    
    func handleMessage(_ message: EventHelper.Message) {
        switch message {
            case .reloadWebInterfaceMenuBarItemDidSelect:
                reloadWebView()
                
            case let .globalMediaKeyDidPress(mediaKey):
                switch mediaKey {
                    case .playPause:
                        clickWebButton(javaScriptClass: "player-controls__btn_play") { result in
                            guard !result else {
                                return
                            }
                            
                            self.clickWebButton(javaScriptClass: "player-controls__btn_pause")
                        }
                        
                    case .previousTrack:
                        clickWebButton(javaScriptClass: "player-controls__btn_prev")
                    case .nextTrack:
                        clickWebButton(javaScriptClass: "player-controls__btn_next")
                }
                
            case .resetBuiltInBrowser:
                let webViewStore = WKWebsiteDataStore.default()
                let dataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
                
                webViewStore.fetchDataRecords(ofTypes: dataTypes) { records in
                    webViewStore.removeData(ofTypes: dataTypes, for: records) {
                        self.reloadWebView()
                    }
                }
        }
    }
    
}

// MARK: - Window Delegate

extension MainViewController: NSWindowDelegate {
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }
    
}
