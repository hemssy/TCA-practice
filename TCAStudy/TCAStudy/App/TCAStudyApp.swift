//
//  TCAStudyApp.swift
//  TCAStudy
//
//  Created by 신서연 on 11/23/26.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCAStudyApp: App {
    var body: some Scene {
        WindowGroup {
            CounterView(
                store: Store(initialState: CounterFeature.State()) {
                    CounterFeature()
                        ._printChanges()
                }
            )
        }
    }
}
