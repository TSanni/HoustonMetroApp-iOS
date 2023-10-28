//
//  MetroInfoViewModel_Tests.swift
//  HoustonMetro_Tests
//
//  Created by Tomas Sanni on 10/27/23.
//

import XCTest
@testable import HoustonMetro
import Combine

final class MetroInfoViewModel_Tests: XCTestCase {
    // Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
    // Naming Structure: test_[struct or class]_[variable or function]_[expected result]

    // Testing Structure: Given, When, Then
    var viewModel: MetroInfoViewModel?
    var cancellables = Set<AnyCancellable>()

    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        viewModel = MetroInfoViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        viewModel = nil
    }
    
    
    func test_MetroInfoViewModel_dataExists_shouldStartFalse() {
        
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        
        
        
        // Then
        XCTAssertFalse(vm.dataExists)
    }
    
    func test_MetroInfoViewModel_date_shouldStartNil() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        
        // Then
        XCTAssertNil(vm.date)
    }

    
    func test_MetroInfoViewModel_routes_shouldBeMoreThan10() {
        
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after a seconds")

        
        MetroManager.instance.getAllRoutes { returnedRoutes in
            vm.routes = returnedRoutes
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.routes.value.count, 10)

    }
    
    func test_MetroInfoViewModel_stopsForRoute_shouldBeAtLeast1() {
        
        // Given
        let vm = MetroInfoViewModel()
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after a seconds")
        
        MetroManager.instance.getAllStopsForRoute(routeId: "002") { returnedStops in
            
            if returnedStops.value.isEmpty {
                vm.stopsForRoute = [Stops.StopsHolder]
            } else {
                vm.stopsForRoute = returnedStops.value
            }
            
            
            expectation.fulfill()
        }
        
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.stopsForRoute.count, 1)
    }
    
    

}
