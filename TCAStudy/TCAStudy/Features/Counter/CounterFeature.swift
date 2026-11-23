//
//  CounterFeature.swift
//  TCAStudy
//
//  Created by 신서연 on 11/23/26.
//

import SwiftUI
import ComposableArchitecture

@Reducer // 해당 타입이 TCA의 Reducer로 동작하는 데 필요한 코드를 생성하는 매크로
struct CounterFeature {
    // 카운터 기능의 상태,행동,로직을 정의할 타입이다.
    
    @ObservableState // SwiftUI는 State의 변경을 관찰하려면 이걸 사용한다.
    struct State {
        var count = 0 // 이게 State
    }
     
    enum Action { // 사용자의 행동
        case incrementButtonTapped
        case decrementButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .incrementButtonTapped:
                state.count += 1
                return .none // 실행할 추가 Effect가 없는 상황이다.
            case .decrementButtonTapped:
                state.count -= 1
                return .none
            }
        }
    }

}

struct CounterView: View {
    let store: StoreOf<CounterFeature> // CounterFeature의 Store를 전달받는다.

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
