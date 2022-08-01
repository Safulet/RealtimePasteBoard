//
//  ConfirmDeleteViewModel.swift
//  RealtimePasteBoard (iOS)
//
//  Created by Book on 2022/8/2.
//

import Combine
import SwiftUI

class ConfirmDeleteViewModel: ObservableObject {
    
    private var repository:PasteBoardRepositroy
    
    init(repository:PasteBoardRepositroy = .shared) {
        self.repository = repository
    }
    
    func delete(index:Int) {
        repository.deletePasteData(index: index)
    }
}
