//
//  CustomBarContainerView.swift
//  SwiftUIMastering
//
//  Created by Андрей Воробьев on 20.07.2022.
//

import SwiftUI

struct CustomBarContainerView<Content:View>: View {
    
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .ignoresSafeArea()
            CustomTabBarView(tabs: tabs, selection: $selection, localSelection: selection)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

struct CustomBarContainerView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [.home, .favorites, .profile]
    
    static var previews: some View {
        CustomBarContainerView(selection: .constant(tabs.first!)) {
            Color.red
        }
    }
}
