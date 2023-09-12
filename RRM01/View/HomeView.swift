//
//  Home.swift
//  RRM01
//
//  Created by william colglazier on 10/08/2023.
//

import SwiftUI

struct Home: View {
    @State private var currentDate: Date = .init()
    @State private var weekSlider: [[Date.WeekDay]] = []
    @State private var currentWeekIndex: Int = 1
    @State private var createWeek: Bool = false
    @State private var postTextPresented = false
    @ObservedObject var postModel = PostModel()
    
    @State var currentTab: Tab = .Home
    @Namespace var animation

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        NavigationView {
            TabView(selection: $currentTab) {
                mainContentView
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
        }
    }

    var mainContentView: some View {
        VStack(alignment: .leading, spacing: -15, content: {
            HeaderView()
            Spacer() // This pushes the HeaderView to the top of the screen.
            
            // Add spacer at the top of the post text section
            Spacer().frame(height: 20)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 3) {
                    ForEach(postModel.posts, id: \.self) { post in
                        VStack(alignment: .leading) {
                            Text(" College Station ➟").foregroundColor(Color(red: 0.5, green: 0.0, blue: 0.0)).bold() +
                            Text(" \(post.detail) ") +
                            Text("at").foregroundColor(Color(red: 0.5, green: 0.0, blue: 0.0)).bold() +
                            Text(" \(post.time)")
                                .font(.system(size: 16))
                            
                            Text(" Driver is ")
                                .foregroundColor(Color(red: 0.5, green: 0.0, blue: 0.0))
                                .bold() +
                            Text(Gender.getGender(val: post.gender))
                            
                            
                            Text(" I'm Charging").foregroundColor(Color(red: 0.5, green: 0.0, blue: 0.0)).bold() + Text(" \(post.price)")
                                .font(.system(size: 16))
                            
                            Text(" Text me").foregroundColor(Color(red: 0.5, green: 0.0, blue: 0.0)).bold() +
                            Text(" \(post.phone) ") +
                            Text("Snap me").foregroundColor(Color(red: 0.5, green: 0.0, blue: 0.0)).bold() +
                            Text(" \(post.snap)")
                                .font(.system(size: 16))
                            
                            
                            
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .border(Color.black, width: 0.8)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.clear, Color(red: 0.5, green: 0.0, blue: 0.0)]),
                                startPoint: .center,
                                       endPoint: .leading
                            )
                        )
                    }}
                .padding() // Add horizontal padding to center the content
                Spacer().frame(height: 2)
            }
            
        })
        .padding(.top) // Provides padding at the top.
        .background(Color.white)
        .onAppear(perform: {
            if weekSlider.isEmpty {
                // Assuming fetchWeek returns an array of Dates for the current week
                let currentWeek = Date().fetchWeek()
                
                if let firstDate = currentWeek.first?.date {
                    weekSlider.append(firstDate.createPreviousWeek())
                }
                
                weekSlider.append(currentWeek)
                
                if let lastDate = currentWeek.last?.date {
                    weekSlider.append(lastDate.createNextWeek())
                }
            }
        })
    }
    
    
    @ViewBuilder
    func HeaderView() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 5) {
                Text(currentDate.format("MMMM"))
                    .foregroundColor(Color(red: 0.5, green: 0.0, blue: 0.0))
                
                Text(currentDate.format("yyyy"))
                    .foregroundStyle(.gray)
            
                   

                
            }
            .font(.title.bold())

            
            Text(currentDate.formatted(date: .complete, time: .omitted))            .font(.callout)
                .fontWeight(.semibold)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            TabView(selection: $currentWeekIndex) {
                ForEach(weekSlider.indices, id: \.self) { index in
                    let week = weekSlider[index]
                    WeekView(week)
                        .padding(.horizontal, 15)
                        .tag(index)
                    
                }
            }
            .padding(.horizontal, -15)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 90)
        }
  
        .padding(15)
        .background(.white)
        .onChange(of: currentWeekIndex) { newValue in
            // Checking if the index is either at the start or the end of the weekSlider array
            if newValue == 0 || newValue == (weekSlider.count - 1) {
                createWeek = true
                // Here, you can add additional logic or actions that should occur when createWeek is set to true
            }
        }

}

    @ViewBuilder
    func WeekView(_ week: [Date.WeekDay]) -> some View {
        
        HStack(spacing: 0) {
            ForEach(week) { day in
                VStack(spacing: 8) {
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                    
                    Text(day.date.format("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .white : .gray)
                        .frame(width: 35, height: 35)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack {
                                // Main date circle
                                if isSameDate(day.date, currentDate) {
                                    Circle().fill(Color(red: 0.5, green: 0.0, blue: 0.0))
                                        .matchedGeometryEffect(id: "TABINDICATOR", in: animation)

                                }
                                
                                // Small circle indicator for today's date
                                if day.date.isToday {
                                    Circle()
                                        .fill(Color(red: 0.5, green: 0.0, blue: 0.0))
                                        .frame(width: 5, height: 5)
                                        .vSpacing(.bottom)
                                        .offset(y: 24)  // Adjust this value to position the small circle below the main circle
                                }
                            })
                        }
                .contentShape(Rectangle()) // Setting the tappable area as a rectangle
                .onTapGesture {
                    // Updating Current Date with animation
                    withAnimation {
                        currentDate = day.date
                        

                        
                    }
                }
            }
        }
    }
}


struct Home_Previews: PreviewProvider {
   static var previews: some View {
       Home()
   }
}
               

