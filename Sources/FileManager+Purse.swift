//
//  FileManager+Purse.swift
//  Purse
///
// Copyright (c) 2018 Harlan Kellaway
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Foundation

public extension FileManager {
    
    /// Checks if a directory exists at the provided path.
    ///
    /// - Parameter path: Path.
    /// - Returns: True if directory exists, false otherwise.
    func directoryExists(atPath path: String) -> Bool {
        var isDirectory: ObjCBool = false
        
        if fileExists(atPath: path, isDirectory: &isDirectory) {
            return isDirectory.boolValue
        } else {
            return false
        }
    }
    
    /// URL to search path directory relative to the user's home directory (i.e. where user stores personal items (~))
    /// - Parameter searchPathDirectory: Search path directory.
    /// - Returns: URL if determinable, nil otherwise.
    func userHomeDirectoryURL(toSearchPathDirectory searchPathDirectory: FileManager.SearchPathDirectory) -> URL? {
        guard let url = urls(for: searchPathDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return url
    }
    
}
