//
//  NewTaskView.swift
//  TaskManagementApp
//
//  Created by 멘태 on 11/26/25.
//

import SwiftUI

struct NewTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var date: Date = .init()
    @State private var color: Color = .blue
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .tint(.red)
            }
            .hSpacing(.leading)
            
            VStack(alignment: .leading) {
                Text("Title")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                TextField("Go for a walk!", text: $title)
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
            }
            .padding(.top, 5)
            
            HStack(spacing: 12) {
                VStack(alignment: .leading) {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    DatePicker("", selection: $date)
                        .datePickerStyle(.compact)
                        .scaleEffect(0.9, anchor: .leading)
                }
                .padding(.trailing, -16)
                
                VStack(alignment: .leading) {
                    Text("Color")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    let colors: [Color] = [.yellow, .cyan, .white, .pink, .gray]
                    
                    HStack(spacing: 0) {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 20, height: 20)
                                .background {
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .opacity(self.color == color ? 1 : 0)
                                }
                                .hSpacing(.center)
                                .contentShape(.rect)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        self.color = color
                                    }
                                }
                        }
                    }
                }
            }
            .padding(.top, 5)
            
            Spacer(minLength: 0)
            
            Button {
                
            } label: {
                Text("Create Task")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.black)
                    .hSpacing(.center)
                    .padding(.vertical, 12)
                    .background(color, in: .rect(cornerRadius: 10))
            }
            .disabled(title == "")
            .opacity(title == "" ? 0.5 : 1)
        }
        .hSpacing(.center)
        .padding()
    }
}

#Preview {
    NewTaskView()
        .vSpacing(.bottom)
}
