//
//  ReleaseSelectionView.swift
//  CrossMyBook
//
//  Created by Chenjun Zhou on 11/7/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReleaseSelectionView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

  
    @ObservedObject var vc = ReleaseController()
    @State var isbn: String = ""
    @State var jump = false
    var body: some View {
        NavigationView{
            
            ScrollView {
                NavigationLink(
                    destination:ReleaseFormView(vc:vc)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true),
                    isActive: $jump){EmptyView()}
                // MARK: top bar
                HStack {
                    Button (action: {
                      self.presentationMode.wrappedValue.dismiss() // TODO: back action
                    }) {
                        FAIcon(name: "chevron-left")
                    }
                    Text("Create New Release").font(.custom("NotoSerif", size: 24)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
                }.padding(10)
                
                // MARK: input ISBN
                
                VStack(alignment: .leading) {
                    CustomText(s: "Please choose the book you want to release", size: 14).frame(maxWidth: .infinity, alignment: .center)
                    TextField("Title, Author, Series, ISBN", text: $isbn, onCommit: {
                        vc.fetchBookDetails(isbn: isbn)
                        jump = true
                    })
                    .frame(height: 48)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    
                }.padding(.leading, 18).padding(.trailing, 18)
                    
                
                
                
                
                // MARK: book lists
                VStack(alignment: .leading)  {
                    
                }.padding(18)
            }
            .background(Color.backgroundGrey)
            
        }.navigationBarHidden(true)
    }
}

struct ReleaseSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReleaseSelectionView()
    }
}
