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
    
    @IBOutlet private weak var labelDate        : UILabel!
    @IBOutlet private weak var buttonChooseDate : UIButton!
    @IBOutlet private weak var cleanButton      : UIButton!
    
    // MARK: - Properties -
    
    private var defaultDate: Date? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonChooseDate.layer.cornerRadius = buttonChooseDate.bounds.size.height * 0.5
        buttonChooseDate.layer.borderColor = UIColor.black.cgColor;
        buttonChooseDate.layer.borderWidth = 2;
        
        cleanButton.layer.cornerRadius = cleanButton.bounds.size.height * 0.5
        cleanButton.layer.borderColor = buttonChooseDate.layer.borderColor
        cleanButton.layer.borderWidth = buttonChooseDate.layer.borderWidth;
        
        self.defaultDate = nil
    }

    // MARK: - IBActions -
    
    @IBAction func actionClean(_ sender: Any) {
        self.defaultDate = nil
    }
    
    @IBAction func actionSelectDate(_ sender: Any) {
        
        let datePickerOptions = DatePickerOptions()
        
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
