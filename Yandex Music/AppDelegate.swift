//
//  AppDelegate.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 11.02.2022.
//

import Cocoa
import FirebaseAnalytics
import FirebaseCore

@main final class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet private weak var backMenuBarItem: NSMenuItem!
    @IBOutlet private weak var forwardMenuBarItem: NSMenuItem!
    
    // MARK: Life Cycle
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        configureFirebase()
        
        EventHelper.instance.addTarget(self)
        UpdateHelper.checkNewVersionAvailability()
        
        guard StorageHelper.isFirstLaunch != false else {
            return
        }
        
        StorageHelper.isFirstLaunch = false
        TerminalHelper.updateSystemMusicAppLaunchAgent(isLoaded: false)
    }
    
    func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        let menu = NSMenu()
        let localizedString = LocalizedString.DockMenu.self
        
        var selector = #selector(playPauseDockMenuItemDidSelect)
        menu.addItem(withTitle: localizedString.playPause, action: selector, keyEquivalent: "")
        
        selector = #selector(nextTrackDockMenuItemDidSelect)
        menu.addItem(withTitle: localizedString.nextTrack, action: selector, keyEquivalent: "")
        
        selector = #selector(previousTrackDockMenuItemDidSelect)
        menu.addItem(withTitle: localizedString.previousTrack, action: selector, keyEquivalent: "")
        
        return menu
    }
    
    // MARK: Builder Actions
    
    @IBAction private func backMenuBarItemDidSelect(_ sender: Any) {
        EventHelper.instance.report(.backMenuBarItemDidSelect)
    }
    
    @IBAction private func forwardMenuBarItemDidSelect(_ sender: Any) {
        EventHelper.instance.report(.forwardMenuBarItemDidSelect)
    }
    
    @IBAction private func homeMenuBarItemDidSelect(_ sender: Any) {
        EventHelper.instance.report(.homeMenuBarItemDidSelect)
    }
    
    @IBAction private func reloadPageMenuBarItemDidSelect(_ sender: Any) {
        EventHelper.instance.report(.reloadPageMenuBarItemDidSelect)
    }
    
    @IBAction private func codeRepositoryMenuBarItemDidSelect(_ sender: Any) {
        NSWorkspace.shared.open(Constants.repositoryURL)
    }
    
    // MARK: Functions
    
    private func configureFirebase() {
        let secretDataKeys = [
            "CLIENT_ID",
            "REVERSED_CLIENT_ID",
            "API_KEY",
            "GCM_SENDER_ID",
            "GOOGLE_APP_ID"
        ]
        
        guard
            let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
            let availableKeys = NSDictionary(contentsOfFile: path)?.allKeys.compactMap({ $0 as? String }),
            secretDataKeys.allSatisfy({ availableKeys.contains($0) })
        else {
            return
        }
        
        FirebaseApp.configure()
        Analytics.setAnalyticsCollectionEnabled(true)
    }
    
    @objc private func playPauseDockMenuItemDidSelect(_ sender: Any) {
        let message = EventHelper.Message.globalMediaKeyDidPress(.playPause)
        EventHelper.instance.report(message)
    }
    
    @objc private func previousTrackDockMenuItemDidSelect(_ sender: Any) {
        let message = EventHelper.Message.globalMediaKeyDidPress(.previousTrack)
        EventHelper.instance.report(message)
    }
    
    @objc private func nextTrackDockMenuItemDidSelect(_ sender: Any) {
        let message = EventHelper.Message.globalMediaKeyDidPress(.nextTrack)
        EventHelper.instance.report(message)
    }
    
}

// MARK: - Event Helper Target

extension AppDelegate: EventHelper.Target {
    
    func handleMessage(_ message: EventHelper.Message) {
        switch message {
            case let .updateBackMenuBarItem(isEnabled):
                backMenuBarItem.action = isEnabled ? #selector(backMenuBarItemDidSelect) : nil
            case let .updateForwardMenuBarItem(isEnabled):
                forwardMenuBarItem.action = isEnabled ? #selector(forwardMenuBarItemDidSelect) : nil
                
            default:
                break
        }
    }
    
}
