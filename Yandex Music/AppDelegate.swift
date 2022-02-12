//
//  AppDelegate.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 11.02.2022.
//

import Cocoa

@main final class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBAction private func reloadMenuItemDidSelect(_ sender: Any) {
        EventHelper.instance.report(.reloadMenuItemDidSelect)
    }
    
    @IBAction private func repositoryMenuItemDidSelect(_ sender: Any) {
        guard let url = URL(string: "https://github.com/debug45/Yandex-Music") else {
            return
        }
        
        NSWorkspace.shared.open(url)
    }
    
}
