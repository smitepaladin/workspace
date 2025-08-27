//
//  SignUp.swift
//  running
//
//  Created by HeartFluttery on 8/19/25.
//
import SwiftUI
import PhotosUI
import UIKit   // (뷰에서만) 로컬 미리보기용 UIImage(data:)

struct SignUpView: View {
    @StateObject private var vm = SignUpViewModel()   // 회원가입 로직을 담당하는 VM
    @Environment(\.dismiss) private var dismiss       // 현재 화면 닫기 위한 Environment 변수
    
    @State private var birth6: String = ""  // 주민번호 앞부분 (YYMMDD)
    @State private var tail1: String = ""   // 주민번호 뒷자리 첫 글자 (성별 코드)
    @State private var pickerItem: PhotosPickerItem?
    

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("회원가입")
                    .font(.largeTitle).bold()
                    .padding(.top, 12)

                Group {
                    // 이름 입력 필드
                    TextField("이름", text: $vm.name)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)

                    // 이메일 입력 필드 + 중복 확인 버튼
                    HStack(spacing: 8) {
                        TextField("이메일", text: $vm.email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)

                        Button {
                            Task { await vm.checkEmailDuplicate() }   // 이메일 중복 확인 실행
                        } label: {
                            if vm.isCheckingEmail {
                                ProgressView().padding(.horizontal, 8) // 로딩 중
                            } else {
                                Text("중복확인")
                                    .bold()
                                    .padding(.horizontal, 8)
                            }
                        }
                        .padding(.vertical, 12)
                        .background(Color.blue.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .disabled(vm.isCheckingEmail || vm.email.isEmpty) // 확인 중이거나 비어있으면 비활성화
                    }

                    // 이메일 중복 확인 결과 표시
                    if let available = vm.isEmailAvailable {
                        Text(available ? "✅ 사용 가능한 이메일입니다." : "❌ 이미 등록된 이메일입니다.")
                            .font(.footnote)
                            .foregroundColor(available ? .green : .red)
                            .padding(.horizontal, 4)
                    }

                    // 비밀번호 입력
                    SecureField("비밀번호 (6자 이상)", text: $vm.password)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)

                    // 비밀번호 조건 불일치 시 경고 표시
                    if !vm.isPasswordValid(vm.password) && !vm.password.isEmpty {
                        Text("비밀번호는 소문자, 숫자, 특수문자를 포함하여 6자리 이상이어야 합니다.")
                            .font(.footnote)
                            .foregroundColor(.red)
                            .padding(.horizontal, 4)
                    }

                    // 비밀번호 재확인 입력
                    SecureField("비밀번호 재확인", text: $vm.confirmPassword)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                }
                

                // 주민번호 앞 6자리 + 뒷자리 1자리
                HStack(spacing: 8) {
                    // 앞 6자리 입력 (YYMMDD)
                    TextField("생년월일 6자리 (YYMMDD)", text: Binding(
                        get: { birth6 },
                        set: { newValue in
                            // 숫자만 허용 + 최대 6자리
                            let filtered = newValue.filter { $0.isNumber }
                            birth6 = String(filtered.prefix(6))
                            vm.identification = birth6 + tail1
                        })
                    )
                    .keyboardType(.numberPad)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    
                    Text("-") // 구분선

                    // 뒷자리 첫 글자 입력 (성별 코드)
                    TextField("뒷자리처음", text: Binding(
                        get: { tail1 },
                        set: { newValue in
                            // 숫자만 허용 + 최대 1자리
                            let filtered = newValue.filter { $0.isNumber }
                            tail1 = String(filtered.prefix(1))
                            vm.identification = birth6 + tail1
                        })
                    )
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .frame(width: 80)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                }
                // 이미 값이 있으면 화면 열 때 분리해서 보여주기
                .onAppear {
                    let id = vm.identification.filter { $0.isNumber }
                    if id.count >= 6 {
                        birth6 = String(id.prefix(6))
                        tail1  = id.count >= 7 ? String(id.dropFirst(6).prefix(1)) : ""
                    }
                }
                // 항상 vm.identification 은 birth6 + tail1 로 유지됨


                // 추가 정보 (차/자녀 여부)
                Toggle("차 보유 여부", isOn: $vm.hasCar)
                    .padding(.horizontal)
                Toggle("자녀 유무", isOn: $vm.hasChildren)
                    .padding(.horizontal)

                // Toggle들 아래, "회원가입 버튼" 위에 추가
                Group {
                    Text("선택 입력")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // 키(cm)
                    HStack {
                        TextField("키 (cm) — 선택", text: $vm.heightText)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                        Text("cm").foregroundColor(.secondary)
                    }

                    // 몸무게(kg)
                    HStack {
                        TextField("몸무게 (kg) — 선택", text: $vm.weightText)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                        Text("kg").foregroundColor(.secondary)
                    }

                    // 프로필 사진
                    HStack(spacing: 12) {
                        // 로컬 미리보기
                        if let data = vm.profileImageData, let img = UIImage(data: data) {
                            Image(uiImage: img)
                                .resizable().scaledToFill()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .fill(.gray.opacity(0.15))
                                .frame(width: 64, height: 64)
                                .overlay(Image(systemName: "person.crop.circle").font(.title2))
                        }

                        PhotosPicker(selection: $pickerItem, matching: .images) {
                            Text(vm.profileImageData == nil ? "프로필 사진 선택 (선택)" : "사진 변경")
                        }

                        if vm.profileImageData != nil {
                            Button("제거") { vm.profileImageData = nil }
                        }
                    }
                }
                // 회원가입 버튼
                Button {
                    Task { await vm.signUp() } // 회원가입 실행
                } label: {
                    HStack {
                        if vm.isLoading { ProgressView().tint(.white) }
                        Text("회원가입").bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(vm.isLoading ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                // 버튼 비활성화 조건
                .disabled(vm.isLoading
                          || vm.isEmailAvailable == false
                          || vm.isEmailAvailable == nil     // 중복 확인 안했을 때
                          || vm.identification.count != 7)  // 주민번호 7자리가 아닐 때
                .padding(.top, 8)

                Spacer()
            }
            // ⬇️ VStack 마지막 .padding() 바로 아래에 추가
            .onChange(of: pickerItem) { _, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        vm.profileImageData = data    // ✅ VM은 Data만 보관 (UIKit 불필요)
                    }
                }
            }
            .padding()
            // 알림창 표시 (성공/실패 메시지)
            .alert("알림", isPresented: .constant(vm.alertMessage != nil), actions: {
                Button("확인") {
                    vm.alertMessage = nil
                    if vm.didCompleteSignUp {
                        // 회원가입 완료 시 화면 닫기
                        dismiss()
                    }
                }
            }, message: {
                Text(vm.alertMessage ?? "")
            })
        }
    }
}

#Preview {
    SignUpView()
}
