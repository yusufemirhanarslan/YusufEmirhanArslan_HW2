//
//  ViewController.swift
//  NewsApp
//
//  Created by Yusuf Emirhan Arslan on 13.05.2023.
//

import UIKit
import NewsAppAPI
import Network

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var value: String?
    var check: Bool?
    
    var viewModel: ViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if monitorNetwork() {
            setSegmentedControl()
            
            tableView.separatorStyle = .none
            
            newsTitle.text = segmentedControl.titleForSegment(at: 0)?.uppercased()
            
            segmentedControl.selectedSegmentIndex = 0
            
            viewModel.fetchData(value: viewModel.setSegmentedControl(index: segmentedControl.selectedSegmentIndex))
            
            tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "homeCell")
        } else {
            exit(0)
        }
    }
    
    func setSegmentedControl() {
        
        segmentedControl.removeAllSegments()
        
        for i in 0...viewModel.segmentedCount - 1 {
            let name = viewModel.setSegmentedControl(index: i)
            segmentedControl.insertSegment(withTitle: name, at: i , animated: true)
        }
    }
    
    func monitorNetwork() -> Bool {
        
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { path in
            
            if path.status == .satisfied {
                
                DispatchQueue.main.async {
                    self.check = true
                }
                
            } else {
                self.check = false
            }
        }
        
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
        
        return self.check ?? true
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
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = storyboard?.instantiateViewController(identifier: "detailVC") as! DetailViewController
        
        if let model = viewModel.getNews(indexPath.row) {
            detailVC.dataEqual(model: model)
        }
        
        detailVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailVC, animated: true)
    }
}



