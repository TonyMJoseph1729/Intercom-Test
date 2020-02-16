//
//  Extension+UserListingViewController.swift
//  Intercom Test
//
//  Created by Tony on 15/02/2020.
//  Copyright © 2020 Tony M Joseph. All rights reserved.
//

import UIKit

//MARK: - TableView Delegates
extension CustomerListingViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredCustomerListArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
}

//MARK:- TableView Datasources
extension CustomerListingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIElementsConstants.customerTableViewCellIdentifier) as! CustomerTableViewCell
        let customer = filteredCustomerListArray[indexPath.section]
        cell.setLabels(customer)
        return cell
    }
}
