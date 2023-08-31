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
        // 델리게이트 패턴의 대리자 설정
        tableView.dataSource = self
        tableView.delegate = self
        
        // 셀의 높이 설정
        tableView.rowHeight = 120
        
        title = "영화목록"
        
        movieDataManager.makeMovieData()
        // moviesArray = movieDataManager.getMovieData()
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        movieDataManager.updateMovieData()
        
        tableView.reloadData()
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


extension ViewController: UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetail") {
            let detailVC = segue.destination as! DetailViewController
            let array = movieDataManager.getMovieData()
            
            let indexPath = sender as! IndexPath
            
            detailVC.movieData = array[indexPath.row]
        }
    }
    
    
}

