//
//  WIdget.swift
//  WIdget
//
//  Created by Rahul Patel on 19/07/20.
//

import WidgetKit
import SwiftUI
 
struct widgetModel: TimelineEntry {
    var date: Date
    var currentTime: String
}

struct Provider: TimelineProvider {
    func timeline(with context: Context, completion: @escaping (Timeline<widgetModel>) -> ()) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        let time = formatter.string(from: date)
        let entry = widgetModel(date: date, currentTime: time)
        
        let refresh = Calendar.current.date(byAdding: .second, value: 10, to: date)!
        print("Current Date: \(date) Refresh Date : \(refresh)")
        let timeLine = Timeline(entries: [entry], policy: .after(refresh))
        completion(timeLine)
    }
    
    func snapshot(with context: Context, completion: @escaping (widgetModel) -> ()) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        let time = formatter.string(from: date)
        let entry = widgetModel(date: date, currentTime: time)
        completion(entry)
    }
}

struct WidgetView: View {
    
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text("Date")
            Text(entry.currentTime)
        }
        .padding(.all, 0)
    }
}


@main
struct config: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Widget", provider: Provider(), placeholder: Text("Date")) { data in
            WidgetView(entry: data)
        }
        .supportedFamilies([.systemSmall])
        .description(Text("Current time widget"))
    }
}
