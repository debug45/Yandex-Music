//
//  AppDelegate.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 11.02.2022.
//

import Cocoa

@main final class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet private weak var backMenuBarItem: NSMenuItem!
    @IBOutlet private weak var forwardMenuBarItem: NSMenuItem!
    
    // MARK: Life Cycle
    
    func applicationDidFinishLaunching(_ notification: Notification) {
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
        
        var selector = #selector(playPauseDockMenuItemDidSelect)
        menu.addItem(withTitle: "Воспроизведение\u{2009}/\u{2009}пауза", action: selector, keyEquivalent: "")
        
        selector = #selector(nextTrackDockMenuItemDidSelect)
        menu.addItem(withTitle: "Следующий трек", action: selector, keyEquivalent: "")
        
        selector = #selector(previousTrackDockMenuItemDidSelect)
        menu.addItem(withTitle: "Предыдущий трек", action: selector, keyEquivalent: "")
        
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
        let url = URL(string: "https://github.com/debug45/Yandex-Music")!
        NSWorkspace.shared.open(url)
    }
    
    // MARK: Functions
    
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
