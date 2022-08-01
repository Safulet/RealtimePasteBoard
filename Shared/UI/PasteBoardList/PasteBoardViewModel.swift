//
//  PasteBoardViewModel.swift
//  RealtimePasteBoard (iOS)
//
//  Created by Book on 2022/7/31.
//

import Combine
import SwiftUI

class PasteBoardViewModel: ObservableObject {
    
    @Published var pasteDatas:[PasteBoardDomainObject.PasteData] =
    [.init(title: "TTTitle",
           value: "Value")]
    
    private var repository:PasteBoardRepositroy
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init(repository:PasteBoardRepositroy = .shared) {
        self.repository = repository
        setup()
    }
    
    func setup() {
        repository.$pasteDatas
            .receive(on: DispatchQueue.main)
            .sink { [weak self] datas in
                guard let self = self else { return }
                self.pasteDatas = datas
                print("sink\(self.pasteDatas)")
            }.store(in: &subscriptions)
    }
    
    func create(title:String,value:String) {
        repository.createPasteBoard(data: .init(title: title, value: value))
    }


}
