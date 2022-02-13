//
//  AppDelegate.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 11.02.2022.
//

import Cocoa

@main final class AppDelegate: NSObject, NSApplicationDelegate {
    
    // MARK: Life Cycle
    
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
    
    @IBAction private func reloadWebInterfaceMenuBarItemDidSelect(_ sender: Any) {
        EventHelper.instance.report(.reloadWebInterfaceMenuBarItemDidSelect)
    }
    
    @IBAction private func codeRepositoryMenuBarItemDidSelect(_ sender: Any) {
        guard let url = URL(string: "https://github.com/debug45/Yandex-Music") else {
            return
        }
        
        NSWorkspace.shared.open(url)
    }
    
    // MARK: Private Functions
    
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
