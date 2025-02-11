

import SwiftUI

// MARK: - 缩放过渡 (Zoom Transition)
struct ZPhoto: Identifiable, Hashable {
    let id = UUID()
    let name: String
}

struct ZoomTransitionDemo: View {
    let samplePhotos = (1...20).map { ZPhoto(name: "coffee-\($0)") }
    @Namespace() var namespace
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(samplePhotos) { photo in
                        NavigationLink {
                            Image(photo.name)
                                .resizable()
                                .scaledToFit()
                                .navigationTransition(.zoom(sourceID: photo.id, in: namespace))
                        } label: {
                            Image(photo.name)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 150)
                                .cornerRadius(30.0)
                                .background(.black)
                                .overlay{
                                    Text("\(photo.name)")
                                }
                        }
                        .matchedTransitionSource(id: photo.id, in: namespace)
                    }
                }
            }
            .navigationTitle("Zoom Transition")
        }
    }
}

// MARK: - SF Symbols 动画 (SF Symbols Animation)
struct SFSymbolsAnimationDemo: View {
    @State private var animate = false
    
    var body: some View {
        VStack {
            Image(systemName: "ellipsis.message")
                .font(.system(size: 100))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.purple, .gray)
                .symbolEffect(.rotate, value: animate)
                .onTapGesture {
                    animate.toggle()
                }
            
            Text("Tap the icon to animate!")
                .font(.headline)
                .padding(.top, 20)
        }
    }
}

// MARK: - 滚动视图控制 (Scroll View Enhancements)
struct ScrollViewDemo: View {
    let samplePhotos = (1...20).map { ZPhoto(name: "coffee-\($0)") }
    @State private var showScrollToTop = false
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack {
                    ForEach(samplePhotos) { photo in
                        Image(photo.name)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .id(photo.id)
                    }
                }
            }
            .onScrollGeometryChange(for: Bool.self) { geometry in
                geometry.contentOffset.y > 200
            } action: { oldValue, newValue in
                withAnimation {
                    showScrollToTop = newValue
                }
            }
            .overlay(alignment: .bottomTrailing) {
                if showScrollToTop {
                    Button {
                        withAnimation {
                            proxy.scrollTo(samplePhotos.first!.id, anchor: .top)
                        }
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 40))
                            .padding()
                    }
                }
            }
        }
        .navigationTitle("Scroll View Demo")
    }
}

// MARK: - 控制中心小工具 (Widgets in Control Center)
//struct StartPartyControl: ControlWidget {
//    var body: some ControlWidgetConfiguration {
//        StaticControlConfiguration(kind: "com.apple.karaoke_start_party") {
//            ControlWidgetButton(action: StartPartyIntent()) {
//                Label("Start the Party!", systemImage: "music.mic")
//                Text("Next Party: Karaoke Night")
//            }
//        }
//    }
//}

//struct StartPartyIntent: AppIntent {
//    static var title: LocalizedStringResource = "Start Party"
//    
//    func perform() async throws -> some IntentResult {
//        // 在这里实现启动派对的逻辑
//        print("Party started!")
//        return .result()
//    }
//}

struct TextWidget: View {
    var body: some View {
      
        TabView {
                    ZoomTransitionDemo()
                        .tabItem {
                            Label("Zoom", systemImage: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                    
                    SFSymbolsAnimationDemo()
                        .tabItem {
                            Label("SF Symbols", systemImage: "ellipsis.message")
                        }
                    
                    ScrollViewDemo()
                        .tabItem {
                            Label("Scroll", systemImage: "arrow.up.arrow.down")
                        }
                }
        
    }
}

#Preview {
    TextWidget()
}
