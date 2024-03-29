//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Mac on 24/02/2023.
//

import SwiftUI

@main
struct TodoAppApp: App {
    
    @StateObject var listViewModel : ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
//            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
        }
    }
}
