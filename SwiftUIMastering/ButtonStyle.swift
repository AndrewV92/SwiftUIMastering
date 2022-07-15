//
//  ButtonStyle.swift
//  SwiftUIMastering
//
//  Created by Андрей Воробьев on 16.07.2022.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    
    let scaledAmount: CGFloat
    
    init(scaledAmount: CGFloat) {
        self.scaledAmount = scaledAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            //.brightness(configuration.isPressed ? 0.05 : 0)
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
    }
}

extension View {
    func withPressableStyle(scaledAmount: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount))  //self.buttonStyle, self is implied
    }
}

struct MyButtonStyle: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Click Me")
                .font(.headline)
                .withDefaultButtonFormatting() //from ViewModiffiers
        }
        .withPressableStyle(scaledAmount: 0.9)  //with extention
        //.buttonStyle(PressableButtonStyle())  without extention
        .padding(40)

    }
}

struct ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        MyButtonStyle()
    }
}
