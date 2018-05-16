//
//  ViewController.swift
//  CoreDataBasic
//
//  Created by Yue Zhou on 5/15/18.
//  Copyright © 2018 Yue Zhou. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

func RGBColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

private let id = "person"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    // MARK: - subviews and member fields
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var personsTableView: UITableView!
    
    fileprivate lazy var persons = CoreDataManager.shared().getAllPersons()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configTextFields()
    }
    
    // MARK: - config UI 
    private func configTextFields() {
        self.nameField.backgroundColor = RGBColor(r: 239, g: 239, b: 239)
        self.ageField.backgroundColor = RGBColor(r: 239, g: 239, b: 239)
        
        let nameSignal = self.nameField.reactive.continuousTextValues.map { (text: String?) -> Bool in
            return text!.trimmingCharacters(in: CharacterSet.whitespaces).characters.count > 1
        }
        let ageSignal = self.ageField.reactive.continuousTextValues.map { (text:String?) -> Bool in
            return text!.trimmingCharacters(in: CharacterSet.whitespaces).characters.count > 1
        }
        
        self.addButton.reactive.isEnabled <~ Signal.combineLatest(nameSignal, ageSignal).map { $0 && $1}
    }
}


// MARK: - UITableViewDataSource, Delegate
extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: id)!
        cell.selectionStyle = .none
        cell.textLabel?.numberOfLines = 0
        
        let person = self.persons[indexPath.row]
        cell.textLabel?.text = person.name! + "\nAge: \(person.age)"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let p = self.persons[indexPath.row]
            CoreDataManager.shared().delete(person: p)
            self.persons.remove(at: indexPath.row)
            self.personsTableView.reloadData()
        }
    }
}


// MARK: - button respond
extension ViewController {
    @IBAction func add(_ sender: UIButton) {
        self.view.endEditing(true)
        
        guard let name = self.nameField.text else { return  }
        guard let age = self.ageField.text else { return  }
        guard let age16 = Int16(age.trimmingCharacters(in: CharacterSet.whitespaces)) else { return  }
        
        // add new person
        let p = CoreDataManager.shared().addPerson(with: name.trimmingCharacters(in: CharacterSet.whitespaces), age: age16)
        self.persons.append(p)
        self.personsTableView.reloadData()
    }
    
    @IBAction func refresh(_ sender: UIButton) {
        self.view.endEditing(true)
        self.persons = CoreDataManager.shared().getAllPersons()
        self.personsTableView.reloadData()
    }
}

