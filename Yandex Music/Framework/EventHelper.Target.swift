//
//  EventHelper.Target.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 11.02.2022.
//

extension EventHelper {
    
    typealias Target = EventHelperTarget
    
}

// MARK: -

protocol EventHelperTarget: AnyObject {
    
    func handleMessage(_ message: EventHelper.Message)
    
}
