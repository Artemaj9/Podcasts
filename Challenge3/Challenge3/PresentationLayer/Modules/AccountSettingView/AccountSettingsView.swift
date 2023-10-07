//
//  AccountSettingsView.swift
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import Kingfisher

struct AccountSettingsView: View, ItemView {
    
    // MARK: - Property Wrappers
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var accountSettingsViewModel: AccountSettingsViewModel
    
    // MARK: - Internal Properties
    var listener: CustomNavigationContainer?
    
    // MARK: - Private Properties
    
    private var strings = Localizable.AccountSettings.self
    
    private var titles: [String] = [
        Localizable.AccountSettings.firstName, Localizable.AccountSettings.lastName, Localizable.AccountSettings.email
    ]
    
    
    // MARK: - Private Views
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center) {
                VStack {
                    ZStack {
                        if let image = accountSettingsViewModel.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                        } else if  let urlString = userManager.imageUrl, let url = URL(string: urlString), url.scheme != nil {
                            KFImage(url)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                        } else {
                            Image(Images.DefaultView.avatar.rawValue)
                                .overlay(
                                    Image(Images.Icon.edit.rawValue)
                                        .offset(x: 35, y: 35)
                                )
                        }
                    }
                    .task {
                        userManager.searchImage()
                    }
                    .onTapGesture {
                        withAnimation {
                            accountSettingsViewModel.isChoosingCameraMode.toggle()
                        }
                    }
                    .frame(width: 150, height: 150)
                    .padding([.horizontal, .bottom])
                    .alert(accountSettingsViewModel.warningMessage, isPresented: $accountSettingsViewModel.isWarningPresented) {
                        Button("Open settings") {
                            accountSettingsViewModel.openSettings()
                        }
                        
                        Button("OK") {}
                    }
                    .sheet(isPresented: $accountSettingsViewModel.isShowingImagePicker) {
                        ImagePicker(selectedImage: $accountSettingsViewModel.image, sourceType: accountSettingsViewModel.cameraMode)
                    }
                    .onChange(of: accountSettingsViewModel.image) { image in
                        withAnimation {
                            accountSettingsViewModel.isChoosingCameraMode = false
                        }
                    }
                }
                
                ForEach(titles.indices, id: \.self) { index in
                    LoginTextField(
                        inputText: $accountSettingsViewModel.texts[index],
                        title: titles[index],
                        placeHolder: titles[index],
                        withHideOption: false,
                        withBorder: true,
                        cornerRadius: 24,
                        backgroundColor: Pallete.BlackWhite.white
                    )
                }
                VStack {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text(strings.dateOfBirth)
                                .padding(.leading)
                                .foregroundColor(Pallete.Gray.forText)
                            Spacer()
                        }
                    }
                    HStack {
                        Text(accountSettingsViewModel.selectedBirthday, style: .date)
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Pallete.BlackWhite.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Pallete.Blue.forAccent, lineWidth: 1)
                            )
                    )
                    .overlay {
                        HStack {
                            Spacer()
                            Image(Images.Icon.calendar.rawValue)
                                .padding()
                                .onTapGesture {
                                    withAnimation {
                                        self.accountSettingsViewModel.shouldShowDatePicker = true
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(strings.gender)
                            .padding(.leading)
                            .foregroundColor(Pallete.Gray.forText)
                        Spacer()
                    }
                    
                    GenderPicker(selectedGender: $accountSettingsViewModel.selectedGender)
                        .padding([.top, .horizontal])
                }
                
                CustomButton(title: strings.saveChanges, buttonType: .filledGray) {
                    userManager.persistImageToStorage(image: accountSettingsViewModel.image)
                    
                    userManager.storeUserInformation (
                        dob: accountSettingsViewModel.selectedBirthday,
                        gender: accountSettingsViewModel.selectedGender
                    )
                    
                    accountSettingsViewModel.saveUserData()
                    
                    listener?.pop()
                }
            }
        }
        .blur(radius: accountSettingsViewModel.isChoosingCameraMode ? 5 : 0)
        .makeCustomNavBar {
            NavigationBars(atView: .accountSetting) {
                listener?.pop()
            }
        }
        .overlay {
            if accountSettingsViewModel.shouldShowDatePicker {
                ZStack {
                    Color.black
                        .opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                accountSettingsViewModel.shouldShowDatePicker = false
                            }
                        }
                    
                    DatePicker("", selection: $accountSettingsViewModel.selectedBirthday, in: ...Date(), displayedComponents: .date)
                        .padding()
                        .datePickerStyle(.graphical)
                        .background {
                            Color.white.cornerRadius(10)
                        }
                        .padding()
                }
            }
        }
        .overlay {
            if accountSettingsViewModel.isChoosingCameraMode {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                accountSettingsViewModel.isChoosingCameraMode = false
                            }
                        }
                    
                    CustomAlert { index in
                        switch index {
                        case 0:
                            accountSettingsViewModel.presentCamera()
                        case 1:
                            accountSettingsViewModel.presentLibraryPicker()
                        case 2:
                            accountSettingsViewModel.image = nil
                            userManager.imageUrl = nil
                        default:
                            break
                        }
                    }
                    .padding()
                    .background(Pallete.BlackWhite.white.cornerRadius(12))
                    .padding()
                }
            }
        }
        .onAppear{
            changedTextFields()
        }
    }
    
    func changedTextFields() {
        accountSettingsViewModel.texts[0] = userManager.getFirstName()
        accountSettingsViewModel.texts[1] = userManager.getLastName()
        accountSettingsViewModel.texts[2] = userManager.getEmail()
    }
}

// MARK: - Components
struct GenderPicker: View {
    
    // MARK: - Property Wrappers
    @Binding var selectedGender: SelectedGender
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 16) {
            ForEach(SelectedGender.allCases, id: \.hashValue) { gender in
                var genderText: String {
                    switch gender {
                    case .male:
                        return Localizable.AccountSettings.male
                    case .female:
                        return Localizable.AccountSettings.female
                    }
                }
                
                HStack {
                    Image(selectedGender == gender ? Images.Icon.checkFill.rawValue : Images.Icon.check.rawValue)
                    
                    Spacer()
                    
                    Text(genderText)
                        .font(.system(size: 16, weight: .semibold))
                    
                    Spacer()
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Pallete.Blue.forAccent, lineWidth: 1)
                        )
                }
                .onTapGesture {
                    withAnimation {
                        selectedGender = gender
                    }
                }
                if gender == .male {
                    Spacer()
                }
            }
        }
    }
}

enum SelectedGender: String, CaseIterable {
    case male
    case female
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView()
            .environmentObject(AccountSettingsViewModel())
    }
}
