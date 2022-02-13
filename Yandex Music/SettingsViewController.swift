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
        systemMusicSuppressionCheckbox.state = TerminalHelper.checkIsSystemMusicAppLaunchAgentLoaded() == false ? .on : .off
        
        guard isFirstAppearance else {
            return
        }
        
        isFirstAppearance = false
        view.window?.center()
    }
    
    // MARK: Builder Actions
    
    @IBAction private func systemMusicSuppressionCheckboxDidPress(_ sender: Any) {
        TerminalHelper.updateSystemMusicAppLaunchAgent(isLoaded: systemMusicSuppressionCheckbox.state == .off)
    }
    
    @IBAction private func resetBuiltInBrowserButtonDidPress(_ sender: Any) {
        EventHelper.instance.report(.resetBuiltInBrowser)
    }
    
}
