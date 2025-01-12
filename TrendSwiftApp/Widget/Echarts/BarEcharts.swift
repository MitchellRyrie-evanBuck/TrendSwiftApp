//
//  BarEcharts.swift
//  TrendSwiftApp
//
//  Created by L Af on 2025/1/12.
//

import SwiftUI
import Charts

// 任务数据模型
struct TaskData: Identifiable {
    let id = UUID()
    let status: String
    let percentage: Double
    let color: Color
}

struct TaskStatusView: View {
    // 任务数据
    @State private var taskData: [TaskData] = [
        TaskData(status: "Completed", percentage: 40, color: Color("#5CC5C0")),
        TaskData(status: "In Progress", percentage: 20, color: Color("#9F97E9")),
        TaskData(status: "Pending", percentage: 40, color: Color("#FF8FBA"))
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 顶部用户信息
            HStack(spacing: 16) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading) {
                    Text("Hello User!")
                        .font(.title2)
                        .bold()
                    Text("You have 9 tasks to do today")
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                HStack(spacing: 20) {
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                    Image(systemName: "bell")
                        .font(.title3)
                }
            }
            .padding(.horizontal)
            
            // 任务状态卡片
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Task Status")
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                    
                    Menu {
                        Button("Today", action: {})
                        Button("This Week", action: {})
                        Button("This Month", action: {})
                    } label: {
                        HStack {
                            Text("Today")
                                .foregroundColor(.primary)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.primary)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color(.systemBackground))
                        .cornerRadius(15)
                    }
                }
                
                Text("You have 9 tasks due today and 30 other tasks to complete for the rest of the week.")
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                
                // Charts 环形图表
                Chart(taskData) { item in
                    SectorMark(
                        angle: .value("Percentage", item.percentage),
                        innerRadius: .ratio(0.75),
                        outerRadius: .ratio(1)
                    )
                    .foregroundStyle(item.color)
                    .cornerRadius(5)
                }
                .frame(height: 200)
                .padding(.vertical)
                
                // 状态百分比标签
                HStack {
                    ForEach(taskData) { item in
                        VStack(alignment: .leading) {
                            Text(item.status)
                                .foregroundColor(item.color)
                            Text("\(Int(item.percentage))%")
                                .font(.title2.bold())
                        }
                        if item.id != taskData.last?.id {
                            Spacer()
                        }
                    }
                }
                
                // 底部导航栏
                HStack(spacing: 16) {
                    Text("All Tasks")
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color("#5CC5C0"))
                        .cornerRadius(20)
                    
                    ForEach(["Today", "Upcoming", "Completed"], id: \.self) { tab in
                        Text(tab)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 8)
            }
            .padding(20)
            .background(Color(.systemGray6).opacity(0.5))
            .cornerRadius(20)
            .padding(.horizontal)
            
            // 当前任务
            HStack {
                Text("Current Tasks")
                    .font(.title2)
                    .bold()
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
}

// Color 扩展
extension Color {
    init(_ hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }
}

#Preview {
    TaskStatusView()
        .preferredColorScheme(.light)
}
