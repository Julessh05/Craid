//
//  UserFileSystem.swift
//  Craid
//
//  Created by Julian Schumacher on 26.04.22.
//

import Foundation

/// This Struct holds all the Values like Paths and URLs that are
/// different from User to User
internal struct UserFileSystem {
    
    /// The Default File Manager which is used in this struct
    static private let fileManager : FileManager = FileManager.default
    
    static private let backupFileName = "backupPaths"
    
    static private var backupFileLocation : URL {
        return URL(fileURLWithPath: fileManager.currentDirectoryPath + backupFileName)
    }
    
    /// Returns the Path of the Moodle Installation Container .
    /// Usually there the Data are stored
    static internal func getMoodlePath () -> URL {
        return  URL(fileURLWithPath:  "\(fileManager.homeDirectoryForCurrentUser.path)/Library/Containers/com.moodle.moodledesktop/Data/Documents/com.moodle.moodlemobile/sites/")
    }
    
    /// Returns the Directory above the Moodle Directory
    /// Used to check if the Directory does not exist or if you deleted it previously
    static internal func getPreMoodlePath() -> URL {
        return URL(fileURLWithPath: "\(fileManager.homeDirectoryForCurrentUser.path)/Library/Containers/com.moodle.moodledesktop/Data/Documents/com.moodle.moodlemobile/")
    }
    
    /// Returns the Path of the Moodle Installation Container
    /// If this Directory does not exists, Moodle isn't installed
    static internal func getMoodleAppPath() -> URL {
        return URL(fileURLWithPath: "\(fileManager.homeDirectoryForCurrentUser.path)/Library/Containers/com.moodle.moodledesktop/")
    }
    
    static internal func getBackupPaths() throws -> [URL : URL] {
        if !fileManager.fileExists(atPath: backupFileLocation.path) {
            throw NoBackupPathsError()
        }
        do {
            let data = try Data(contentsOf: backupFileLocation)
            let string : String = String(data: data, encoding: .utf8)!
            let lines = string.split(separator: "\n")
            var paths : [URL : URL] = [:]
            for line in lines {
                let splitted = line.split(separator: " : ")
                paths[
                    URL(string: String(splitted[0]))!
                ] = URL(string: String(splitted[1]))
            }
            return paths
        } catch {
            throw InvalidBackupPathsError()
        }
    }
    
    static internal func addPathToBackupPaths(_ paths : [URL : URL]) throws (InvalidDataError) -> Void {
        var content : String = ""
        for (key, value) in paths {
            content += "\(key) : \(value)\n"
        }
        if !fileManager.fileExists(atPath: backupFileLocation.path) {
            fileManager
                .createFile(
                    atPath: backupFileLocation.path,
                    contents: content.data(using: .utf8)
                )
        } else {
            do {
                var currentData = try Data(contentsOf: backupFileLocation)
                currentData += content.data(using: .utf8)!
                try currentData.write(to: backupFileLocation)
            } catch {
                throw InvalidDataError()
            }
        }
    }
}
