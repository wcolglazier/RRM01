import SwiftUI

// MARK: - Material Effect View
struct MaterialEffect: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

// MARK: - Safe Area Extension
extension View {
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}


// MARK: - Main Content View
import SwiftUI

struct ContentView: View {
    
    @State var currentTab: Tab = .Home
    @Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
       // NavigationView {
            TabView(selection: $currentTab) {
                Home()
                    .tag(Tab.Home)
                
                PostView()
                    .tag(Tab.Post)

                SettingsView(showSignInView: .constant(false))
                    .tag(Tab.Settings)
            }
            .overlay(
                HStack(spacing: 0) {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        TabButton(tab: tab, currentTab: $currentTab)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    currentTab = tab
                                }
                            }
                    }
                    .padding(.vertical)
                    .padding(.bottom, getSafeArea().bottom == 0 ? 5 : (getSafeArea().bottom - 15))
                    .background(Color.white)
                },
                alignment: .bottom
            )
            .ignoresSafeArea(.all, edges: .bottom)
       // }
        //xxxx
    }
}

enum Tab: String, CaseIterable {
    case Home = "house"
    case Post = "plus.circle"
    case Settings = "gearshape"
    
    var tabName: String {
        switch self {
        case .Home:
            return "Home"
        case .Post:
            return "Post"
        case .Settings:
            return "Settings"
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
