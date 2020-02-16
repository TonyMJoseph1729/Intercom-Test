//
//  ViewController.swift
//  Intercom Test
//
//  Created by Tony on 14/02/2020.
//  Copyright © 2020 Tony M Joseph. All rights reserved.
//

import UIKit

class CustomerListingViewController: UIViewController, UISearchResultsUpdating {
    
    let distanceCutOff = 100.00 //Need to find customers within distanceCutOff kms from Intercom Office
    
    var invitedCustomerListSorted = [Customer]() //full list of sorted invited customers
    var filteredCustomerListArray = [Customer]() //for searching
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var customersTableView: UITableView!
    @IBOutlet weak var noCustomersFoundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addSearchBar()
        displayInvitedCustomerList()
    }
    
    //fetch the invited customer list sorted by user_id and reload data in tableview
    func displayInvitedCustomerList() {
        let customerList = Utilities().fetchCustomerList()
            let invitedCustomers = self.fetchInvitedCustomerList(customerList)
            self.invitedCustomerListSorted = self.sortCustomerListByUserId(invitedCustomers)
            self.filteredCustomerListArray = self.invitedCustomerListSorted
            self.reloadData()
    }
    
    //fetch the invited CustomerList based on their distance from Intercom Office
    func fetchInvitedCustomerList(_ customerList: [Customer]) -> [Customer] {
        var wantedCustomerList = [Customer]()
        for customer in customerList {
            let distance = Utilities().distancefrom(customer)
            if distance <= distanceCutOff {
                wantedCustomerList.append(customer)
            }
        }
        return wantedCustomerList
    }
    
    //reload the tableView
    func reloadData() {
        setNoCustomersFoundLabelVisibility()
        DispatchQueue.main.async {
            self.customersTableView.reloadData()
        }
    }
    
    // Set visibilty of no customers label based on the customer count
    func setNoCustomersFoundLabelVisibility() {
        DispatchQueue.main.async {
            self.noCustomersFoundLabel.isHidden = (self.filteredCustomerListArray.count > 0) ? true : false
        }
    }
    
    //return array sorted by user_id
    func sortCustomerListByUserId(_ unsortedArray: [Customer]) -> [Customer] {
        return unsortedArray.sorted(by: { $0.user_id < $1.user_id })
    }
    
    //add the search bar as tableview header
    func addSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        customersTableView.tableHeaderView = searchController.searchBar
    }
    
    // Filter the customer list based on search text
    func filterInvitedCustomerArray(_ searchText: String, _ invitedCustomerList: [Customer]) -> [Customer] {
        var filteredArray = invitedCustomerList
        if !searchText.isEmpty {
            filteredArray = invitedCustomerList.filter {
                $0.name.lowercased().contains(searchText.lowercased()) || String($0.user_id).contains(searchText.lowercased())
            }
        }
        return filteredArray
    }
    
    //MARK:- Search Delegates
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filteredCustomerListArray = filterInvitedCustomerArray(searchText, invitedCustomerListSorted)
        }
        reloadData()
    }
    
}
