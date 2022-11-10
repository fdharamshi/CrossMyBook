//
//  RequestController.swift
//  CrossMyBook
//
//  Created by 魏妤庭 on 2022/11/8.
//

import Foundation

class RequestController: ObservableObject {
    
    @Published var requestModel = RequestModel()
    @Published var success: Bool = true
    
    func createRequest() -> Bool {
        let userID = requestModel.userID
        let copyID = requestModel.copyID
        let listingID = requestModel.listingID
        let lat = requestModel.lat
        let lon = requestModel.lon
        let note = requestModel.note
        
        let url = URL(string: "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/createRequest")
        guard let requestUrl = url else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "user_id=\(userID)&copy_id=\(copyID)&listing_id=\(listingID)&lat=\(lat)&lon=\(lon)&note=\(note)";
        print(postString)
        
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("Error: No data to decode")
                return
            }
            
            // Decode the JSON here
            guard let message = try? JSONDecoder().decode(RequestMessage.self, from: data) else {
                self.success = false
                print("Error: Couldn't decode data into a result (RequestController)")
                return
            }
        }
        task.resume()
        return self.success
    }
}
