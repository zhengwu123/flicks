//
//  detialViewController.swift
//  Movie review
//
//  Created by New on 1/5/16.
//  Copyright © 2016 New. All rights reserved.
//

import UIKit

class detialViewController: UIViewController, UITextViewDelegate{
    
    
    @IBOutlet var scrollViewOutput: UIScrollView!
    @IBOutlet var popularityLabel: UILabel!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet var vote_averageLabel: UILabel!
    @IBOutlet var voteCountLabel: UILabel!
    @IBOutlet var detailedLabel: UITextView!
    @IBOutlet  var DetailImage: UIImageView!
    
    
    @IBOutlet var hideButton: UIBarButtonItem!
    var popularityLabelText: String!
    var movieTitleText: String!
    var releaseDateText: String!
    var vote_averageLabelText: String!
    var voteCountLabelText: String!
    var detailedLabelText: String!
    var DetailImageURL: URL!
    
    @IBAction func Onhidebutton(_ sender: Any) {
        
        if hideButton.title == "hide"{
        hideButton.title = "show"
            self.myview.isHidden = true
        }
        else{
            hideButton.title = "hide"
            self.myview.isHidden = false
        }
    }
    
    @IBOutlet var myview: UIView!
    
    @IBOutlet var MnameLabel: UILabel!
    
    @IBOutlet var MvavgLabel: UILabel!
    
    @IBOutlet var MpopularityLabel: UILabel!
    
    @IBOutlet var DescriptionLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var viewOutLet: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailedLabel.delegate = self
        scrollViewOutput.contentSize.height = 800
        scrollViewOutput.contentSize.width = self.scrollViewOutput.frame.width
        /*CGSize(width:scrollViewOutput.frame.width, height: viewOutLet.frame.origin.y + viewOutLet.frame.size.height)*/
        myview.layer.cornerRadius = 8.0
        myview.clipsToBounds = true
        
        
        self.detailedLabel.text = detailedLabelText
        self.DetailImage.setImageWith(DetailImageURL)
        self.movieTitle.text = movieTitleText
        self.vote_averageLabel.text = vote_averageLabelText
        //self.voteCountLabel.text = voteCountLabelText
        //self.vote_averageLabel.text = vote_averageLabelText
        //self.releaseDate.text = releaseDateText
        //self.popularityLabel.text = popularityLabelText
        self.MnameLabel.text = movieTitleText
        self.MvavgLabel.text = vote_averageLabelText
        self.MpopularityLabel.text = popularityLabelText
        self.DescriptionLabel.text = detailedLabelText
        self.releaseDateLabel.text = releaseDateText
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
