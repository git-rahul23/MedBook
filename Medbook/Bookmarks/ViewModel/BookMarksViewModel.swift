//
//  BookMarksViewModel.swift
//  Medbook
//
//  Created by RAHUL RANA on 27/12/23.
//

import Foundation
import CoreData

class BookMarksViewModel : ObservableObject {

    @Published var books: [Book] = []
    
    func fetchBookMarks() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<BookmarkedBook> = BookmarkedBook.fetchRequest()
        
        do {
            let books = try context.fetch(fetchRequest)
            if !books.isEmpty {
                convertToBooks(books: books)
            }
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
        }
    }
    
    func removeBookMark(key: String) {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<BookmarkedBook> = BookmarkedBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "key == %@", key)
        
        do {
            let bookmarks = try context.fetch(fetchRequest)
            for bookmark in bookmarks {
                context.delete(bookmark)
            }
            
            try context.save()
            
            fetchBookMarks()
            
        } catch {
            print("Error removing user: \(error.localizedDescription)")
        }
    }
    
    private func convertToBooks(books: [BookmarkedBook]) {
        self.books = books.map { book in
            return Book(
                key: book.key,
                title: book.title,
                ratingsAverage: book.rating,
                ratingsCount: Int(book.count),
                coverI: Int(book.cover),
                authorName: [book.author ?? ""]
            )
        }
    }
}
