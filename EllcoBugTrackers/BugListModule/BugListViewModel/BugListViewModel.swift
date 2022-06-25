//
//  BugListViewModel.swift
//  EllcoBugTrackers
//
//  Created by admin on 24.06.2022.
//

import Foundation
import RxSwift
class BugViewModel: BugViewOutputProtocol {
    let disposeBag = DisposeBag()
    var networkService: NetWorkServiceInputProtocol!
    weak var viewController: BugListViewInputProtocol?
    var totalPage = 1
    var currentPage = 0
    
    var bugTrackers = [BugTracker]()
    let subjectRequest = PublishSubject<String>()
    let subjectResponse = PublishSubject<[BugTracker]>()
    
    func setBinding(){
        
        viewController?.beginSubject.bind(onNext: {[weak self] (message) in
            
            if self!.totalPage > self!.currentPage{
                self!.currentPage += 1
                self?.networkService?.callApi(page: self!.currentPage).bind(onNext: { [weak self] (bugResponse) in
                    self!.totalPage = bugResponse.totalPages
                    self!.bugTrackers.append(contentsOf: bugResponse.bugTrackers)
                    self!.subjectResponse.onNext(self!.bugTrackers)
                }).disposed(by: self!.disposeBag)
            }else{
                self?.viewController?.activityIndicator.stopAnimating()
            }
            
            
            
        }).disposed(by: disposeBag)
    }
    
    
}
