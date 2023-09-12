import SwiftUI

struct SelectButton: View {
    @Binding var isSelected: Bool
    var color: Color
    var text: String
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
        }) {
            Rectangle()
                .fill(Color.clear)
                .border(Color.gray, width: 1)
                .frame(height: 50)
                .overlay(
                    Text(text)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(isSelected ? color : Color.white)
                        .foregroundColor(isSelected ? .white : .gray) 
                        .cornerRadius(1)
                )
        }
        .border(Color.gray, width: 1)
    }
}
