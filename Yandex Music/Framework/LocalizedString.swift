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
    
    enum MainMenu {
        
        static let app = NSLocalizedString("MainMenu.App", comment: "")
        
        enum App {
            
            static let about = NSLocalizedString("MainMenu.App.About", comment: "")
            static let preferences = NSLocalizedString("MainMenu.App.Preferences", comment: "")
            static let services = NSLocalizedString("MainMenu.App.Services", comment: "")
            static let hide = NSLocalizedString("MainMenu.App.Hide", comment: "")
            static let hideOthers = NSLocalizedString("MainMenu.App.HideOthers", comment: "")
            static let showAll = NSLocalizedString("MainMenu.App.ShowAll", comment: "")
            static let quit = NSLocalizedString("MainMenu.App.Quit", comment: "")
            
        }
        
        static let edit = NSLocalizedString("MainMenu.Edit", comment: "")
        
        enum Edit {
            
            static let undo = NSLocalizedString("MainMenu.Edit.Undo", comment: "")
            static let redo = NSLocalizedString("MainMenu.Edit.Redo", comment: "")
            static let cut = NSLocalizedString("MainMenu.Edit.Cut", comment: "")
            static let copy = NSLocalizedString("MainMenu.Edit.Copy", comment: "")
            static let paste = NSLocalizedString("MainMenu.Edit.Paste", comment: "")
            static let delete = NSLocalizedString("MainMenu.Edit.Delete", comment: "")
            static let selectAll = NSLocalizedString("MainMenu.Edit.SelectAll", comment: "")
            
        }
        
        static let view = NSLocalizedString("MainMenu.View", comment: "")
        
        enum View {
            
            static let back = NSLocalizedString("MainMenu.View.Back", comment: "")
            static let forward = NSLocalizedString("MainMenu.View.Forward", comment: "")
            static let home = NSLocalizedString("MainMenu.View.Home", comment: "")
            static let reloadPage = NSLocalizedString("MainMenu.View.ReloadPage", comment: "")
            static let enterFullScreen = NSLocalizedString("MainMenu.View.EnterFullScreen", comment: "")
            
        }
        
        static let window = NSLocalizedString("MainMenu.Window", comment: "")
        
        enum Window {
            
            static let close = NSLocalizedString("MainMenu.Window.Close", comment: "")
            static let minimize = NSLocalizedString("MainMenu.Window.Minimize", comment: "")
            static let zoom = NSLocalizedString("MainMenu.Window.Zoom", comment: "")
            static let bringAllToFront = NSLocalizedString("MainMenu.Window.BringAllToFront", comment: "")
            
        }
        
        static let help = NSLocalizedString("MainMenu.Help", comment: "")
        
        enum Help {
            static let codeRepository = NSLocalizedString("MainMenu.Help.CodeRepository", comment: "")
        }
        
    }
    
    enum DockMenu {
        
        static let playPause = NSLocalizedString("DockMenu.PlayPause", comment: "")
        static let nextTrack = NSLocalizedString("DockMenu.NextTrack", comment: "")
        static let previousTrack = NSLocalizedString("DockMenu.PreviousTrack", comment: "")
        
    }
    
}
