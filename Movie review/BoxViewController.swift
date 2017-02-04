//
//  BoxViewController.swift
//  Movie review
//
//  Created by New on 1/7/16.
//  Copyright © 2016 New. All rights reserved.
//

import UIKit
import AFNetworking

//import AlgoliaSearch-Client-Swift

class BoxViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    @IBOutlet var boxView: UICollectionView!
    var movies: [NSDictionary]?
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Search controller
        boxView.delegate = self
        boxView.dataSource = self
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string:"https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.boxView.reloadData()
                    }
                }
        });
        
        refreshControl = UIRefreshControl()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        
        self.boxView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(BoxViewController.reload), for: UIControlEvents.valueChanged)
        task.resume()
        
        
    }
    
    func reload(){
        self.boxView.reloadData()
    }
   /* func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if let movies = movies{
            return movies.count
        }
        return 0
    }*/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movies = movies{
            return movies.count
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = boxView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
       // let overview = movie["overview"] as! String
        let posterPath = movie["poster_path"] as! String
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let imageURL = URL(string: baseURL + posterPath)
        cell.movieImage.setImageWith(imageURL!)
        // cell.
        cell.labelTitle.text = title
        //cell.textView1.text = overview
        //-----below is code for fade in
      //  let imageUrl = imageURL
        //let imageRequest = NSURLRequest(URL:imageUrl! )
        
       /* cell.image1.setImageWithURLRequest(
            imageRequest,
            placeholderImage: nil,
            success: { (imageRequest, imageResponse, image) -> Void in
                
                // imageResponse will be nil if the image is cached
                if imageResponse != nil {
                    print("Image was NOT cached, fade in image")
                    cell.image1.alpha = 0.0
                    cell.image1.image = image
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        cell.image1.alpha = 1.0
                    })
                } else {
                    print("Image was cached so just update the image")
                    cell.image1.image = image
                }
            },
            failure: { (imageRequest, imageResponse, error) -> Void in
                // do something for the failure condition
        })*/
        
        
        return cell
    }
    
    
   /* func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        EZLoadingActivity.hide(success: true, animated: true)
        let cell = tableView.dequeueReusableCellWithIdentifier("boxCell") as! boxCell
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let posterPath = movie["poster_path"] as! String
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let imageURL = NSURL(string: baseURL + posterPath)
        cell.image1.setImageWithURL(imageURL!)
        // cell.
        cell.label1.text = title
        cell.textView1.text = overview
        //-----below is code for fade in
        let imageUrl = imageURL
        let imageRequest = NSURLRequest(URL:imageUrl! )
        
        cell.image1.setImageWithURLRequest(
            imageRequest,
            placeholderImage: nil,
            success: { (imageRequest, imageResponse, image) -> Void in
                
                // imageResponse will be nil if the image is cached
                if imageResponse != nil {
                    print("Image was NOT cached, fade in image")
                    cell.image1.alpha = 0.0
                    cell.image1.image = image
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        cell.image1.alpha = 1.0
                    })
                } else {
                    print("Image was cached so just update the image")
                    cell.image1.image = image
                }
            },
            failure: { (imageRequest, imageResponse, error) -> Void in
                // do something for the failure condition
        })
        
        
        return cell
        
    }
*/
    // var movietitle = ""
    //var relasedate = ""
    //var popularity:NSNumber = 0.0
    //var vote_average:NSNumber = 0.0
    // var votecount:NSNumber = 0
    //var overview = ""
    //var posterPath = ""
    //var baseURL = ""
    
    var movietitleText = ""
    var relasedate = ""
    var popularity : NSNumber!
    var  vote_average : NSNumber!
    var votecount : NSNumber!
    var overview = ""
    var  posterPath = ""
    var baseURL = ""
    var imageURL :URL!
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies![indexPath.item]
        movietitleText = movie["title"] as! String
        relasedate = movie["release_date"] as! String
        popularity = movie["popularity"] as! NSNumber
        vote_average = movie["vote_average"] as! NSNumber
        votecount = movie["vote_count"] as! NSNumber
        overview = movie["overview"] as! String
        posterPath = movie["poster_path"] as! String
        baseURL = "http://image.tmdb.org/t/p/w500"
        imageURL = URL(string: baseURL + posterPath)!
        self.performSegue(withIdentifier: "ShowDetail", sender: self)
        print(movie)

    }
   /* func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let movie = movies![indexPath.row]
        movietitleText = movie["title"] as! String
        relasedate = movie["release_date"] as! String
        popularity = movie["popularity"] as! NSNumber
        vote_average = movie["vote_average"] as! NSNumber
        votecount = movie["vote_count"] as! NSNumber
        overview = movie["overview"] as! String
        posterPath = movie["poster_path"] as! String
        baseURL = "http://image.tmdb.org/t/p/w500"
        imageURL = NSURL(string: baseURL + posterPath)!
        //detialViewController().detailedLabel.text = overview
        // detialViewController().DetailImage.setImageWithURL(imageURL!)
        // detialViewController().movieTitle.text = title
        // detailedView.releaseDate.text = "Release Date: " + relasedate
        // let s_average:String = String(format:"%.2f", vote_average.doubleValue)
        // let s:String = String(format:"%.2f", popularity.doubleValue)
        //let s_count:String = String(format:"%f", votecount.doubleValue)
        // detailedView.popularityLabel.text = "Popularity: " + s
        // detailedView.vote_averageLabel.text = "Vote Average: " + s_average
        //detialViewController().voteCountLabel.text = "Vote Count: " + s_count
        /// detialViewController().detailedLabel.text = "10000"
        //self.movietitle.text = movietitle
        //  print(movietitle)
        // print(popularity)
        //  print(relasedate)
        // print(vote_average)
        //print(overview)
        //print(detialViewController().releaseDate.text)
        self.performSegueWithIdentifier("ShowDetail", sender: self)
        
    }
    
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail"  {
            let detialViewControllerInstance = segue.destination as! detialViewController
            detialViewControllerInstance.detailedLabelText = overview
            detialViewControllerInstance.DetailImageURL = imageURL
            detialViewControllerInstance.movieTitleText = movietitleText
            //let s_popularity:String = "Popularity: " + String(format:"%.2f", popularity.doubleValue)
           // detialViewControllerInstance.popularityLabelText = s_popularity
            //let s_count:String = "Vote Count: " + String(format:"%d", votecount.intValue)
            //detialViewControllerInstance.voteCountLabelText = s_count
           //// detialViewControllerInstance.releaseDateText = relasedate
            //let s_average:String = "Vote Average: " + String(format:"%.2f", vote_average.doubleValue)
            //detialViewControllerInstance.vote_averageLabelText = s_average
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
