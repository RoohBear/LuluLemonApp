//
//  UIKitVersionTests.swift
//  UIKitVersionTests
//
//  Created by G Bear on 2021-02-24.
//

import XCTest
@testable import UIKitVersion

class UIKitVersionTests: XCTestCase
{
	var model = LuluModel()
	
	override func setUpWithError() throws
	{
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws
	{
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws
	{
		DispatchQueue.main.async {
			self.model.addGarment(name:"fooh")
			XCTAssert(self.model.arrGarments.count == 1)

			self.model.addGarment(name:"pooh")
			XCTAssert(self.model.arrGarments.count == 2)

			self.model.addGarment(name:"booh")
			XCTAssert(self.model.arrGarments.count == 3)

			self.model.addGarment(name:"")	// this should not get added so the count should still be 3
			XCTAssert(self.model.arrGarments.count == 3)
		}
		
		// This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws
	{
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
