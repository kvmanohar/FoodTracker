//
//  MealTableCell.swift
//  FoodTracker
//
//  Created by Manohar Kurapati on 03/11/2017.
//  Copyright © 2017 Manosoft. All rights reserved.
//

import UIKit

class MealTableCell: UITableViewCell {

    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealLabel: UILabel!
    @IBOutlet weak var mealRating: RatingControlSV!
    
    func updateMealTableCellView(meal: Meal){
        mealImage.image = meal.photo
        mealLabel.text = meal.name
        mealRating.rating = meal.rating
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
