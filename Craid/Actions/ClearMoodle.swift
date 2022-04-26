//
//  ClearMoodle.swift
//  Craid
//
//  Created by Julian Schumacher on 26.04.22.
//

import Foundation

/// Struct that executes the clear-moodle Action
internal struct ClearMoodle : ActionProtocol {
    
    /// Deletes the Moodle Documents Directory
    static internal func execute() -> Void {
        // Create
        /// FIleManager Object to execute Actions
        let fileManager : FileManager = FileManager.default
        
        // Check if File exists
        if fileManager.fileExists(atPath: UserFileSystem.getMoodlePath().path) {
            // File Exists
            do {
                // Try to remove the Directory
                try fileManager.removeItem(at: UserFileSystem.getMoodlePath())
                // Error was thrown
            } catch let fileError {
                // Show the Error and some help
                CraidIO.communicate(message: "\(fileError)", whereTo: .error)
                CraidIO.showOnError()
            }
        } else {
            // The Directory does not exist
            if fileManager.fileExists(atPath: UserFileSystem.getPreMoodlePath().path) {
                CraidIO.communicate(message: "You executed this Command and cleared the Directory already.")
                CraidIO.communicate(message: "Since the last Time you did it, moodle did not store any Data")
            } else {
                CraidIO.communicate(message: "Directory does not exist \(UserFileSystem.getMoodlePath())")
                CraidIO.showOnError()
            }
        }
    }
}