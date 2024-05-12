//
//  HomeController.swift
//  Bodiary
//
//  Created by Kyuhong Jo on 5/9/24.
//

import UIKit
import FSCalendar

class HomeController: UIViewController {
    
    private var selectedDate = Date()
    
    private var records: [String: DailyRecord] = [:] {
        didSet { calendar.reloadData() }
        
    }
    
    lazy var header: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        
        view.addSubview(settingButton)
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        settingButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        settingButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    private let settingButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(systemName: "archivebox"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(goSetting), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var titleButton: UIButton = {
        let button = UIButton(type: .system)
        button.addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.topAnchor.constraint(equalTo: button.topAnchor).isActive = true
        titleView.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        
        button.addTarget(self, action: #selector(openDatePicker), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        view.addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleImageView.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 5).isActive = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "2024년 05월"
        label.textColor = .white
        return label
    }()
    
    private let titleImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")
        iv.tintColor = .lightGray
        return iv
    }()
    
    
    private let calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.appearance.weekdayTextColor = .lightGray
        calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "토"
        calendar.appearance.todayColor = .clear
        calendar.appearance.selectionColor = .systemPink        
        
        
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.titleWeekendColor = .white
        calendar.scrollEnabled = true
        calendar.scrollDirection = .vertical
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.placeholderType = .none
        calendar.headerHeight = 0
        
        return calendar
    }()
    
    private let addRecordButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .systemPink
        button.clipsToBounds = true
        
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.imageView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        button.addTarget(self, action: #selector(openNewRecord), for: .touchUpInside)
        return button
    }()
    
    private let moveToTodayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("오늘", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(moveToToday), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchRecord()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        fetchRecord()
    }
    
    // MARK: - Selectors
    
    @objc func moveToToday() {
        let today = Date()
        selectedDate = today
        self.calendar.setCurrentPage(today, animated: true)
        self.calendar.select(today)
    }
    
    @objc func openNewRecord() {
        let controller = NewRecordController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc func openDatePicker() {
        let alert = UIAlertController(title: "날짜 선택", message: "", preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
        
        
        let ok = UIAlertAction(title: "선택 완료", style: .cancel) { action in
            self.selectedDate = datePicker.date
            self.calendar.setCurrentPage(self.selectedDate, animated: true)
            self.calendar.select(self.selectedDate)
        }
        
        alert.addAction(ok)
        
        let vc = UIViewController()
        vc.view = datePicker
        
        alert.setValue(vc, forKey: "contentViewController")
        
        present(alert, animated: true)
    }
    
    @objc func goSetting() {
        let controller = SettingController()
        let backBarButton = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        backBarButton.tintColor = .white
        navigationItem.backBarButtonItem = backBarButton
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - API
    func fetchRecord() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let datas = try context.fetch(DailyRecord.fetchRequest()) as! [DailyRecord]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY년 MM월 dd일"
            datas.forEach { dailyRecord in
                guard let timestamp = dailyRecord.timestamp else { return }
                let timestampStr = dateFormatter.string(from: timestamp)
                records[timestampStr] = dailyRecord
            }
            calendar.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
        view.addSubview(header)
        
        header.translatesAutoresizingMaskIntoConstraints = false
        header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        header.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        header.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        header.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(calendar)
        calendar.delegate = self
        calendar.dataSource = self
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        calendar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        calendar.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 150).isActive = true
        calendar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250).isActive = true
        calendar.select(Date())
        view.addSubview(addRecordButton)
        
        view.addSubview(titleButton)
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        titleButton.bottomAnchor.constraint(equalTo: calendar.topAnchor, constant: -10).isActive = true
        titleButton.leftAnchor.constraint(equalTo: calendar.leftAnchor, constant: 16).isActive = true
        titleButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
        
        
        view.addSubview(moveToTodayButton)
        moveToTodayButton.translatesAutoresizingMaskIntoConstraints = false
        moveToTodayButton.bottomAnchor.constraint(equalTo: calendar.topAnchor, constant: -10).isActive = true
        moveToTodayButton.rightAnchor.constraint(equalTo: calendar.rightAnchor, constant: -16).isActive = true
        moveToTodayButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        moveToTodayButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        moveToTodayButton.layer.borderWidth = 1.0
        moveToTodayButton.layer.cornerRadius = 25 / 2
        moveToTodayButton.layer.borderColor = UIColor.white.cgColor
        
        
        addRecordButton.backgroundColor = .white
        addRecordButton.translatesAutoresizingMaskIntoConstraints = false
        addRecordButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        addRecordButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
        addRecordButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addRecordButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        addRecordButton.layer.cornerRadius = 40 / 2
        
    }
}

// MARK: - FSCalendarDataSource, FSCalendarDelegate

extension HomeController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        DispatchQueue.main.async {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY년 MM월"
            self.titleLabel.text = dateFormatter.string(from: calendar.currentPage)
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.selectedDate = date
      }

    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월 dd일"
        if records[dateFormatter.string(from: date)] != nil {
            return 1
        } else {
            return 0
        }
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        let eventScaleFactor: CGFloat = 1
        cell.eventIndicator.transform = CGAffineTransform(scaleX: eventScaleFactor, y: eventScaleFactor)
    }

    
}


extension HomeController: NewRecordControllerDelegate {
    func updateRecordDate() -> Date {
        print(selectedDate)
        return selectedDate
    }
}
