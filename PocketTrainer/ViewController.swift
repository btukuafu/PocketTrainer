//
//  ViewController.swift
//  PocketTrainer
//
//  Created by Bruce Tukuafu on 3/9/23.
//

import UIKit

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getItems() {
        do {
            let items = try context.fetch(WorkoutList.fetchRequest())
        } catch{
            //error handling needs to be completed.
        }
    }
    
    func createItem(name: String) {
        let newItem = WorkoutList(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        
        do {
            try context.save()
        }
        catch {
            
        }
    }
    
    func deleteItem(item: WorkoutList) {
        context.delete(item)
        
        do {
            try context.save()
        }
        catch {
            
        }
        
    }
    
    func updateItem(item: WorkoutList, newName: String) {
        item.name = newName
        
        do {
            try context.save()
        }
        catch {
            
        }
    }
}
