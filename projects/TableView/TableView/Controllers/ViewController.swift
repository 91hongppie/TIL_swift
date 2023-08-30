//
//  ViewController.swift
//  TableView
//
//  Created by Kyuhong Jo on 2023/08/29.
//

import UIKit

class ViewController: UIViewController {

//    var moviesArray: [Movie] = []

    var movieDataManager = DataManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = 120
        
        movieDataManager.makeMovieData()
//        moviesArray = movieDataManager.getMovieData()
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return movieDataManager.getMovieData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let array = movieDataManager.getMovieData()
        
        let movie = array[indexPath.row]
        
        
        cell.mainImageView.image = movie.movieImage
        cell.movieNameLabel.text = movie.movieName
        cell.descriptionLabel.text = movie.movieDescription
//        cell.selectionStyle = .none
        
        
        
        return cell
    }
}
