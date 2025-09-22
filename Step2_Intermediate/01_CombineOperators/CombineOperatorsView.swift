//
//  CombineOperatorsView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/22/25.
//

import SwiftUI

/*
 - NavigaionView: "use NavigationStack or NavigationSplitView instead"
 - NavigaionView 보다는 NavigationStack 사용 권장!
 */

struct CombineOperatorsView: View {
    @StateObject private var viewModel = CombineOperatorsViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.numbers, id: \.self) { num in
                    Text("\(num)")
                }
                Button("Start") {
                    viewModel.start()
                }
            }
            .navigationTitle("Combine Operators")
        }
    }
}

#Preview {
    CombineOperatorsView()
}
