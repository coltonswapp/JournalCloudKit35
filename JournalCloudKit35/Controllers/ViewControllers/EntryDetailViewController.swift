//
//  EntryDetailViewController.swift
//  JournalCloudKit35
//
//  Created by Colton Swapp on 8/17/20.
//  Copyright © 2020 Colton Swapp. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    

    // Landing Pad!
    var entry: Entry? {
        didSet {
            updateViews(for: entry)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.delegate = self
    }
    
    // MARK: - Actions
    
    @IBAction func mainViewTapped(_ sender: Any) {
        bodyTextView.resignFirstResponder()
        titleTextField.resignFirstResponder()
    }
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        EntryController.sharedInstance.createEntry(with: titleTextField.text ?? "", body: bodyTextView.text ?? "") { (result) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func updateViews(for entry: Entry?) {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EntryDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
