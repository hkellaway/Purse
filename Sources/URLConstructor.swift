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

/// Constructs URLs to locations on disk.
public protocol URLConstructor {
    
    /// Creates URL of file in provided directory type.
    ///
    /// - Parameters:
    ///   - fileName: File name.
    ///   - directory: Directory.
    /// - Returns: URL if created successfully, false otherwise.
    /// - Throws: Error if issue constructing URL.
    func createURL(fileName: FileName, in directory: Purse.Directory) throws -> URL
    
}

/// Default Purse URL
public final class PurseURLConstructor: URLConstructor {
    
    // MARK: - Properties
    
    /// File system.
    public let fileSystem: FileSystem
    
    // MARK: - Init
    
    public init(fileSystem: FileSystem = PurseFileSystem.shared) {
        self.fileSystem = fileSystem
    }
    
    // MARK: - Protocol Conformance
    
    // MARK: URLConstructor
    
    public func createURL(fileName: FileName, in directory: Purse.Directory) throws -> URL {
        guard let path = fileName.prepareForUseInFilePath() else {
            throw PurseError.invalidFileName(value: fileName)
        }
        
        let fileLocation: URL
        
        switch directory {
        case .applicationSupport, .caches, .documents:
            guard let url = fileSystem.userHomeURL(toDirectory: directory) else {
                throw PurseError.couldNotAccessUserDomainMask
            }
            
            fileLocation = url
        case .sharedContainer(let appGroupName):
            guard let url = fileSystem.appGroupContainerURL(appGroupName: appGroupName) else {
                 throw PurseError.couldNotAccessSharedContainer(appGroupName: appGroupName)
            }

            fileLocation = url
        case .temporary:
            guard let url = fileSystem.temporaryDirectoryURL() else {
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

}
