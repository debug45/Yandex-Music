//
//  YMMenu.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 28.01.2023.
//

import AppKit

@IBDesignable final class YMMenu: NSMenu {
    
    @IBInspectable var titleKey: String? {
        didSet {
            if let titleKey {
                title = NSLocalizedString(titleKey, comment: "")
            } else {
                title = ""
            }
        }
    }
    
}
