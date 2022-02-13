//
//  EventHelper.Message.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 11.02.2022.
//

extension EventHelper {
    
    enum Message {
        
        case reloadWebInterfaceMenuBarItemDidSelect
        case globalMediaKeyDidPress(_ mediaKey: MediaKey)
        
        case resetBuiltInBrowser
        
    }
    
}
