//
//  TrendWidgetBundle.swift
//  TrendWidget
//
//  Created by L Af on 2025/1/21.
//

import WidgetKit
import SwiftUI

@main
struct TrendWidgetBundle: WidgetBundle {
    var body: some Widget {
        TrendWidget()
        TrendWidgetControl()
        TrendWidgetLiveActivity()
    }
}
