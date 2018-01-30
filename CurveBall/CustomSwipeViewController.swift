//
//  CustomSwipeViewController.swift
//  CurveBall
//
//  Created by Chao-I Chen on 1/24/18.
//  Copyright © 2018 Chao-I Chen. All rights reserved.
//

import UIKit
import CoreData

class CustomSwipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    //    @IBOutlet weak var nameLabel: UILabel!
    
    var items = [SwipeCell]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        if items[indexPath.row].select == 0{
            cell.detailTextLabel?.isHidden = true
        }else if items[indexPath.row].select == 1{
            cell.detailTextLabel?.text = items[indexPath.row].word
            cell.detailTextLabel?.isHidden = false
            
        }else if items[indexPath.row].select == 2{
            cell.detailTextLabel?.text = items[indexPath.row].nemesis
            cell.detailTextLabel?.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let nemesisAction = UITableViewRowAction(style: .default, title: "Nemesis"){ (action, indexPath) in
            let item = self.items[indexPath.row]
            item.select = 2
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        nemesisAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        let wordAction = UITableViewRowAction(style: .default, title: "Word"){ (action, indexPath) in
            let item = self.items[indexPath.row]
            item.select = 1
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        wordAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
  
        let clearAction = UITableViewRowAction(style: .default, title: "Clear"){ (action, indexPath) in
            let item = self.items[indexPath.row]
            item.select = 0
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        clearAction.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
/*        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
            self.items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
 */
        do{
            try managedObjectContext.save()
        }catch{
            print(error)
        }
        
        let item = items[indexPath.row]
        if (item.select == 1){
            return [clearAction, nemesisAction]
        }else if (item.select == 2){
            return [clearAction, wordAction]
        }else{
            return [wordAction, nemesisAction]
        }
    }

    func FetchAll(){
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SwipeCell")

        do {
            // get the results by executing the fetch request we made earlier
            let results = try managedObjectContext.fetch(itemRequest)
            // downcast the results as an array of AwesomeEntity objects
            items = results as! [SwipeCell]
            // print the details of each item
        } catch {
            // print the error if it is caught (Swift automatically saves the error in "error")
            print("\(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
/*
        let newItem1 = NSEntityDescription.insertNewObject(forEntityName: "SwipeCell", into: managedObjectContext) as! SwipeCell
        newItem1.title = "First"
        newItem1.word = "word 1"
        newItem1.nemesis = "nemesis 1"
        newItem1.select = 0
//        items.append(newItem)
        do{
            try managedObjectContext.save()
        }catch{
            print(error)
        }
        
        let newItem2 = NSEntityDescription.insertNewObject(forEntityName: "SwipeCell", into: managedObjectContext) as! SwipeCell
        newItem2.title = "Second"
        newItem2.word = "word 2"
        newItem2.nemesis = "nemesis 2"
        newItem2.select = 0
//        items.append(newItem)
        do{
            try managedObjectContext.save()
        }catch{
            print(error)
        }
        
        let newItem3 = NSEntityDescription.insertNewObject(forEntityName: "SwipeCell", into: managedObjectContext) as! SwipeCell
        newItem3.title = "Third"
        newItem3.word = "word 3"
        newItem3.nemesis = "nemesis 3"
        newItem3.select = 0
//        items.append(newItem)
        do{
            try managedObjectContext.save()
        }catch{
            print(error)
        }
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
*/
        FetchAll()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
