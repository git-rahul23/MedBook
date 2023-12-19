//
//  BookDetailView.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import SwiftUI

struct BookDetailView: View {
    
    let book: Book
    
    let width = (UIScreen.main.bounds.width - 56)*0.5
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            Color.clear
            
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
            

        }
        .navigationBarItems(trailing:
                                Button(action: {
            //self.isSkipped = true
        }, label: {
            Text("SKIP")
        })
        )
        
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
                    
                    
                    
                }
                .padding(.horizontal, 16)
                
                Spacer()
            }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: .init(title: "The Time Machine", ratingsAverage: 4.2, ratingsCount: 152, coverI: 9009316, authorName: ["H. G. Wells"]))
    }
}
