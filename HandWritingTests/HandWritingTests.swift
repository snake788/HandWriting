//
//  HandWritingTests.swift
//  HandWritingTests
//
//  Created by Aurélien WOLFERT on 19/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import XCTest
@testable import HandWriting

class HandWritingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchAllHandWritingsCount() {
        let asyncExpectation = expectationWithDescription("FetchAllHandWritings")
        var handWritings = Array<HandWriting>()
        
        WSManager.fetchAllHandWritings { (allHandWritings, error) in
            if error == nil {
                handWritings = allHandWritings!
            } else {
                XCTFail((error?.localizedDescription)!)
            }
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(10.0) { (error) in
            XCTAssertNil(error, "It's too longs... something get wrong to fetch all handwritings!")
            
            XCTAssertGreaterThan(handWritings.count, 0)
        }
    }
    
    func testGetRenderPNGType() {
        let asyncExpectation = expectationWithDescription("GetRenderPNG")
        var render: NSData?
        let handWritingDict = [
            "id": "2D5QW0F80001",
            "title": "Molly",
            "date_created": "2015-04-30T21:27:45.979398Z",
            "date_modified": "2016-01-06T20:28:09.55861Z",
            "rating_neatness": 1459,
            "rating_cursivity": 1286,
            "rating_embellishment": 1367,
            "rating_character_width": 1339]
        let sampleHandWriting = HandWriting(dictionnary: handWritingDict)
        let renderOptionsDict = [
            "text":"Texte",
            "handwriting_size":20,
            "handwriting_color":"#000000",
            "width":400,
            "height":400,
            "line_spacing":1.5]
        
        let sampleRenderOptions = RenderOptions(dictionnary: renderOptionsDict, handWriting: sampleHandWriting)
        
        WSManager.getRenderPNG(sampleRenderOptions) { (renderPNG, error) in
            if error == nil {
                render = renderPNG
            } else {
                XCTFail((error?.localizedDescription)!)
            }
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(10.0) { (error) in
            XCTAssertNil(error, "It's too longs... something get wrong to get render PNG!")
            
            XCTAssertTrue(render != nil)
        }
    }
}
