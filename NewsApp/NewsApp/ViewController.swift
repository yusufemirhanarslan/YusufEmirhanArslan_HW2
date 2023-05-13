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
    
    
    
    var viewModel: ViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setSegmentedControl()
        
       
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
    
    
    @IBAction func seelctedSegmentedControl(_ sender: Any) {
        
        let index = segmentedControl.selectedSegmentIndex
        guard let title = segmentedControl.titleForSegment(at: index) else {return}
        
        viewModel.fetchData(value: title)
        print("Total Value: \(viewModel.segmentedCount)")
    }
    
}

extension ViewController: ViewModelDelegate {
    
}
