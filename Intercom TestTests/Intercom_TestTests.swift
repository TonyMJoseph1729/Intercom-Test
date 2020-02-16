//
//  Intercom_TestTests.swift
//  Intercom TestTests
//
//  Created by Tony on 15/02/2020.
//  Copyright © 2020 Tony M Joseph. All rights reserved.
//

import XCTest

class Intercom_TestTests: XCTestCase {

    // Harcoded customers for test
    let customer1 = Customer(latitude: "53.2451022", name: "Ian Kehoe", longitude: "-6.238335", user_id: 4)
    let customer2 = Customer(latitude: "52.986375", name: "Christina McArdle", longitude: "-6.043701", user_id: 12)
    let customer3 = Customer(latitude: "51.92893", name: "Alice Cahill", longitude: "-10.27699", user_id: 1)
    
    let customerVC = CustomerListingViewController()
    
    func testDistance() {
        let customer = customer1
        let distance = Utilities().distancefrom(customer)
        XCTAssertEqual(distance, 10.566965160122678)
    }
    
    func testInvitedCustomerCount() {
        let customerList = [customer1,customer2,customer3]
        let invitedCustomers = customerVC.fetchInvitedCustomerList(customerList)
        XCTAssertEqual(2, invitedCustomers.count)
    }
    
    func testCustomerListCount() {
        let customerList = Utilities().fetchCustomerList()
            XCTAssertEqual(32, customerList.count)
    }
    
    func testDistanceLabel() {
        let customer = customer1
        let distanceString = CustomerTableViewCell().distanceLabelText(customer)
        XCTAssertEqual(distanceString, "10.57 kms")
    }
    
    func testdegreestoRadianConversion() {
        let radian = 50.0.degreesToRadians
        XCTAssertEqual(0.8726646259971648, radian)
    }
    
    func testCentralAngle() {
        let latitude = Double(Float(customer2.latitude)!).degreesToRadians
        let longitude = Double(Float(customer2.longitude)!).degreesToRadians
        let centralAngle = Utilities().getcentralAngle(latitude, longitude)
        XCTAssertEqual(0.0065560879718088768, centralAngle)
    }
    
    func testSearching() {
        let searchText = "ca"
        let customerList = [customer1,customer2,customer3]
        let filteredArray = customerVC.filterInvitedCustomerArray(searchText, customerList)
        XCTAssertEqual(2, filteredArray.count)
    }
}
