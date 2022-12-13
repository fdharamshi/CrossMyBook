//
//  SearchPageView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 12/4/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchPageView: View {
  
  @State var searchString: String = ""
  var receivedSearchString: String
  @State var index: Int = 0
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @ObservedObject var searchController: SearchController = SearchController()
  
  func toggleIndex() {
    if(index == 0) {
      index = 1
    } else {
      index = 0
    }
  }
  
  init(searchString: String, receivedSearchString: String) {
    self.receivedSearchString = receivedSearchString
    self.searchString = receivedSearchString
    
    searchController.fetchSearcheditems(receivedSearchString)
  }
  
    var body: some View {
      VStack {
        ZStack (alignment: .leading) {
          Text("Search")
            .font(.custom("NotoSerif", size: 25)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
          Button (action: {
            self.presentationMode.wrappedValue.dismiss() // TODO: back action
          }) {
            FAIcon(name: "chevron-left")
          }
        }.background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
        HStack (alignment: .center) {
          RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .overlay(
              TextField("Search Book Title", text: $searchString)
                .font(Font.custom("NotoSerif", size: 15))
                .padding(.leading, 10.0)
                .autocorrectionDisabled(true)
                .onSubmit {
                  searchController.fetchSearcheditems(searchString)
                }
                .onAppear(perform: {
                  searchString = receivedSearchString
                })
            )
            .frame(height: 38)
          Button(action: {
            searchController.fetchSearcheditems(searchString)
          }) {
            FAIcon(name: "search", size: 20)
          }
        }
        HStack {
          
          if(index == 0)
          {
            Text("Books")
              .frame(maxWidth: .infinity)
              .padding(10.0)
              .font(.custom("NotoSerif", size: 16))
              .background(Color("Theme"))
              .foregroundColor(Color.white)
              .cornerRadius(12.0)
          } else {
            Text("Books")
              .frame(maxWidth: .infinity)
              .font(.custom("NotoSerif", size: 16))
              .padding(10.0)
              .cornerRadius(12.0)
              .onTapGesture(perform: toggleIndex)
          }
          
          if(index == 1)
          {
            Text("Book Copies")
              .frame(maxWidth: .infinity)
              .font(.custom("NotoSerif", size: 16))
              .padding(10.0)
              .background(Color("Theme"))
              .foregroundColor(Color.white)
              .cornerRadius(12.0)
          } else {
            Text("Book Copies")
              .frame(maxWidth: .infinity)
              .font(.custom("NotoSerif", size: 16))
              .padding(10.0)
              .cornerRadius(12.0)
              .onTapGesture(perform: toggleIndex)
          }
        }.background(Color.white).cornerRadius(12.0).padding(.vertical, 10.0)
        
        ScrollView {
          VStack (alignment: .center) {
            
            if(index == 0) {
              if(searchController.searchModel?.books.count == 0) {
                Text("No results for \"\(receivedSearchString)\"").font(.custom("NotoSerif", size: 16))
              } else {
                ForEach(searchController.searchModel?.books ?? []) { searchBook in
                    NavigationLink(destination: BookDetailView(bookId: String(searchBook.id)).navigationBarHidden(true)) {
                        HStack (alignment: .top) {
                            WebImage(url: URL(string: searchBook.coverURL))
                              .resizable()
                              .placeholder(Image(uiImage: UIImage(named: "bookplaceholder")!)) // Placeholder Image
                              .scaledToFit()
                              .frame(width: 100, height: 150, alignment: .center).cornerRadius(5)
                              .shadow(color: .gray, radius: 3, x: 0, y: 3)
                              .padding(.bottom, 3)
                          VStack (alignment: .leading){
                            Text(searchBook.title)
                              .frame(width: .infinity)
                              .multilineTextAlignment(.leading)
                              .font(.custom("NotoSerif", size: 16)).foregroundColor(Color.black)
                              .bold()
                              .lineLimit(1)
                            Text(searchBook.author)
                              .frame(width: .infinity)
                              .multilineTextAlignment(.leading)
                              .font(.custom("NotoSerif", size: 16)).foregroundColor(Color.black)
                              .lineLimit(1)
                            // TODO: Implement Rating
                          }
                          Spacer()
                        }
                    }
                  
                 
                }
              }
            } else {
              if(searchController.searchModel?.availableCopies.count == 0) {
                Text("No results for \"\(receivedSearchString)\"").font(.custom("NotoSerif", size: 16))
              } else {
                ForEach(searchController.searchModel!.availableCopies) { copy in
                    NavigationLink(destination: CopyDetailsView(copy.copyID).navigationBarHidden(true)) {
                        HStack (alignment: .top) {
                          WebImage(url: URL(string: copy.coverURL))
                            .resizable()
                            .placeholder(Image(uiImage: UIImage(named: "bookplaceholder")!)) // Placeholder Image
                            .scaledToFit()
                            .frame(width: 100, height: 150, alignment: .center).cornerRadius(5)
                            .shadow(color: .gray, radius: 3, x: 0, y: 3)
                            .padding(.bottom, 3)
                          VStack (alignment: .leading) {
                            Text(copy.title)
                              .frame(width: .infinity)
                              .multilineTextAlignment(.leading)
                              .font(.custom("NotoSerif", size: 16)).foregroundColor(Color.black)
                              .bold()
                              .lineLimit(1)
                            Text(copy.author)
                              .frame(width: .infinity)
                              .multilineTextAlignment(.leading)
                              .font(.custom("NotoSerif", size: 16)).foregroundColor(Color.black)
                              .lineLimit(1)
                            Text("Current Owner:")
                              .frame(width: .infinity)
                              .multilineTextAlignment(.leading)
                              .font(.custom("NotoSerif", size: 16)).foregroundColor(Color.black)
                              .bold()
                              .lineLimit(1)
                            Text(copy.copyOwner)
                              .frame(width: .infinity)
                              .multilineTextAlignment(.leading)
                              .font(.custom("NotoSerif", size: 16)).foregroundColor(Color.black)
                              .lineLimit(1)
                            WebImage(url: URL(string: copy.ownerProfile))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50, alignment: .center)
                                .cornerRadius(25)
                          }
                          Spacer()
                        }.padding(.bottom, 10.0)
                    }
                }
              }
            }
            
          }
        }
        
      }.padding(10.0).navigationBarHidden(true).background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
      SearchPageView(searchString: "Ver", receivedSearchString: "Ver")
    }
}
