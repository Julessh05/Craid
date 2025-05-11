//
//  ActionProtocol.swift
//  Craid
//
//  Created by Julian Schumacher on 26.04.22.
//

import Foundation

// All actions have to match one of these two protocols.

/// The Full Action Protocol. Only Actions with a shorthand, or other specific
/// Options have to match this Protocol
internal protocol FullActionProtocol {
    
    /// The Name of the Action.
    static var actionName : String { get }
    
    /// The Shorthand of the Action
    static var actionShortHand : String { get }
    
    /// This Number indicates, how many Arguments this Action
    /// takes. In some cases these are more than one.
    static var argumentsCount : Int { get }
    
    /// The Options you can enter behind the Action Name
    /// Every Action has at least one Option ( -h )
    /// This Options calls the showOnHelp() Method
    static var options : [Option] { get }
    
    /// This Function is called when the User types -h or --help behind
    /// a specific Action
    static func showOnHelp() -> Void
    
    /// Function to execute the Action
    static func execute(args : [Any]?) -> Void
    
    /// The Execute Function called when an Option is passed
    static func execute(option : Option) -> Void
}

/// The bare minimum, an Action has to provide.
/// All Actions have to match at least this protocol.
internal protocol SmallActionProtocol {
    
    /// The Name of the Action.
    static var actionName: String { get }
    
    /// The Options you can enter behind the Action Name
    /// Every Action has at least one Option ( -h )
    /// This Options calls the showOnHelp() Method
    static var options : [Option] { get }
    
    /// This Function is called when the User types -h or --help behind
    /// a specific Action
    static func showOnHelp() -> Void
    
    /// Function to execute the Action
    static func execute(args: [Any]?) -> Void
    
    /// The Execute Function called when an Option is passed
    static func execute(option: Option) -> Void
}
