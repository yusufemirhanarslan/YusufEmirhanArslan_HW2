//
//  ViewController.swift
//  NewsApp
//
//  Created by Yusuf Emirhan Arslan on 13.05.2023.
//

import UIKit
import NewsAppAPI

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var value: String?
    
    var viewModel: ViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setSegmentedControl()
        
        tableView.separatorStyle = .none
        
        newsTitle.text = segmentedControl.titleForSegment(at: 0)?.uppercased()
        
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "homeCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchData(value: viewModel.setSegmentedControl(index: 0))
        segmentedControl.selectedSegmentIndex = 0
        
    }
    
    func setSegmentedControl() {
        
        segmentedControl.removeAllSegments()
        
        for i in 0...viewModel.segmentedCount - 1 {
            let name = viewModel.setSegmentedControl(index: i)
            segmentedControl.insertSegment(withTitle: name, at: i , animated: true)
            
        }
    }
    
    @IBAction func selectedSegmentedControl(_ sender: Any) {
        let index = segmentedControl.selectedSegmentIndex
        guard let title = segmentedControl.titleForSegment(at: index) else {return}
        
        self.value = title
        newsTitle.text = title.uppercased()
        
        viewModel.fetchData(value: title)
        
    }
    
    
}

extension ViewController: ViewModelDelegate {
   
    func reloadData() {
        tableView.reloadData()
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
        
        
        if let model = viewModel.getNews(indexPath.row) {
            cell.set(newsModel: model)
        }
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    
}



