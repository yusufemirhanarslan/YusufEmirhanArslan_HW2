//
//  ViewController.swift
//  NewsApp
//
//  Created by Yusuf Emirhan Arslan on 13.05.2023.
//

import UIKit
import NewsAppAPI

class ViewController: UIViewController {
  
    var viewModel: ViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchData()
    }
    
}

extension ViewController: ViewModelDelegate {
    
}
