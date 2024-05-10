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
    
    private var todayImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var customTextInput: UIView = {
        let view = UIView()
        
        view.addSubview(messageInput)
        messageInput.translatesAutoresizingMaskIntoConstraints = false
        messageInput.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        messageInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        messageInput.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        messageInput.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(placeholder)
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        placeholder.topAnchor.constraint(equalTo: messageInput.topAnchor, constant: 9).isActive = true
        placeholder.leftAnchor.constraint(equalTo: messageInput.leftAnchor, constant: 6).isActive = true
        
        
        return view
    }()
    
    private let messageInput: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16)
        tv.backgroundColor = .black
        tv.keyboardType = .webSearch
        tv.textColor = .white
        return tv
    }()
    
    private let placeholder: UILabel = {
        let label = UILabel()
        label.text = "오늘 한 운동을 입력해주세요."
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
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
    
    @objc func handleSave() {
        print("왜 안되냐")
    }
    
    @objc func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func keyboardWillShow() {
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 88
        }
    }
    
    @objc func handleTextDidChange() {
        placeholder.isHidden = !messageInput.text.isEmpty
    }
    
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        view.endEditing(true)
        present(imagePickerController, animated: true)
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        view.backgroundColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismiss))
        navigationItem.leftBarButtonItem?.tintColor = .systemRed
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
        navigationItem.rightBarButtonItem?.tintColor = .systemGreen
        
        recordDate = delegate?.updateRecordDate()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        plusPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusPhotoButton.heightAnchor.constraint(equalToConstant: 350).isActive = true
        plusPhotoButton.widthAnchor.constraint(equalToConstant: 350
        ).isActive = true
        
        view.addSubview(customTextInput)
        customTextInput.translatesAutoresizingMaskIntoConstraints = false
        customTextInput.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 10).isActive = true
        customTextInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        customTextInput.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        customTextInput.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    func configureTitle() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월 dd일"
        guard let recordDate = recordDate else { return }
        configureNavigationBar(withTitle: dateFormatter.string(from: recordDate), prefersLargeTitles: false)

    }
}


extension NewRecordController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        todayImage = image
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 0.0
        dismiss(animated: true)
    }
    
}
