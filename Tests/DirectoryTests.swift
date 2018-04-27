//
//  PurseTests.swift
//  PurseTests
//
//  Created by Harlan Kellaway on 4/24/18.
//  Copyright © 2018 Harlan Kellaway. All rights reserved.
//

import XCTest
@testable import Purse

class DirectoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDescription_shouldHaveCorrectValue() {
        XCTAssertEqual(Purse.Directory.applicationSupport.description, "<Application_Home>/Library/Application")
        XCTAssertEqual(Purse.Directory.caches.description, "<Application_Home>/Library/Caches")
        XCTAssertEqual(Purse.Directory.documents.description, "<Application_Home>/Documents")
        XCTAssertEqual(Purse.Directory.sharedContainer(appGroupName: "test").description, "test")
        XCTAssertEqual(Purse.Directory.temporary.description, "<Application_Home>/tmp")
    }
    
}
