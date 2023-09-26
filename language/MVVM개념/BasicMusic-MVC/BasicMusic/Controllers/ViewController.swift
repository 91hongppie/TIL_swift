//
//  ViewController.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    // 데이터(모델) (일반적으로 뷰컨트롤러가 가지고 있음)
    var music: Music? {
        didSet {
            DispatchQueue.main.async {
                self.configureUI()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configureUI() {
        self.albumNameLabel.text = self.music?.albumName
        self.songNameLabel.text = self.music?.songName
        self.artistNameLabel.text = self.music?.artistName
    }
    
    // 네트워킹 시작 (로직도 뷰컨트롤러가 가지고 있음)
    @IBAction func startButtonTapped(_ sender: UIButton) {
        fetchMusic { [weak self] result in
            switch result {
            case .success(let music):
                self?.music = music
//                DispatchQueue.main.async {
//                    self.configureUI()
//                }
            case .failure(let error):
                switch error {
                case .dataError:
                    print("데이터 에러")
                case .networkingError:
                    print("네트워킹 에러")
                case .parseError:
                    print("파싱 에러")
                }
            }
        }
    }
    
    // 화면이동
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let music = self.music else { return }
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        
        detailVC.modalPresentationStyle = .fullScreen
        
        // 다음화면에서 필요한 데이터 전달 ⭐️
        //detailVC.music = music
        detailVC.songName = music.songName
        detailVC.imageURL = music.imageUrl
        
        self.present(detailVC, animated: true)
    }
}

extension ViewController {
    
    // 네트워킹 관련 함수도 뷰컨트롤러가 가지고 있음(일반적으로 분리)
    func fetchMusic(completion: @escaping (Result<Music?, NetworkError>) -> Void) {
        let urlString = "https://itunes.apple.com/search?media=music&term=jazz"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                let musicData = try JSONDecoder().decode(MusicData.self, from: safeData)
                let music = musicData.results.first
                completion(.success(music))
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
        
    }
}
