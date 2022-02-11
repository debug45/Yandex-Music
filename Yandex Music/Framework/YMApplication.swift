//
//  YMApplication.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 11.02.2022.
//

import Cocoa

final class YMApplication: NSApplication {
    
    override func sendEvent(_ event: NSEvent) {
        if event.type == .systemDefined && event.subtype.rawValue == 8 {
            let keyCode = (event.data1 & 0xFFFF0000) >> 16
            let flags = event.data1 & 0x0000FFFF
            
            if (flags & 0xFF00) >> 8 == 0xA, let mediaKey = MediaKey(systemCode: keyCode) {
                let message = EventHelper.Message.mediaKeyDidPress(mediaKey)
                EventHelper.instance.report(message)
            }
        }
        
        super.sendEvent(event)
    }
    
}
