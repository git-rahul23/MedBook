//
//  BookMarksView.swift
//  Medbook
//
//  Created by RAHUL RANA on 27/12/23.
//

import SwiftUI

struct BookMarksView: View {
    
    @ObservedObject var viewModel = BookMarksViewModel()
    
    var body: some View {
        VStack {
            if let books = viewModel.books {
                ScrollView {
                    ForEach(0..<books.count, id: \.self) { index in
                        
                        HStack(alignment: .top) {
                            
                            ContentImageView(
                                "https://covers.openlibrary.org/b/id/\(books[index].coverI ?? 0)-M.jpg",
                                width: 50,
                                height: 50/0.633)
                            
                            VStack(alignment: .leading) {
                                
                                Text(books[index].title ?? "")
                                    .font(.appFont(.semiBold, size: 16))
                                
                                Text(books[index].authorName?[0] ?? "")
                                    .font(.appFont(.medium, size: 14))
                                
                            }
                            
                            Spacer()
                            
                            Button {
                                viewModel.removeBookMark(key: books[index].key ?? "")
                            } label: {
                                Image(systemName: "trash.fill")
                            }

                        }
                    }
                }
            }
        }
        .padding(.horizontal, 24)
        .onAppear {
            viewModel.fetchBookMarks()
        }
        
    }

}

struct BookMarksView_Previews: PreviewProvider {
    static var previews: some View {
        BookMarksView()
    }
}
