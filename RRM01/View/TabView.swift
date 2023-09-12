//
//  TabView.swift
//  RRM01
//
//  Created by william colglazier on 01/09/2023.
//

import SwiftUI

// MARK: - Tab Enum
//enum Tab: String, CaseIterable {
//    case Home = "house"
//    case Post = "plus.circle"
//    case Profile = "person"
//    
//    var tabName: String {
//        switch self {
//        case .Home:
//            return "Home"
//        case .Post:
//            return "Post"
//        case .Profile:
//            return "Profile"
//        }
//    }
//}

struct TabButton: View {
    var tab: Tab
    @Binding var currentTab: Tab
    @Namespace private var animation
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Image(systemName: currentTab == tab ? tab.rawValue + ".fill" : tab.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(currentTab == tab ? .primary : .secondary)
                    .padding(currentTab == tab ? 15 : 0)
                    .background(
                        ZStack {
                            if currentTab == tab {
                                MaterialEffect(style: .light)
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                
                                Text(tab.tabName).foregroundColor(.black)
                                    .font(.footnote).padding(.top, 50)
                            }
                        }
                    )
                    .contentShape(Rectangle())
                    .offset(y: currentTab == tab ? -35 : 0)
            }
        }
        .frame(height: 25)
    }
}
