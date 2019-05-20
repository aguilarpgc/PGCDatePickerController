//
//  ViewController.swift
//  TestDatePickerController
//
//  Created by aguilarpgc on 4/23/19.
//  Copyright © 2019 aguilarpgc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets -
    
    @IBOutlet private weak var labelDate: UILabel!
    
    // MARK: - Properties -
    
    private var defaultDate: Date? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.defaultDate = nil
    }

    // MARK: - IBActions -
    
    @IBAction func actionClean(_ sender: Any) {
        self.defaultDate = nil
    }
    
    @IBAction func actionSelectDate(_ sender: Any) {
        
        let datePickerOptions = DatePickerOptions()
//        datePickerOptions.minimumDate = Date()
        
        let dateController = PGCDatePickerController.with(currentDateSelected: self.defaultDate, withOptions: datePickerOptions) { [weak self] (date) in
            
            guard let self = self else { return }
            
            self.defaultDate = date
        }
        
        self.present(dateController, animated: false, completion: nil)
    }
    
    // MARK: - Methods -
    
    private func updateView() {
        
        if let date = defaultDate {
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "dd/MM/yyyy"
            
            self.labelDate.text = dateFormatterPrint.string(from: date)
            
        } else {
            
            self.labelDate.text = "-"
        }
    }
}
