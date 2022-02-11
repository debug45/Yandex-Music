//
//  WeakPointer.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 11.02.2022.
//

final class WeakPointer {
    
    private(set) weak var object: AnyObject?
    
    // MARK: Life Cycle
    
    init(_ object: AnyObject) {
        self.object = object
    }
    
}
