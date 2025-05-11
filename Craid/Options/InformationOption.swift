//
//  InformationOption.swift
//  Craid
//
//  Created by Julian Schumacher on 22.05.22.
//

import Foundation

internal struct InformationOption : SmallOptionsProtocol {
    
    /// The Name you have to answer to execute the Option
    static var optionsName: String = "--information"
    
    
    static var options: [Option] = [.help]
    
    /// After the User typed -h or --help after the option, this is called
    static func showOnHelp() {
        CraidIO.communicate(message: "Shows you the Information about this Tool")
    }
    
    static func execute() {
        VersionOption.execute()
        CraidIO.communicate(message: "© 2022 - 2025 Julian Schumacher")
        CraidIO.communicate(message: "Project Repository: https://github.com/Julessh05/Craid")
    }
    
    static func execute(option: Option) {
        if(options.contains(option)) {
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
