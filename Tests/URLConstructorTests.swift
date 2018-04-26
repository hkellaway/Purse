//
//  URLConstructorTests.swift
//  Purse
//
//  Created by Harlan Kellaway on 4/25/18.
//  Copyright © 2018 Harlan Kellaway. All rights reserved.
//

import Foundation

import XCTest
@testable import Purse

class URLConstructorTests: XCTestCase {
    
    var sut: URLConstructor!
    var fakeAppGroupURL = "someDirectory/AppGroup"
    var fakeApplicationSupportURL = "someDirectory/Application"
    var fakeCachesURL = "someDirectory/Caches"
    var fakeDocumentsURL = "someDirectory/Documents"
    var fakeTempURL = "someDirectory/Temp"
    var fakeUserHomeURL = "someDirectory/Home"
    
    override func setUp() {
        super.setUp()
        
        let fakeFileSystem = FakeFileSystem()
        fakeFileSystem.appGroupURL = URL(string: fakeAppGroupURL)
        fakeFileSystem.applicationSupportURL = URL(string: fakeApplicationSupportURL)
        fakeFileSystem.cachesURL = URL(string: fakeCachesURL)
        fakeFileSystem.documentsURL = URL(string: fakeDocumentsURL)
        fakeFileSystem.tempURL = URL(string: fakeTempURL)
        fakeFileSystem.userHomeURL = URL(string: fakeUserHomeURL)
        
        sut = PurseURLConstructor(fileSystem: fakeFileSystem)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testCreateURL_shouldReturnCorrectURL_forApplicationSupport() {
        let fileName: FileName = "test"
        let actual = try! sut.createURL(fileName: fileName, in: .applicationSupport)
        let expected = URL(string: "file://\(fakeApplicationSupportURL)/test")!
        
        XCTAssertEqual(actual, expected)
    }
    
    func testCreateURL_shouldReturnCorrectURL_forCaches() {
        let fileName: FileName = "test"
        let actual = try! sut.createURL(fileName: fileName, in: .caches)
        let expected = URL(string: "file://\(fakeCachesURL)/test")!
        
        XCTAssertEqual(actual, expected)
    }
    
    func testCreateURL_shouldReturnCorrectURL_forDocuments() {
        let fileName: FileName = "test"
        let actual = try! sut.createURL(fileName: fileName, in: .documents)
        let expected = URL(string: "file://\(fakeDocumentsURL)/test")!
        
        XCTAssertEqual(actual, expected)
    }

    func testCreateURL_shouldReturnCorrectURL_forSharedContainer() {
        let fileName: FileName = "test"
        let appGroupName = "name"
        let actual = try! sut.createURL(fileName: fileName, in: .sharedContainer(appGroupName: appGroupName))
        let expected = URL(string: "file://\(fakeAppGroupURL)/test")!

        XCTAssertEqual(actual, expected)
    }
    
    func testCreateURL_shouldReturnCorrectURL_forTemporary() {
        let fileName: FileName = "test"
        let actual = try! sut.createURL(fileName: fileName, in: .temporary)
        let expected = URL(string: "file://\(fakeTempURL)/test")!
        
        XCTAssertEqual(actual, expected)
    }

}
