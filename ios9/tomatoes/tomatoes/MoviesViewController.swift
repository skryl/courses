//
//  MoviesViewController.swift
//  tomatoes
//
//  Created by Alex Skryl on 6/10/15.
//  Copyright (c) 2015 Alex Skryl. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var movies: [NSDictionary]! = [NSDictionary]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5")
        
        var request = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                var json   = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
                self.movies = json["movies"] as! [NSDictionary]
                self.tableView.reloadData()
        }
        
        tableView.delegate   = self
        tableView.dataSource = self
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as! MovieCell
        var movie = movies[indexPath.row]
        
        cell.titleLabel.text    = movie["title"]    as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        var url = movie.valueForKeyPath("posters.thumbnail") as! String
        url = "http://\(url[advance(url.startIndex, 64) ..< url.endIndex ])"
        
        cell.posterView.setImageWithURL(NSURL(string: url)!)
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       var movieDetailViewController = segue.destinationViewController as! MovieDetailViewController
        
       var cell = sender as! UITableViewCell
       var indexPath = tableView.indexPathForCell(cell)! as NSIndexPath
        
       movieDetailViewController.movie = movies[indexPath.row]
    }
}
