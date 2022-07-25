//
//  AppNavBarView.swift
//  SwiftUIMastering
//
//  Created by Андрей Воробьев on 25.07.2022.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color.orange.ignoresSafeArea()
                
                CustomNavLink(destination:
                                Text("Destination")
                                    .customNavigationTitle("Second Screen")
                                    .customNavigationSubTitle("Subtitle second screen")
                ) {
                    Text("Navigate")
                }
            }
//            .customNavigationTitle("Custom Title")
//            .customNavigationBarBackButtonHidden(true)
            .customNavBarItems(title: "New Title", subtitle: "Subtitle", backButtonHidden: true)
        }
    }
}

struct AppNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavBarView()
    }
}


extension AppNavBarView {
    
    private var defaultNavView: some View {
        NavigationView {
            ZStack {
                Color.green.ignoresSafeArea()
                
                NavigationLink {
                    Text("Destination")
                        .navigationTitle("Title 2")
                        .navigationBarBackButtonHidden(false)
                } label: {
                    Text("Navigate")
                }
            }.navigationTitle("Nav title here")
        }
    }
}
