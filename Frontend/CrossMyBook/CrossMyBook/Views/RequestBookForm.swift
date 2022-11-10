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
    
    @ObservedObject var copyDetailsController: CopyDetailsController = CopyDetailsController()
    @ObservedObject var requestController: RequestController = RequestController()
    
    @State var location = Location()
    @State var note: String = ""
    
    @State var hasSubmitted: Bool = false
    
    let copyID: Int
    
    init(_ copyID: Int) {
        self.copyID = copyID
        self.location.getCurrentLocation()
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
                                
                            }
                        }
                        Spacer()
                    }
                    VStack {
                        
                        
                        RoundedTextField(text: .constant("Femin Dharamshi"), placeholder: "name", height: 48)
                        
                        Button("Fetch Current Location", action: {self.location.getCurrentLocation()})
                        Text("Lat:\(self.location.latitude) Lon:\(self.location.longitude)")
                        
                        RoundedTextField(text: $note, placeholder: "leave a note", height: 250)
                        
                    }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                }
                Button(action: {
                    // Hardcode userID to be 2 for now
                    requestController.requestModel.userID = 2
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
        }.onAppear(perform: {
            copyDetailsController.fetchCopyDetails(copyID)
        })
    }
}
