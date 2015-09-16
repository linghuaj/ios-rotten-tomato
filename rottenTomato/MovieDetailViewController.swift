//
//  MovieDetailViewController.swift
//  rottenTomato
//
//  Created by Linghua Jin on 9/13/15.


import UIKit

class MovieDetailViewController: UIViewController {
    var movie: NSDictionary!
    
    @IBOutlet weak var movieNavTitle: UINavigationItem!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var pgTag: UILabel!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var scroller: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialize with the movie passed from movies view controller
        movieImage.alpha = 0.5
        movieTitle.text = movie["title"] as? String
        movieNavTitle.title = movie["title"] as? String
        desc.text = movie["synopsis"]  as? String
        pgTag.text = movie["mpaa_rating"]  as? String
        
        //enable scroller
        scroller.scrollEnabled = true;
        scroller.contentSize = CGSizeMake(320, 624);
        
        self.loadMovieImage()
    }
    
    /**
     * load low res image first
     * when high res available it overrides the low res image
     * set up image fadein
    */
    func loadMovieImage(){
        //use low res image first
        var imgUrlStr = movie.valueForKeyPath("posters.thumbnail") as! String
        let imgUrlOri = NSURL(string: imgUrlStr)!
        movieImage.setImageWithURL(imgUrlOri)
        
        //load high res image, API stopped returning URLs to the high resolution poster images. get around by manually hacking the URL.
        var range = imgUrlStr.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            imgUrlStr = imgUrlStr.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        let imgUrlHighRes = NSURL(string: imgUrlStr)!
        movieImage.setImageWithURL(imgUrlHighRes)
        
        //fadein the image
        UIView.animateWithDuration(0.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.movieImage.alpha = 1.0
            }, completion: nil)
    }
    
}
