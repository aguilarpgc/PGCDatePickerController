//
//  PGCDatePickerController.swift
//
//
//  Created by Paul Aguilar on 28/03/18.
//

import UIKit

typealias DateSelectionHandler = (_ date: Date) -> Void

struct DatePickerOptions {
    
    var minuteInterval: Int = 1
    var mode: UIDatePicker.Mode = .date
    var minimumDate: Date? = nil
    var maximumDate: Date? = nil
    
}

class PGCDatePickerController: UIViewController {
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    @IBOutlet private weak var constraintPickerContainerTop: NSLayoutConstraint!
    @IBOutlet private weak var viewFadeBackground: UIView!
    @IBOutlet private weak var viewPickerContainer: UIView!
    
    // MARK: - Properties -
    
    public var selectionHandler: DateSelectionHandler? = nil
    
    private var currentDateSelected: Date?
    private let animationDuration = 0.35
    private var datePickerOptions: DatePickerOptions?
    
    // MARK: - Life cycle -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        datePickerView.datePickerMode = datePickerOptions?.mode ?? .date
        datePickerView.minuteInterval = datePickerOptions?.minuteInterval ?? 1
        datePickerView.minimumDate = datePickerOptions?.minimumDate
        datePickerView.maximumDate = datePickerOptions?.maximumDate
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        setupDatePickerValue()
        showPickerContainer()
    }
    
    // MARK: - Actions -
    
    @IBAction func actionCancel(_ sender: Any) {
        
        setDefaultValues()
        hidePickerController()
    }
    
    @IBAction func actionDone(_ sender: Any) {
        
        setNewValue(selection: pickerValueSelected())
        hidePickerController()
    }
    
    @IBAction func actionTapFadeBackground(_ sender: Any) {
        
        setNewValue(selection: pickerValueSelected())
        hidePickerController()
    }
    
    // MARK: - Methods -
    
    public static func with(currentDateSelected date: Date?, withOptions options: DatePickerOptions = DatePickerOptions(), selectionHandler: @escaping DateSelectionHandler) -> PGCDatePickerController {
        
        let controller = UIStoryboard.instantiatePGCDatePickerController
        
        controller.modalPresentationStyle = .overCurrentContext
        controller.currentDateSelected = date
        controller.datePickerOptions   = options
        controller.selectionHandler    = selectionHandler
        
        return controller
    }
    
    // MARK: - Private -
    
    private func hidePickerController() {
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: animationDuration, animations: { [unowned self] in
            
            self.viewFadeBackground.alpha = 0.0
            self.constraintPickerContainerTop.constant = 0.0
            
            self.view.layoutIfNeeded()
            
        }) { (finished) in
            
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    private func pickerValueSelected() -> Date {
        
        return datePickerView.date
    }
    
    private func setDefaultValues() {
        
        guard let current = currentDateSelected else {
            return
        }
        
        self.setNewValue(selection: current)
    }
    
    private func setNewValue(selection: Date) {
        
        self.selectionHandler?(selection)
    }
    
    private func setupDatePickerValue() {
        
        guard let current = currentDateSelected else {
            return
        }
        
        datePickerView.date = current
    }
    
    private func showPickerContainer() {
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: animationDuration, animations: {
            
            self.viewFadeBackground.alpha = 1.0
            self.constraintPickerContainerTop.constant = -self.viewPickerContainer.bounds.size.height
            
            self.view.layoutIfNeeded()
            
        })
    }
}

// MARK: - Protocols -

internal extension UIStoryboard {
    
    static var instantiatePGCDatePickerController: PGCDatePickerController {
        
        guard let pickerController = UIStoryboard(name: "PGCDatePickerController", bundle: nil).instantiateInitialViewController() as? PGCDatePickerController else {
            
            fatalError()
        }
        
        return pickerController
    }
}

