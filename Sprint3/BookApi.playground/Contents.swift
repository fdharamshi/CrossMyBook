import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//let isbn = "9781466208681" // CTCI
let isbn = "9780593207093" // Atomic Habits
let url = "https://openlibrary.org/isbn/\(isbn).json"
print(url)

// Your structs go here
struct Book: Decodable {
  let authors: [Authors]
  let title: String
  let covers: [Int]
  
  enum CodingKeys : String, CodingKey {
    case authors
    case title
    case covers
  }
}

struct Authors: Decodable {
  let key: String
  
  enum CodingKeys: String, CodingKey {
    case key
  }
}

struct Author: Decodable {
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case name
  }
}

func getAuthorName(_ authorKey: String) {
  let url: String = "https://openlibrary.org\(authorKey).json"
  let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
    guard let data = data else {
      print("Error: No data to decode")
      return
    }
    
    // Decode the JSON here
    guard let author = try? JSONDecoder().decode(Author.self, from: data) else {
      print("Error: Couldn't decode data into a result")
      return
    }
    
    
    // Output if everything is working right
    print("Author Name: \(author.name)")
  }
  task.resume()
}




let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
  guard let data = data else {
    print("Error: No data to decode")
    return
  }
  
  // Decode the JSON here
  guard let book = try? JSONDecoder().decode(Book.self, from: data) else {
    print("Error: Couldn't decode data into a result")
    return
  }
  
  
  // Output if everything is working right
  print("Book Title: \(book.title)")
  print("\n#######################")
  print("Number of Authors: \(book.authors.count)")
  print("Author Keys:")
  for author in book.authors {
    print(author.key)
  }
  print("\n#######################")
  print("Number of covers: \(book.covers.count)")
  print("Cover URLs:")
  for cover in book.covers {
    print("https://covers.openlibrary.org/b/id/\(cover)-L.jpg")
  }
  print("\n#######################")
  print("Author Names:")
  for author in book.authors {
    getAuthorName(author.key)
  }
}

task.resume()
