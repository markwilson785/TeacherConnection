//
//  ViewController.swift
//  TeacherConnection
//
//  Created by Mark Wilson on 12/8/20.
//

import UIKit



class ViewController: UIViewController {
    
    var teachers: [Person] = []
    var students: [Person] = []
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var teacherLabel: UILabel!
    
    enum TableSection: Int {
        case teachers
        case students
    }
    
    @IBAction func RandomButton(_ sender: Any){
        guard let randomTeachers = teachers.randomElement(),
              let randomStudents = students.randomElement() else { return }
        teacherLabel.text = randomTeachers.name
        displayLabel.text = randomStudents.name
        
    }
    
    override func viewDidLoad() {
      
        if let people = Person.loadFromFile() {
            for person in people {
                if person.isTeacher == true {
                    teachers.append(person)
                }else {
                    students.append(person)
                }
                
            }
            
        } else {
            students = Person.loadSampleTeacherNames()
        }
        
    }
    
   
}

