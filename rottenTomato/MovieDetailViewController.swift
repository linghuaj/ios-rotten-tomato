//
//  MovieDetailViewController.swift
//  rottenTomato
//
//  Created by Linghua Jin on 9/13/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var movie: NSDictionary!

    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitle.text = movie["title"] as? String
        movieDescription.text = movie["synopsis"]  as? String
        
        var imgUrlStr = movie.valueForKeyPath("posters.thumbnail") as! String
//        they stopped returning URLs to the high resolution poster images. You can get around that by manually hacking the URL, as below.
        var range = imgUrlStr.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            imgUrlStr = imgUrlStr.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        let imgUrl = NSURL(string: imgUrlStr)!
        movieImage.setImageWithURL(imgUrl)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
