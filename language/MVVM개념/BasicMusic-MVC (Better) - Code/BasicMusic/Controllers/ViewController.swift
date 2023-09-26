//
//  ViewController.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import UIKit

class ViewController: UIViewController {
    
    // 일부러 싱글톤으로 안 만듦 (APIService객체에 의존하게됨) ⭐️
    let apiManager = APIService()

    let albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "앨범제목"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.text = "노래제목"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "아티스트 이름"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [albumNameLabel, songNameLabel, artistNameLabel])
        stview.spacing = 8
        stview.axis = .vertical
        stview.distribution = .fillEqually
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [startButton, nextButton])
        stview.spacing = 20
        stview.axis = .horizontal
        stview.distribution = .fillEqually
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    
    // 데이터(모델) (일반적으로 뷰컨트롤러가 가지고 있음) ⭐️⭐️⭐️
    var music: Music? {
        didSet {
            DispatchQueue.main.async {
                self.configureUI()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoLayout()
    }
    
    func configureUI() {
        self.albumNameLabel.text = self.music?.albumName
        self.songNameLabel.text = self.music?.songName
        self.artistNameLabel.text = self.music?.artistName
    }
    
    func setupAutoLayout() {
        self.view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40)
        ])
        
        self.view.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            buttonStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            buttonStackView.heightAnchor.constraint(equalToConstant: 45),
            buttonStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
    
    @objc func startButtonTapped(_ sender: UIButton) {
        apiManager.fetchMusic { [weak self] result in
            switch result {
            case .success(let music):
                self?.music = music

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
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        guard let music = self.music else { return }
        
        // 스토리보드로 인스턴스 생성
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        detailVC.modalPresentationStyle = .fullScreen   // 화면 어떻게 띄울지 설정
        
        // 네트워킹 매니저 전달
        detailVC.apiManager = self.apiManager
        
        // 다음화면에서 필요한 데이터 전달 ⭐️
        //detailVC.music = music
        detailVC.songName = music.songName
        detailVC.imageURL = music.imageUrl
        
        self.present(detailVC, animated: true)
    }
}

