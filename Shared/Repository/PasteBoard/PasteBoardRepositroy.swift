//
//  PasteBoardRepositroy.swift
//  RealtimePasteBoard (iOS)
//
//  Created by Book on 2022/7/30.
//

import Foundation
import SwiftUI
import Combine

//MARK: - Create
class PasteBoardRepositroy {
    
    static var shared:PasteBoardRepositroy = PasteBoardRepositroy()
    
    private var realtimeDatabase:RealtimeDatabase
    
    @Published var pasteDatas:[PasteBoardDomainObject.PasteData] = []
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init(realtimeDatabase:RealtimeDatabase = .shared) {
        self.realtimeDatabase = realtimeDatabase
        observe()
    }
    
    func observe() {
        realtimeDatabase.$root
            .sink { root in
            let pasteDatas = root.pasteBoard
                .map({ return PasteBoardDomainObject
                        .PasteData(title: $0.title,
                                   value: $0.value)})
            self.pasteDatas = pasteDatas
            }.store(in: &subscriptions)
    }
}

//MARK: - Create
extension PasteBoardRepositroy {
    func createPasteBoard(data:PasteBoardDomainObject.PasteData) {
        let pasteDatas = RealTimeDatabaseDomainObject.Root
            .PasteData(title: data.title,
                       value: data.value)
        realtimeDatabase.createPasteData(data: pasteDatas)
    }
}

//MARK: - Read
extension PasteBoardRepositroy {
    func getPasteDatas() -> [PasteBoardDomainObject.PasteData] {
        let pasteDatas = realtimeDatabase
            .getPasteData()
            .map({ return PasteBoardDomainObject
                    .PasteData(title: $0.title,
                               value: $0.value)})
        self.pasteDatas = pasteDatas
        return pasteDatas
    }
}

//MARK: - Update
extension PasteBoardRepositroy {
    func updatePasteData(index:Int,data:PasteBoardDomainObject.PasteData) {
        realtimeDatabase.updatePasteData(index: index, data: .init(title: data.title,
                                                                   value: data.value))
    }
}

//MARK: - Delete
extension PasteBoardRepositroy {
    func deletePasteData(index:Int) {
        realtimeDatabase.deletePasteData(index: index)
    }
}

