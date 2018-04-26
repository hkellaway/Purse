//
//  String+Purse.swift
//  Purse
//
//  Created by Harlan Kellaway on 4/25/18.
//  Copyright © 2018 Harlan Kellaway. All rights reserved.
//

import Foundation

public extension String {
    
    /// Whether the string starts with the provided string.
    ///
    /// - Parameter string: String to check against.
    /// - Returns: True if starts with provided string, false otherwise.
    func startsWithString(_ string: String) -> Bool {
        return lowercased().prefix(string.count) == string
    }
    
    /// Whether the first character of the string is the one provided.
    ///
    /// - Parameter character: Character to check against.
    /// - Returns: True if character is first, false otherwise.
    func startsWithCharacter(_ character: String) -> Bool {
        return firstCharacter() == character
    }
    
    /// First character of string.
    ///
    /// - Returns: First character.
    func firstCharacter() -> String.SubSequence {
        return prefix(1)
    }
    
    /// Removes characters in provided set.
    ///
    /// - Parameter characterSet: Set of characters to remove.
    /// - Returns: String with characters removed.
    func withoutCharacters(inSet characterSet: CharacterSet) -> String {
        return components(separatedBy: characterSet).joined(separator: "")
    }
    
}
