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
    
    private let homeURL = {
        let baseDomain = Constants.baseDomains.first(where: { $0.languageCode == Locale.current.languageCode })?.host
            ?? Constants.baseDomains.first?.host ?? ""
        
        return URL(string: "https://music." + baseDomain)!
    } ()
    
    private let allowedDomains = Constants.baseDomains.flatMap {
        return ["music." + $0.host, "passport." + $0.host]
    }
    
    private var isFirstAppearance = true
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        view.window?.title = LocalizedString.Scene.Main.title
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        guard isFirstAppearance else {
            return
        }
        
        isFirstAppearance = false
        
        view.window?.delegate = self
        loadingIndicator.startAnimation(self)
        
        goHome()
    }
    
    // MARK: Builder Actions
    
    @IBAction private func tryAgainButtonDidPress(_ sender: Any) {
        resetVisibleState()
        reloadPage()
    }
    
    // MARK: Functions
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard (object as? WKWebView) == webView else {
            return
        }
        
        var message: EventHelper.Message?
        
        switch keyPath {
            case #keyPath(WKWebView.canGoBack):
                message = .updateBackMenuBarItem(isEnabled: webView.canGoBack)
            case #keyPath(WKWebView.canGoForward):
                message = .updateForwardMenuBarItem(isEnabled: webView.canGoForward)
                
            default:
                break
        }
        
        if let message {
            EventHelper.instance.report(message)
        }
    }
    
    private func configure() {
        for keyPath in [
            #keyPath(WKWebView.canGoBack),
            #keyPath(WKWebView.canGoForward)
        ] {
            webView.addObserver(self, forKeyPath: keyPath, options: [.initial, .new], context: nil)
        }
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        EventHelper.instance.addTarget(self)
    }
    
    private func goHome() {
        let request = URLRequest(url: homeURL)
        webView.load(request)
    }
    
    private func reloadPage() {
        if webView.url != nil {
            webView.reload()
        } else {
            goHome()
        }
    }
    
    private func resetVisibleState() {
        webView.isHidden = true
        errorView.isHidden = true
        
        loadingIndicator.startAnimation(self)
    }
    
    private func checkForRedirectionFromLoginToSettings(url: URL) -> Bool {
        let suitablePaths = Constants.baseDomains.flatMap {
            let value = "music.\($0.host)/settings"
            
            let allowedCharacters = CharacterSet.urlHostAllowed
            let encoded = value.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!
            
            return [
                value,
                encoded,
                encoded.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!
            ]
        }
        
        let url = url.absoluteString
        return suitablePaths.contains(where: { url.contains($0) }) && url.contains("from-passport")
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
        
        guard let url = navigationAction.request.url else {
            return result
        }
        
        switch navigationAction.navigationType {
            case .linkActivated:
                if !allowedDomains.contains(where: { url.absoluteString.contains($0) }) {
                    NSWorkspace.shared.open(url)
                    result = .cancel
                }
                
            case .formSubmitted:
                if checkForRedirectionFromLoginToSettings(url: url) {
                    DispatchQueue.main.async {
                        self.goHome()
                    }
                    
                    result = .cancel
                }
                
            default:
                break
        }
        
        return result
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loadingIndicator.stopAnimation(self)
        webView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let error = error as NSError
        
        if error.code == 102, let url = error.userInfo["NSErrorFailingURLKey"] as? URL, checkForRedirectionFromLoginToSettings(url: url) {
            return
        }
        
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
            case .backMenuBarItemDidSelect:
                webView.goBack()
            case .forwardMenuBarItemDidSelect:
                webView.goForward()
                
            case .homeMenuBarItemDidSelect:
                if !errorView.isHidden {
                    resetVisibleState()
                }
                
                goHome()
                
            case .reloadPageMenuBarItemDidSelect:
                if !errorView.isHidden {
                    resetVisibleState()
                }
                
                reloadPage()
                
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
                        self.resetVisibleState()
                        self.goHome()
                    }
                }
                
            default:
                break
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
