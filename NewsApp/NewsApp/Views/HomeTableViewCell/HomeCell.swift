//
//  HomeCell.swift
//  NewsApp
//
//  Created by Yusuf Emirhan Arslan on 14.05.2023.
//

import UIKit
import NewsAppAPI
import SDWebImage

class HomeCell: UITableViewCell {

    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsSectionName: UILabel!
    @IBOutlet weak var publisherName: UILabel!
    @IBOutlet weak var outStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    
    func setup() {
        
        outStackView.layer.cornerRadius = 20
        outStackView.layer.borderColor = UIColor.black.cgColor
        outStackView.layer.borderWidth = 1
        
        newsImageView.layer.cornerRadius = 20
    }
    
    func set(newsModel: News) {
        setup()
        
        if let url = newsModel.multimedia?.first?.url {
            setImage(urlString: url)
        }
        newsTitle.text = newsModel.title
        newsSectionName.text = newsModel.section
        publisherName.text = newsModel.byline
        
    }
    
    private func setImage(urlString: String) {
          newsImageView.sd_setImage(with: URL(string: urlString))
    }
    
}
