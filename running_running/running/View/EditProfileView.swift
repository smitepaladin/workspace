//
//  EditProfileView.swift
//  running
//

import SwiftUI
import PhotosUI
import SDWebImageSwiftUI
import UIKit

struct EditProfileView: View {
    @StateObject private var vm = EditProfileViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var pickerItem: PhotosPickerItem?
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    PasswordSection(vm: vm)

                    Divider().padding(.vertical, 8)

                    BasicInfoSection(vm: vm)

                    OptionalInputsSection(vm: vm, pickerItem: $pickerItem)
                }
                .padding()
                .onChange(of: pickerItem) { _, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            vm.profileImageData = data
                        }
                    }
                }
                .onChange(of: vm.alertMessage) { _, newVal in
                    showAlert = (newVal != nil)
                }
            }
            .navigationTitle("회원정보 변경")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("닫기") { dismiss() }
                }
            }
            .task { await vm.loadProfile() }
            .alert("알림", isPresented: $showAlert) {
                Button("확인", role: .cancel) { vm.alertMessage = nil }
            } message: {
                Text(vm.alertMessage ?? "")
            }
        }
    }
}

private struct PasswordSection: View {
    @ObservedObject var vm: EditProfileViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("비밀번호 변경").font(.title3).bold()

            SecureField("현재 비밀번호", text: $vm.currentPassword)
                .textContentType(.password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

            SecureField("새 비밀번호 (소문자/숫자/특수문자 포함 6자 이상)", text: $vm.newPassword)
                .textContentType(.newPassword)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

            if !vm.newPassword.isEmpty && !vm.isPasswordValid(vm.newPassword) {
                Text("비밀번호는 소문자, 숫자, 특수문자를 포함하여 6자리 이상이어야 합니다.")
                    .font(.footnote).foregroundColor(.red)
            }

            SecureField("새 비밀번호 확인", text: $vm.confirmNewPassword)
                .textContentType(.newPassword)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

            Button {
                Task { await vm.changePassword() }
            } label: {
                RowButtonLabel(text: "비밀번호 변경", loading: vm.isLoading)
            }
            .disabled(vm.isLoading)
        }
    }
}

private struct BasicInfoSection: View {
    @ObservedObject var vm: EditProfileViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("기본 정보").font(.title3).bold()
            Toggle("차 보유 여부", isOn: $vm.hasCar)
            Toggle("자녀 유무", isOn: $vm.hasChildren)
        }
    }
}

private struct OptionalInputsSection: View {
    @ObservedObject var vm: EditProfileViewModel
    @Binding var pickerItem: PhotosPickerItem?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("선택 입력").font(.title3).bold()

            HStack {
                TextField("키 (cm) — 선택", text: $vm.heightText)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                Text("cm").foregroundColor(.secondary)
            }

            HStack {
                TextField("몸무게 (kg) — 선택", text: $vm.weightText)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                Text("kg").foregroundColor(.secondary)
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("프로필 사진 (선택)")
                    .font(.subheadline).foregroundColor(.secondary)

                HStack(spacing: 12) {
                    AvatarView(data: vm.profileImageData, urlString: vm.currentPhotoURL)

                    PhotosPicker(selection: $pickerItem, matching: .images) {
                        Text(vm.profileImageData == nil ? "사진 선택" : "사진 변경")
                    }

                    if vm.profileImageData != nil || vm.currentPhotoURL != nil {
                        Button("사진 제거") {
                            Task { await vm.removePhoto() }
                        }
                        .tint(.red)
                    }
                }
            }

            Button {
                Task { await vm.saveProfile() }
            } label: {
                RowButtonLabel(text: "변경사항 저장", loading: vm.isLoading)
            }
            .disabled(vm.isLoading)
        }
    }
}

private struct AvatarView: View {
    let data: Data?
    let urlString: String?

    var body: some View {
        content
            .frame(width: 72, height: 72)
            .clipShape(Circle())
    }

    @ViewBuilder
    private var content: some View {
        if let data = data, let img = UIImage(data: data) {
            Image(uiImage: img)
                .resizable()
                .scaledToFill()
        } else if let urlString = urlString, let url = URL(string: urlString) {
            ZStack {
                AvatarPlaceholder()
                WebImage(url: url)
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.25))
                    .scaledToFill()
            }
        } else {
            AvatarPlaceholder()
        }
    }
}

private struct AvatarPlaceholder: View {
    var body: some View {
        Circle().fill(.gray.opacity(0.15))
            .overlay(Image(systemName: "person.crop.circle").font(.title2))
    }
}

private struct RowButtonLabel: View {
    let text: String
    let loading: Bool
    var body: some View {
        HStack {
            if loading { ProgressView().tint(.white) }
            Text(text).bold()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(loading ? Color.gray : Color.blue)
        .foregroundColor(.white)
        .cornerRadius(12)
    }
}

#Preview {
    EditProfileView() // 미리보기
}
