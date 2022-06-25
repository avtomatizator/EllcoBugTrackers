//
//  BugDetailViewController.swift
//  EllcoBugTrackers
//
//  Created by admin on 25.06.2022.
//

import UIKit
import RxSwift
import RxCocoa

class BugDetailViewController: UIViewController{
    let disposeBag = DisposeBag()
    weak var coordinator: BugTrackerCoordinator!
    let tableView = UITableView(frame: .zero, style: .grouped)
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        
    }

    private func setTableView(){
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "detailCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        
        setConstraintsTableView()
    }
    
    private func setConstraintsTableView(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension BugDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Номер Заявки"
        case 1:
            return "Проблема"
        case 2:
            return "Детали"
        case 3:
            return "Имя пользователя"
        case 4:
            return "Источник"
        case 5:
            return "Статус заявки"
        case 6:
            return "Время создания заявки"
        
        
        default:
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
        switch indexPath.section {
        case 0:
            
            coordinator.detailObservalbe?.bind(onNext: { (bugTracker) in
                cell.textLabel?.text = String(bugTracker.id)
            }).disposed(by: disposeBag)
            return cell
        case 1:
            coordinator.detailObservalbe?.bind(onNext: { (bugTracker) in
                cell.textLabel?.text = bugTracker.name
            }).disposed(by: disposeBag)
            return cell
        case 2:
            coordinator.detailObservalbe?.bind(onNext: { (bugTracker) in
                cell.textLabel?.text = bugTracker.description
            }).disposed(by: disposeBag)
            return cell
        case 3:
            coordinator.detailObservalbe?.bind(onNext: { (bugTracker) in
                cell.textLabel?.text = bugTracker.sender.username
            }).disposed(by: disposeBag)
            return cell
        
        case 4:
            coordinator.detailObservalbe?.bind(onNext: { (bugTracker) in
                cell.textLabel?.text = bugTracker.product.name
            }).disposed(by: disposeBag)
            return cell
            
        case 5:
            cell.accessoryType = .detailButton
            
            coordinator.detailObservalbe?.bind(onNext: { (bugTracker) in
                cell.textLabel?.text = bugTracker.status.description
            }).disposed(by: disposeBag)
            return cell
        case 6:
            coordinator.detailObservalbe?.bind(onNext: { (bugTracker) in
                
                let date = NSDate(timeIntervalSince1970: TimeInterval(bugTracker.createdAt.timestamp))
                let dayTimePeriodFormatter = DateFormatter()
                dayTimePeriodFormatter.dateFormat = "MM.dd.yyyy HH:mm"
                dayTimePeriodFormatter.locale = Locale(identifier: "ru_RU")
                let dateString = dayTimePeriodFormatter.string(from: date as Date)
                cell.textLabel?.text = dateString
            }).disposed(by: disposeBag)
            return cell
        default:
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        coordinator.detailObservalbe?.bind(onNext: {[unowned self] (bugTracker) in
            let alertController = UIAlertController(title: "Детали заявки", message: bugTracker.status.tooltip, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
            alertController.addAction(action)
            if indexPath.section == 5 {
                self.present(alertController, animated: true, completion: nil)
            }
        }).disposed(by: disposeBag)
        
        
        
    }
    
    
}
