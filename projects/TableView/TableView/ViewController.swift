//
//  ViewController.swift
//  TableView
//
//  Created by Kyuhong Jo on 2023/08/29.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        return UITableViewCell()
    }

}

