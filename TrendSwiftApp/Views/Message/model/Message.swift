//
//  Message.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/3.
//

import SwiftUI

struct Message: Identifiable{
  var id: UUID = .init()
  var message: String
  var isReply: Bool = false
}

let messages: [Message] = [
  .init(message: text1),
  .init(message: text2),
  .init(message: text3, isReply: true ),
  .init(message: text4),
  .init(message: text5),
  .init(message: text6, isReply: true),
  .init(message: text7),
  .init(message: text8, isReply: true),
  .init(message: text9, isReply: true),
  .init(message: text10),
  .init(message: text11),
  .init(message: text12, isReply: true),
  .init(message: text13),
  .init(message: text14),
  .init(message: text15, isReply: true),
  .init(message: text16),
  .init(message: text17),
]



var text1 =  "Our lives are streams,flowing into the same river, towards whatever heaven lies in the mist beyond the falls…Close your eyes, let the waters take you home."
var text2 =   "Using a widget function instead of a widget fully guarantees"
var text3 =   "Life was like a box of chocolates, you never know what you going to get.o"
var text4 =   "只有热爱你所做的事情，才能做出伟大的工作。"
var text5 =   "The only way to do great work is to love what you do."
var text6 =   "世界上最好、最美丽的东西是看不见的，甚至是摸不到的 - 它们必须用心去感受"
var text7 =   "The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart."
var text8 =   "我们对明天的实现的唯一限制将是我们今天的怀疑"
var text9 =   "The only limit to our realization of tomorrow will be our doubts of today."
var text10 =   "The greatest glory in living lies not in never falling, but in rising every time we fall."
var text11 =   "人生最大的荣耀不在于永不跌倒，而在于每一次跌倒后都能够重新站起来。"
var text12 =   "Freedom is the ability to do what you want, say what you want, and love who you want"
var text13 =   "Im going to be myself, no matter what anyone says"
var text14 =   "自由是创造的源泉，我们要用它来创造美好的生活"
var text15 =   "自由是每个人的权利，我们要为它而奋斗"
var text16 =   "自由是无价的，我们要珍惜它"
var text17 =   "Freedom is the companion of responsibility, and we should be responsible for our own freedom."
