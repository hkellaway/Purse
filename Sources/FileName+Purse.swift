//
//  FileName+Purse.swift
//  Purse
//
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

public extension FileName {
    
    /// Removes all slashes from the beginning of the file name.
    ///
    /// - Parameter fileName: File name.
    /// - Returns: File name with no slashes at beginning.
    static func removeSlashesFromBeginning(ofFileName fileName: FileName) -> FileName {
        var mutableFileName = fileName
        
        if mutableFileName.startsWithCharacter("/") {
            mutableFileName.remove(at: mutableFileName.startIndex)
        }
        
        if mutableFileName.startsWithCharacter("/") {
            mutableFileName = removeSlashesFromBeginning(ofFileName: mutableFileName)
        }
        
        return mutableFileName
    }
    
    /// Prepares a file name for use in a file path.
    ///
    /// - Returns: <#return value description#>
    func prepareForUseInFilePath() -> FileName? {
        let clean = FileName.removeSlashesFromBeginning(
            ofFileName: withoutCharacters(inSet: .invalidPathCharacters)
        )
        
        guard !isEmpty && self != "." else {
            return nil
        }
        
        return clean
    }
    
    /// Whether the file name indicates a directory (i.e. ends with '/')
    ///
    /// - Returns: True if a directory, false otherwise.
    func isDirectory() -> Bool {
        return hasSuffix("/")
    }
    
}
