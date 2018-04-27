//
//  URL+Purse.swift
//  Purse
//
//  Created by Harlan Kellaway on 4/25/18.
//  Copyright © 2018 Harlan Kellaway. All rights reserved.
//

import Foundation

public extension URL {
    
    /// Identifies url as a file (i.e. file://).
    static var fileIdentifier = "file://"
    
    /// Prepends identifier that marks URL as a file if its not
    /// already present.
    ///
    /// - Returns: URL with file identifier.
    func prependFileIdentifierIfNotPresent() -> URL? {
        guard !startsWithFileIdentifier() else {
            return self
        }
        
        return prepend(URL.fileIdentifier)
    }
    
    /// Prepends the provided string to the URL.
    ///
    /// - Parameter string: String to prepend.
    /// - Returns: URL with string prepended.
    func prepend(_ string: String) -> URL? {
        return URL(string: string + absoluteString)
    }
    
    /// Whether the URL starts with an identifier that marks it as a file.
    ///
    /// - Returns: True if URL starts with file identifier, false otherwise.
    func startsWithFileIdentifier() -> Bool {
        return absoluteString.startsWithString(URL.fileIdentifier)
    }
    
    /// Appends the provided optional path if it has a value.
    ///
    /// - Parameters:
    ///   - path: Optional path.
    ///   - isDirectory: Whether the resulting URL should be a directory.
    /// - Returns: URL created by appending path if possible.
    func appendPathIfPossible(path: String?, isDirectory: Bool) -> URL {
        guard let path = path else {
            return self
        }
        
        return appendingPathComponent(path, isDirectory: isDirectory)
    }
    
}
