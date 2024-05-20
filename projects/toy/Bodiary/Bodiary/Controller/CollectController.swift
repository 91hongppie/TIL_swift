//
//  CalendarController.swift
//  Bodiary
//
//  Created by Kyuhong Jo on 5/9/24.
//

import UIKit

private let reuseIdentifier = "CollectView"


protocol CollectControllerDelegate: AnyObject {
    func updateData() -> [String: DailyRecord]?
    func dismissal(_ isModified: Bool) -> Void
}

class CollectController: UICollectionViewController {
    
    private var records: [String: DailyRecord]? {
        didSet {
            guard let newKeys = records?.keys else { return }
            keys = Array(newKeys).sorted(by: { $0 < $1 })
            collectionView.reloadData()
        }
    }
    
    private var selectedDate = Date()
    
    private var keys: [String]?
    
    private let emptyDataLabel: UILabel = {
        let label = UILabel()
        let text = "오늘의 운동과 변화를\n사진으로 기록해보세요!"
        let attributedString = NSMutableAttributedString(string: text)
        
        
        attributedString.addAttribute(.kern, value: 1.5, range: NSRange(location: 0, length: text.count))
        
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 18), range: NSRange(location: 0, length: text.count))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.count))
        label.attributedText = attributedString
        label.textAlignment = .center
        label.numberOfLines = 0
        
        label.textColor = .white
        return label
    }()
    
    
    weak var delegate: CollectControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        records = delegate?.updateData()
        
        
        view.backgroundColor = .black
        configureUI()
        scrollToBottom()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        configureNavigationBar(withTitle: "모아보기", prefersLargeTitles: false)
        
    }
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let lastSectionIndex = self.collectionView.numberOfSections - 1
            let lastItemIndex = self.collectionView.numberOfItems(inSection: lastSectionIndex) - 1
            if lastSectionIndex >= 0, lastItemIndex >= 0 {
                let indexPath = IndexPath(item: lastItemIndex, section: lastSectionIndex)
                self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: false)
            }
        }
    }
    
    func configureUI() {
        collectionView.backgroundColor = .black
        
        if records?.isEmpty == true {
            
            collectionView.addSubview(emptyDataLabel)
            emptyDataLabel.translatesAutoresizingMaskIntoConstraints = false
            emptyDataLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 100).isActive = true
            emptyDataLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
            return
        }
        collectionView.register(CollectCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

extension CollectController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return records?.keys.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectCell
        
        if let key = keys?[indexPath.row] {
            cell.record = records?[key]
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let key = keys?[indexPath.row], let newSelectedDate = records?[key]?.timestamp {
            selectedDate = newSelectedDate
        }
        let controller = NewRecordController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}


extension CollectController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        
        return CGSize(width: width / 3, height: width / 3)
    }
}


extension CollectController: NewRecordControllerDelegate {
    func dismissal(_ isModified: Bool) {
        delegate?.dismissal(isModified)
        if isModified == false {
            return
        }
        records = delegate?.updateData()
        collectionView.reloadData()
    }
    
    func updateRecordDate() -> Date {
        return selectedDate
    }
    
    func updateRecordData() -> DailyRecord? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월 dd일"
        let dateStr = dateFormatter.string(from: selectedDate)
        return records?[dateStr]
    }
}
