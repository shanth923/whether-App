//
//  WhetherNowTests.swift
//  WhetherNowTests
//
//  Created by runku shanth kumar on 11/04/24.
//

import XCTest
import Foundation
@testable import WhetherNow


final class WhetherNowTests: XCTestCase {

    var viewModel: WheaterViewModel!
    override func setUpWithError() throws {
        viewModel = WheaterViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testPrperties() {
        XCTAssertEqual(viewModel.searchString, "Search")
        XCTAssertEqual(viewModel.todayString, "Today")
        XCTAssertEqual(viewModel.whetherNowString, "Weather now")
    }
    
    func testgetCurrentWeather() async {
        
        let lat = 40.730610
        let long = -73.935242
        do {
            let response = try await viewModel.getCurrentWeather(latitude: lat, longitude: long)
            XCTAssertNotNil(viewModel.responseBody)
        }
        catch {
            print("error")
        }
        
    }
    
    
    func testGetNextThreeDaysWhether() async {
        do {
            let response = try await viewModel.getNextThreeDaysWhether(city: "mumbai")
            XCTAssertNotNil(viewModel.responseBodyListData)
            XCTAssertEqual(response.city?.name?.lowercased(), "mumbai")
        }
        catch {
            print("error")
        }
        
    }
    
    
    

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
