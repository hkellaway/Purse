//
//  PurseError.swift
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

/// Purse error.
///
/// - couldNotAccessSharedContainer: Could not access shared container on device.
/// - couldNotAccessTemporaryDirectory: Could not access temporary directory on device.
/// - couldNotAccessUserDomainMask: Could not access user domain mask.
/// - invalidFileName: Invalid filename provided when saving/retrieving object.
public enum PurseError: Error, LocalizedError {
    case couldNotAccessSharedContainer(appGroupName: String)
    case couldNotAccessTemporaryDirectory
    case couldNotAccessUserDomainMask
    case couldNotCreateURLForFileName(fileName: String, directory: Purse.Directory)
    case invalidFileName(value: String)
    
    public var errorDescription: String? {
        switch self {
        case .couldNotAccessSharedContainer(let appGroupName):
            return "Could not access shared container: \(appGroupName)."
        case .couldNotAccessTemporaryDirectory:
            return "Could not access application's temporary directory."
        case .couldNotAccessUserDomainMask:
            return "Could not access file system's user domain mask."
        case .couldNotCreateURLForFileName(let fileName, let directory):
            return "Could not create URL for file name \"\(fileName)\" in directory \"\(directory.description)\""
        case .invalidFileName(let value):
            return "Cannot persist/retrieve object with file name: \(value)"
        }
        
    }
}
