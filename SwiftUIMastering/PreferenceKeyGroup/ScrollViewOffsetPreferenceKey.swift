//
//  ScrollViewOffsetPreferenceKey.swift
//  SwiftUIMastering
//
//  Created by Андрей Воробьев on 19.07.2022.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ScrollViewOffsetPreferenceKeyView: View {
    
    let title: String = "New title here"
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
                titleLayer
                    .opacity(Double(scrollViewOffset / 63.0))
                    .onScrollViewOffsetChanged { offset in
                        self.scrollViewOffset = offset
                    }
             //       .background(
             //           GeometryReader { geo in
             //           Text("")
             //                   .preference(key: ScrollViewOffsetPreferenceKey.self, value: //geo.frame(in: .global).minY)
             //           }
             //       )
                contentLayer
            }
            .padding()
        }
        .overlay(Text("\(scrollViewOffset)"))
  //      .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
  //          scrollViewOffset = value
  //      }
        .overlay(navBarLayer.opacity(scrollViewOffset < 40 ? 1.0 : 0.0), alignment: .top)
    }
}

struct ScrollViewOffsetPreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffsetPreferenceKeyView()
    }
}

extension ScrollViewOffsetPreferenceKeyView {
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var contentLayer: some View {
        ForEach(0..<30) { _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }
    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue)
    }
}

extension View {
    func onScrollViewOffsetChanged(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self.background(
            GeometryReader { geo in
            Text("")
                    .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
            }
        )
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            action(value)
        }
    }
}
