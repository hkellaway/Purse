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
    
    override func setUp() {
        super.setUp()
        
        sut = PurseURLConstructor()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testCreateURL_shouldReturnCorrectURL_forApplicationSupport() {
        let fileName: FileName = "test"
        let actual = try! sut.createURL(fileName: fileName, in: .applicationSupport)
        let expected = URL(string: "file:///Users/harlan/Library/Developer/CoreSimulator/Devices/B5DEFB5F-4E06-4146-8AA5-4A7690510E9F/data/Library/Application%20Support/test")!
        
        XCTAssertEqual(actual, expected)
    }
    
    func testCreateURL_shouldReturnCorrectURL_forCaches() {
        let fileName: FileName = "test"
        let actual = try! sut.createURL(fileName: fileName, in: .caches)
        let expected = URL(string: "file:///Users/harlan/Library/Developer/CoreSimulator/Devices/B5DEFB5F-4E06-4146-8AA5-4A7690510E9F/data/Library/Caches/test")!
        
        XCTAssertEqual(actual, expected)
    }
    
    func testCreateURL_shouldReturnCorrectURL_forDocuments() {
        let fileName: FileName = "test"
        let actual = try! sut.createURL(fileName: fileName, in: .documents)
        let expected = URL(string: "file:///Users/harlan/Library/Developer/CoreSimulator/Devices/B5DEFB5F-4E06-4146-8AA5-4A7690510E9F/data/Documents/test")!
        
        XCTAssertEqual(actual, expected)
    }

//    func testCreateURL_shouldReturnCorrectURL_forSharedContainer() {
//        let fileName: FileName = "test"
//        let appGroupName = "name"
//        let actual = try! sut.createURL(fileName: fileName, in: .sharedContainer(appGroupName: appGroupName))
//        let expected = URL(string: "https://google.com")!
//
//        XCTAssertEqual(actual, expected)
//    }
    
    func testCreateURL_shouldReturnCorrectURL_forTemporary() {
        let fileName: FileName = "test"
        let actual = try! sut.createURL(fileName: fileName, in: .temporary)
        let expected = URL(string: "file:///Users/harlan/Library/Developer/CoreSimulator/Devices/B5DEFB5F-4E06-4146-8AA5-4A7690510E9F/data/tmp/test")!
        
        XCTAssertEqual(actual, expected)
    }

}
