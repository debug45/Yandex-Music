//
//  LocalizedString.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 28.01.2023.
//

import Foundation

enum LocalizedString {
    
    enum Scene {
        
        enum Main {
            
            static let title = NSLocalizedString("Scene.Main.Title", comment: "")
            
            enum Error {
                
                static let title = NSLocalizedString("Scene.Main.Error.Title", comment: "")
                static let tryAgainButton = NSLocalizedString("Scene.Main.Error.TryAgainButton", comment: "")
                
            }
            
        }
        
        enum Settings {
            
            static let title = NSLocalizedString("Scene.Settings.Title", comment: "")
            static let systemMusicSuppressionCheckbox = NSLocalizedString("Scene.Settings.SystemMusicSuppressionCheckbox", comment: "")
            static let resetBrowserButton = NSLocalizedString("Scene.Settings.ResetBrowserButton", comment: "")
            
        }
        
    }
    
    enum Alert {
        enum Update {
            
            static let title = NSLocalizedString("Alert.Update.Title", comment: "")
            static let description = NSLocalizedString("Alert.Update.Description", comment: "")
            
            enum Button {
                
                static let showDetails = NSLocalizedString("Alert.Update.Button.ShowDetails", comment: "")
                static let later = NSLocalizedString("Alert.Update.Button.Later", comment: "")
                
            }
            
        }
    }
    
    enum DockMenu {
        
        static let playPause = NSLocalizedString("DockMenu.PlayPause", comment: "")
        static let nextTrack = NSLocalizedString("DockMenu.NextTrack", comment: "")
        static let previousTrack = NSLocalizedString("DockMenu.PreviousTrack", comment: "")
        
    }
    
}
