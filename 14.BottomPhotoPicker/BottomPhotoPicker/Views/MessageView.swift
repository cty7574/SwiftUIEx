//
//  MessageView.swift
//  BottomPhotoPicker
//
//  Created by 멘태 on 12/26/25.
//

import SwiftUI
import PhotosUI

struct PickerInteractionProperties {
    var storedKeyboardHeight: CGFloat = 0
    var dragOffset: CGFloat = 0
    var showPhotoPicker: Bool = false
    
    var keyboardHeight: CGFloat {
        storedKeyboardHeight == 0 ? 300 : storedKeyboardHeight
    }
    
    var safeArea: UIEdgeInsets {
        if let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets {
            return safeArea
        }
        
        return .zero
    }
    
    var screenSize: CGSize {
        if let size = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds.size {
            return size
        }
        
        return .zero
    }
    
    var animation: Animation {
        .interpolatingSpring(duration: 0.3, bounce: 0, initialVelocity: 0)
    }
}

struct MessageView: View {
    @State private var properties: PickerInteractionProperties = .init()
    @State private var messageText: String = ""
    @State private var selectedPhoto: PhotosPickerItem?
    @FocusState private var isKeyboardActive: Bool
    
    var animatedKeyboardHeight: CGFloat {
        return (properties.showPhotoPicker || isKeyboardActive) ? properties.keyboardHeight : 0
    }
    
    var body: some View {
        ScrollView {
            
        }
        .scrollDismissesKeyboard(.interactively)
        .safeAreaInset(edge: .bottom, spacing: 10) {
            bottomBar()
        }
        .ignoresSafeArea(.keyboard, edges: .all)
        .background {
            if #available(iOS 26, *) {
                Rectangle()
                    .fill(.clear)
                    .onGeometryChange(for: CGFloat.self) { proxy in
                        proxy.frame(in: .global).maxY
                    } action: { newValue in
                        guard properties.storedKeyboardHeight != 0 else { return }
                        let height = max(properties.screenSize.height - newValue - properties.safeArea.bottom, 0)
                        properties.dragOffset = properties.storedKeyboardHeight - height
                    }

            }
        }
        .navigationTitle("iJustine")
    }
    
    @ViewBuilder
    func bottomBar() -> some View {
        HStack(alignment: .bottom) {
            Button {
                properties.showPhotoPicker.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.medium)
                    .frame(width: 40, height: 40)
                    .background(.ultraThinMaterial, in: .circle)
                    .contentShape(.circle)
            }
            
            TextField("Message...", text: $messageText, axis: .vertical)
                .lineLimit(6)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 30))
                .focused($isKeyboardActive)

        }
        .padding(.horizontal)
        .padding(.bottom, 10)
        .geometryGroup()
        .padding(.bottom, animatedKeyboardHeight)
        .offset(y: isKeyboardActive ? properties.dragOffset : 0)
        .animation(properties.animation, value: animatedKeyboardHeight)
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)) { info in
            if let frame = info.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let height: CGFloat = frame.cgRectValue.height
                if properties.storedKeyboardHeight == 0 {
                    properties.storedKeyboardHeight = max(height - properties.safeArea.bottom, 0)
                }
            }
        }
        .sheet(isPresented: $properties.showPhotoPicker) {
            PhotosPicker("", selection: $selectedPhoto)
                .photosPickerStyle(.inline)
                .photosPickerDisabledCapabilities([.stagingArea, .sensitivityAnalysisIntervention])
                .presentationDetents([.height(properties.keyboardHeight), .large])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(properties.keyboardHeight)))
        }
        .onChange(of: properties.showPhotoPicker) { oldValue, newValue in
            if newValue {
                isKeyboardActive = false
            }
        }
        .onChange(of: isKeyboardActive) { oldValue, newValue in
            if newValue {
                properties.showPhotoPicker = false
            }
        }
    }
}

#Preview {
    NavigationStack {
        MessageView()
    }
}
