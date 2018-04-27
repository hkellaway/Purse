//
//  FakeFileSystem.swift
//  Purse
//
//  Created by Harlan Kellaway on 4/25/18.
//  Copyright © 2018 Harlan Kellaway. All rights reserved.
//

import Foundation

import XCTest
@testable import Purse

final class FakeFileSystem: PurseFileSystem {
    
    var appGroupURL: URL? = nil
    var applicationSupportURL: URL? = nil
    var cachesURL: URL? = nil
    var documentsURL: URL? = nil
    var tempURL: URL? = nil
    var userHomeURL: URL? = nil
    
    init() {
        super.init()
    }
    
    override func appGroupContainerURL(appGroupName: String) -> URL? {
        return appGroupURL
    }
    
    override func temporaryDirectoryURL() -> URL? {
        return tempURL
    }
    
    override func userHomeURL(toDirectory directory: Purse.Directory) -> URL? {
        switch directory {
        case .applicationSupport:
            return applicationSupportURL
        case .caches:
            return cachesURL
        case .documents:
            return documentsURL
        default:
            return nil
        }
    }
    
    override func createDirectoryIfNeeded(at url: URL) throws {
        return
    }
    
}
