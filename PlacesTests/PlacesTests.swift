//
//  PlacesTests.swift
//  PlacesTests
//
//  Created by Богдан Маншилин on 14/07/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import XCTest
import Alamofire
@testable import Places

class PlacesTests: XCTestCase {
    
    var places: PlacesServiceProtocol!
    
    override func setUp() {
        super.setUp()
        places = PlacesService(sessionManager: SessionManager())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPlaces() {
        
        let semaphore = DispatchSemaphore(value: 0)
        
        places.places { (result) in
            
            dump(result)
            
            if let error = result.error {
                XCTFail("\(error)")
            }
            
            semaphore.signal()
        }
        
        let timeout = DispatchTime.now() + .seconds(10)
        if semaphore.wait(timeout: timeout) == .timedOut {
            XCTFail("timed out")
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
