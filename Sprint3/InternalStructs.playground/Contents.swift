import UIKit

/** This playground contains the structs for the internal API that will be created in Sprint4
 Using Django Framwork. **/

/* NOTE: Every response will contain a success boolean which will denote if the process was successful or not.
 It will also contain a message String, which can be used to send a message back to the mobile app:
 incase there was an error, we can give more details of the error
 Or else it will just contain "Success!" */

// #################################
// ### STRUCT FOR SIGNUP REQUEST ###
// #################################

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

// ################################
// ### STRUCT FOR LOGIN REQUEST ###
// ################################

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

// #############################
// ### STRUCTS FOR MAIN PAGE ###
// #############################

struct TravelPoint : Decodable {
  let lat: Float
  let lon: Float
  let zip: String
  let city: String
  let date: String
  let userId: Int
  let UserProfilePic: String
  
  enum CodingKeys : String, CodingKey {
    case lat
    case lon
    case zip
    case city
    case date
    case userId = "user_id"
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
  
  let bookId: Int
  let coverURL: String
  let title: String
  let author: String
  let rating: Int
  
  enum CodingKeys : String, CodingKey {
    case success
    case msg
    
    case bookId = "book_id"
    case coverURL = "cover_url"
    case title
    case author
    case rating
  }
}

// TODO: API for Search

// #########################################
// ### STRUCTS FOR BOOK INFORMATION PAGE ###
// #########################################

struct CommentsBookDetails : Decodable {
  
  // TODO: Complete this: Name, Comment, Date
  
  let success: Bool
  let msg: String
  
  let userId: Int
  let comment: String
  let date: String
  
  enum CodingKeys : String, CodingKey {
    case success
    case msg
    
    case userId = "user_id"
    case comment
    case date
  }
  
}

struct AvailableCopies : Decodable {
  
  // TODO: Complete this: CopyID, UserName, UserProfilePic, Distance, City
  
  let success: Bool
  let msg: String
  
  let copyId: Int
  let userId: Int
  let UserProfilePic: String
  let distance: Int
  let city: String
  
  enum CodingKeys : String, CodingKey {
    case success
    case msg
    
    case copyId = "copy_id"
    case userId = "user_id"
    case UserProfilePic = "profile_url"
    case distance
    case city
  }
  
}

struct BookDetails : Decodable {
  
  // TODO: Complete this: BookID, Title, Author, Rating, Description?, CoverURL, [CommentsBookDetails], [AvailableCopies]
  
  let success: Bool
  let msg: String
  
  let bookId: Int
  let title: String
  let author: String
  let rating: Int
  let description: String?
  let coverURL: String
  let commentsBookDetails: [CommentsBookDetails]
  let availableCopies: [AvailableCopies]
  
  enum CodingKeys : String, CodingKey {
    case success
    case msg
    
    case bookId = "book_id"
    case title
    case author
    case rating
    case description
    case coverURL = "cover_url"
    case commentsBookDetails = "comments_book_details"
    case availableCopies = "available_copies"
  }
  
}

// #########################################
// ### STRUCTS FOR COPY INFORMATION PAGE ###
// #########################################

struct CopyDetails : Decodable {
  
  // TODO: Complete this: copyID, status, [TravelPoint], title, author, coverURL, rating, shippingExpense, Willingness To Ship, Book Condition, Notes
  
  let success: Bool
  let msg: String
  
  let copyId: Int
  let bookId: Int
  let status: Int
  let travelHistory: [TravelPoint]
  let title: String
  let author: String
  let coverURL: String
  let rating: Int
  let shippingExpense: String
  let willingnessToShip: String
  let bookCondition: String
  let note: String
  
  enum CodingKeys : String, CodingKey {
    case success
    case msg
    
    case copyId = "copy_id"
    case bookId = "book_id"
    case status
    case travelHistory = "travel_history"
    case title
    case author
    case coverURL = "cover_url"
    case rating
    case shippingExpense = "shipping_expense"
    case willingnessToShip = "willingness"
    case bookCondition = "book_condition"
    case note
  }
  
}

struct RequestResult : Decodable {
  
  // TODO: Complete this: success, msg, requestID
  
  let success: Bool
  let msg: String
  let requestId: Int
  
