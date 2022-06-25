//
//  BugViewOutputProtocol.swift
//  EllcoBugTrackers
//
//  Created by admin on 25.06.2022.
//

import Foundation
import RxSwift

protocol BugViewOutputProtocol: class {
    var bugTrackers: [BugTracker] {get set}
    var subjectResponse: PublishSubject<[BugTracker]> {get}
    func setBinding()
}
