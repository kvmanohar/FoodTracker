//
//  Meal.swift
//  FoodTracker
//
//  Created by Manohar Kurapati on 02/11/2017.
//  Copyright © 2017 Manosoft. All rights reserved.
//

import UIKit

struct Meal {
    
    private(set) public var name: String
    private(set) public var photo: UIImage?
    private(set) public var rating: Int
    
    //Initialise stored parameters
    init?(name: String, photo: UIImage?, rating:Int){
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 || rating > 5 {
            return nil
        }
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
