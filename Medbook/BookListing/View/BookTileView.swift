//
//  BookTileView.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import SwiftUI

struct BookTileView: View {
    
    var book: Book
    
    let width = (UIScreen.main.bounds.width - 56)*0.5
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                
                ContentImageView(
                    "https://covers.openlibrary.org/b/id/\(book.coverI ?? 0)-M.jpg",
                    width: width,
                    height: width/0.633)
                
                
                if let average = book.ratingsAverage, let count = book.ratingsCount {
                    HStack {
                        
                        
                        Text(String(format: "%.1f", average))
                            .font(.appFont(.bold, size: 14))
                        
                        Text("|")
                        
                        Text(String(count))
                            .font(.appFont(.bold, size: 14))
                        
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.trailing, 8)
                    .padding(.bottom, 8)
                }
                
            }
            
            VStack(alignment: .leading) {
                
                Text(book.title ?? "")
                    .lineLimit(2)
                    .font(.appFont(.bold, size: 16))
                    .frame(height: 38)
                
                
                Text(book.authorName?[0] ?? "")
                    .font(.appFont(.bold, size: 14))
                    .foregroundColor(.gray)
                
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .frame(width: width, alignment: .leading)
            
            Spacer()
        }
        .frame(width: width)
        .background(Color.gray.opacity(0.05))
        .clipped()
        .cornerRadius(7)
    }
}
