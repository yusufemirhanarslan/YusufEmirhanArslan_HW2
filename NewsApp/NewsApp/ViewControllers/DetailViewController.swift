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
import CoreData

class DetailViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet private weak var outView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
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
        
        favoriteButton.setImage(checkUrl() ? UIImage(named: "heartFill") : UIImage(named: "heart"), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    func saveData() {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedObjectContext = appDelegate?.persistentContainer.viewContext
        
        let saveData = NSEntityDescription.insertNewObject(forEntityName: "FavoriteNews", into: managedObjectContext!)
        
        guard let imagePress = newsImageView.image?.jpegData(compressionQuality: 0.5) else {return}
        
         saveData.setValue(news?.abstract, forKey: "abstract")
         saveData.setValue(news?.byline , forKey: "byline")
         saveData.setValue(news?.section , forKey: "section")
         saveData.setValue(news?.subsection, forKey: "subsection")
         saveData.setValue(news?.title, forKey: "title")
        saveData.setValue(news?.url, forKey: "url")
         saveData.setValue(imagePress, forKey: "image")
         
         do {
             try managedObjectContext?.save()
             print("Success")
         }catch {
             print("Failed")
         }
    }
   
    @IBAction func favoriteButtonAction(_ sender: Any) {
        
        if checkUrl() {
          deleteData()
        } else {
            saveData()
        }
        
        favoriteButton.setImage(checkUrl() ? UIImage(named: "heartFill") : UIImage(named: "heart"), for: .normal)
    }
    
    func checkUrl() -> Bool {
        
        var urlArray: [String] = []
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedObjectContext = appDelegate?.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteNews")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            
           let results = try managedObjectContext?.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                
                if let url = result.value(forKey: "url") as? String {
                    
                    urlArray.append(url)
                }
                
            }
            
            return urlArray.contains(news?.url ?? "")
            
        }catch {
            
        }
        return false
        
    }
    
    func deleteData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteNews")
        fetchRequest.predicate = NSPredicate(format: "url = %@", news?.url ?? "")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            
           let results = try managedObjectContext.fetch(fetchRequest)
                    
            for result in results as! [NSManagedObject] {
                managedObjectContext.delete(result)
            }
            do {
                try managedObjectContext.save()
            }catch {
                
            }
            
        }catch {
            
        }
        
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
