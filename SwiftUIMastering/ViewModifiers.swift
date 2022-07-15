//
//  ViewModifiers.swift
//  SwiftUIMastering
//
//  Created by Андрей Воробьев on 15.07.2022.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
    }
}

extension View {
    func withDefaultButtonFormatting(backgroundColor: Color = .blue) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
}

struct ViewModifiers: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .modifier(DefaultButtonViewModifier(backgroundColor: .red))
            
            Text("Hello, world!")
                .withDefaultButtonFormatting(backgroundColor: .orange)
            
            Text("Hello, world!")
                .withDefaultButtonFormatting()
        }
    }
}

struct ViewModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifiers()
    }
}
