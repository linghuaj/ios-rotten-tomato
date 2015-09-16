## Rotten Tomatoes

This is a movies app displaying box office and top rental DVDs using the [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON).

Time spent: `<Number of hours spent>`

### Features

#### Required

- [x] User can view a list of movies. Poster images load asynchronously.
- [x] User can view movie details by tapping on a cell.
- [x] User sees loading state while waiting for the API.
- [x] User sees error message when there is a network error: http://cl.ly/image/1l1L3M460c3C
- [x] User can pull to refresh the movie list.

#### Optional

- [ ] All images fade in.
- [x] For the larger poster, load the low-res first and switch to high-res when complete.
- [x] All images should be cached in memory and disk: AppDelegate has an instance of `NSURLCache` and `NSURLRequest` makes a request with `ReturnCacheDataElseLoad` cache policy. I tested it by turning off wifi and restarting the app.
- [x] Customize the highlight and selection effect of the cell.
- [x] Customize the navigation bar.
- [x] Add a tab bar for Box Office and DVD.
- [x] Add a search bar: pretty simple implementation of searching against the existing table view data.

### Walkthrough
![Video Walkthrough](http://i.imgur.com/9d4fXIm.gif)

##steps:
- pod install
- open rottenTomato.xcworkspace
- run simulator

##TODO:

##Notes:s
### cache policy
```
   let request = NSURLRequest(URL: NSURL(string:currentAPI)!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval:5)
```

###UIRefreshControl
Pull Down to refresh the
http://courses.codepath.com/courses/ios_for_designers/pages/using_uirefreshcontrol
create the UIRefreshControl as an instance variable at the top of the class because you need to access it to stop the loading behavior. 

```
    override func viewDidLoad() {
        //  add the refresh control as a subview of the scrollview. It's best to insert it at the lowest index so that it appears behind all the views in the scrollview.
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        movieList.insertSubview(refreshControl, atIndex: 0)
    }

    func onRefresh() {
        //get current selected tag
        makeRequest(){
            self.refreshControl.endRefreshing()
        };
    }

```

##tabBar
- add tab bar to the bottom

```
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate {
	override func viewDidLoad() {
    	tabBar.delegate = self
	}

	func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
		if item.tag != tabBar.selectedItem?.tag {
	    	return
	    }
	    //detecting current tab is handled in making request. because onRefresh needs to do the same thing
	    	makeRequest(){}
	    }
	}
```


Credits
---------
* [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
* icon Image by BenPixels from the Noun Project