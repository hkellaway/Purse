//
//  FolderCreator.swift
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

/// Enables manipulation of files on disk.
public protocol FileSystem {
    
    /// Constructs URL given desired file name and Directory type.
    ///
    /// - Parameters:
    ///   - fileName: File name.
    ///   - directory: Directory.
    /// - Returns: URL if able to construct, nil otherwise.
    /// - Throws: Error if issue constructing URL.
    func url(fileName: FileName, in directory: Purse.Directory) throws -> URL
    
    /// URL for shared container of provided app group.
    ///
    /// - Parameter appGroupName: App group name.
    /// - Returns: URL for app group.
    func appGroupContainerURL(appGroupName: String) -> URL?
    
    /// URL for temporary directory.
    ///
    /// - Returns: URL for temporary directory.
    func temporaryDirectoryURL() -> URL?
    
    /// URL of user's home to the provided directory.
    ///
    /// - Parameter directory: Directory.
    /// - Returns: Nil if provided directory isn't a SearchPathDirectory, url otherwise.
    func userHomeURL(toDirectory directory: Purse.Directory) -> URL?
    
    /// Creates directory at provided URL if one does not exist yet.
    ///
    /// - Parameter url: URL.
    /// - Throws: Error if issue creating directory.
    func createDirectoryIfNeeded(at url: URL) throws
    
    /// Checks if a directory exists at the provided path.
    ///
    /// - Parameter path: Path.
    /// - Returns: True if directory exists, false otherwise.
    func directoryExists(atPath path: String) -> Bool
    
}

/// Default Purse FileSystem.
/// Wraps FileManager.
public class PurseFileSystem: FileSystem {
    
    // MARK: - Class properties
    
    /// Shared instance.
    public static var shared = PurseFileSystem()
    
    // MARK: - Properties
    
    /// File manager.
    public let fileManager: FileManager
    
    // MARK: - Init
    
    public init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }
    
    // MARK: - Protocol conformance
    
    // MARK: FileSystem
    
    public func url(fileName: FileName, in directory: Purse.Directory) throws -> URL {
        guard let path = fileName.prepareForUseInFilePath() else {
            throw PurseError.invalidFileName(value: fileName)
        }
        
        let fileLocation: URL
        
        switch directory {
        case .applicationSupport, .caches, .documents:
            guard let url = userHomeURL(toDirectory: directory) else {
                throw PurseError.couldNotAccessUserDomainMask
            }
            
            fileLocation = url
        case .sharedContainer(let appGroupName):
            guard let url = appGroupContainerURL(appGroupName: appGroupName) else {
                throw PurseError.couldNotAccessSharedContainer(appGroupName: appGroupName)
            }
            
            fileLocation = url
        case .temporary:
            guard let url = temporaryDirectoryURL() else {
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
    
    public func appGroupContainerURL(appGroupName: String) -> URL? {
        return fileManager.containerURL(forSecurityApplicationGroupIdentifier: appGroupName)
    }
    
    public func temporaryDirectoryURL() -> URL? {
        return URL(string: NSTemporaryDirectory())
    }
    
    public func userHomeURL(toDirectory directory: Purse.Directory) -> URL? {
        let searchPathDirectory: FileManager.SearchPathDirectory?
        
        switch directory {
        case .applicationSupport:
            searchPathDirectory = .applicationSupportDirectory
        case .caches:
            searchPathDirectory = .cachesDirectory
        case .documents:
            searchPathDirectory = .documentDirectory
        case .temporary, .sharedContainer(_):
            searchPathDirectory = nil
        }
        
        guard let directory = searchPathDirectory else {
            assertionFailure("[Purse] Unexpected Directory type for userHomeURL(:)")
            return nil
        }
        
        return fileManager.urls(for: directory, in: .userDomainMask).first
    }
    
    public func createDirectoryIfNeeded(at url: URL) throws {
        let folderURL = url.deletingLastPathComponent()
        
        if directoryExists(atPath: folderURL.path) {
            return
        }
        
        try fileManager.createDirectory(at: folderURL,
                                        withIntermediateDirectories: true,
                                        attributes: nil)
    }
    
    public func directoryExists(atPath path: String) -> Bool {
        var isDirectory: ObjCBool = false
        
        if fileManager.fileExists(atPath: path, isDirectory: &isDirectory) {
            return isDirectory.boolValue
        } else {
            return false
        }
    }
    
}
