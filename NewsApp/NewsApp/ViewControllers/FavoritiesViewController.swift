//
//  FavoritiesViewController.swift
//  NewsApp
//
//  Created by Yusuf Emirhan Arslan on 18.05.2023.
//

import UIKit
import CoreData

class FavoritiesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var fetchData: [NewsCoreData?] = []
    var news = NewsCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "homeCell")
        tableView.separatorStyle = .none
        
        fetchCoreData()
    }
    
    func fetchCoreData() {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedObjectContext = appDelegate?.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteNews")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            
           let results = try managedObjectContext?.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                
                if let abstract = result.value(forKey: "abstract") as? String{
                    news.abstract = abstract
                }
                
                if let byline = result.value(forKey: "byline") as? String{
                    news.byline = byline
                }
                
                if let image = result.value(forKey: "image") as? Data {
                    news.image = image
                }
                
                if let section = result.value(forKey: "section") as? String{
                    news.section = section
                }
                
                if let subsection = result.value(forKey: "subsection") as? String{
                    news.subsection = subsection
                }
                
                if let title = result.value(forKey: "title") as? String {
                    news.title = title
                }
                
                if let url = result.value(forKey: "url") as? String{
                    news.url = url
                }
                
                fetchData.append(news)
                tableView.reloadData()
            }
            
        }catch {
            
        }
    }
    

}

extension FavoritiesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        fetchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
        
        cell.selectionStyle = .none
        
        if let data = fetchData[indexPath.row] {
            cell.favoritSet(news: data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
}
