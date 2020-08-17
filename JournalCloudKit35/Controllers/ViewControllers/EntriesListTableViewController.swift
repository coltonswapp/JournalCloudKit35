//
//  EntriesListTableViewController.swift
//  JournalCloudKit35
//
//  Created by Colton Swapp on 8/17/20.
//  Copyright © 2020 Colton Swapp. All rights reserved.
//

import UIKit

class EntriesListTableViewController: UITableViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        EntryController.sharedInstance.fetchEntriesWith { (result) in
            self.updateViews()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /// call the reloadData method on the tableView to reload your rows and sections
        tableView.reloadData()
    }
    
    // MARK: - Class Methods
    
    func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return EntryController.sharedInstance.entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        let entry = EntryController.sharedInstance.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.timestamp.dateAsString()

        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditEntry" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? EntryDetailViewController else { return }
            let entryToSend = EntryController.sharedInstance.entries[indexPath.row]
            destinationVC.entry = entryToSend
        }
    }
    

}
