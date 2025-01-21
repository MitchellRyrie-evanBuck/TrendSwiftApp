//
//  TrendWidgetLiveActivity.swift
//  TrendWidget
//
//  Created by L Af on 2025/1/21.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TrendWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TrendWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TrendWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TrendWidgetAttributes {
    fileprivate static var preview: TrendWidgetAttributes {
        TrendWidgetAttributes(name: "World")
    }
}

extension TrendWidgetAttributes.ContentState {
    fileprivate static var smiley: TrendWidgetAttributes.ContentState {
        TrendWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TrendWidgetAttributes.ContentState {
         TrendWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TrendWidgetAttributes.preview) {
   TrendWidgetLiveActivity()
} contentStates: {
    TrendWidgetAttributes.ContentState.smiley
    TrendWidgetAttributes.ContentState.starEyes
}
