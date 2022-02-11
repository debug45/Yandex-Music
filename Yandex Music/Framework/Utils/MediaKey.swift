//
//  MediaKey.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 11.02.2022.
//

import IOKit

enum MediaKey {
    
    case playPause
    
    case previousTrack
    case nextTrack
    
    // MARK: Life Cycle
    
    init?(systemCode: Int) {
        switch Int32(systemCode) {
            case NX_KEYTYPE_PLAY:
                self = .playPause
                
            case NX_KEYTYPE_REWIND:
                self = .previousTrack
            case NX_KEYTYPE_FAST:
                self = .nextTrack
                
            default:
                return nil
        }
    }
    
}
