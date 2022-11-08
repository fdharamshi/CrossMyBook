//
//  ReleaseFormView.swift
//  CrossMyBook
//
//  Created by Chenjun Zhou on 11/7/22.
//
import SwiftUI
import SDWebImageSwiftUI
import Combine

struct ReleaseFormView: View {
    @ObservedObject var vc: ReleaseController
    @ObservedObject var bookViewModel: BookViewModel = BookViewModel()
    @State var zip: String = ""
    @State private var showingAlert = false
    var body: some View {
        
        VStack {
            HStack {
                Button (action: {
                    print("Back") // TODO: back action
                }) {
                    FAIcon(name: "chevron-left")
                }
                Text("Create New Release").font(.custom("NotoSerif", size: 24)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
            }.padding(10)
            
            ScrollView {
                ReleaseCardView(book: vc.book)
                VStack {
                    TextField("Leave a note", text: $vc.release.note, axis: .vertical)
                        .lineLimit(10...)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 15, trailing: 20))
                        .multilineTextAlignment(.leading)
                        .background(RoundedRectangle(cornerRadius:10).fill(Color.white))
                    
                    Button(action: {
                        self.vc.loc.getCurrentLocation()
                        self.showingAlert = true
                    }) {
                        Text("Get my location")
                    }
                    TextField("Street Address", text: $vc.release.distance)
                        .frame(height: 48)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    
                    TextField("Zip Code", text: $zip)
                        .frame(height: 48)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        .keyboardType(.numberPad)
                        .onReceive(Just(zip)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                zip = ""
                            }else{
                                vc.inputZipCode(zip:zip)
                            }
                        }
                    HStack{
                        CustomText(s: "Shipping Option", size: 14).bold()
                        Spacer()
                        Picker("Shipping Option", selection: $vc.release.shipping) {
                            Text("Pay by Requester")
                            Text("Pay by Sender")
                            Text("Split by Both Parties")
                        }.pickerStyle(.menu)
                    }.frame(height: 48)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    HStack{
                        CustomText(s: "Travel Distance", size: 14).bold()
                        Spacer()
                        Picker("Travel Distance", selection: $vc.release.distance) {
                            Text("Same City")
                            Text("Same State")
                            Text("Same Country")
                            Text("Worldwide")
                        }.pickerStyle(.menu)
                    }.frame(height: 48)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    HStack{
                        CustomText(s: "Book Condition", size: 14).bold()
                        Spacer()
                        Picker("Book Condition", selection: $vc.release.condition) {
                            Text("Excellent")
                            Text("Good")
                            Text("Fair")
                        }.pickerStyle(.menu)
                    }.frame(height: 48)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("Location"), message: Text(vc.generateTitle()))
            }
            Button(action: {
                vc.createRelease()
            }) {
                Text("Release Book").font(.custom("NotoSerif", size: 15))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255)))
                    .foregroundColor(Color.white)
            }
            .padding(.horizontal)
        }.background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
        
    }
    
}

//struct ReleaseFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReleaseFormView()
//    }
//}
