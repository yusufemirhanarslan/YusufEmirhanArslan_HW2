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

    
    @IBOutlet private weak var outView: UIView!
    @IBOutlet private weak var favoriteButton: UIImageView!
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsTitle: UILabel!
    @IBOutlet private weak var sectionName: UILabel!
    @IBOutlet private weak var newsDescription: UITextView!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var newsSiteButton: UIButton!
    @IBOutlet weak var sharedButton: UIButton!
    @IBOutlet weak var authorLabel: UILabel!
    private var news: News?
    
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
        authorLabel.text = news?.byline
        
    }
    
    func design() {
        
        favoriteButton.image = UIImage(named: "heart")
        
        favoriteButton.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeFavorite))
        favoriteButton.addGestureRecognizer(tapGesture)

        bottomView.layer.cornerRadius = Design.cornerRadius
        
        sharedButton.setImage(UIImage(named: "share"), for: .disabled)
    }
    
    func dataEqual(model: News){
        self.news = model
    }
    
    @IBAction func openNewsSite(_ sender: Any) {
        
        if let url = news?.url{
            showNews(url: URL(string: url))
        }
        
    }
    
    @objc private func changeFavorite() {
        
    }
    
    func showNews(url: URL?) {
        
        if let url = url {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.delegate = self
            present(safariViewController, animated: true)
            
        }
        
    }
    
    @IBAction func sharedButton(_ sender: Any) {
        
        guard let newsUrl = news?.url else {return}
        
        let sharedInformation = [newsUrl]
        let activityVC = UIActivityViewController(activityItems: sharedInformation as [Any], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        present(activityVC, animated: true)
    }
}
extension DetailViewController {
    
    enum Design {
        static let cornerRadius = 20.0
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
               scrollView.contentOffset.x = 0
           }
    }
}
