//
//  ViewController.swift
//  rottenTomato
//
//  Created by Linghua Jin on 9/13/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
private let CELL_NAME = "com.codepath.rottenTomato.movieCell"
private let API_ROOT = "https://gist.githubusercontent.com/timothy1ee/e41513a57049e21bc6cf/raw/b490e79be2d21818f28614ec933d5d8f467f0a66/gistfile1.json"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var movies:NSArray?
    //  create the UIRefreshControl as an instance variable at the top of the class because you need to access it to stop the loading behavior. http://courses.codepath.com/courses/ios_for_designers/pages/using_uirefreshcontrol
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var networkErrBg: UIView!
    
    //movieList is the uitable outlet
    @IBOutlet weak var movieList: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func makeRequest(closure:()->()){
        //every request hide the network error notification
        self.networkErrBg.hidden = true;
        //TODO: switch with remote uri
        let request = NSMutableURLRequest(URL: NSURL(string:API_ROOT)!)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            if ((error) != nil){
                //if there is network error, show it up
                dispatch_async(dispatch_get_main_queue()){
                    self.networkErrBg.hidden = false;
                    self.activityIndicator.hidden = true
                }
                
                return
            }
            let dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as? NSDictionary
            //if successful show movie list container
            self.movieList.hidden = false
            dispatch_async(dispatch_get_main_queue()) {
                self.activityIndicator.hidden = true
                //need to check if dictionary exist! otherwise the following statement won't pass compile
                if let dictionary = dictionary {
                    self.movies = dictionary["movies"] as? NSArray
                    self.movieList.reloadData()
                }
                NSLog("request complete, dispatch to the main queue")
                closure()
            }
            
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //otherwise didSelectRowAtIndexPath won't work
        movieList.delegate = self
        makeRequest({});
        //networkErrBg.hidden = true;
        
        //  add the refresh control as a subview of the scrollview. It's best to insert it at the lowest index so that it appears behind all the views in the scrollview.
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        movieList.insertSubview(refreshControl, atIndex: 0)
    }
    // DO NOT DELETE
    // REFERENCE FOR swift closure
    //    func delay(delay:Double, closure:()->()) {
    //        dispatch_after(
    //            dispatch_time(
    //                DISPATCH_TIME_NOW,
    //                Int64(delay * Double(NSEC_PER_SEC))
    //            ),
    //            dispatch_get_main_queue(), closure)
    //    }
    
    func onRefresh() {
        makeRequest({
            self.refreshControl.endRefreshing()
        });
        //        delay(2, closure: {
        //            self.refreshControl.endRefreshing()
        //        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //        let cell = UITableViewCell()
        //        cell.textLabel?.text = "niuniu \(indexPath.row)"
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_NAME) as! MovieCell;
        let movie = self.movies![indexPath.row] as! NSDictionary
        cell.movieTitle.text = movie["title"] as? String
        cell.movieDescription.text = movie["synopsis"] as? String
        //grab image url
        let imgUrl = NSURL(string: movie.valueForKeyPath("posters.thumbnail") as! String)!
        cell.movieImage.setImageWithURL(imgUrl)
        return cell;
    }
    
    //deselect table if table is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
        view.endEditing(true)
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = movieList.indexPathForCell(cell)!
        let movie = movies![indexPath.row] as! NSDictionary
        let transitionToController = segue.destinationViewController as! MovieDetailViewController
        transitionToController.movie = movie
        view.endEditing(true)
        
    }
    //when tap anywhere on the screen, cancel the number pad triggered by input
    //this is deprecating the events for push navigation if i add the tapgesture reference outlet connection to view
    @IBAction func onTapAnywhere(sender: UITapGestureRecognizer) {
        NSLog("onTap")
        
        //        view.endEditing(true)
        
    }
    
}
