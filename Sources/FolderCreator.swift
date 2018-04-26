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

/// Creates folders on disk.
public protocol FolderCreator {
    
    /// Creates a new folder if one doesn't exist at the provided URL.
    ///
    /// - Parameter url: URL of folder.
    /// - Throws: Error if issue creating folder.
    func createFolderIfNeeded(at url: URL) throws
    
}

public final class PurseFolderCreator: FolderCreator {
    
    // MARK: - Properties
    
    /// File manager.
    public let fileManager: FileManager
    
    // MARK: - Init
    
    public init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }
    
    // MARK: - Protocol conformane
    
    // MARK: FolderCreator
    
    public func createFolderIfNeeded(at url: URL) throws {
        let folderURL = url.deletingLastPathComponent()
        
        if fileManager.directoryExists(atPath: folderURL.path) {
            return
        }
        
        try fileManager.createDirectory(at: folderURL,
                                        withIntermediateDirectories: true,
                                        attributes: nil)
    }
    
}