  enum CodingKeys : String, CodingKey {
    case success
    case msg
    case requestId = "request_id"
  }
  
}

struct RequestActionResult : Decodable {
  
  // This will be used when the owner clicks on accept/decline
  // TODO: Complete this: success, msg, requestID
  
  let success: Bool
  let msg: String
  let requestId: Int
  
  enum CodingKeys : String, CodingKey {
    case success
    case msg
    case requestId = "request_id"
  }
  
}

// #####################################
// ### STRUCTS FOR RELEASE BOOK PAGE ###
// #####################################

// Third party ISBN API will either be called on our backend
// or on our frontend. We haven't decided yet, but the structs
// will remain similar.

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

struct BookDetailsFromISBN: Decodable {
  let authors: [Authors]
  let title: String
  let covers: [Int]
  
  enum CodingKeys : String, CodingKey {
    case authors
    case title
    case covers
  }
}

// TODO: Complete structs for this page

// ##########################################
// ### STRUCTS FOR PROFILE/DASHBOARD PAGE ###
// ##########################################

struct UserInformation: Decodable{
  let userId: Int
  let userName: String
  // list of Ids
  let ownReviews: [Int]
  let favorReviews: [Int]
  let currentCopy: [Int]
  let historyCopy: [Int]
  
  enum CodingKeys: String, CodingKey{
    case userId
    case userName
    case ownReviews
    case favorReviews
    case currentCopy
    case historyCopy
  }
  
}

struct DeleteReview: Decodable{
  let success: Bool
  let msg: String
  let reviewId: Int
  
  enum CodingKeys: String, CodingKey{
    case success
    case msg
    case reviewId
  }
  
}


// TODO: Complete structs for this page

// ##################################
// ### STRUCTS FOR COMMUNITY PAGE ###
// ##################################


struct ReviewDetails: Decodable{
  let reviewId: Int
  let userId: Int
  let userName: String
  let bookId: Int
  
  let coverURL: String
  let title: String
  let author: String
  let date: String
  
  let rating: Int
  let review: String
  
  enum CodingKeys: String, CodingKey{
    case reviewId = "review_id"
    case userId = "user_id"
    case userName = "user_name"
    case bookId = "book_id"
    case coverURL = "cover_url"
    case title
    case author
    case date
    case rating
    case review
  }
  
}

struct GetReviews: Decodable{
  // list of reviewIds
  
  let success: Bool
  let msg: String
  
  let allReviews: [ReviewDetails]
  let relatedReviews: [ReviewDetails]
  
  enum CodingKeys: String, CodingKey{
    
    case success
    case msg
    
    case allReviews = "all_reviews"
    case relatedReviews = "related_reviews"
  }
  
}


// TODO: Complete structs for this page

// ######################################
// ### STRUCTS FOR NOTIFICATIONS PAGE ###
// ######################################

// TODO: Complete structs for this page

struct BookRequest : Decodable {
  
  // This struct does not have success,msg because it is used by another struct that fetches from the API
  
  let requestId: Int
  let copyId: Int
  let bookId: Int
  let coverURL: String
  let bookCondition: String
  let shippingExpense: String
  
  let requestorId: Int
  let requestorProfilePicture: String
  let requestorName: String
  let lat: Float
  let lon: Float
  let distance: Float
  let note: String
  
  // TODO: Complete the Coding Keys
  
  enum CodingKeys : String, CodingKey {
    case requestId = "request_id"
    case copyId = "copy_id"
    case bookId = "book_id"
    case coverURL = "cover_url"
    case bookCondition = "book_condition"
    case shippingExpense = "shipping_expense"
    case requestorId = "requestor_id"
    case requestorProfilePicture = "requestor_profile_url"
    case requestorName = "requestor_name"
    case lat
    case lon
    case distance
    case note
  }
  
}

struct Notifications : Decodable {
  
  let success: Bool
  let msg: String
  let incomingRequests: [BookRequest]
  let acceptedRequests: [BookRequest]
  
  // TODO: Complete the Coding Keys
  enum CodingKeys : String, CodingKey {
    case success
    case msg
    case incomingRequests = "incoming_requests"
    case acceptedRequests = "accepted_requests"
  }
}

