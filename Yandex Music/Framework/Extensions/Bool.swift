//
//  Bool.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 13.02.2022.
//

extension Bool {
    
    private static let binaryValues = [
        false: "0",
        true: "1"
    ]
    
    // MARK: Life Cycle
    
    init?(binaryValue: String) {
        if let value = Self.binaryValues.first(where: { $0.value == binaryValue })?.key {
            self = value
        } else {
            return nil
        }
    }
    
    // MARK: Properties
    
    var binaryValue: String {
        return Self.binaryValues[self]!
    }
    
}
