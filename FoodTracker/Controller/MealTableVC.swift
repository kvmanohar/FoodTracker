//
//  MealTableVC.swift
//  FoodTracker
//
//  Created by Manohar Kurapati on 02/11/2017.
//  Copyright © 2017 Manosoft. All rights reserved.
//

import UIKit

class MealTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mealTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealTable.dataSource = self
        mealTable.delegate = self

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MealDataService.instanse.getMeals().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableCell") as? MealTableCell {
            let meal = MealDataService.instanse.getMeals()[indexPath.row]
            cell.updateMealTableCellView(meal: meal)
            return cell
            
        } else {
            return MealTableCell()
        }
    }
    

}
