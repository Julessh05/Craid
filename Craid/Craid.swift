//
//  Craid.swift
//  Craid
//
//  Created by Julian Schumacher on 24.04.22.
//

import Foundation

/// The different Options you can pass to the Programm
internal enum Option : String {
    /// The Option to show  the Help
    case help
    
    /// get the Version
    case version
    
    /// Returns the Information about this Tool
    case information
    
    /// Everything else
    case unidentified
    
    init(option : String) {
        switch option {

                // Help Options
            case HelpOption.optionsShortHand:
                self = .help
                break

            case HelpOption.optionsName:
                self = .help
                break

                // Version Options
            case VersionOption.optionsShortHand:
                self = .version
                break

            case VersionOption.optionsName:
                self = .version
                break

                // Information Options
            case InformationOption.optionsName:
                self = .information
                break

                // TODO: find better solution
                // This shouldn't be done like this
            case "--info":
                self = .information
                break

            default:
                self = .unidentified
                break
        }
    }
}

/// All the Actions avaible with Craid
private enum Action : String {
    /// Action to delete the Moodle Downloads Folder
    case clearMoodle
    
    /// Get the Time in a specific Time Zone or City
    case time
    
    /// init a Flutter Project
    //case initFlutter
    
    /// Init a Swift Project
    //case initSwift
    
    /// The Passed Action isn't an Action
    case noAction
    
    init(action : String) {
        switch action {

                // Clear Moodle Actions
            case ClearMoodleAction.actionName:
                self = .clearMoodle
                break

            case ClearMoodleAction.actionShortHand:
                self = .clearMoodle
                break

                // Get Time Action
            case TimeAction.actionName:
                self = .time
                break

            case TimeAction.actionShortHand:
                self = .time
                break
            
            /*
        case InitFlutterAction.actionName:
            self = .initFlutter
            break
            
        case InitFlutterAction.actionShortHand:
            self = .initFlutter
            break
            
        case InitSwiftAction.actionName:
            self = .initSwift
            break
            
        case InitSwiftAction.actionShortHand:
            self = .initSwift
            break
             */

            default:
                self = .noAction
                break
        }
    }
}

/// The main Struct which holds the actual Tool
internal struct Craid {
    
    /// The Version of this Program as a String
    static internal let version : String = "1.2.2"
    
    /// The Method called when the Programm starts
    internal func start() -> Void {
        
        // Get first Argument (Option)
        // The Index 1 is used, because the index
        // 0 is always the Name of the Executable
        /// First Option Argument after the Executable Name
        let optionArgument : String = CommandLine.arguments[1]
        
        if CommandLine.argc > 2 {
            if Converter.isOption(string: CommandLine.arguments[2]) {
                if Converter.isOption(string: optionArgument) {
                    let optionForOption : String = CommandLine.arguments[2]
                    executeOption(option: getOption(option: optionArgument), secondOption: getOption(option: optionForOption))
                } else {
                    let optionForAction : String = CommandLine.arguments[2]
                    executeAction(action: getAction(), option: getOption(option: optionForAction))
                }
            } else {
                CraidIO.showOnError()
                return
            }
        } else if Converter.isOption(string: optionArgument){
            executeOption(option: getOption(option: optionArgument))
        } else if CommandLine.argc > 2 {
            executeAction(action: getAction(), arguments: [CommandLine.arguments[2], CommandLine.arguments[3]])
        } else {
            executeAction(action: getAction())
        }
    }
    
    /// Returns the Option the User entered
    private func getOption(option : String) -> Option {
        return Option(option: option)
    }
    
    /// If no Option is passed, get the Action the User wanted to execute
    private func getAction() -> Action {
        return Action(action: CommandLine.arguments[1])
    }
    
    /// Checks the Option and executes the Action connected to it
    private func executeOption(option: Option) -> Void {
        switch option {
                // Show Help
            case .help:
                HelpOption.execute()
                break

                // Return the Version Number of this Tool
            case .version:
                VersionOption.execute()
                break

                // Show the Information about this Tool
            case .information:
                InformationOption.execute()
                break

                /// Craid cound't  the Option, so the Help is shown
            default:
                CraidIO.showOnError()
                break
        }
    }
    
    /// Checks the Option and the Option behind it to execute it
    private func executeOption(option: Option, secondOption: Option) -> Void {
        switch option {
            case .help:
                HelpOption.execute(option: secondOption)
                break

            case .version:
                VersionOption.execute(option: secondOption)

            case .information:
                InformationOption.execute(option: secondOption)
                break

            default:
                CraidIO.showOnError()
                break
        }
    }
    
    
    /// Checks the Action and executes it, if it is a valid Action.
    /// This Method is called when the Action has an Option
    private func executeAction(action : Action, option : Option) -> Void {
        switch action {
                // User wants the Moodle Directory to be cleared
            case .clearMoodle:
                ClearMoodleAction.execute(option: option)
                break
                // The User wants to know an Option for the Time Action
            case .time:
                TimeAction.execute(option: option)
                break
            /*
        case .initFlutter:
            InitFlutterAction.execute(option: option)
            break
            
        case .initSwift:
            InitSwiftAction.execute(option: option)
            break
             */

                // User has entered no Option. So the Error Indicator is shown
            case .noAction:
                CraidIO.showOnError()
                break
        }
    }
    
    /// Checks the Action and executes it. The arguments are passed, when a specific Action
    /// needs to have more information to run correclty.
    /// This Action only checks the Action that have the Possibility to take arguments.
    /// If you want to execute an Action without Arguments, use the executeAction Method without
    /// any arguments passed
    private func executeAction(action : Action, arguments : [Any]? = nil) -> Void {
        switch action {

                // Execute the Clear Moodle Action and delete the Documents Folder in the Container
            case .clearMoodle:
                ClearMoodleAction.execute()
                break
                // Execute the Time Action
            case .time:
                TimeAction.execute(args: arguments)
                break
            /*
        case .initFlutter:
            InitFlutterAction.execute(args: arguments)
            break
            
        case .initSwift:
            InitSwiftAction.execute(args: arguments)
            break
             */

            case .noAction:
                CraidIO.showOnError()
                break
        }
    }
}
