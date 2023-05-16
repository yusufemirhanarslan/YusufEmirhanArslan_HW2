//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Yusuf Emirhan Arslan on 16.05.2023.
//

import UIKit
import NewsAppAPI
import SDWebImage
import SafariServices

class DetailViewController: UIViewController, SFSafariViewControllerDelegate {

    
    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var sectionName: UILabel!
    @IBOutlet weak var newsDescription: UITextField!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var newsSiteButton: UIButton!
    
    var news: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        design()
    }
    
    
    func setup() {
        
        if let url = news?.multimedia?.first?.url {
            newsImageView.sd_setImage(with: URL(string: url))
        }
        
        newsTitle.text = news?.title
        sectionName.text = news?.section
        newsDescription.text = news?.abstract
        
    }
    
    func design() {
        
        visualEffectView.layer.cornerRadius = 20
        visualEffectView.clipsToBounds = true
        
        let cornerRadius =  min(bottomView.bounds.width, bottomView.bounds.height) * Design.cornerRadiusRatio
        let maskPath = UIBezierPath(roundedRect: bottomView.bounds,
                                    byRoundingCorners: [.topRight, .topLeft],
                                    cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bottomView.bounds
        maskLayer.path = maskPath.cgPath
        
        bottomView.layer.mask = maskLayer
    }
    
    func dataEqual(model: News){
        self.news = model
        
    }
    
    @IBAction func openNewsSite(_ sender: Any) {
        
        if let url = news?.url{
            showNews(url: URL(string: url))
        }
        
    }
    
    func showNews(url: URL?) {
        
        if let url = url {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.delegate = self
            present(safariViewController, animated: true)
            
        }
        
    }
}

extension DetailViewController {
    
    enum Design {
        static let cornerRadiusRatio = 0.1
    }
    
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
               scrollView.contentOffset.x = 0
           }
    }
}
