//
//  BugListInputProtocol.swift
//  EllcoBugTrackers
//
//  Created by admin on 25.06.2022.
//

import Foundation
import RxSwift

protocol  BugListViewInputProtocol: class{
    var activityIndicator: UIActivityIndicatorView {get}
    var beginSubject: PublishSubject<String> {get}
}
