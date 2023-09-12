import SwiftUI
import Firebase
import FirebaseFirestore


// 1. CustomDatePicker outside of PostView
struct CustomDatePicker: View {
    @State private var selectedDate: Date = Date()
    let startDate: Date = Date() // Today's date
    let endDate: Date = Calendar.current.date(byAdding: .weekOfYear, value: 2, to: Date())! // Two weeks from today
    
    var dateRange: [Date] {
        let components = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
        return Array(0..<components.day!).map { Calendar.current.date(byAdding: .day, value: $0, to: startDate)! }
    }
    
    var body: some View {
        VStack {
            Picker("Select Date", selection: $selectedDate) {
                ForEach(dateRange, id: \.self) { date in
                    Text(date, formatter: DateFormatter.shortDate)
                        .foregroundColor(.green) // Make the text green
                        .bold() // Make the text bold
                }
            }
            .labelsHidden()
            .frame(width: 370, height: 20)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
        }
    }
}

// 2. DateFormatter extension outside of PostView
extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}


struct PostView: View {
    
    
    
    
    
    
    var postModel = PostModel()
    
    @State var detailText = ""
    @State var timeText = ""
    @State var priceText = ""
    @State var phoneText = ""
    @State var snapText = ""
    
    @State private var selectedOption: Int?
    let options = ["Austin", "Houstan", "Dallas", "Fort Worth"]
    
    @State private var isSelected: Bool = false
    @State private var isSelected2: Bool = false
    @State private var isSelected3: Bool = false
    @State private var navigateToHome = false
    
    let currentDate = Date()
    
    var formattedDate: String {
        //let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: currentDate)
    }
    
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                Text("Make a Post")
                    .font(.system(size: 45, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.black)
                    .padding(.top, 20)
                
   
                Text("When are you leaving")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 0.5, green: 0.0, blue: 0.0))
              
            
                CustomDatePicker()
                 
                          .padding(.top, -5)
                
                Text("Where are you Traveling?")
                    .padding(.leading, -120)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 0.5, green: 0.0, blue: 0.0))
                
                Picker(selection: $selectedOption, label: Text("Options")) {
                    if selectedOption == nil {
                        Text("Pick a city").tag(nil as Int?)
                    }
                    
                    ForEach(0..<options.count) { index in
                        Text(self.options[index]).tag(index as Int?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 367, height: 22)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))

                
                
                
                
                
                VStack {
                
                    
                    
                    
                    
                    Text("What time are you planning on leaving")
                    
                        .foregroundColor(Color(red: 0.5, green: 0.0, blue: 0.0))
                        .font(.system(size: 20, weight: .bold))
                    
                    TextField("Time", text: $timeText)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    
                    Text("How much do you want to charge per rider")
                    
                        .foregroundColor(Color(red: 0.5, green: 0.0, blue: 0.0))
                        .font(.system(size: 20, weight: .bold))
                    
                    TextField("Price", text: $priceText)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    
                    Text("Provide your phone number")
                        .foregroundColor(Color(red: 0.5, green: 0.0, blue: 0.0))
                        .font(.system(size: 20, weight: .bold))
                    
                    
                    TextField("Phone Number", text: $phoneText)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                
                
                Rectangle()

                    
                    .fill(Color.clear)
                    .border(Color.gray, width: 1)
                    .frame(height: 50)
                    .overlay(
                        
                        
                        HStack(spacing: 1) {
                            
                           
                            // Male Button
                            SelectButton(isSelected: $isSelected, color: Color(red: 0.5, green: 0.0, blue: 0.0), text: "Male")
                                .frame(width: 132)
                                .frame(height: 50)
                                .onTapGesture {
                                    isSelected = true
                                    isSelected2 = false
                                    isSelected3 = false
                                }
                            
                            // Female Button
                            SelectButton(isSelected: $isSelected2, color: Color(red: 0.5, green: 0.0, blue: 0.0), text: "Female")
                                .frame(width: 132)
                                .frame(height: 50)
                                .onTapGesture {
                                    isSelected = false
                                    isSelected2 = true
                                    isSelected3 = false
                                }
                            
                            // Other Button
                            SelectButton(isSelected: $isSelected3, color: Color(red: 0.5, green: 0.0, blue: 0.0), text: "Other")
                                .frame(width: 132)
                                .frame(height: 50)
                                .onTapGesture {
                                    isSelected = false
                                    isSelected2 = false
                                    isSelected3 = true
                                }
                        }
                            .padding(10)
                        
                    )
                    
               
                
                TextField("Snapchat", text: $snapText)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                
                Button(action: {
                    
                    var gender = -1
                    if isSelected {
                        gender = 0
                    } else if isSelected2 {
                        gender = 1
                    } else if isSelected3 {
                        gender = 2
                    }
                    
                    
                    
                    
                    
                    
                    let post = Post(id: .init(), detail: detailText, date: currentDate, time: timeText, price: priceText, phone: phoneText, snap: snapText, gender: gender   )
                    
                    
                    
                    
                    
                    
                    postModel.add(post: post)
                    navigateToHome = true  // Activate the navigation link
                }) {
                    Text("Post")
                        .font(.system(size: 24, weight: .bold))
                }
                
                    NavigationLink(destination: Home(), isActive: $navigateToHome) {
                        EmptyView()
                    }
            }
            .padding()
        }
    }}
}

struct PostText__Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
