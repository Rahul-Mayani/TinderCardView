//
//  PeopleCarouselUITests.swift
//  PeopleCarouselUITests
//
//  Created by Rahul Mayani on 15/10/20.
//

import XCTest

class PeopleCarouselUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        

        let peopleElement = app.otherElements["People"]
        peopleElement.tap()
        app/*@START_MENU_TOKEN@*/.buttons["lifepreserver"]/*[[".otherElements[\"People\"].buttons[\"lifepreserver\"]",".buttons[\"lifepreserver\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    // MARK: Custome Test UI case
    func testSwipeLeftRight() {
        let app = XCUIApplication()
        app.launch()
        let emailMilagrosDuranExampleComGenderFemaleNatEsStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Email: milagros.duran@example.com\n\nGender: female\n\nNat: ES\n\n\n"]/*[[".otherElements[\"People\"].staticTexts[\"Email: milagros.duran@example.com\\n\\nGender: female\\n\\nNat: ES\\n\\n\\n\"]",".staticTexts[\"Email: milagros.duran@example.com\\n\\nGender: female\\n\\nNat: ES\\n\\n\\n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        emailMilagrosDuranExampleComGenderFemaleNatEsStaticText.swipeRight()
        emailMilagrosDuranExampleComGenderFemaleNatEsStaticText/*@START_MENU_TOKEN@*/.swipeLeft()/*[[".swipeUp()",".swipeLeft()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    }
    
    func testFavouriteButtonTap() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["love"].tap()
    }
    
    func testUserInfoButtonTap() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["person"].tap()
    }
}
