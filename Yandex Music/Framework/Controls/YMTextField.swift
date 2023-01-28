//
//  YMTextField.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 28.01.2023.
//

import AppKit

@IBDesignable final class YMTextField: NSTextField {
    
    @IBInspectable var titleKey: String? {
        didSet {
            if let titleKey {
                stringValue = NSLocalizedString(titleKey, comment: "")
            } else {
                stringValue = ""
            }
        }
    }
    
}
