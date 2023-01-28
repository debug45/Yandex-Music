//
//  Constants.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 28.01.2023.
//

import Foundation

final class Constants {
    
    // MARK: Life Cycle
    
    private init() { }
    
    // MARK: Properties
    
    static let baseDomains = [
        (languageCode: "en", host: "yandex.com"),
        (languageCode: "ru", host: "yandex.ru")
    ]
    
    static let repositoryURL = URL(string: "https://github.com/debug45/Yandex-Music")!
    static let releasesURL = URL(string: "https://github.com/debug45/Yandex-Music/releases")!
    
    static let actualVersionDataURL = URL(string: "https://raw.githubusercontent.com/debug45/Yandex-Music/master/Repository/ActualVersion.txt")!
    
}
