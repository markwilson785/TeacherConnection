//
//  PeopleViewController.swift
//  TeacherConnection
//
//  Created by Mark Wilson on 12/8/20.
//

import UIKit
class PeopleViewController: UIViewController {
    enum TableSection: Int {
        case teachers
        case students
    }
    
    @IBOutlet var tableView: UITableView!
    
    var teachers = [String]()
    var students = [String]()
    var isAddingTeacher = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teachers = ["Parker","Ben","Johnny","Kevin","Jeff"]
        students = ["Mark","Michael","Melissa","Brianna","Talmage"]
    }
}


extension PeopleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return teachers.count + 1
        }
        else {
            return students.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)

        var name = ""
        let tableSection = TableSection (rawValue: indexPath.section)!
        switch tableSection {
        case .teachers:
            if indexPath.row == teachers.count {
                name = "➕ Add New Teacher"
            } else {
                name = teachers[indexPath.row]
            }
        case .students:
            if indexPath.row == students.count {
                name = "➕ Add New Student"
            } else {
                name = students[indexPath.row]
            }
        }
        cell.textLabel?.text = name
        
        return cell
    }
    
    
}

extension PeopleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableSection = TableSection (rawValue: section)!
        switch tableSection {
        case .teachers:
            return "Teachers"
        case .students:
            return "Students"
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableSection = TableSection (rawValue: indexPath.section)!
        switch tableSection {
        case .teachers:
            isAddingTeacher = true
        case .students:
            isAddingTeacher = false
            
        }
        present(newPersonAlert(), animated: true, completion: nil)

    }
    func newPersonAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Add new Person", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        let saveAction = UIAlertAction(title: "save", style: .default) { (_) in
            self.saveNewPerson(name: alert.textFields!.first!.text!)
        }
        alert.addTextField { (textField) in
            textField.placeholder = "EnterName"
        }
        alert.addAction(saveAction)
        return alert
    }
    func saveNewPerson(name:String){
        if isAddingTeacher {
            teachers.append(name)
        } else {
            students.append(name)
        }
        tableView.reloadData()
    }
}
