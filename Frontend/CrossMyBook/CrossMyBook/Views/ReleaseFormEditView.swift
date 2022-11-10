//
//  ReleaseFormView.swift
//  CrossMyBook
//
//  Created by Chenjun Zhou on 11/7/22.
//
import SwiftUI
import SDWebImageSwiftUI
import Combine

struct ReleaseFormEditView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var releaseEditController: ReleaseEditController = ReleaseEditController()
    @State var jump = false
//    @State private var showingAlert = false
    let copyID: Int
    let existing: Bool
    
    init(_ copyID: Int, _ existing: Bool) {
        self.copyID = copyID
        self.existing = existing
    }
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    Button (action: {
                        self.presentationMode.wrappedValue.dismiss() //
                    }) {
                        FAIcon(name: "chevron-left")
                    }
                    Text("Create New Release").font(.custom("NotoSerif", size: 24)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
                }.padding(10)
                
                ScrollView {
                    NavigationLink(
                        destination:CopyDetailsView(copyID)
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true),
                        isActive: $jump){EmptyView()}
                    
                    ReleaseCardView(book: releaseEditController.book)
                    
                    VStack {
                        TextField("Leave a note", text: $releaseEditController.release.note, axis: .vertical)
                            .lineLimit(10...)
                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 15, trailing: 20))
                            .multilineTextAlignment(.leading)
                            .background(RoundedRectangle(cornerRadius:10).fill(Color.white))
                        
//                        Button(action: {
//                            self.vc.loc.getCurrentLocation()
//                            self.showingAlert = true
//                        }) {
//                            Text("Get my location")
//                        }.frame(height: 48)
//                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
//                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))

                        HStack{
                            CustomText(s: "Shipping Option", size: 14).bold()
                            Spacer()
                            Picker("Shipping Option", selection: $releaseEditController.release.shipping) {
                                Text("Pay by Requester").tag("Pay by the Requester")
                                Text("Pay by Sender").tag("Pay by the Sender")
                                Text("Split by Both Parties").tag("Split by Both Parties")
                            }.pickerStyle(.menu)
                        }.frame(height: 48)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        HStack{
                            CustomText(s: "Travel Distance", size: 14).bold()
                            Spacer()
                            Picker("Travel Distance", selection: $releaseEditController.release.distance) {
                                Text("Same City").tag("Same City")
                                Text("Same State").tag("Same State")
                                Text("Same Country").tag("Same Country")
                                Text("Worldwide").tag("Worldwide")
                            }.pickerStyle(.menu)
                        }.frame(height: 48)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        HStack{
                            CustomText(s: "Book Condition", size: 14).bold()
                            Spacer()
                            Picker("Book Condition", selection: $releaseEditController.release.condition) {
                                Text("Excellent").tag("Excellent")
                                Text("Good").tag("Good")
                                Text("Fair").tag("Fair")
                            }.pickerStyle(.menu)
                        }.frame(height: 48)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                }
//                .alert(isPresented: $showingAlert) {
//                    Alert(title: Text("Location"), message: Text(releaseEditController.generateTitle()))
//                }
                
                
                
                Button(action: {
                    jump = releaseEditController.updateRelease()
                }) {
                    Text("Release Book").font(.custom("NotoSerif", size: 15))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255)))
                        .foregroundColor(Color.white)
                }
                .padding(.horizontal)
            }.background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
            
        }.onAppear(perform: {
            releaseEditController.fetchData(copyId: copyID, existing: self.existing)
          })
        
    }
    
}

//struct ReleaseFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReleaseFormView()
//    }
//}
