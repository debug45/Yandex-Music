//
//  UpdateHelper.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 13.02.2022.
//

import AppKit

final class UpdateHelper {
    
    // MARK: Life Cycle
    
    private init() { }
    
    // MARK: Functions
    
    static func checkNewVersionAvailability() {
        DispatchQueue.global(qos: .utility).async {
            guard
                let url = URL(string: "https://raw.githubusercontent.com/debug45/Yandex-Music/master/Repository/ActualVersion.txt"),
                let response = try? String(contentsOf: url),
                
                let newVersion = Int(response),
                let currentVersion = getCurrentVersion(),
                
                newVersion > currentVersion
            else {
                return
            }
            
            DispatchQueue.main.async {
                let alert = NSAlert()
                alert.alertStyle = .warning
                
                alert.messageText = "Доступна новая версия приложения"
                alert.informativeText = "Хотите узнать, какие изменения в\u{00A0}неё вошли?"
                
                alert.addButton(withTitle: "Подробнее")
                alert.addButton(withTitle: "Не сейчас")
                
                switch alert.runModal() {
                    case .alertFirstButtonReturn:
                        let url = URL(string: "https://github.com/debug45/Yandex-Music/releases")!
                        NSWorkspace.shared.open(url)
                        
                    default:
                        break
                }
            }
        }
    }
    
    private static func getCurrentVersion() -> Int? {
        guard
            let infoDictionary = Bundle.main.infoDictionary,
            let numberComponents = (infoDictionary["CFBundleShortVersionString"] as? String)?.split(separator: ".")
        else {
            return nil
        }
        
        var result = 0
        
        if numberComponents.count >= 2 {
            if let major = Int(numberComponents[0]) {
                result += major * 1_00_00
            }
            
            if let minor = Int(numberComponents[1]) {
                result += minor * 1_00
            }
            
            if numberComponents.count >= 3, let patch = Int(numberComponents[2]) {
                result += patch
            }
        }
        
        return result > 0 ? result : nil
    }
    
}
