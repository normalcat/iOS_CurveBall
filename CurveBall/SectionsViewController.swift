//
//  SectionsViewController.swift
//  CurveBall
//
//  Created by Chao-I Chen on 1/25/18.
//  Copyright © 2018 Chao-I Chen. All rights reserved.
//

import UIKit
import CoreData

class SectionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let header = ["Favorite Quotes", "Quote Bank"]
    var quoteBank: [Quotes] = []
    var favoriteQuotes: [Quotes] = []
    var allQuotes:[[Quotes]] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    var items = [Quotes]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return header.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allQuotes[section].count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let single_quote = allQuotes[indexPath.section][indexPath.row]
        if single_quote.favorite{
            single_quote.favorite = false
        }else{
            single_quote.favorite = true
        }
        do{
            try managedObjectContext.save()
        }catch{
            print(error)
        }
        
        allQuotes[indexPath.section].remove(at: indexPath.row)
        
        if indexPath.section == 0{
            allQuotes[1].append(single_quote)
        }else{
            allQuotes[0].append(single_quote)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        cell.textLabel?.text = allQuotes[indexPath.section][indexPath.row].contents
        cell.detailTextLabel?.text = allQuotes[indexPath.section][indexPath.row].author
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //oneTimeCreate()
        FetchAll()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func FetchAll(){
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Quotes")
        
        do {
            // get the results by executing the fetch request we made earlier
            let results = try managedObjectContext.fetch(itemRequest)
            // downcast the results as an array of AwesomeEntity objects
            for single_quote in results as! [Quotes]{
                if single_quote.favorite{
                    favoriteQuotes.append(single_quote)
                }else{
                    quoteBank.append(single_quote)
                }
            }
            allQuotes.append(quoteBank)
            allQuotes.append(favoriteQuotes)
            // print the details of each item
        } catch {
            // print the error if it is caught (Swift automatically saves the error in "error")
            print("\(error)")
        }
    }

    func oneTimeCreate(){
        let newItem1 = NSEntityDescription.insertNewObject(forEntityName: "Quotes", into: managedObjectContext) as! Quotes
        newItem1.contents = "First quote"
        newItem1.author = "Alex Bob"
        newItem1.favorite = true
        do{
            try managedObjectContext.save()
        }catch{
            print(error)
        }
        
        let newItem2 = NSEntityDescription.insertNewObject(forEntityName: "Quotes", into: managedObjectContext) as! Quotes
        newItem2.contents = "Second quote"
        newItem2.author = "Chris Bob"
        newItem2.favorite = true
        
        let newItem3 = NSEntityDescription.insertNewObject(forEntityName: "Quotes", into: managedObjectContext) as! Quotes
        newItem3.contents = "Third quote"
        newItem3.author = "Frank Silver"
        newItem3.favorite = false
    }
}
