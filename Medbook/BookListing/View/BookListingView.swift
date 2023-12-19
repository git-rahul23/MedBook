//
//  BookListingView.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import SwiftUI

enum BookSortOptions: String, CaseIterable {
    case title
    case average
    case hits
    
    var image: String {
        switch self {
        case .title:
            return "textformat.size.larger"
        case .average:
            return "calendar"
        case .hits:
            return "folder"
        }
    }
}

struct BookListingView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    let width = (UIScreen.main.bounds.width - 56)*0.5
    
    var body: some View {
        
        VStack {
            searchFiedlView
            
            if viewModel.docs == nil {
                
                Spacer()
                
                Text("Start styping to find your favoutite books")
                    .font(.appFont(.semiBold, size: 14))
                    .foregroundColor(.gray.opacity(0.7))
                
                Spacer()
                
            } else {
                mainView
            }

        }
        .padding(.horizontal, 24)
        .navigationBarHidden(true)
        
    }
    
    var searchFiedlView: some View {
        HStack {
            
            Image(systemName: "magnifyingglass")
            
            TextField("Search Bond", text: $viewModel.searchString)
            
            if !viewModel.searchString.isEmpty {
                Button {
                    viewModel.searchString = ""
                } label: {
                    Image(systemName: "clear")
                        .renderingMode(.template)
                        .foregroundColor(.black)
                }
            }
            
            
        }
        .padding(.all, 8)
        .background(Color.white)
        .overlay {
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.gray, lineWidth: 1)
        }
    }
    
    var mainView: some View {
        VStack {
            
            HStack {
                
                Spacer()
                
                Menu {
                    Picker("", selection: $viewModel.sortOption) {
                        ForEach(BookSortOptions.allCases,
                                id: \.rawValue) { option in
                            Label(option.rawValue.capitalized,
                                  systemImage: option.image)
                            .tag(option)
                        }
                    }
                    .labelsHidden()
                    
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                }
            }
            
            ScrollViewReader { scrollProxy in
                
                ScrollView {
                    if let docs = viewModel.docs {
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: width))], spacing: 16) {
                            ForEach(0..<docs.count, id: \.self) { index in
                                let book = docs[index]
                                
                                
                                // add nav link to proceed to book detail
                                BookTileView(book: book)
                                    .onAppear {
                                        if book == docs.last {
                                            viewModel.loadMore()
                                        }
                                    }
                                
                            }
                        }
                        .id(viewModel.shouldScrollToTop)
                    }
                }
            }
            
            Spacer()
            
        }
    }
}

