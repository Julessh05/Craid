//
//  OptionsProtocol.swift
//  Craid
//
//  Created by Julian Schumacher on 27.04.22.
//

import Foundation

// All Options have to match one of these Protocols

/// The Full Options Protocol.
/// only Options that have a shorthand and more have to
/// match this Protocol
internal protocol FullOptionsProtocol {
    
    /// The Name of the Option.
    /// This is the full Length Option and has to be entered
    /// with two dashes ( -- )
    static var optionsName : String { get }
    
    /// The Shorthand of the Option.
    /// Mostly this is only one Letter.
    /// Has to be entered with one dash ( - )
    static var optionsShortHand : String? { get }
    
    /// The Options you can enter behind the Option Name
    /// Every Option has at least one Option ( -h )
    /// This Options calls the showOnHelp() Method
    static var options : [Option] { get }
    
    /// This Function is shown when the User types
    /// -h or --help behind the Option
    static func showOnHelp() -> Void
    
    /// This Fuction executes whatever is done
    /// with this Option
    static func execute() -> Void
    
    /// Executes a specific Option for that option
    static func execute(option: Option) -> Void
}

/// The bare minimum all Options have to provide.
/// All Options have to match at least this Protocol.
internal protocol SmallOptionsProtocol {
    
    /// The Name of the Option.
    /// This is the full Length Option and has to be entered
    /// with two dashes ( -- )
    static var optionsName : String { get }
    
    /// The Options you can enter behind the Option Name
    /// Every Option has at least one Option ( -h )
    /// This Options calls the showOnHelp() Method
    static var options : [Option] { get }
    
    /// This Function is shown when the User types
    /// -h or --help behind the Option
    static func showOnHelp() -> Void
    
    /// This Fuction executes whatever is done
    /// with this Option
    static func execute() -> Void
    
    /// Executes a specific Option for that option
    static func execute(option: Option) -> Void
}
