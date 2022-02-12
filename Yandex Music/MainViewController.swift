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
        
        EventHelper.instance.addTarget(self)
    }
    
    private func clickWebButton(javaScriptClass: String, completion: ((Bool) -> Void)? = nil) {
        webView.evaluateJavaScript("""
            document.querySelector('.\(javaScriptClass)').click();
        """) { _, error in
            completion?(error == nil)
        }
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
            case .reloadMenuItemDidSelect:
                webView.reload()
                
            case let .mediaKeyDidPress(mediaKey):
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
        }
    }
    
}
