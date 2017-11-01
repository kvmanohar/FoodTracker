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
    var rating = 0
    
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
            removeArrangedSubview(button)      // Tell the stackview to no longer calcuate the width and height measurements.
            button.removeFromSuperview()       // Now remove the button from the stackView
        }
        ratingButtons.removeAll()              // Clear the Button array
        
        for _ in 0..<starCount {
            //Create the button
            let button = UIButton()
            button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            
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
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        print("Button pressed ")
    }
    
    
}
