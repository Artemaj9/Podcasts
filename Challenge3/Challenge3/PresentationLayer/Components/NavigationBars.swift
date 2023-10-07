//
//  NavigationBars.swift
//

import SwiftUI

struct NavigationBars: View {

    var atView: NavigationBarPlacement
    var screenTitle: String?
    var leadingButtonAction: () -> Void
    var trailingButtonAction: (() -> Void)?

    private var currentText: String {
        switch atView {
        case .signUp:
            return "Sign Up"
        case .channel:
            return "Channel"
        case .nowPlaying:
            return "Now playing"
        case .search:
            return "Search"
        case .playlist:
            return "Playlist"
        case .accountSetting:
            return "Profile"
        case .createPlaylist:
            return "Create Playlist"
        case .favorites:
            return self.screenTitle ?? "Favorites"
        case .chageCover:
            return "Change Cover"
        }
    }

    private var leadingContentView: some View {
        Group {
            switch atView {
            case .signUp, .channel, .nowPlaying, .accountSetting, .createPlaylist, .chageCover:
                BackButton(isReverse: false, padding: 0) {
                    leadingButtonAction()
                }

            case .favorites:
                if let screenTitle {
                    BackButton(isReverse: false, padding: 0) {
                        leadingButtonAction()
                    }
                }

            default:
                EmptyView()
            }
        }
    }

    private var trailingContentView: some View {
        Group {
            switch atView {
            case .nowPlaying:
                Button {
                    if let trailingButtonAction {
                        trailingButtonAction()
                    }
                } label: {
                    Image(Images.Icon.playlist.rawValue)
                }

            case .playlist, .createPlaylist:
                Button {
                    if let trailingButtonAction {
                        trailingButtonAction()
                    }
                } label: {
                    Image(Images.Icon.horizontalIcon.rawValue)
                        .foregroundColor(.black)
                }

            default:
                EmptyView()
            }
        }
    }

    var body: some View {
        HStack {
            Spacer()
            Text(currentText)
                .font(.system(size: 16, weight: .bold))
            Spacer()
        }
        .overlay {
            HStack {
                leadingContentView
                Spacer()
                trailingContentView
            }.padding(.horizontal, 32)
        }
    }
}

struct NavigationBars_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            Image("image2")
        }
        .makeCustomNavBar {
            NavigationBars(atView: .chageCover) {
            }
        }
    }
}

enum NavigationBarPlacement {
    case signUp, channel, nowPlaying, search, playlist, accountSetting, createPlaylist, favorites, chageCover
}
