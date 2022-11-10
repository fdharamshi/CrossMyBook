//
//  CopyDetailsView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/3/22.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI

struct CopyDetailsView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @ObservedObject var copyDetailsController: CopyDetailsController = CopyDetailsController()
  @State var userID: String = UserDefaults.standard.string(forKey: "user_id") ?? "1"
  
  @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 49.9, longitude: -79.29), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
  
  @State var isRequest: Bool = false
  @State var isEditListing: Bool = false
  
  let copyID: Int
  
  init(_ id: Int) {
    self.copyID = id
//    copyDetailsController.fetchCopyDetails(id)
  }
  
  func getButtonText(_ status: Int) -> String {
    switch(status) {
    case 0: return "Request Book"
    case 1: return "Book Unavailable"
    case 2: return "Edit Listing"
    case 3: return "Release Book"
    default: return "Book Unavailable"
    }
  }
  
  func getButtonStatus(_ status: Int) -> Bool {
    switch(status) {
    case 0: return false
    case 1: return true
    case 2: return false
    case 3: return false
    default: return true
    }
  }
  
  var body: some View {
    NavigationView {
            VStack {
              
              // MARK: Top Bar
              
              ZStack (alignment: .bottomLeading) {
                Text("Cross My Book")
                  .font(.custom("NotoSerif", size: 25)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
                Button (action: {
                  self.presentationMode.wrappedValue.dismiss() // TODO: back action
                }) {
                  FAIcon(name: "chevron-left")
                }
              }.padding(10)
              ScrollView {
                
                NavigationLink(
                    destination:RequestBookForm(copyID)
                      .navigationBarBackButtonHidden(true)
                      .navigationBarHidden(true), isActive: $isRequest){EmptyView()}
                
                NavigationLink(
                    destination:ReleaseFormEditView(copyID, true)
                      .navigationBarBackButtonHidden(true)
                      .navigationBarHidden(true), isActive: $isEditListing){EmptyView()}
                
                // MARK: MAP
                
                ZStack (alignment: .bottomLeading) {
                  Map(coordinateRegion: $mapRegion, annotationItems: copyDetailsController.observedCopy?.travelHistory ?? []) { tH in
                    MapMarker(coordinate: CLLocationCoordinate2D(
                      latitude: tH.lat,
                      longitude: tH.lon
                    ))
                  }
                  .frame(height: 450)
                  
                  
                  // MARK: Book Cover
                  WebImage(url: URL(string: copyDetailsController.observedCopy?.coverURL ?? ""))
                    .resizable()
                    .placeholder(Image(uiImage: UIImage(named: "bookplaceholder")!)) // Placeholder Image
                    .scaledToFit()
                    .frame(width: 100, height: 150, alignment: .center)
                    .border(Color.black, width: 1)
                    .background(Color.brown)
                    .onTapGesture(perform: {
                      // TODO: Jump To Book Details Page
                      print("Book Details")
                    })
                    .offset(x: 30, y: 75)
                }.onReceive(copyDetailsController.$observedCopy) { observedCopy in
                  
                  // TODO: Update center of the map to the last location
                  
                  mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: observedCopy?.travelHistory.last?.lat ?? 51.5, longitude: observedCopy?.travelHistory.last?.lon ?? -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                }
                
                VStack {
                  
                  // MARK: Book Title, Author & Rating
                  VStack (alignment: .leading) {
                    Text(copyDetailsController.observedCopy?.title ?? "Loading...")
                      .multilineTextAlignment(.leading)
                      .fixedSize(horizontal: false, vertical: true)
                      .font(.custom("NotoSerif", size: 20))
                      .bold()
                    
                    Text(copyDetailsController.observedCopy?.author ?? "Loading...")
                      .font(.custom("NotoSerif", size: 15))
                      .multilineTextAlignment(.leading)
                      .fixedSize(horizontal: false, vertical: true)
                    
                    HStack (spacing: 1){
                      ForEach (0..<5) {_ in
                        Image(systemName: "star.fill")
                          .font(.system(size: 12))
                          .foregroundColor(Color.yellow)
                      }
                    }
                    
                  }.frame(maxWidth: UIScreen.main.bounds.size.width - 160, alignment: .leading)
                    .offset(x: 150, y:0)
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                // MARK: Travel History
                VStack {
                  Text("Travel History")
                    .font(.custom("NotoSerif", size: 18))
                    .bold()
                    .multilineTextAlignment(.leading)
                }.frame(maxWidth: .infinity, alignment: .leading)
                  .padding()
                
                ScrollView(.horizontal, showsIndicators: false) {
                  HStack(spacing: 10) {
                    
                    ForEach(copyDetailsController.observedCopy?.travelHistory ?? []) { travelPoint in
                      WebImage(url: URL(string: travelPoint.userPicture))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70, alignment: .center)
                        .cornerRadius(35)
                      
                      if(travelPoint != copyDetailsController.observedCopy?.travelHistory.last) {
                        WebImage(url: URL(string: "https://cdn-icons-png.flaticon.com/512/3183/3183354.png"))
                          .resizable()
                          .scaledToFit()
                          .frame(width: 30, height: 30, alignment: .center)
                      }
                    }
                  }
                }.padding(.leading)
                
                if (copyDetailsController.observedCopy?.listing != nil) {
                  
                  // ##################################################
                  // Listing Details only if there is an active listing
                  // ##################################################
                  
                  // MARK: Listing Details
                  
                  VStack (alignment: .leading) {
                    Text("Shipping Expense")
                      .font(.custom("NotoSerif", size: 15))
                      .bold()
                      .padding([.top, .leading, .trailing])
                      .frame(width: .infinity)
                      .multilineTextAlignment(.leading)
                      .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
                    Text(copyDetailsController.observedCopy?.listing?.shippingExpense ?? "Loading...")
                      .font(.custom("NotoSerif", size: 15))
                      .padding([.leading, .bottom, .trailing])
                      .frame(width: .infinity)
                      .multilineTextAlignment(.leading)
                    
                  }.frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                  ).background(Color.white).padding([.leading, .top, .trailing])
                  
                  VStack (alignment: .leading) {
                    Text("Willingness to Ship")
                      .font(.custom("NotoSerif", size: 15))
                      .bold()
                      .padding([.top, .leading, .trailing])
                      .frame(width: .infinity)
                      .multilineTextAlignment(.leading)
                      .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
                    Text(copyDetailsController.observedCopy?.listing?.willingness ?? "Loading...")
                      .font(.custom("NotoSerif", size: 15))
                      .padding([.leading, .bottom, .trailing])
                      .frame(width: .infinity)
                      .multilineTextAlignment(.leading)
                    
                  }.frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                  ).background(Color.white).padding([.leading, .top, .trailing])
                  
                  VStack (alignment: .leading) {
                    Text("Book Condition")
                      .font(.custom("NotoSerif", size: 15))
                      .bold()
                      .padding([.top, .leading, .trailing])
                      .frame(width: .infinity)
                      .multilineTextAlignment(.leading)
                      .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
                    Text(copyDetailsController.observedCopy?.listing?.bookCondition ?? "Loading...")
                      .font(.custom("NotoSerif", size: 15))
                      .padding([.leading, .bottom, .trailing])
                      .frame(width: .infinity)
                      .multilineTextAlignment(.leading)
                    
                  }.frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                  ).background(Color.white).padding([.leading, .top, .trailing])
                  
                  VStack (alignment: .leading) {
                    Text("Note from Current Owner")
                      .font(.custom("NotoSerif", size: 15))
                      .bold()
                      .padding([.top, .leading, .trailing])
                      .frame(width: .infinity)
                      .multilineTextAlignment(.leading)
                      .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
                    Text(copyDetailsController.observedCopy?.listing?.note ?? "-")
                      .font(.custom("NotoSerif", size: 15))
                      .padding([.leading, .bottom, .trailing])
                      .frame(width: .infinity)
                      .multilineTextAlignment(.leading)
                    
                  }.frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                  ).background(Color.white).padding([.leading, .top, .trailing])
                }
              }
              
              Button(action: {
                if(copyDetailsController.observedCopy?.status == 0) {
                  self.isRequest = true
                } else if (copyDetailsController.observedCopy?.status == 1) {
                  // Book Unavailable. Do nothing.
                } else if (copyDetailsController.observedCopy?.status == 2) {
                  self.isEditListing = true
                } else if (copyDetailsController.observedCopy?.status == 3) {
                  // TODO: Release Book
                }
                
              }) {
                Text(getButtonText(copyDetailsController.observedCopy?.status ?? 1)).font(.custom("NotoSerif", size: 15))
                  .padding()
                  .frame(maxWidth: .infinity)
                  .background(RoundedRectangle(cornerRadius: 8).fill(copyDetailsController.observedCopy?.status == 1 ? Color("LightBrown") : Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255)))
                  .foregroundColor(Color.white)
              }
              .padding(.horizontal).disabled(getButtonStatus(copyDetailsController.observedCopy?.status ?? 1))
            }.background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
    }.onAppear(perform: {
      copyDetailsController.fetchCopyDetails(copyID, Int(userID) ?? 1)
    })
  }
}

struct CopyDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    CopyDetailsView(2)
  }
}
