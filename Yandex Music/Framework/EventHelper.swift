//
//  EventHelper.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 11.02.2022.
//

final class EventHelper {
    
    static let instance = EventHelper()
    
    private var targets: [WeakPointer] = []
    
    // MARK: Life Cycle
    
    private init() { }
    
    // MARK: Functions
    
    func addTarget(_ target: Target) {
        guard !targets.contains(where: { $0.object === target }) else {
            return
        }
        
        let pointer = WeakPointer(target)
        targets.append(pointer)
    }
    
    func report(_ message: Message) {
        var index = 0
        
        while index < targets.count {
            let pointer = targets[index]
            
            guard let target = pointer.object as? Target else {
                targets.remove(at: index)
                continue
            }
            
            target.handleMessage(message)
            index += 1
        }
    }
    
}
