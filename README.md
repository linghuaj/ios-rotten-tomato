## Rotten Tomatoes

This is a movies app displaying box office and top rental DVDs using the [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON).


### Features

#### Required

- [x] User can view a list of movies. Poster images load asynchronously.
- [x] User can view movie details by tapping on a cell.
- [x] User sees loading state while waiting for the API.
- [x] User sees error message when there is a network error: http://cl.ly/image/1l1L3M460c3C
- [x] User can pull to refresh the movie list.

#### Optional

- [x] All images fade in.
- [x] For the larger poster, load the low-res first and switch to high-res when complete.
- [x] All images should be cached in memory and disk: AppDelegate has an instance of `NSURLCache` and `NSURLRequest` makes a request with `ReturnCacheDataElseLoad` cache policy. I tested it by turning off wifi and restarting the app.
- [x] Customize the highlight and selection effect of the cell.
- [x] Customize the navigation bar.
- [x] Add a tab bar for Box Office and DVD.
- [x] Add a search bar: pretty simple implementation of searching against the existing table view data.

### Walkthrough
![Video Walkthrough](https://github.com/linghuaj/rotten-tomato/blob/master/rotten_tomato.gif)

### Steps:
- git clone https://github.com/linghuaj/rotten-tomato.git
- pod install
- open rottenTomato.xcworkspace
- run simulator

###Notes:
#### cache policy
```
let request = NSURLRequest(URL: NSURL(string:currentAPI)!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval:5)
```

#### Pull to refresh (UIRefreshControl)
Pull Down to refresh the table view
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

#### tabBar
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
}
```

#### simulate network loading
simulate network loading by canceling refreshing after a couple of seconds.
``` 
func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

func onRefresh() {
    delay(2, closure: {
        self.refreshControl.endRefreshing()
    })
}
```

### install pods
- pod init
- vi podfile https://github.com/linghuaj/rotten-tomato/blob/master/Podfile
- pod install
- open open rottenTomato.xcworkspace !!
- create a empty objective C file named 'dummy' to create a header file 
- delete the dummy file
- edit the header file to add in 

```
//with the import extension to class as UIImageView, the extension will be available after import
#import "UIImageView+AFNetworking.h"
```

### scroll for contents
- add scrollview
- drag contents-view under scroll view
- (use textview if to fit a longtext with scrolling and vertical top align)

```
override func viewDidLoad() {
    //enable scroller
    scroller.scrollEnabled = true;
    scroller.contentSize = CGSizeMake(320, 624);
}
```


### Credits
---------
* [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
* icon Image by BenPixels from the Noun Project
