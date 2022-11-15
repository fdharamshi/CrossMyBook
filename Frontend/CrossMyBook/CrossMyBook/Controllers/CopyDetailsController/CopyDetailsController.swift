//
//  CopyDetailsController.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/7/22.
//

import Foundation
import MapKit

class CopyDetailsController: ObservableObject {
  
  @Published var observedCopy: CopyDetailsModel?
  @Published var state: ControllerState = .Idle
  @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 49.9, longitude: -79.29), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
  
  init() {
    self.observedCopy = nil
  }
  
  func fetchCopyDetails(_ copyID: Int, _ userID: Int) {
    self.state = .Busy
    fetchData(copyID, userID, completion: { copyDetailsModel in
      self.observedCopy = copyDetailsModel
      self.mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: copyDetailsModel.travelHistory.last?.lat ?? 49.9, longitude: copyDetailsModel.travelHistory.last?.lon ?? -79.29), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
      self.state = .Idle
    })
  }
  
  private func fetchData(_ copyID: Int, _ userID: Int, completion: @escaping (CopyDetailsModel) -> ()) {
    let url: String = "http://ec2-3-87-92-147.compute-1.amazonaws.com:8000/getCopyDetails?copy_id=\(copyID)&user_id=\(userID)"
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
      guard let data = data else {
        print("Error: No data to decode")
        return
      }
      
      // Decode the JSON here
      guard let copyDetails = try? JSONDecoder().decode(CopyDetailsModel.self, from: data) else {
        print("Error: Couldn't decode data into a result(CopyDetailsController) id: \(copyID)")
        return
      }
      
      completion(copyDetails)
    }
    task.resume()
  }
  
}
