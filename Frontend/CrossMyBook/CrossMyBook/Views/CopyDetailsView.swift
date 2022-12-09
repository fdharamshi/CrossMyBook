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
    
    //  @State var userID: String = UserDefaults.standard.string(forKey: "user_id") ?? "1"
    
    @AppStorage("user_id") var userID: Int = -1
    
    @State var isRequest: Bool = false
    @State var isEditListing: Bool = false
    @State var releaseCurrent:Bool = false
    
    let copyID: Int
    
    init(_ id: Int) {
        self.copyID = id
        copyDetailsController.fetchCopyDetails(copyID, userID)
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
                        destination:RequestBookForm(copyID, copyDetailsController)
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true), isActive: $isRequest){EmptyView()}
                    
                    NavigationLink(
                        destination:ReleaseFormEditView(copyID, true)
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true), isActive: $isEditListing){EmptyView()}
                    
                    NavigationLink(
                        destination:ReleaseFormEditView(copyID, false)
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true), isActive: $releaseCurrent){EmptyView()}
                    // MARK: MAP
                    
                    ZStack (alignment: .bottomLeading) {
                        if(copyDetailsController.state == .Idle) {
                            MapView(mapRegion: copyDetailsController.mapRegion, travelPoints: copyDetailsController.observedCopy?.travelHistory ?? []).frame(height: 450)
                        }
                        
                        
                        
                        // MARK: Book Cover
                        NavigationLink(destination: BookDetailView(bookId: String(copyDetailsController.observedCopy?.bookID ?? 3) ).navigationBarHidden(true)) {
                            WebImage(url: URL(string: copyDetailsController.observedCopy?.coverURL ?? ""))
                                .resizable()
                                .placeholder(Image(uiImage: UIImage(named: "bookplaceholder")!)) // Placeholder Image
                                .scaledToFit().cornerRadius(5)
                                .frame(width: 100, height: 150, alignment: .center)
                                .shadow(color: .gray, radius: 3, x: 0, y: 3)
                                .offset(x: 30, y: 75)
                        }
                        
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
                                .fixedSize(horizontal: false, vertical: true).padding(.bottom, 0.5)
                            
                            HStack (spacing: 1){
                                ForEach (0..<5) {_ in
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.yellow)
                                }
                            }
                            
                        }.frame(maxWidth: UIScreen.main.bounds.size.width - 160, alignment: .leading)
                            .offset(x: 150, y:0)
                    }.frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 20)
                    
                    // MARK: Travel History
                    VStack {
                        Text("Travel History")
                            .font(.custom("NotoSerif", size: 18))
                            .bold()
                            .multilineTextAlignment(.leading)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 18)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            
                            ForEach(copyDetailsController.observedCopy?.travelHistory.reversed() ?? []) { travelPoint in
                              VStack (alignment: .center) {
                                WebImage(url: URL(string: travelPoint.userPicture))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 70, alignment: .center)
                                    .cornerRadius(35)
                                Text(travelPoint.user).font(.custom("NotoSerif", size: 12))
                              }
                                
                                if(travelPoint != copyDetailsController.observedCopy?.travelHistory.first) {
                                    WebImage(url: URL(string: "https://cdn-icons-png.flaticon.com/512/3183/3183354.png"))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30, alignment: .center)
                                }
                            }
                        }
                    }.padding(.leading, 20)
                    
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
                        ).background(Color.white).padding()
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
                        print("release current")
                        self.releaseCurrent = true
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
            copyDetailsController.fetchCopyDetails(copyID, userID)
        })
    }
}

struct CopyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CopyDetailsView(2)
    }
}
