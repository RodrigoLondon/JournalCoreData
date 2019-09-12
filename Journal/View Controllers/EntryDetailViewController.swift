//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Lewis Jones on 13/07/2018.
//  Copyright © 2018 Lewis Jones. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var categoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    // MARK: Actions
    
    @IBAction func clearsButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
        categoryTextField.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let title = titleTextField.text, let text = bodyTextView.text, let category = categoryTextField.text else { return }
        
        
        if let entry =  self.entry
        {
            EntryController.shared.update(entry: entry, with: title, category: category, text: text)
        } else {
            let entry = Entry(title: title, category: category, text: text)
            EntryController.shared.add(entry: entry)
        }
        // After adding or updating entries dismisses the current view.
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: Private
    
    
    private func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.text
        categoryTextField.text = entry.category
    }
    
    
    // MARK: UITextFiledDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Properties
    
    var entry: Entry? {
        didSet {
            if isViewLoaded { updateViews() }
        }
    }

}
