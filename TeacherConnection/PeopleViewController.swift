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
    
    @IBOutlet weak var editButton: UINavigationItem!
    
    var newTeachers = [Person]()
    var newStudents = [Person]()
    var isAddingTeacher = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        if let people = Person.loadFromFile() {
            for person in people {
                if person.isTeacher == true {
                    newTeachers.append(person)
                }else {
                    newStudents.append(person)
                }
                
            }
            
        } else {
            newStudents = Person.loadSampleTeacherNames()
        }
    }
}


extension PeopleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return newTeachers.count + 1
        }
        else {
            return newStudents.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        
        var name = ""
        let tableSection = TableSection (rawValue: indexPath.section)!
        switch tableSection {
        case .teachers:
            if indexPath.row == newTeachers.count {
                name = "➕ Add New Teacher"
            } else {
                name = newTeachers[indexPath.row].name
            }
        case .students:
            if indexPath.row == newStudents.count {
                name = "➕ Add New Student"
            } else {
                
                name = newStudents[indexPath.row].name
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
        if indexPath.row == newTeachers.count {
            present(newPersonAlert(), animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func editTappedFromTableView(_ sender: Any) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            tableView.beginUpdates()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
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
            
            let teacher = Person(name: name, isTeacher: true)
            newTeachers.append(teacher)
            //            Person.saveToFile(person: teachers)
            Person.saveToFile(person: newTeachers + newStudents)
        } else {
            
            let student = Person(name: name, isTeacher: false)
            newStudents.append(student)
            Person.saveToFile(person: newStudents + newTeachers)
        }
        tableView.reloadData()
    }
    
}


