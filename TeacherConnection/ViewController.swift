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
    
    var temporaryStudents: [Person] = []
    
    @IBOutlet weak var firstTeacherLabel: UILabel!
 
    @IBOutlet weak var secondTeacherLabel: UILabel!
    
    @IBOutlet weak var thirdTeacherLabel: UILabel!
    
    @IBOutlet weak var fourthTeacherLabel: UILabel!
    
    @IBOutlet weak var fithTeacherLabel: UILabel!
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var teacherLabel: UILabel!
    
    enum TableSection: Int {
        case teachers
        case students
    }

    
    func studentsPerTeacher() -> Int {
        let teacherCount = teachers.count
        let studentCount = students.count
        
        let perStudent: Int = studentCount/teacherCount
        return perStudent
    }
   
    @IBAction func RandomButton(_ sender: Any) {
        guard let randomTeachers = teachers.randomElement(),
              let randomStudents = students.randomElement() else { return }
//        teacherLabel.text = randomTeachers.name
//        displayLabel.text = randomStudents.name
        
        setLabelForTeacher(label: firstTeacherLabel, index: 0, numberOfStudentPerTeacher: studentsPerTeacher())
        setLabelForTeacher(label: secondTeacherLabel, index: 1, numberOfStudentPerTeacher: studentsPerTeacher())
        setLabelForTeacher(label: thirdTeacherLabel, index: 2, numberOfStudentPerTeacher: studentsPerTeacher())
        setLabelForTeacher(label: fourthTeacherLabel, index: 3, numberOfStudentPerTeacher: studentsPerTeacher())
        setLabelForTeacher(label: fithTeacherLabel, index: 4, numberOfStudentPerTeacher: studentsPerTeacher())
        
        // For each teacher get students set label
        
    }
    
    func setLabelForTeacher(label: UILabel, index: Int, numberOfStudentPerTeacher: Int) {
        if temporaryStudents.count == 0 {
            temporaryStudents = students
        }
        let teacher = teachers[index]
        var stringForLabel: String = "\(teacher.name) - "
        var studentNumber = numberOfStudentPerTeacher
        while studentNumber > 0 {
            guard let randomStudent = temporaryStudents.randomElement(),
                  let removeIndex = temporaryStudents.firstIndex(of: randomStudent) else { return }
            temporaryStudents.remove(at: removeIndex)
            //if studentNumber == 1 then no comma
            stringForLabel += "\(randomStudent.name), "
            studentNumber -= 1
        }
        label.text = stringForLabel
    }
    
    
   override func viewWillAppear(_ animated: Bool) {
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
//    studentsPerTeacher()
    temporaryStudents = students

    }
    
    override func viewDidLoad() {
      
       
        
    }
    
   
}

