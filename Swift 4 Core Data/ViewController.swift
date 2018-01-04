//
//  ViewController.swift
//  Swift 4 Core Data
//
//  Created by Rafael M. Trasmontero on 1/3/18.
//  Copyright © 2018 KLTuts. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var peopleArray = [Person]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchContext()
    
    }

    @IBAction func plusButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "Enter Name"
        }
        
        alert.addTextField { (textfield) in
            textfield.placeholder = "Phone Number"
            textfield.keyboardType = .phonePad
        }
        
        let action = UIAlertAction(title: "Post", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text else {return}
            guard let phoneNumber = alert.textFields?.last?.text else {return}
            guard let phoneNumberInt =  Int16(phoneNumber) else {return}
            print(name)
            print(phoneNumberInt)
            
            //Create Person Context for Core Data
            let person = Person(context: CoreDataService.context)
            person.name = name
            person.phoneNumber = phoneNumberInt
            
            //Save the Person Context to Core Data
            CoreDataService.saveContext()
            
            //Add person to people array
            self.peopleArray.append(person)
            
            //Update Table View
            self.tableView.reloadData()
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    //Fetch Context Saved in Core Data
    func fetchContext(){
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            let fetchedPeople = try CoreDataService.context.fetch(fetchRequest)
            print("CONTEXT FECTHED FROM COREDATA")
            self.peopleArray = fetchedPeople
            self.tableView.reloadData()
        } catch let err{
            print(err.localizedDescription)
        }
    }


}


extension ViewController:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = peopleArray[indexPath.row].name ?? "N/A"
        cell.detailTextLabel?.text = String(peopleArray[indexPath.row].phoneNumber)
        return cell
        
    }
    
}


