//
//  MovieCell.swift
//  rottenTomato
//
//  Created by Linghua Jin on 9/13/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        // Set background color
        let view = UIView()
        view.backgroundColor =  UIColor(red: 1, green: 165/255, blue: 0, alpha: 0.5)
        selectedBackgroundView = view
    }
}
