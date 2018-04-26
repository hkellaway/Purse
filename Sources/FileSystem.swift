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
    
    private init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }
    
    // MARK: - Protocol conformance
    
    // MARK: FileSystem
    
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
            assertionFailure("[Purse] Unexpected directory type for userHomeURL(:)")
            return nil
        }
        
        return fileManager.urls(for: directory, in: .userDomainMask).first
    }
    
    public func createDirectoryIfNeeded(at url: URL) throws {
        let folderURL = url.deletingLastPathComponent()
        
        if fileManager.directoryExists(atPath: folderURL.path) {
            return
        }
        
        try fileManager.createDirectory(at: folderURL,
                                        withIntermediateDirectories: true,
                                        attributes: nil)
    }
    
}
