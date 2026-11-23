//
//  CounterView.swift
//  TCAStudy
//
//  Created by 신서연 on 11/23/26.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {

    // MARK: - Properties

    let store: StoreOf<CounterFeature>

    // MARK: - Body

    var body: some View {
        VStack {
            Text("\(store.count)")

            HStack {
                Button("-") {
                    store.send(.decrementButtonTapped)
                }

                Button("+") {
                    store.send(.incrementButtonTapped)
                }
            }
        }
    }
}
