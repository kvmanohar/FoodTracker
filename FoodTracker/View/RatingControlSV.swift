//
//  RatingControlSV.swift
//  FoodTracker
//
//  Created by Manohar Kurapati on 01/11/2017.
//  Copyright © 2017 Manosoft. All rights reserved.
//

import UIKit

@IBDesignable
class RatingControlSV: UIStackView {

    //Design parameter for the view
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet {
            setupButton()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet{
            setupButton()
        }
    }
    
    // Variables to store the button array and current rating.
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet{
            updateButtonSelectionStatus()
        }
    }
    
    //Default initi frame function override
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    //Default init coder function override
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    
    //Create Single Button in the stake view
    private func setupButton(){
        
        //Remove the exisiting buttons on the stake view if already exists
        for button in ratingButtons{
            removeArrangedSubview(button)      // Tell the stackview to no longer calcuate the width and height
            button.removeFromSuperview()       // Now remove the button from the stackView
        }
        ratingButtons.removeAll()              // Clear the Button array
        
        
        //Load the button image to cateloge bundle
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
    
        
        for _ in 0..<starCount {
            //Create the button
            let button = UIButton()
            
            //Set the button image
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.selected,.highlighted])
            
            //Add contraints to the button
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //Setup Button Action
            button.addTarget(self, action: #selector(RatingControlSV.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //Add the button to the stack
            addArrangedSubview(button)
            
            //Add new button to rating Button array
            ratingButtons.append(button)
        }
        updateButtonSelectionStatus()
    }
    
    
    
    //Function similar to IBAction for the button
    @objc func ratingButtonTapped(button: UIButton) {
     
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The Button \(button), is not in the  ratingButton array: \(ratingButtons)")
        }
        
        let selectedRating = index + 1
        
        if selectedRating == rating {
            //if the selected star rating represent the current rating, reset the rating
            rating = 0
        }else{
            rating = selectedRating
        }
    }// End of ratingButtonTapped
    
    private func updateButtonSelectionStatus(){
        for (index, button) in ratingButtons.enumerated(){
            button.isSelected = index < rating
        }
    }
    
    
}
