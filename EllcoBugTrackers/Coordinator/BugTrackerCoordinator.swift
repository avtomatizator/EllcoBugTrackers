//
//  BugCoordinator.swift
//  EllcoBugTrackers
//
//  Created by admin on 24.06.2022.
//

import UIKit
import RxSwift
import RxCocoa

class BugTrackerCoordinator: BugTrackerInputCoordinatorProtocol {
    let disposeBag = DisposeBag()
    var detailObservalbe: Observable<BugTracker>?
    let CoordinatorSubject = PublishSubject<BugTracker>()
    let navigationController = UINavigationController()
    
    init(window:UIWindow) {
        window.rootViewController = navigationController
        
    }
    
    func start(){
        let viewController = ModuleFactory.makeBugListModul(coordinator: self)
        navigationController.viewControllers = [viewController]
        
        let observableViewController =  (viewController as? BugOutputCoordinatorProtocol)!
        observableViewController.tableView.rx.modelSelected(BugTracker.self).bind { (bugTracker) in
            self.CoordinatorSubject.onNext(bugTracker)
            
        }.disposed(by: disposeBag)
        
    }
    
    func showDetailModule(){
        let viewController = BugDetailViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
        CoordinatorSubject.bind {[weak self] (bugTracker) in
            self?.detailObservalbe = Observable<BugTracker>.just(bugTracker)
        }.disposed(by: disposeBag)
    }
}
