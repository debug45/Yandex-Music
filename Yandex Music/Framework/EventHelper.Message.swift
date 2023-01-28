//
//  EventHelper.Message.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 11.02.2022.
//

extension EventHelper {
    
    enum Message {
        
        case updateBackMenuBarItem(isEnabled: Bool)
        case updateForwardMenuBarItem(isEnabled: Bool)
        
        case backMenuBarItemDidSelect
        case forwardMenuBarItemDidSelect
        case homeMenuBarItemDidSelect
        case reloadPageMenuBarItemDidSelect
        
        case globalMediaKeyDidPress(_ mediaKey: MediaKey)
        case resetBuiltInBrowser
        
    }
    
}
