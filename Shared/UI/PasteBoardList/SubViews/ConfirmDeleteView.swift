//
//  ConfirmDeleteView.swift
//  RealtimePasteBoard (iOS)
//
//  Created by Book on 2022/8/1.
//

import SwiftUI

struct ConfirmDeleteObject {
    internal init(title: String = "",
                  value: String = "",
                  index: Int = 0) {
        self.title = title
        self.value = value
        self.index = index
    }
    
    var title:String
    var value:String
    var index:Int
}

struct ConfirmDeleteView: View {
    
    @Binding var deleteData:ConfirmDeleteObject
    @Binding var isShowing: Bool
    
    @StateObject private var viewModel = ConfirmDeleteViewModel()
    
    var body: some View {
        VStack {
            Group {
                Text("Are you sure you want to delete 「 ")
                    .font(.title3)
                + Text(deleteData.title)
                    .foregroundColor(.yellow)
                    .font(.title2.bold())
                + Text("」 ？")
                    .font(.title3)
                + Text("\nOnce deleted,")
                    .font(.title3)
                + Text(" it cannot be recovered")
                    .foregroundColor(.red)
                    .font(.title2.bold())
            }
            
            HStack {
                Text("Cancel")
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .onTapGesture { isShowing = false  }
                    .padding()
                
                Button {
                    isShowing = false
                    viewModel.delete(index: deleteData.index)
                } label: {
                    Text("Confirm")
                        .font(.title2.bold())
                        .foregroundColor(.red)
                }.padding()
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color(uiColor: .tertiarySystemBackground)))
        .padding()
    }
}

struct ConfirmDeleteView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmDeleteView(deleteData: Binding.constant(.init(title:"BTC_Address")),
                          isShowing: Binding.constant(true))
        .background(.yellow)
    }
}
