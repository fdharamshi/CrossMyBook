//
//  ReleaseFormView.swift
//  CrossMyBook
//
//  Created by Chenjun Zhou on 11/7/22.
//

import SwiftUI
import SDWebImageSwiftUI

enum Shipping: String, CaseIterable, Identifiable {
    case PayByMe, Seperate, PayByRequester
    var id: Self { self }
}

struct ReleaseFormView: View {
    @State var note: String = ""
    @State var streetAddress: String = ""
    @State var zipCode: String = ""
    @State var shipping: Shipping = .PayByMe
    @State var distance: String = ""
    @State var condition: String = ""
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
                BookCardView(bookData: Book(bookId: 1, coverURL: "https://covers.openlibrary.org/b/id/10447672-L.jpg", title: "Remarkably Bright Creatures", author: "Caifei Hong", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas placerat non elit ac vulputate. Nullam a libero lectus. Quisque eu fringilla lectus. ", rating: 4))
                
                VStack {
                    TextField("Leave a note", text: $note, axis: .vertical)
                        .lineLimit(10...)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 15, trailing: 20))
                        .multilineTextAlignment(.leading)
                        .background(RoundedRectangle(cornerRadius:10).fill(Color.white))
                    TextField("Street Address", text: $streetAddress)
                        .frame(height: 48)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    
                    TextField("Zip Code", text: $zipCode)
                        .frame(height: 48)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    
                    Picker("Shipping Option", selection: $shipping) {
                        Text("Chocolate").tag(Shipping.PayByMe)
                        Text("Vanilla").tag(Shipping.PayByRequester)
                        Text("Strawberry").tag(Shipping.Seperate)
                    }.pickerStyle(.menu)
                    .padding(.top, 20)
           
                    
                }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
            }
            Button(action: {
                print("Release Book")
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

struct ReleaseFormView_Previews: PreviewProvider {
    static var previews: some View {
        ReleaseFormView()
    }
}
