import SwiftUI

struct Listnavigation: View {
    @State private var selectedTab = 0
    let tabs = ["Tab 1", "Tab 2", "Tab 3"]
    
    // 修改为 @State private var imageURLs: [URL] = []
    @State private var imageURLs: [URL] = []

    var body: some View {
        VStack {
            // Top switchable section 保持不变
            Picker("Tabs", selection: $selectedTab) {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Text(tabs[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Content area
            TabView(selection: $selectedTab) {
                ForEach(0..<tabs.count, id: \.self) { _ in
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(imageURLs, id: \.self) { url in
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(height: 150)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height: 150)
                                            .cornerRadius(10)
                                            .clipped()
                                    case .failure:
                                        Image(systemName: "photo")
                                            .frame(height: 150)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .frame(height: 150)
                                .cornerRadius(10)
                            }
                        }
                        .padding()
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .onAppear {
            loadImages()
        }
    }
    
    // 修改加载图片的函数
    func loadImages() {
        // 使用Picsum Photos API获取多个随机图片
        for i in 1...16 {
            if let url = URL(string: "https://picsum.photos/300/300?random=\(i)") {
                imageURLs.append(url)
            }
        }
    }
}

#Preview {
    Listnavigation()
}

// End of file. No additional code.
