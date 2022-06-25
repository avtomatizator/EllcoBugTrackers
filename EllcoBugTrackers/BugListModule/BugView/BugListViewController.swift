//
//  BugListViewController.swift
//  EllcoBugTrackers
//
//  Created by admin on 24.06.2022.
//

import UIKit
import RxCocoa
import RxSwift

class BugListViewController: UIViewController, BugListViewInputProtocol, BugOutputCoordinatorProtocol {
    let disposeBag = DisposeBag()
    let beginSubject = PublishSubject<String>()
    var coordinator: BugTrackerInputCoordinatorProtocol!
    var viewModel: BugViewOutputProtocol!
    let tableView = UITableView()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        title = "BugTracker"
        viewModel!.setBinding()
        setTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sendRequest()
    }
    
    private func setTableView(){
        view.addSubview(tableView)
        tableView.addSubview(activityIndicator)
        tableView.tableFooterView = activityIndicator
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        tableView.register(BugListCell.self, forCellReuseIdentifier: "bugListCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        setConstraintsTableView()
        
        
        viewModel?.subjectResponse.bind(to: self.tableView.rx.items(cellIdentifier: "bugListCell", cellType: BugListCell.self)){ [weak self] row,model,cell in
            self?.activityIndicator.stopAnimating()
            
            let date = NSDate(timeIntervalSince1970: TimeInterval(model.createdAt.timestamp))
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "MM.dd.yyyy HH:mm"
            dayTimePeriodFormatter.locale = Locale(identifier: "ru_RU")
            
            let dateString = dayTimePeriodFormatter.string(from: date as Date)
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = model.name
            cell.detailTextLabel?.text = dateString
            
        }.disposed(by: disposeBag)
        
        
        
        
    }
    
    private func sendRequest(){
        
        beginSubject.onNext("")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

}

extension BugListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        coordinator.showDetailModule()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    

    
    private func setConstraintsTableView(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > viewModel.bugTrackers.count - 2{
            sendRequest()
        }
    }

}

