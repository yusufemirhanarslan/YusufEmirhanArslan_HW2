//
//  FavoritiesViewController.swift
//  NewsApp
//
//  Created by Yusuf Emirhan Arslan on 18.05.2023.
//

import UIKit

class FavoritiesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "homeCell")
       
        tableView.separatorStyle = .none
    }
    

}

extension FavoritiesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
