//
//  MealDataService.swift
//  FoodTracker
//
//  Created by Manohar Kurapati on 03/11/2017.
//  Copyright © 2017 Manosoft. All rights reserved.
//

import UIKit

class MealDataService {
    static let instanse = MealDataService()

    func getMeals() -> [Meal] {
        return  loadSampleMeals()
    }
 
    private func loadSampleMeals() -> [Meal]{
        var meals = [Meal]()
        
        guard let meal1 = Meal(name: "Caprese Salad", photo: UIImage(named: "meal1"), rating: 3) else {
            fatalError("Unable to instantiate meal1")
        }
        guard let meal2 = Meal(name: "Chiken and Potato", photo: UIImage(named: "meal2"), rating: 5) else {
            fatalError("Unable to instantiate meal2")
        }
        guard let meal3 = Meal(name: "Pasta with meatballs", photo: UIImage(named: "meal3"), rating: 2) else {
            fatalError("Unable to instantiate meal3")
        }
        meals += [meal1, meal2, meal3]
        
        return meals
    }
    
//    private func getMeals() -> [Meal] {
//        return  meals
//
//    }
//        private let meals = [
//            Meal(name: "Caprese Salad", photo: UIImage(named: "meal1"), rating: 4),
//            Meal(name: "Chiken & Potatos", photo: UIImage(named:"meal2"), rating: 5),
//            Meal(name: "Pasta with Meatballs", photo: UIImage(named:"meal3"), rating: 2)
//        ]
    
    
}
