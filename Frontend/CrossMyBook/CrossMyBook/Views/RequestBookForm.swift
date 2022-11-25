//
//  CopyDetailsView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/3/22.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI

struct RequestBookForm: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var requestController: RequestController = RequestController()
    @ObservedObject var profileController: ProfileController = ProfileController()
  
//    @State var userID: String = UserDefaults.standard.string(forKey: "user_id") ?? "1"
    @AppStorage("user_id") var userID: Int = -1
    @State var name: String = ""
    @State var location = Location()
    @State var note: String = ""
    @State var showLocationAlert: Bool = false
    @State var hasSubmitted: Bool = false
    
    let copyID: Int
    let copyDetailsController: CopyDetailsController
    
    init(_ copyID: Int, _ copyDetailsController: CopyDetailsController) {
        self.copyID = copyID
        self.copyDetailsController = copyDetailsController
        self.location.getCurrentLocation()
        profileController.fetchProfile(userID)
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                HStack {
                    Button (action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        FAIcon(name: "chevron-left")
                    }
                    Text("CrossMyBook").font(.custom("NotoSerif", size: 24)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
                }.padding(10)
                
                ScrollView {
                    NavigationLink(
                        destination: LandingView()
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true), isActive: $hasSubmitted){EmptyView()}
                    
                    HStack (alignment: .top) {
                        Spacer()
                        
                        WebImage(url: URL(string: copyDetailsController.observedCopy?.coverURL ?? "")).resizable().scaledToFit().frame(height: 180).cornerRadius(5)
                        
                        Spacer()
                        
                        VStack {
                            VStack (alignment: .leading, spacing: 5) {
                                Text(copyDetailsController.observedCopy?.title ?? "Loading...")
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.custom("NotoSerif", size: 20))
                                    .bold()
                                
                              Text(copyDetailsController.observedCopy?.author ?? "Loading...")
                                    .font(.custom("NotoSerif", size: 15)).bold()
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                HStack (spacing: 1){
                                    ForEach (0..<5) {_ in
                                        Image(systemName: "star.fill")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color.yellow)
                                    }
                                }
                              
                                Spacer()
                              
                                Text(copyDetailsController.observedCopy?.listing?.bookCondition ?? "Loading...")
                                    .font(.custom("NotoSerif", size: 15))
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                              
                                Text("Shipping expense \(copyDetailsController.observedCopy?.listing?.shippingExpense ?? "Loading...")")
                                    .font(.custom("NotoSerif", size: 15))
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                Text("Willing to ship in \(copyDetailsController.observedCopy?.listing?.willingness ?? "Loading...")")
                                    .font(.custom("NotoSerif", size: 15))
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                            }
                        }
                        Spacer()
                    }
                    VStack {
                      
                      HStack {
                        
                        WebImage(url: URL(string: profileController.profile?.profileUrl ?? ""))
                          .resizable()
                          .scaledToFit()
                          .frame(width: 70, height: 70, alignment: .center)
                          .cornerRadius(35)
                          .padding([.top, .bottom], 8.0)
                        
                        Text("\(profileController.profile?.firstName ?? "") \(profileController.profile?.lastName ?? "")")
                            .font(.custom("NotoSerif", size: 20)).bold()
                            .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
                        
                      }.padding(.bottom)
                      
                      VStack {
                        Text("Lat: \(self.location.latitude) Lon: \(self.location.longitude)")
                          .padding(.bottom, 1.0)
                          .font(.custom("NotoSerif", size: 15))
                        
                        Button("Update Current Location", action: {
                          self.location.getCurrentLocation()
                          self.showLocationAlert = true
                        })
                          .font(.custom("NotoSerif", size: 12))
                        
                      }.padding(.bottom)
                      
                      RoundedTextField(text: $note, placeholder: "leave a note", height: 200)
                        
                    }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                }.alert(isPresented: $showLocationAlert) {
                  Alert(title: Text("Location"), message: Text("Your location is at:\n(\(self.location.latitude), \(self.location.longitude))"))
                }
                Button(action: {
                    requestController.requestModel.userID = userID
                    requestController.requestModel.copyID = copyID
                    requestController.requestModel.listingID = copyDetailsController.observedCopy?.listing?.listingID ?? 0
                    requestController.requestModel.lat = location.latitude
                    requestController.requestModel.lon = location.longitude
                    requestController.requestModel.note = note
                    self.hasSubmitted = requestController.createRequest()
                }) {
                    Text("Submit Request").font(.custom("NotoSerif", size: 15).bold())
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255)))
                        .foregroundColor(Color.white)
                }
                .padding(.horizontal)
            }.background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
            .onAppear(perform: {
              copyDetailsController.fetchCopyDetails(copyID, userID)
            })
        }
    }
}
