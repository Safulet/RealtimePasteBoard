//
//  PasteBoardListView.swift
//  RealtimePasteBoard (iOS)
//
//  Created by Book on 2022/7/30.
//

import SwiftUI

struct PasteBoardListView: View {
    
    private let logoImageURL = "https://www.binet.com.tw/wp-content/uploads/2021/11/binance_icon.png"
    
    @State var newKey:String = ""
    @State var newValue:String = ""
    
    @State var isShowingConfirmDelete = false
    @State var prepareDeleteData:ConfirmDeleteObject = .init()
    
    @StateObject private var viewModel = PasteBoardViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    
                    logoImage

                    Text("Realtime PasteBoard")
                        .font(.title)
                        .padding()
                }
                
                titleTextField
                
                valueTextField
                
                addButton
                
                dataList
            }
        }
        .overlay(
            Color.black.opacity(isShowingConfirmDelete ? 0.5 : 0)
                .onTapGesture { isShowingConfirmDelete = false }
        )
        .overlay(alignment: .top) {
            if isShowingConfirmDelete {
                self.confirmDeleteView
            }
        }
        .animation(.spring(), value: isShowingConfirmDelete)
    }
    
//  MARK: - SubViews
    
    var confirmDeleteView: some View {
        ConfirmDeleteView(deleteData: $prepareDeleteData,
                          isShowing: $isShowingConfirmDelete)
        .offset(y: UIScreen.main.bounds.maxY / 3 )
        .transition(.scale)
    }
    
    var logoImage: some View {
        AsyncImage(url: URL(string: logoImageURL)) { phase in
            switch phase {
            case .empty:
                Image(systemName: "icloud.and.arrow.down")
                    .resizable()
                    .scaledToFill()
                    .background(Color.yellow.opacity(0.1))
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure(_):
                Image(systemName: "exclamationmark.icloud")
                    .resizable()
                    .scaledToFit()
            @unknown default:
                Image(systemName: "exclamationmark.icloud")
            }
        }.aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
            .cornerRadius(8)
    }
    
    var titleTextField: some View {
        TextField("Input new title", text: $newKey)
            .textFieldStyle(.roundedBorder)
            .font(.title)
            .padding(.horizontal,16)
            .padding(.vertical,5)
        
    }
    
    var valueTextField: some View {
        TextField("Input new value", text: $newValue)
            .textFieldStyle(.roundedBorder)
            .font(.body)
            .padding(.vertical,5)
            .padding(.horizontal,16)
    }
    
    var addButton: some View {
        Button {
            viewModel.create(title: newKey, value: newValue)
        } label: {
            Text("Add")
                .foregroundColor(.black)
                .font(.title2.weight(.bold))
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 20).foregroundColor(.yellow))
                .padding(.horizontal, 16)
        }
    }
    
    var dataList: some View {
        ForEach(Array($viewModel.pasteDatas.enumerated()), id: \.offset) { index, $data in
            HStack {
                VStack {
                    HStack {
                        Text(data.title)
                            .bold().font(.title)
                        
                        Spacer()
                        
                        Button {
                            prepareDeleteData = .init(title: data.title,
                                                      value: data.value,
                                                      index: index)
                            isShowingConfirmDelete = true
                        } label: {
                            Text("Delete")
                                .bold().font(.title2)
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.top,10)
                    .padding(.horizontal,10)
                    
                    Spacer()
                    
                    Text(data.value)
                        .font(.body)
                        .frame(maxWidth:.infinity,alignment:.leading)
                        .padding(.horizontal, 10)
                        .padding(.bottom,20)
                    
                }.padding(.leading)
            }
            .frame(height: 102)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.yellow))
            .padding([.leading,.trailing])
            .onTapGesture {
                UIPasteboard.general.string = data.value
                ProgressManager.showSuccessHUD(withStatus: data.value)
            }
        }
    }
}


struct PasteBoardList_Previews: PreviewProvider {
    static var previews: some View {
        PasteBoardListView()
    }
}
