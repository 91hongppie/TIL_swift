//
//  NewRecordController.swift
//  Bodiary
//
//  Created by Kyuhong Jo on 5/9/24.
//

import UIKit

protocol NewRecordControllerDelegate: class {
    func updateRecordDate() -> Date
}

class NewRecordController: UIViewController {
    
    // MARK: - Properties
    private var recordDate: Date? {
        didSet { configureTitle() }
    }
    
    weak var delegate: NewRecordControllerDelegate?
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        view.backgroundColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismiss))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        recordDate = delegate?.updateRecordDate()
    }
    
    func configureTitle() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월 dd일"
        guard let recordDate = recordDate else { return }
        print(dateFormatter.string(from: recordDate))
        configureNavigationBar(withTitle: dateFormatter.string(from: recordDate), prefersLargeTitles: false)

    }
}
