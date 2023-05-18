//
//  HomeCell.swift
//  NewsApp
//
//  Created by Yusuf Emirhan Arslan on 14.05.2023.
//

import UIKit
import NewsAppAPI
import SDWebImage

final class HomeCell: UITableViewCell {
    
    @IBOutlet private weak var visualEffectView: UIView!
    @IBOutlet private weak var outView: UIView!
    @IBOutlet private weak var innerView: UIView!
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsTitle: UILabel!
    @IBOutlet private weak var newsSectionName: UILabel!
    @IBOutlet private weak var publisherName: UILabel!
    @IBOutlet private weak var outStackView: UIStackView!
    @IBOutlet private weak var favoriteButton: UIImageView!
    
    func setup() {
        
        outStackView.layer.cornerRadius = 20
        outStackView.layer.borderColor = UIColor.black.cgColor
        outStackView.layer.borderWidth = 1
        
        newsImageView.layer.cornerRadius = 20
        
        visualEffectView.layer.cornerRadius = 20
        visualEffectView.clipsToBounds = true
        visualEffectView.isHidden = true
        
        checkFavoriteButton(false)
        favoriteButton.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addFavorite))
        favoriteButton.addGestureRecognizer(tapGestureRecognizer)
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
    
    @objc func addFavorite(){
        
        checkFavoriteButton(true)
    }
    
    func checkFavoriteButton(_ check: Bool) {
        
        switch check {
            
        case true:
            favoriteButton.image = UIImage(named: "heartFill")
        case false:
            favoriteButton.image = UIImage(named: "heart")
        }
    }
}
