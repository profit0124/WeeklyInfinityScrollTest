//
//  ContentView.swift
//  WeeklyCalendarTest
//
//  Created by Sooik Kim on 2023/02/27.
//

import SwiftUI

struct ContentView: View {
    
    let width = UIScreen.main.bounds.width
    @State var dayList:[[Int]] = [[1,2,3,4,5,6,7], [8,9,10,11,12,13,14], [15,16,17,18,19,20,21]]
    @GestureState var gestureOffset: CGFloat = .zero
    @State var offset: CGFloat = .zero
    let days:[String] = ["월", "화", "수", "목", "금", "토", "일"]
    let currentDay:Int = 6

    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { i in
                    Text(i)
                        .frame(width: width * 0.13)
                }
            }
            // 초기에 offset을 주는 이유는 월요일 이전 scroll이 되는것을 알려주기 위해 전주의 일자를 살짝 보여준다.
            .offset(x: width * 0.03)
            
            HStack(spacing: 0) {
                ForEach(dayList.indices, id: \.self) { i in
                    NumberView(numbers: $dayList[i])
                }
            }
            // 날짜의 경우 DragGesture가 동작할때 값과 end가 될때 offset 값을 더해서 페이지 전환 효과를 준다.
            .offset(x: width*0.03 + gestureOffset + offset)
            
        }
        .gesture(
            DragGesture()
                .updating($gestureOffset) { dragValue, gestureState, _ in
                    // drag 하는 도중 view의 offset을 실시간으로 반영해주기 위함
                    gestureState = dragValue.translation.width
                }.onEnded { value in
                    // 제스쳐가 종료가 되는 즉시 offset을 스크롤된 값으로 할당해주고, 스크롤 방향, 값을 기준으로 페이지 전환 시 offset을 증감, 아닐시 .zero를 할당해주되, withAnimation의 closer에 정의함으로서 애니메이션 효과를 추가한다.
                    offset = value.translation.width
                    if value.translation.width < -100 {
                        withAnimation(.linear(duration: 0.05)) {
                            offset = width * -1
                        }
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05) {
                            nextWeek()
                        }
                    } else if value.translation.width > 100 {
                        withAnimation(.linear(duration: 0.05)) {
                            offset = width * 1
                        }
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05) {
                            previousWeek()
                        }
                    } else {
                        withAnimation(.linear(duration: 0.5)) {
                            offset = .zero
                        }
                    }
                }
        )
    }
    
    // 추후 dayList 의 새롭게 추가되는 배열은 날짜 구하는 공식으로 바꿔 실제 날짜로 표시되도록 수정
    private func nextWeek() {
        dayList.append(dayList[2].map{ $0 + 7 })
        dayList.removeFirst()
        offset = .zero
    }
    
    private func previousWeek() {
        dayList.insert(dayList[0].map{ $0 - 7 }, at: 0)
        dayList.removeLast()
        offset = .zero
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
