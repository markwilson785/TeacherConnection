//
//  ViewController.swift
//  TeacherConnection
//
//  Created by Mark Wilson on 12/8/20.
//

import UIKit



class ViewController: UIViewController {
    
    var teachers: [String] = []
    var students: [String] = []
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var teacherLabel: UILabel!
    
    enum TableSection: Int {
        case teachers
        case students
    }
    
    @IBAction func RandomButton(_ sender: Any){
        guard let randomTeachers = teachers.randomElement(),
              let randomStudents = students.randomElement() else { return }
        teacherLabel.text = String(randomTeachers)
        displayLabel.text = String(randomStudents)
        
    }
    
    override func viewDidLoad() {
        teachers = ["Parker","Ben","Johnny","Kevin","Jeff"]
        students = ["Mark","Michael","Melissa","Brianna","Talmage"]
    }
    
    
}

