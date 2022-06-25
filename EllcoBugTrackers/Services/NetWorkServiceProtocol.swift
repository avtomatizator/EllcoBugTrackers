//
//  NetWorkServiceProtocol.swift
//  EllcoBugTrackers
//
//  Created by admin on 25.06.2022.
//

import Foundation
import RxSwift

protocol NetWorkServiceInputProtocol: class {
    func callApi(page: Int) -> Observable<BugResponse>
}
