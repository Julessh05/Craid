//
//  BackupConfigActions.swift
//  Craid
//
//  Created by Julian Schumacher on 11.05.25.
//

import Foundation

internal struct AddPathsToBackupConfigAction: FullActionProtocol {
    static var actionName: String = "add-backup-paths"

    static var actionShortHand: String = "add-bup"

    static var argumentsCount: Int = 2

    static var options: [Option] = [.help]

    static func showOnHelp() {
        CraidIO.communicate(message: "Add files to the list of backup files with this action. You have to pass two arguments: the path to the file and the path to the backup directory.")
    }

    static func execute(args: [Any]?) {
        if args == nil || args!.count < 2 {
            // TODO: throw error
            return
        }
        UserFileSystem.addPathToBackupPaths(
                [
                    URL(string: args![0] as! String)! : URL(string: args![1] as! String)!
                ]
            )
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
