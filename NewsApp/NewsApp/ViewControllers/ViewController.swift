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
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var newsTitle: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var favoriesPageButton: UIButton!
    
    var value: String?
    
    
    var viewModel: ViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupFavoriesButton()
        
        setSegmentedControl()
        
        tableView.separatorStyle = .none
        
        newsTitle.text = self.segmentedControl.titleForSegment(at: 0)?.uppercased()
        
        segmentedControl.selectedSegmentIndex = 0
        
        viewModel.fetchData(value: viewModel.setSegmentedControl(index: segmentedControl.selectedSegmentIndex))
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "homeCell")
        
    }
    
    func setSegmentedControl() {
        
        segmentedControl.removeAllSegments()
        
        for i in 0...viewModel.segmentedCount - 1 {
            let name = viewModel.setSegmentedControl(index: i).uppercased()
            segmentedControl.insertSegment(withTitle: name, at: i , animated: true)
        }
    }
    
    private func setupFavoriesButton() {
        
        favoriesPageButton.layer.cornerRadius = 20
        favoriesPageButton.clipsToBounds = true
        favoriesPageButton.imageView?.contentMode = .scaleAspectFill
        
    }
    
    @IBAction func selectedSegmentedControl(_ sender: Any) {
        
        let index = segmentedControl.selectedSegmentIndex
        guard let title = segmentedControl.titleForSegment(at: index) else {return}
        
        self.value = title
        newsTitle.text = title.uppercased()
        
        viewModel.fetchData(value: title)
        
    }
    
    @IBAction func favoriesPageButton(_ sender: Any) {
        
        let favoritiesViewController = storyboard?.instantiateViewController(identifier: "favoritiesViewController") as! FavoritiesViewController
        navigationController?.pushViewController(favoritiesViewController, animated: true)
        
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
