//
//  TableViewController.swift
//  CoreDataApp
//
//  Created by user176866 on 8/19/20.
//  Copyright © 2020 user176866. All rights reserved.
//

import CoreData
import UIKit

class TableViewController: UITableViewController {
    var managedContext: NSManagedObjectContext?
    var people = [NSManagedObject]()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "People"
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let managedContext = self.managedContext else {
            return
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do {
            self.people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let person = self.people[indexPath.row]
        
        cell.textLabel?.text = person.value(forKey: "name") as? String
        
        return cell
    }

    @IBAction func addBarButtonItemTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Name", message: nil, preferredStyle: .alert)
        
        let saveAlertAction = UIAlertAction(title: "Save", style: .default) { [unowned self] alertAction in
            guard let name = alertController.textFields?.first?.text else {
                return
            }
            
            self.save(name: name)
            self.tableView.reloadData()
        }
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(saveAlertAction)
        alertController.addAction(cancelAlertAction)
        
        alertController.addTextField()
        
        self.present(alertController, animated: true)
    }
    
    func save(name: String) {
        guard let managedContext = self.managedContext else {
            return
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(name, forKey: "name")
        
        do {
            try self.managedContext?.save()
            self.people.append(person)
        } catch let error as NSError  {
            print(error)
        }
    }
}
