//
//  RefineFetchViewController.swift
//  CurveBall
//
//  Created by Chao-I Chen on 1/25/18.
//  Copyright © 2018 Chao-I Chen. All rights reserved.
//

import UIKit
import CoreData

class RefineFetchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items = [AnimalList2]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Animal", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    
    @IBAction func allMammals(_ sender: UIButton) {
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AnimalList2")
        itemRequest.predicate = NSPredicate(format: "type = %@", "Mammal")
        do{
            let result = try managedObjectContext.fetch(itemRequest)
            items = result as! [AnimalList2]
            tableView.reloadData()
        }
        catch{
            print("\(error)")
        }
    }
    
    @IBAction func allRepetiles(_ sender: UIButton) {
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AnimalList2")
        itemRequest.predicate = NSPredicate(format: "type = %@", "Reptile")
        do{
            let result = try managedObjectContext.fetch(itemRequest)
            items = result as! [AnimalList2]
            tableView.reloadData()
        }
        catch{
            print("\(error)")
        }
        tableView.reloadData()
    }
    
    @IBAction func allAnimal(_ sender: UIButton) {
        FetchAll()
        tableView.reloadData()
    }
    
    func oneTimeDataCreation(){
        let newItem1 = NSEntityDescription.insertNewObject(forEntityName: "AnimalList2", into: managedObjectContext) as! AnimalList2
        newItem1.name = "Retil 1"
        newItem1.type = "Reptile"
        do{
            try managedObjectContext.save()
        }catch{
            print(error)
        }
        
        let newItem2 = NSEntityDescription.insertNewObject(forEntityName: "AnimalList2", into: managedObjectContext) as! AnimalList2
        newItem2.name = "Retil 2"
        newItem2.type = "Reptile"
        do{
            try managedObjectContext.save()
        }catch{
            print(error)
        }
        
        let newItem3 = NSEntityDescription.insertNewObject(forEntityName: "AnimalList2", into: managedObjectContext) as! AnimalList2
        newItem3.name = "Mammal 1"
        newItem3.type = "Mammal"
        do{
            try managedObjectContext.save()
        }catch{
            print(error)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//       oneTimeDataCreation()
        FetchAll()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func FetchAll(){
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AnimalList2")
        
        do {
            // get the results by executing the fetch request we made earlier
            let results = try managedObjectContext.fetch(itemRequest)
            // downcast the results as an array of AwesomeEntity objects
            items = results as! [AnimalList2]
            // print the details of each item
        } catch {
            // print the error if it is caught (Swift automatically saves the error in "error")
            print("\(error)")
        }
    }
}
