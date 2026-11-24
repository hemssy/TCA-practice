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
            
            Button("Fact") {
                store.send(.factButtonTapped)
            }
            
            if store.isLoading {
                ProgressView()
            }
            
            if let fact = store.fact {
                Text(fact)
            }
            
            Button(
                store.isTimerRunning ? "Stop timer" : "Start timer"
            ) {
                store.send(.toggleTimerButtonTapped)
            }
        }
    }
}
