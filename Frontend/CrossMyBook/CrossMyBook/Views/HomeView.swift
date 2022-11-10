//
//  HomeView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/8/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
  
  @ObservedObject var temporaryMainController: TemporaryMainController = TemporaryMainController()
  
  init() {
    temporaryMainController.fetchDetails()
  }
  
  var body: some View {
    VStack (alignment: .leading) {
      Text("All Copys:")
        .font(Font.custom("NotoSerif", size: 15))
        .bold()
        .foregroundColor(Color("FontBlack"))
        .multilineTextAlignment(.leading)
        .padding(.leading, 20)
        .padding(.top, 20.0)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 10) {
          ForEach(temporaryMainController.observedCopy?.allCopies ?? []) { copy in
            NavigationLink(destination: CopyDetailsView(copy.copyID ?? 1).navigationBarHidden(true)) {
              VStack {
                WebImage(url: URL(string: copy.coverURL))
                  .resizable()
                  .placeholder(Image(uiImage: UIImage(named: "bookplaceholder")!)) // Placeholder Image
                  .scaledToFit()
                  .frame(width: 100, height: 150, alignment: .center)
                  .border(Color.black, width: 1)
                  .background(Color.brown).padding(.leading, 20)
                Text(copy.title).frame(width:100).padding(.leading, 20).foregroundColor(Color.black)
              }
            }
          }
          
        }
      }
      Text("All Books:")
        .font(Font.custom("NotoSerif", size: 15))
        .bold()
        .foregroundColor(Color("FontBlack"))
        .multilineTextAlignment(.leading)
        .padding(.leading, 20)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 10) {
          ForEach(temporaryMainController.observedCopy?.allBooks ?? []) { listing in
            
              VStack {
                WebImage(url: URL(string: listing.coverURL))
                  .resizable()
                  .placeholder(Image(uiImage: UIImage(named: "bookplaceholder")!)) // Placeholder Image
                  .scaledToFit()
                  .frame(width: 100, height: 150, alignment: .center)
                  .border(Color.black, width: 1)
                  .background(Color.brown).padding(.leading, 20)
                Text(listing.title).frame(width:100).padding(.leading, 20).foregroundColor(Color.black)
              }
            
          }
          
        }
      }
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
    
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
