//
//  ModulFactory.swift
//  EllcoBugTrackers
//
//  Created by admin on 24.06.2022.
//

import UIKit

class ModuleFactory {
    static func makeBugListModul(coordinator: BugTrackerCoordinator) -> UIViewController {
        let networkService = NetWorkService()
        let viewModel = BugViewModel()
        let viewController = BugListViewController()
        viewModel.networkService = networkService
        viewController.viewModel = viewModel
        viewModel.viewController = viewController
        viewController.coordinator = coordinator
        
        return viewController
        
    }
}
