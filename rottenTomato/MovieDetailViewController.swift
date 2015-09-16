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
        movieTitle.text = movie["title"] as? String
        movieNavTitle.title = movie["title"] as? String
        
        
           desc.text = movie["synopsis"]  as? String
        pgTag.text = movie["mpaa_rating"]  as? String
        
        var imgUrlStr = movie.valueForKeyPath("posters.thumbnail") as! String
        let imgUrlOri = NSURL(string: imgUrlStr)!
        //use low res image first
        movieImage.setImageWithURL(imgUrlOri)
        
        //        they stopped returning URLs to the high resolution poster images. You can get around that by manually hacking the URL, as below.
        var range = imgUrlStr.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            imgUrlStr = imgUrlStr.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        let imgUrlHighRes = NSURL(string: imgUrlStr)!
        movieImage.setImageWithURL(imgUrlHighRes)
        
        //enable scroller
        //TODO: view container/scrollview should fit the size of the movie description content
        scroller.scrollEnabled = true;
        scroller.contentSize = CGSizeMake(320, 624);
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
