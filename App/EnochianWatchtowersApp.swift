import SwiftUI

@main
struct EnochianWatchtowersApp: App {
    init() {
        EnochianFont.register()
        if Self.screenshotIndex == 3 { UserDefaults.standard.set(true, forKey: "showEnochian") }
        else if Self.screenshotIndex != nil { UserDefaults.standard.set(false, forKey: "showEnochian") }
    }

    var body: some Scene {
        WindowGroup {
            ContentView(screenshotIndex: Self.screenshotIndex)
                .preferredColorScheme(.light)
                .tint(Parchment.rubric)
        }
    }

    /// SCREENSHOT_MODE_1..3 launch arguments open a prepared screen.
    static var screenshotIndex: Int? {
        for i in 1...3 where CommandLine.arguments.contains("SCREENSHOT_MODE_\(i)") { return i }
        return nil
    }
}

struct ContentView: View {
    let screenshotIndex: Int?
    @State private var tab = 0

    var body: some View {
        TabView(selection: $tab) {
            Group {
                switch screenshotIndex {
                case 1:
                    NavigationStack { TabletView(tablet: WatchtowerData.tablet(.air)) }
                case 3:
                    NavigationStack {
                        TabletView(tablet: WatchtowerData.tablet(.water),
                                   selected: WatchtowerData.tablet(.water).names(.calling).first)
                    }
                default:
                    GreatTableView()
                }
            }
            .tabItem { Label(L("大テーブル", "Great Table"), systemImage: "square.grid.3x3") }
            .tag(0)
            NamesView()
                .tabItem { Label(L("名簿", "Names"), systemImage: "list.bullet.rectangle") }
                .tag(1)
            GlossaryView()
                .tabItem { Label(L("用語", "Terms"), systemImage: "book.closed") }
                .tag(2)
        }
    }
}
