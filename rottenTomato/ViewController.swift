//
//  ViewController.swift
//  rottenTomato
//
//  Created by Linghua Jin on 9/13/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
private let CELL_NAME = "com.codepath.rottenTomato.movieCell"
private let API_ROOT = "http://localhost:8000/"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var movies:NSArray?
    //movieList is the uitable outlet
    @IBOutlet weak var movieList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieList.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        //TODO: switch with remote uri
        //let cachedDataUrlString = "http://localhost:8000/"
        let request = NSMutableURLRequest(URL: NSURL(string:API_ROOT)!)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            (data, response, error) -> Void in
            let dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as? NSDictionary
            dispatch_async(dispatch_get_main_queue()) {
                //need to check if dictionary exist! otherwise the following statement won't pass compile
                if let dictionary = dictionary {
                    self.movies = dictionary["movies"] as? NSArray
                    self.movieList.reloadData()
                }
            }
        }
        task.resume()
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
