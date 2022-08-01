//
//  ConfirmDeleteView.swift
//  RealtimePasteBoard (iOS)
//
//  Created by Book on 2022/8/1.
//

import SwiftUI


struct ConfirmDeleteView: View {
    
    @Binding var deleteData:PasteBoardDomainObject.PasteData
    @Binding var isShowing: Bool
    
    @StateObject private var viewModel = ConfirmDeleteViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("確定要將 ")
                    .font(.title2)
                + Text(deleteData.title)
                    .foregroundColor(.red)
                    .font(.title.bold())
                + Text(" 刪除嗎？")
                    .font(.title2)
            }
            
            VStack {
                Text("取消")
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .onTapGesture { isShowing = false  }
                
                Button {
//                    viewModel.delete(index: 0)
                } label: {
                    Text("確定")
                        .font(.title2)
                        .foregroundColor(.red)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color(uiColor: .tertiarySystemBackground)))
        .padding()
    }
}

struct ConfirmDeleteView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmDeleteView(deleteData: Binding.constant(.init(title: "Key",
                                                             value: "")),
                          isShowing: Binding.constant(true))
    }
}
