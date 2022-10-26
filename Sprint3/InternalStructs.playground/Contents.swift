import UIKit

/** This playground contains the structs for the internal API that will be created in Sprint4
 Using Django Framwork. **/

/* NOTE: Every response will contain a success boolean which will denote if the process was successful or not.
   It will also contain a message String, which can be used to send a message back to the mobile app:
   incase there was an error, we can give more details of the error
   Or else it will just contain "Success!" */

// ### STRUCT FOR SIGNUP REQUEST ###
struct SignUp: Decodable {
  let success: Bool
  let msg: String
  
  let userId: Int
  
  enum CodingKeys : String, CodingKey {
    case success
    case msg
    case userId = "user_id"
  }
}

// ### STRUCT FOR LOGIN REQUEST ###
struct LogIn: Decodable {
  let success: Bool
  let msg: String
  
  let userId: Int
  
  enum CodingKeys : String, CodingKey {
    case success
    case msg
    case userId = "user_id"
  }
}

// ### STRUCTS FOR MAIN PAGE ###
struct TravelPoint : Decodable {
  let lat: Float
  let lon: Float
  let zip: String
  let city: String
  let date: String
  let userID: Int
  let UserProfilePic: String
  
  enum CodingKeys : String, CodingKey {
    case lat
    case lon
    case zip
    case city
    case date
    case userID = "user_id"
    case UserProfilePic = "profile_url"
  }
}


struct OurPick: Decodable {
  let success: Bool
  let msg: String
  
  let copyId: Int
  let bookId: Int
  let userId: Int
  let travelHistory: [TravelPoint]
  
  enum CodingKeys : String, CodingKey {
    case success
    case msg
    
    case copyId = "copy_id"
    case bookId = "boook_id"
    case userId = "user_id"
    case travelHistory = "travel_history"
  }
}

struct Book : Decodable {
  
  let success: Bool
  let msg: String
  
  let bookID: Int
  let coverURL: String
  let title: String
  let author: String
  let rating: Int
  
  enum CodingKeys : String, CodingKey {
    case success
    case msg
    
    case bookID = "boook_id"
    case coverURL = "cover_url"
    case title
    case author
    case rating
  }
}

// TODO: API for Search


// ### STRUCTS FOR BOOK INFORMATION PAGE ###
struct CommentsBookDetails : Decodable {
  
  // TODO: Complete this: Name, Comment, Date
  
}

struct AvailableCopies : Decodable {
  
  // TODO: Complete this: CopyID, UserName, UserProfilePic, Distance, City
  
}

struct BookDetails : Decodable {
  
  // TODO: Complete this: BookID, Title, Author, Rating, Description?, CoverURL, [CommentsBookDetails], [AvailableCopies]
  
}

// ### STRUCTS FOR COPY INFORMATION PAGE ###

struct CopyDetails : Decodable {
  
  // TODO: Complete this: copyID, status, [TravelPoint], title, author, coverURL, rating, shippingExpense, Willingness To Ship, Book Condition, Notes
  
}

struct RequestResult : Decodable {
  
  // TODO: Complete this: success, msg, requestID
  
}

