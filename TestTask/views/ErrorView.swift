//
//  ErrorView.swift
//  TestTask
//
//  Created by mac on 15.06.2024.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    let retryAction: () -> Void

    var body: some View {
        VStack {
            Text("Error: \(error.localizedDescription)")
                .multilineTextAlignment(.center)
            Button(action: retryAction) {
                Text("Retry")
            }
            .padding()
        }
    }
}
