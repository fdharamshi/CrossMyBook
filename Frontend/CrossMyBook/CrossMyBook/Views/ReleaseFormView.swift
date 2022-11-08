//
//  ReleaseFormView.swift
//  CrossMyBook
//
//  Created by Chenjun Zhou on 11/7/22.
//
import SwiftUI
import SDWebImageSwiftUI

struct ReleaseFormView: View {
    @ObservedObject var bookViewModel: BookViewModel = BookViewModel()
    @State var note: String = ""
    @State var streetAddress: String = ""
    @State var zipCode: String = ""
    @State var shipping: String = ""
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
                BookCardView(bookData: self.bookViewModel.bookData)
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
                    HStack{
                        CustomText(s: "Shipping Option", size: 14).bold()
                        Spacer()
                        Picker("Shipping Option", selection: $shipping) {
                            Text("Pay by Requester")
                            Text("Pay by Owner")
                            Text("Seperate")
                        }.pickerStyle(.menu)
                    }.frame(height: 48)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    HStack{
                        CustomText(s: "Travel Distance", size: 14).bold()
                        Spacer()
                        Picker("Travel Distance", selection: $shipping) {
                            Text("Same City")
                            Text("Same Country")
                            Text("Around World")
                        }.pickerStyle(.menu)
                    }.frame(height: 48)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    HStack{
                        CustomText(s: "Book Condition", size: 14).bold()
                        Spacer()
                        Picker("Book Condition", selection: $condition) {
                            Text("Excellent")
                            Text("Good")
                            Text("Fair")
                        }.pickerStyle(.menu)
                    }.frame(height: 48)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
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
