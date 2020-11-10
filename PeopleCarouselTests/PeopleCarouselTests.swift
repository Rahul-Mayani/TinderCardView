//
//  PeopleCarouselTests.swift
//  PeopleCarouselTests
//
//  Created by Rahul Mayani on 15/10/20.
//

import RxSwift
import RxCocoa

import XCTest
@testable import PeopleCarousel

class PeopleCarouselTests: XCTestCase {

    // MARK: - Variable -
    private let rxbag = DisposeBag()
    private let peopleVM = PeopleVM()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // get data from server or local db
        peopleVM.getDataFromLocalDBOrServer(true)
        
        // data response handling by rxswift
        peopleVM.dataArray.subscribe(onNext: { (data) in
            XCTAssertTrue(!data.isEmpty)
        }) => rxbag
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /// Offline load testing
    func testOfflineLoad() {
        peopleVM.getDataFromLocalDBOrServer()
        
        // data response handling by rxswift
        peopleVM.dataArray.subscribe(onNext: { [weak self] (data) in
            guard let self = self else { return }
            XCTAssertTrue(!data.isEmpty)
            self.peopleVM.updateFavouriteData(data.first!)
        }) => rxbag
    }
}
