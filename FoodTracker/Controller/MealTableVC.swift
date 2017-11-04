//
//  MealTableVC.swift
//  FoodTracker
//
//  Created by Manohar Kurapati on 02/11/2017.
//  Copyright © 2017 Manosoft. All rights reserved.
//

import UIKit
import os.log

class MealTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mealTable: UITableView!
    
    var mealList = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mealList = MealDataService.instanse.getMeals()
        mealTable.dataSource = self
        mealTable.delegate = self
        
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
    
    //MARK: Table view delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableCell") as? MealTableCell {
            
            let meal = mealList[indexPath.row]
            cell.updateMealTableCellView(meal: meal)
            return cell
            
        } else {
            return MealTableCell()
        }
    }
    
    //MARK: Delegates for table Edits (Delete)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            mealList.remove(at: indexPath.row)
            mealTable.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? MealDetailVC,
            let meal = sourceViewController.meal {
            
            if let selectedIndexPath = mealTable.indexPathForSelectedRow {
                
                //Update existing row
                mealList[selectedIndexPath.row] = meal
                mealTable.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
                // Add new meal
                let newIndexPath = IndexPath(row: mealList.count, section: 0)
                mealList.append(meal)
                mealTable.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
            
        case "AddItemSegue":
            os_log("Adding new meal item", log:OSLog.default, type: .debug)
            
        case "ShowDetailsSegue":
            
            guard let mealDetailVC = segue.destination as? MealDetailVC else {
                fatalError("Unexpected destination \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = mealTable.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not been displayed by the table")
            }
            
            let selectedMeal = mealList[indexPath.row]
            mealDetailVC.meal = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier : \(String(describing: segue.identifier))")
        }
        
        
    }
    

}
