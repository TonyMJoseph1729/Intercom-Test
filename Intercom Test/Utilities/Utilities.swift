//
//  Utilities.swift
//  Intercom Test
//
//  Created by Tony on 15/02/2020.
//  Copyright © 2020 Tony M Joseph. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    // Find distance of customer from Intercom Office
    func distancefrom(_ customer: Customer) -> Double {
        let latitude = Double(Float(customer.latitude)!).degreesToRadians
        let longitude = Double(Float(customer.longitude)!).degreesToRadians
        let centralAngle = getcentralAngle(latitude, longitude)
        let distance = EquationConstants.radiusOfEarth * centralAngle
        return distance
    }
    
    // Find the central Angle for distance calculation
    func getcentralAngle(_ latitude: Double,_ longitude: Double) -> Double {
        return acos((sin(latitude) * sin(EquationConstants.intercomLatitude)) + (cos(latitude) * cos(EquationConstants.intercomLatitude) * cos(abs(longitude - EquationConstants.intercomLongitude))))
    }
    
    // fetch all Customers from the URL
    func fetchCustomerList() -> [Customer] {
        var customerList = [Customer]()
        let customerFileName = "CustomerList"
        if let path = Bundle.main.path(forResource: customerFileName, ofType: "txt"){
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let customers = data.components(separatedBy: .newlines)
                for customer in customers {
                    let customerData = Data(customer.utf8)
                    if let customerModel = try? JSONDecoder().decode(Customer.self, from: customerData) {
                    customerList.append(customerModel)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    return customerList

    }
}

// convert location coordinates in degrees to radians for distance calculation
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
}
