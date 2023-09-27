//
//  AccountSettingsView.swift
//

import SwiftUI

struct AccountSettingsView: View, ItemView {

    // MARK: - Property Wrappers
    @EnvironmentObject var accountSettingsViewModel: AccountSettingsViewModel

    // MARK: - Internal Properties
    var listener: CustomNavigationContainer?

    // MARK: - Private Properties
    private var titles: [String] = [
        "First name", "Last name", "E-mail"
    ]
    private var strings = Localizable.AccountSettings.self

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
                    .fill(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Pallete.Blue.forAccent, lineWidth: 1)
                    )
            )
            .overlay {
                HStack {
                    Spacer()
                    Image("calendar")
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
                backgroundColor: .white
            )
        }
    }
    private var userImageRow: some View {
        Image(Images.DefaultView.avatar.rawValue)
            .overlay(
                Image(Images.Icon.edit.rawValue)
                    .offset(x: 35, y: 35)
            )
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center) {
                userImageRow
                textFieldsRows
                birthdaySelectionRow
                genderSelectionRow
            }

        }
        .safeAreaInset(edge: .bottom) {
            CustomButton(title: strings.saveChanges, buttonType: .filledGray) {

            }
            .background(.white)
        }
        .makeCustomNavBar {
            NavigationBars(atView: .accountSetting) {

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
                HStack {
                    Image(selectedGender == gender ? Images.Icon.checkFill.rawValue : Images.Icon.check.rawValue)
                    Spacer()
                    Text(gender.rawValue)
                        .font(.system(size: 16, weight: .semibold))
                    Spacer()
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .frame(width: 156)
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
    case male = "Male"
    case fermale = "Fermale"
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView()
    }
}
