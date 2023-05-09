//
//  ToastMessage.swift
//  DigitalLibrary
//
//  Created by 이원빈 on 2023/05/04.
//

import SwiftUI

struct ToastMessage: View {
    @Binding var isSuccessAlert: Bool
    @Binding var showAlert: Bool
    @Binding var message: String
    
    var body: some View {
        Text(message)
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
            .background(
                Color(uiColor: isSuccessAlert ? .darkGray : .red)
                    .opacity(0.9)
            )
            .foregroundColor(.white)
            .cornerRadius(9)
            .opacity(showAlert ? 1 : 0)
            .scaleEffect(showAlert ? 1 : 0.2)
            .animation(.ripple(), value: showAlert)
            .onChange(of: showAlert) { shouldShowAlert in
                guard shouldShowAlert else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    showAlert = false
                }
            }
    }
}

struct ToastMessage_Previews: PreviewProvider {
    
    static var previews: some View {
        ToastMessage(
            isSuccessAlert: .constant(false),
            showAlert: .constant(true),
            message: .constant("더 이상 데이터가 존재하지 않습니다.")
        )
    }
}
