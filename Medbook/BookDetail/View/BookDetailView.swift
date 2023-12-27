//
//  BookDetailView.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import SwiftUI

struct BookDetailView: View {
    
    let width = (UIScreen.main.bounds.width - 56)*0.5
    
    @StateObject private var viewModel: BookDetailViewModel
    let book: Book
    
    init(book: Book) {
        self.book = book
        _viewModel = StateObject(wrappedValue: BookDetailViewModel(key: book.key ?? ""))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            Color.clear
            
            if viewModel.bookDetail != nil {
                ScrollView {
                    mainView
                }
                
                Button {
                    //
                } label: {
                    Text("ADD TO CART")
                        .font(.appFont(.semiBold, size: 16))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 42)
                .background(Color.black)
                .cornerRadius(7)
                .padding(.horizontal, 24)
                
            } else {
                Text("")
            }
    
        }
        .navigationBarItems(trailing:
                                Button(action: {
            self.viewModel.bookMarkedTapped(book: self.book)
        }, label: {
            Image(systemName: viewModel.isBookmarked ? "bookmark.fill" : "bookmark")
        })
        )
        .toast(isPresented: $viewModel.showToast, message: viewModel.toastMessage, type: viewModel.toastType)
        
    }
    
    var mainView: some View {
        
        VStack(alignment: .leading) {
            ZStack {
                ContentImageView(
                    "https://covers.openlibrary.org/b/id/\(book.coverI ?? 0)-M.jpg",
                    width: UIScreen.main.bounds.width,
                    height: width/0.633)
                .blur(radius: 4)
                
                ContentImageView(
                    "https://covers.openlibrary.org/b/id/\(book.coverI ?? 0)-M.jpg",
                    width: width,
                    height: width/0.633)
            }
            
            VStack(alignment: .leading) {
                
                HStack(alignment: .top) {
                    
                    Text(book.title ?? "")
                        .font(.appFont(.bold, size: 20))
                    
                    Spacer()
                    
                    HStack {
                        if let average = book.ratingsAverage {
                            Text(String(average))
                                .font(.appFont(.semiBold, size: 18))
                            
                        }
                        
                        if let count = book.ratingsCount {
                            Text("(\(String(count)))")
                                .font(.appFont(.medium, size: 18))
                            
                        }
                    }
                }
                
                
                Text(viewModel.bookDetail?.description ?? "")
                    .font(.appFont(.regular, size: 16))
            }
            .padding(.horizontal, 16)
            
            
            Spacer()
        }
    }
}
