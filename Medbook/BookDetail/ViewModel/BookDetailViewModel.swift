//
//  BookDetailViewModel.swift
//  Medbook
//
//  Created by RAHUL RANA on 27/12/23.
//

import Foundation
import CoreData

class BookDetailViewModel: ObservableObject {
    
    @Published var bookDetail: BookDetailModel?
    @Published var isBookmarked: Bool = false
    
    private let dataSource = ContentDataSource()
    
    @Published var showToast: Bool = false
    var toastMessage: String = ""
    var toastType: ToastType = .error
    
    private var key: String
    
    init(key: String) {
        self.key = key
        fetchDetails()
        checkIfInBookmarks()
    }
    
    private func fetchDetails() {
        Task {
            
            let result = await dataSource.fetchBookDetil(key: self.key)
            
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.bookDetail = response
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func checkIfInBookmarks() {
        
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<BookmarkedBook> = BookmarkedBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "key == %@", self.key)
        
        do {
            let books = try context.fetch(fetchRequest)
            if !books.isEmpty {
                self.isBookmarked = true
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func bookMarkedTapped(book: Book) {
        
        if isBookmarked {
            removeBookMark()
        } else {
            saveBookMark(book: book)
        }
        
    }
    
    private func removeBookMark() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<BookmarkedBook> = BookmarkedBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "key == %@", self.key)
        
        do {
            let books = try context.fetch(fetchRequest)
            for book in books {
                context.delete(book)
            }
            
            try context.save()
            
            self.toastMessage = "Removed from Bookmarks"
            self.toastType = .success
            self.showToast = true
            self.isBookmarked = false
            
        } catch {
            print("Error removing user: \(error.localizedDescription)")
        }
    }
    
    private func saveBookMark(book: Book) {
        
        let context = PersistenceController.shared.container.viewContext
        let bookmark = BookmarkedBook(context: context)
        bookmark.key = book.key ?? ""
        bookmark.title = book.title ?? ""
        bookmark.rating = book.ratingsAverage ?? 0.0
        bookmark.count = Double(book.ratingsCount ?? 0)
        bookmark.cover = Double(book.coverI ?? 0)
        
        if let authors = book.authorName, authors.count > 0 {
            bookmark.author = authors[0]
        }
        
        do {
            try context.save()
            self.toastMessage = "Added To Bookmarks"
            self.toastType = .success
            self.showToast = true
            self.isBookmarked = true
        } catch {
            print("Error saving user: \(error.localizedDescription)")
            self.toastMessage = "Failed adding to Bookmarks"
            self.toastType = .error
            self.showToast = true
        }
    }
}
