//
//  ReleaseSelectionView.swift
//  CrossMyBook
//
//  Created by Chenjun Zhou on 11/7/22.
//

import SwiftUI
import SDWebImageSwiftUI
import CodeScanner

struct ReleaseSelectionView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    @ObservedObject var vc = ReleaseController()
    @State var isbn: String = ""
    @State var jump = false
    
    @State var scanningBarcode = true
    @State private var resultAlert = false
    @State private var res = false
    @State private var alertMsg = "Sorry, we can't find the book.\n Please use another isbn to try again."
    
    var body: some View {
        NavigationView{
            VStack{
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
                    NavigationLink(
                        destination:ReleaseFormView(vc:vc)
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true),
                        isActive: $jump){EmptyView()}
                    CustomText(s: "Please choose the book you want to release", size: 14).frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                    CustomText(s: "Scan Barcode", size: 14).frame(maxWidth: .infinity, alignment: .center)
                    CodeScannerView(
                        codeTypes: [.ean13]
                    ) { response in
                        if case let .success(result) = response {
                            if(scanningBarcode) {
                                isbn = result.string
                                scanningBarcode = false
                                let result = vc.fetchBookDetails(isbn: isbn)
                                if (result){
                                    jump = true
                                }else{
                                    resultAlert = true
                                }
                                
                            }
                        }
                    }.frame(height: 200)
                    Spacer()
                    CustomText(s: "Or enter the ISBN manually", size: 14).frame(maxWidth: .infinity, alignment: .center)
                    TextField("ISBN", text: $isbn, onCommit: {
                        let result = vc.fetchBookDetails(isbn: isbn)
                        if (result){
                            jump = true
                        }else{
                            resultAlert = true
                        }
                    }).multilineTextAlignment(.center)
                        .frame(height: 48)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    Spacer()
                }.padding(.leading, 18).padding(.trailing, 18)
                
                
            }.background(Color.backgroundGrey)
                .alert(isPresented: $resultAlert) {
                    Alert(
                        title: Text(alertMsg),
                        dismissButton: .default(Text("Got it")) {
                            isbn = ""
                        }
                    )
                }
        }.navigationBarHidden(true)
            .onAppear(perform: {
                isbn = ""
                scanningBarcode = true
                jump = false
            })
        
    }
}

struct ReleaseSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReleaseSelectionView()
    }
}
