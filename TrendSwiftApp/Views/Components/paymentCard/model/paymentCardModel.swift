//
//  paymentCardModel.swift
//  TrendSwiftApp
//
//  Created by L Af on 2025/1/2.
//

import SwiftUI

struct PaymentCardModel: Identifiable {
  var id: String = UUID().uuidString
  var number: String
  var expires: String
  var color: Color
  
  var visaGeometryID: String {
    "VISA_\(id)"
  }
}

var PaymentCards: [PaymentCardModel] = [
  .init(number: "**** **** **** 1234", expires: "02/01", color: .blue),
  .init(number: "**** **** **** 5678", expires: "09/24", color: .indigo),
  .init(number: "**** **** **** 9102", expires: "08/11", color: .pink),
  .init(number: "**** **** **** 1289", expires: "01/029", color: .black),
  .init(number: "**** **** **** 1223", expires: "04/029", color: .gray),
  .init(number: "**** **** **** 6289", expires: "01/019", color: .purple)
]
