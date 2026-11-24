//
//  CounterFeature.swift
//  TCAStudy
//
//  Created by 신서연 on 11/23/26.
//

import Foundation
import ComposableArchitecture

@Reducer // 해당 타입이 TCA의 Reducer로 동작하는 데 필요한 코드를 생성하는 매크로
struct CounterFeature {
    // 카운터 기능의 상태,행동,로직을 정의할 타입이다.
    
    @ObservableState // SwiftUI는 State의 변경을 관찰하려면 이걸 사용한다.
    struct State {
        var count = 0
        var fact: String?
        var isLoading = false
        var isTimerRunning = false
    }
     
    enum Action { // 사용자의 행동
        case incrementButtonTapped
        case decrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case toggleTimerButtonTapped
        case timerTick
    }
    
    enum CancelID {
        case timer
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil // count가 변경될 때 기존 fact를 초기화한다.
                return .none // 실행할 추가 Effect가 없는 상황이다.
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true

                return .run { [count = state.count] send in
                    let (data, _) = try await URLSession.shared
                        .data(
                            from: URL(string: "http://numbersapi.com/\(count)")!
                        )

                    let fact = String(decoding: data, as: UTF8.self)
                    
                    await send(.factResponse(fact))
                }
            
            case let .factResponse(fact):
                state.fact = fact
                state.isLoading = false
                return .none
            
            case .toggleTimerButtonTapped:
                state.isTimerRunning.toggle()

                if state.isTimerRunning {
                    return .run { send in
                        while true {
                            try await Task.sleep(for: .seconds(1))
                            await send(.timerTick)
                        }
                    }
                    .cancellable(id: CancelID.timer) // Effect에 취소용 식별자를 지정해줌

                } else {
                    return .cancel(id: CancelID.timer) // .cancel(id:) 는 해당 식별자의 Effect 취소
                }
            
            case .timerTick:
                state.count += 1
                state.fact = nil
                return .none
            }
        }
    }
}
