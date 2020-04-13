//
//  ViewController.swift
//  KVO_KVC
//
//  Created by Ruslan on 4/13/20.
//  Copyright © 2020 Ruslan Filistovich. All rights reserved.
//

import UIKit

class Person: NSObject {
    @objc dynamic var name = String()
}

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @objc let ruslan = Person()
    @objc dynamic var inputText: String?
    
    var nameObservation: NSKeyValueObservation?
    var inputTextObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameObservation = observe(\ViewController.ruslan.name, options: [.new, .old]) { (vc, change) in
            guard let updateName = change.newValue else { return }
            self.nameLabel.text = updateName
            print("Изменили старое значение:\(change.oldValue) на новое - \(change.newValue)")
        }
        
        inputTextObservation = observe(\ViewController.inputText, options: [.new]) { (vc, change) in
            guard let updatedInputText = change.newValue as? String else { return }
            vc.textLabel.text = updatedInputText
        }
        
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        ruslan.name = "Poman"
    }
    
    @IBAction func textFieldEditingChanget(_ sender: Any) {
        inputText = textField.text
    }

}

