//
//  Purse.swift
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

// 👜 Purse
/// A fashionable accessory to persist data to disk
public class Purse: DiskPersistence {
    
    // MARK: - Types
    
    /// Directory to be persisted to.
    ///
    /// - applicationSupport: For application-created support files. In general, this directory includes files that the app uses to run but that should remain hidden from the user. This directory can also include data files, configuration files, templates and modified versions of resources loaded from the app bundle. Files in this directory are automatically backed up by iCloud. To disable iCloud backup for a specific file, use the .doNotBackup(:in:) method.
    /// - caches: For data that can be downloaded again or regenerated, such as database cache files and downloadable content. Use for application-specific support files that you want to persist between launches of the application or during application updates. Note: iTunes removes such files during a full restoration of the device and that the system may delete this directory to free up disk space.
    /// - documents: For documents and data that is user-generated or that cannot be recreated by your application. Files in this directory are automatically backed up by iCloud. To disable iCloud backup for a specific file, use the .doNotBackup(:in:) function.
    /// - sharedContainer: For apps that share files on device with other apps from the same developer. The "app group" identifier string is used to locate the corresponding group's shared directory.
    /// - temporary: For data that is used only temporarily. Although these files are not backed up to iCloud, remember to delete such files when done with them so they do not continue to consume space on disk. The system will periodically purge these files when your app is not running.
    public enum Directory: CustomStringConvertible {
        case applicationSupport
        case caches
        case documents
        case sharedContainer(appGroupName: String)
        case temporary
        
        public var description: String {
            switch self {
            case .applicationSupport:
                return "<Application_Home>/Library/Application"
            case .caches:
                return "<Application_Home>/Library/Caches"
            case .documents:
                return "<Application_Home>/Documents"
            case .sharedContainer(let appGroupName):
                return appGroupName
            case .temporary:
                return "<Application_Home>/tmp"
            }
        }
    }
    
    // MARK: - Class properties
    
    /// Shared instance.
    public static var shared = Purse()
    
    // MARK: - Properties
    
    /// Converts objects to and from data to store on disk.
    public var dataConverter: DataConverter
    
    /// File system.
    public var fileSystem: FileSystem
    
    // MARK: - Init
    
    public init(dataConverter: DataConverter = PurseJSONDataConverter(),
                fileSystem: FileSystem = PurseFileSystem.shared) {
        self.dataConverter = dataConverter
        self.fileSystem = fileSystem
    }
    
    // MARK: - Protocol conformance
    
    // MARK: DiskPeristence
    
    public func persist<T: Encodable>(_ object: T, to directory: Directory, fileName: FileName) throws {
        guard !fileName.isDirectory() else {
            throw PurseError.invalidFileName(value: fileName)
        }
        
        let data = try dataConverter.objectToData(object)
        let url = try fileSystem.url(fileName: fileName, in: directory)
        try fileSystem.createDirectoryIfNeeded(at: url)
        try fileSystem.write(data: data, toURL: url, options: .atomic)
        return
    }

    public func retrieve<T: Decodable>(from directory: Directory, fileName: FileName, as objectType: T.Type) throws -> T {
        guard !fileName.isDirectory() else {
            throw PurseError.invalidFileName(value: fileName)
        }
        
        let url = try fileSystem.url(fileName: fileName, in: directory)
        let data = try Data(contentsOf: url)
        let object: T = try dataConverter.objectFromData(data)
        return object
    }
    
}
