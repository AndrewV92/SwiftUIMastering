//
//  ViewBuilder.swift
//  SwiftUIMastering
//
//  Created by Андрей Воробьев on 19.07.2022.
//

import SwiftUI

struct HeaderViewRegular: View {
    
    let title: String
    let description: String?
    let iconName: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
            .fontWeight(.semibold)
            if let description = description {
                Text(description)
                    .font(.callout)
            }
            if let iconName = iconName {
                Image(systemName: iconName)
            }
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderViewGeneric<T: View>: View {
    
    let title: String
    let content: T
    
    init(title: String, @ViewBuilder content: () -> T) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
            .fontWeight(.semibold)
            
            content
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct CustomHStack<T: View>: View {
    let content: T
    init(@ViewBuilder content: () -> T) {
        self.content = content()
    }
    var body: some View {
        HStack {
            content
        }
    }
}

struct ViewBuilderView: View {
    var body: some View {
        VStack {
            
            HeaderViewRegular(title: "New Title", description: "Hello", iconName: nil)
            
                        
            HeaderViewRegular(title: "Title with Icon", description: "Icon", iconName: "house")
            
//          HeaderViewGeneric(title: "Generic Title", content: Image(systemName: "heart"))
        
//          HeaderViewGeneric(title: "Generic Title2", content: HStack {
//             Text("Hello")
//             Image(systemName: "bolt.fill")
//         })  //before making content @ViewBuider
            
            HeaderViewGeneric(title: "Closure Title") {
                HStack {
                    Text("Hi")
                    Image(systemName: "bolt.fill")
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 20, height: 20)
                }
            }
            
      //      CustomHStack(content: <#T##() -> _#>)
            
            Spacer()
        }
    }
}

struct ViewBuilder_Previews: PreviewProvider {
    static var previews: some View {
        ViewBuilderView()
        LocalViewBuilder(type: .three)
    }
}


struct LocalViewBuilder: View {
    
    enum ViewType {
        case one, two, three
    }
    
    let type: ViewType
    
    var body: some View {
        headerSection
    }
    
    @ViewBuilder private var headerSection: some View {  //We can put switch in VStack/HStack, they are viewbuilders too, or just mark some View with @ViewBuilder att
        switch type {
        case .one:
            viewOne
        case .two:
            viewTwo
        case .three:
            viewThree
        }
    }
    
    private var viewOne: some View {
        Text("One!")
    }
    private var viewTwo: some View {
        VStack {
            Text("Two")
            Image(systemName: "heart.fill")
        }
    }
    private var viewThree: some View {
        Image(systemName: "heart.fill")
    }
}
