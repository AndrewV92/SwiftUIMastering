//
//  Generics.swift
//  SwiftUIMastering
//
//  Created by Андрей Воробьев on 19.07.2022.
//

import SwiftUI

struct StringModel {
    
    let info: String?
    
    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

struct GenericModel<T> {
    
    let info: T?
    
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject {
    
    @Published var stringModel = StringModel(info: "Hello world!")
    
    @Published var genericStringModel = GenericModel(info: "Hello, world2!")
    @Published var genericBoolModel = GenericModel(info: true)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}

struct GenericView<T: View>: View {
    
    let content: T
    
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

struct Generics: View {
    
    @StateObject private var viewModel = GenericsViewModel()
    
    var body: some View {
        VStack {
            
            GenericView(content: Text("custom content"), title: "New view!") // we can put any View in this generic view(text, button, textfield)
            //GenericView(title: "New View!")
            
            Text(viewModel.stringModel.info ?? "no data")
            Text(viewModel.genericStringModel.info ?? "no data")
            Text(viewModel.genericBoolModel.info?.description ?? "no data")
        }
        .onTapGesture {
            viewModel.removeData()
        }
    }
}

struct Generics_Previews: PreviewProvider {
    static var previews: some View {
        Generics()
    }
}
