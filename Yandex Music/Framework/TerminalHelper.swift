//
//  TerminalHelper.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 12.02.2022.
//

import Foundation

final class TerminalHelper {
    
    // MARK: Life Cycle
    
    private init() { }
    
    // MARK: Functions
    
    static func runCommand(_ command: String) -> String? {
        let process = Process()
        
        process.arguments = ["-c", command]
        process.launchPath = "/bin/sh"
        
        let pipe = Pipe()
        process.standardOutput = pipe
        
        let fileHandle = pipe.fileHandleForReading
        process.launch()
        
        let outputData = fileHandle.readDataToEndOfFile()
        return String(data: outputData, encoding: .utf8)
    }
    
}
