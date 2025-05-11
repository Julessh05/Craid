//
//  BackupAction.swift
//  Craid
//
//  Created by Julian Schumacher on 11.05.25.
//

import Foundation

internal struct BackupAction: FullActionProtocol {
    static var actionName: String = "backup"

    static var actionShortHand: String = "bu"

    static var argumentsCount: Int = 0

    static var options: [Option] = [.help]

    static func showOnHelp() {
        CraidIO.communicate(message: "The backup command action lets you backup a specific folder with all sub-folders and files to another location\nAdd all locations via the add-backup-paths command")
    }

    static func execute(args: [Any]?) {
        do {
            let paths = try UserFileSystem.getBackupPaths()
            for (origin, backup) in paths {
                try FileManager.default.copyItem(atPath: origin.path(), toPath: backup.path())
            }
        } catch {
            
        }
    }

    static func execute(option: Option) {
        if options.contains(option) {
            switch option {
            case .help:
                showOnHelp()
                break
            default:
                break
            }
        } else {
            CraidIO.showOnError()
        }
    }

    
}
