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
    
    static func checkIsSystemMusicAppLaunchAgentLoaded() -> Bool? {
        if let output = TerminalHelper.runCommand("""
            launchctl list
        """) {
            return output.contains("com.apple.rcd")
        }
        
        return nil
    }
    
    static func updateSystemMusicAppLaunchAgent(isLoaded: Bool) {
        let verdict = isLoaded ? "load" : "unload"
        
        _ = TerminalHelper.runCommand("""
            launchctl \(verdict) -w /System/Library/LaunchAgents/com.apple.rcd.plist
        """)
    }
    
    private static func runCommand(_ command: String) -> String? {
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
