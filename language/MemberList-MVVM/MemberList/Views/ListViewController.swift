//
//  ListViewController.swift
//  MemberList
//
//  Created by Allen H on 2022/02/04.
//

import UIKit

final class ListViewController: UIViewController {

    private let tableView = UITableView()
    
    //MARK: - 뷰 모델
    //var memberListManager = MemberListManager()
    let viewModel: MemberListViewModel
    
    lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        return button
    }()
    
    init(viewModel: MemberListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 라이프사이클
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupNaviBar()
        setupDatas()
        setupTableView()
        setupTableViewConstraints()
    }
    
    // 화면에 들어오면 테이블뷰 다시 그리도록 구현
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func setupNaviBar() {
        title = viewModel.title
    
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationItem.rightBarButtonItem = self.plusButton
    }
    
    func setupDatas() {
        //뷰 모델에 위임 (자체적으로 생성자에서 하도록)
    }
    
    //MARK: - 테이블뷰 셋팅
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MemberCell")
    }
    
    
    //MARK: - 오토레이아웃 셋팅
    
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    @objc func plusButtonTapped() {
        viewModel.handleNextVC(nil, fromCurrentVC: self, animated: true)
    }
    
}

//MARK: - 테이블뷰 데이터 소스 구현
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //memberListManager.getMembersList().count
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MyTableViewCell
        
        // MVC에서는 멤버 전달⭐️
        // cell.member = memberListManager[indexPath.row]
        
        // MVVM에서는 뷰모델 전달 ⭐️⭐️⭐️
        let memberVM = viewModel.memberViewModelAtIndex(indexPath.row)
        cell.viewModel = memberVM
        
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - 테이블뷰 델리게이트 구현 (셀이 선택되었을때)

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // MVC에서는 직접 Push ⭐️
        //let detailVC = DetailViewController()
        //detailVC.delegate = self
        
        //let currentMember = memberListManager.getMembersList()[indexPath.row]
        //detailVC.member = currentMember
    
        //navigationController?.pushViewController(detailVC, animated: true)
        
        
        // MVVM에서는 뷰모델에게 위임 (로직) ⭐️⭐️⭐️
        viewModel.handleNextVC(indexPath.row, fromCurrentVC: self, animated: true)
    }
}

