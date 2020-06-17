# PGCDatePickerController

[![Swift](https://img.shields.io/badge/swift-5.0-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/license-MIT-71787A.svg)](https://tldrlegal.com/license/mit-license)
[![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)](https://developer.apple.com/ios/)

## Installation

### Manual

Add PGCDatePickerController folder into your project.

## Usage

You just need to call the `PGCDatePickerController` method, and it will return a `PGCDatePickerController` instance. 

You can pass a `Date` instance to make the default date selected

In the completion you obtain the date selected by the user.

```swift
let dateController = PGCDatePickerController.with(currentDateSelected: self.defaultDate) { [weak self] (date) in
            
            guard let self = self else { return }
            // 
            // Use date selected in completion
            // self.defaultDate = date
            //
        }
```

Then, you need to present the view controller.
```swift
self.present(dateController, animated: false, completion: nil) 
```
### Custom

You can OPTIONALLY setup options for the DatePicker using these variables declared in `DatePickerOptions`:

* minuteInterval
* mode
* minimumDate
* maximumDate

```swift
var datePickerOptions = DatePickerOptions()
datePickerOptions.minimumDate = Date()
datePickerOptions.mode = .dateAndTime
datePickerOptions.minuteInterval = 5
```

And send it as a parameter in the view controller creation

```swift
let dateController = PGCDatePickerController.with(currentDateSelected: self.defaultDate, withOptions: datePickerOptions) { [weak self] (date) in
            
            guard let self = self else { return }
            // 
            // Use date selected in completion
            // self.defaultDate = date
            //
        }
        
        self.present(dateController, animated: false, completion: nil)
```

### Example

![Alt Text](https://github.com/aguilarpgc/PGCDatePickerController/blob/master/Images/example.gif?raw=true)

## License
This program is free software; you can redistribute it and/or modify it under the terms of the MIT License.
