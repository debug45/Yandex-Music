//
//  SettingsViewController.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 11.02.2022.
//

import Cocoa

final class SettingsViewController: NSViewController {
    
    @IBOutlet private weak var systemMusicSuppressionCheckbox: NSButton!
    
    private var isFirstAppearance = true
    
    // MARK: Life Cycle
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        if let output = TerminalHelper.runCommand("""
            launchctl list
        """) {
            systemMusicSuppressionCheckbox.state = !output.contains("com.apple.rcd") ? .on : .off
        }
        
        guard isFirstAppearance else {
            return
        }
        
        isFirstAppearance = false
        view.window?.center()
    }
    
    // MARK: Builder Actions
    
    @IBAction private func systemMusicSuppressionCheckboxDidPress(_ sender: Any) {
        let verdict: String
        
        switch systemMusicSuppressionCheckbox.state {
            case .on:
                verdict = "unload"
            case .off:
                verdict = "load"
                
            default:
                return
        }
        
        _ = TerminalHelper.runCommand("""
            launchctl \(verdict) -w /System/Library/LaunchAgents/com.apple.rcd.plist
        """)
    }
    
    @IBAction private func resetBuiltInBrowserButtonDidPress(_ sender: Any) {
        EventHelper.instance.report(.resetBuiltInBrowser)
    }
    
}
