//
//  URLConstructor.swift
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

public protocol URLConstructor {
    
    func createURL(fileName: FileName, in directory: Purse.Directory) throws -> URL
    
}

public final class PurseURLConstructor: URLConstructor {
    
    // MARK: - Properties
    
    /// File manager.
    public let fileManager: FileManager
    
    // MARK: - Init
    
    public init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }
    
    // MARK: - Protocol Conformance
    
    // MARK: URLConstructor
    
    public func createURL(fileName: FileName, in directory: Purse.Directory) throws -> URL {
        guard let path = fileName.prepareForUseInFilePath() else {
            throw PurseError.invalidFileName(value: fileName)
        }
        
        let fileLocation: URL
        
        switch directory {
        case .applicationSupport:
            fileLocation = try userHomeDirectoryURL(toSearchPathDirectory: .applicationSupportDirectory)
        case .caches:
            fileLocation = try userHomeDirectoryURL(toSearchPathDirectory: .cachesDirectory)
        case .documents:
            fileLocation = try userHomeDirectoryURL(toSearchPathDirectory: .documentDirectory)
        case .sharedContainer(let appGroupName):
            guard let url = fileManager.containerURL(forSecurityApplicationGroupIdentifier: appGroupName) else {
                throw PurseError.couldNotAccessSharedContainer(appGroupName: appGroupName)
            }

            fileLocation = url
        case .temporary:
            guard let url = URL(string: NSTemporaryDirectory()) else {
                throw PurseError.couldNotAccessTemporaryDirectory
            }

            fileLocation = url
        }
        
        guard let url = fileLocation
            .appendPathIfPossible(path: path, isDirectory: false)
            .prependFileIdentifierIfNotPresent() else {
            throw PurseError.couldNotCreateURLForFileName(fileName: fileName, directory: directory)
        }
        
        return url
    }
    
    // MARK: - Instance functions
    
    // MARK: Private instance functions
    
    private func userHomeDirectoryURL(toSearchPathDirectory searchPathDirectory: FileManager.SearchPathDirectory) throws -> URL {
        guard let url = fileManager.userHomeDirectoryURL(toSearchPathDirectory: searchPathDirectory) else {
            throw PurseError.couldNotAccessUserDomainMask
        }
        
        return url
    }

}
