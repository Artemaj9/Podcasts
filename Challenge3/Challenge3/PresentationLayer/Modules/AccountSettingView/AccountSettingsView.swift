//
//  AccountSettingsView.swift
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct AccountSettingsView: View, ItemView {

    // MARK: - Property Wrappers
    @EnvironmentObject var accountSettingsViewModel: AccountSettingsViewModel

    // MARK: - Internal Properties
    var listener: CustomNavigationContainer?

    // MARK: - Private Properties
    private var strings = Localizable.AccountSettings.self
    
    private var titles: [String] = [
        Localizable.AccountSettings.firstName, Localizable.AccountSettings.lastName, Localizable.AccountSettings.email
    ]

    // MARK: - Private Views
    private var datePickerView: some View {
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
    private var genderSelectionRow: some View {
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
    }
    private var birthdaySelectionRow: some View {
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
    }
    private var textFieldsRows: some View {
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
    }
    private var userImageRow: some View {
        VStack {
        ZStack {
            if let image = accountSettingsViewModel.image {
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            } else {
                Image(Images.DefaultView.avatar.rawValue)
                    .overlay(
                        Image(Images.Icon.edit.rawValue)
                            .offset(x: 35, y: 35)
                    )
            }
        }
        .onTapGesture {
            accountSettingsViewModel.showingImagePicker = true
        }
        .frame(width: 150,height: 150)

    .padding([.horizontal, .bottom])
    .onChange(of: accountSettingsViewModel.inputImage) { _ in
        accountSettingsViewModel.loadImage()
    }
    .sheet(isPresented: $accountSettingsViewModel.showingImagePicker) {
        ImagePicker(image: $accountSettingsViewModel.inputImage)
    }
        }
    }
    
    

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center) {
                userImageRow
                textFieldsRows
                birthdaySelectionRow
                genderSelectionRow
                CustomButton(title: strings.saveChanges, buttonType: .filledGray) {
                    listener?.pop()
                }
            }

        }
        .makeCustomNavBar {
            NavigationBars(atView: .accountSetting) {
                listener?.pop()
            }
        }
        .overlay {
            if accountSettingsViewModel.shouldShowDatePicker {
                datePickerView
            }
        }
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

enum SelectedGender: CaseIterable {
    case male
    case female
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView()
            .environmentObject(AccountSettingsViewModel())
    }
}
