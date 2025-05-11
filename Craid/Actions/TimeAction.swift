//
//  TimeAction.swift
//  Craid
//
//  Created by Julian Schumacher on 05.05.22.
//

import Foundation

/// An Action to get the Time in any City of this Planet
internal struct TimeAction : FullActionProtocol {
    
    /// The Name of the Action Time.
    /// This is only the first Word, the so called "Trigger Word".
    /// This Word indicates the Action.
    static var actionName: String = "time"

    /// The Shorthand of the Action
    static var actionShortHand: String = "t"

    /// This shows, that the time Action needs 3 arguments.
    /// The first one is time, the second one in and the last one the
    /// capital.
    static var argumentsCount: Int = 3
    
    /// The avaible options for this Action
    static var options: [Option] = [.help]
    
    
    static func showOnHelp() {
        CraidIO.communicate(message: "Get the current Time in any Capital")
    }
    
    static func execute(args : [Any]?) {
        if args == nil || args?.count ?? 0 < argumentsCount {
            CraidIO.showOnNotEnoughArguments()
        } else {
            let city : String = args![1] as! String
            let time : String = TimeValues.getTime(city: city)
            CraidIO.communicate(message: "Time in \(city): \(time)")
        }
    }
    
    static func execute(option: Option) {
        switch option {
        case .help:
            showOnHelp()
            break
        default:
            break
        }
    }
    
    
}
