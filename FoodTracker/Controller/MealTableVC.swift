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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealTable.dataSource = self
        mealTable.delegate = self

        // Do any additional setup after loading the view.
    }
    
    var mealList = MealDataService.instanse.getMeals()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealList.count
//        return MealDataService.instanse.getMeals().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableCell") as? MealTableCell {
            
            let meal = mealList[indexPath.row]
//            let meal = MealDataService.instanse.getMeals()[indexPath.row]
            cell.updateMealTableCellView(meal: meal)
            return cell
            
        } else {
            return MealTableCell()
        }
    }
    
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? MealDetailVC,
            let meal = sourceViewController.meal {
            
            let newIndexPath = IndexPath(row: mealList.count, section: 0)
            mealList.append(meal)
            mealTable.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
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
