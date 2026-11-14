import SwiftUI
import CoreText

/// Old paper, iron-gall ink and red rubrics.
enum Parchment {
    static let paper = Color(red: 0.95, green: 0.91, blue: 0.82)
    static let paperDark = Color(red: 0.89, green: 0.83, blue: 0.70)
    static let card = Color(red: 0.98, green: 0.95, blue: 0.88)
    static let ink = Color(red: 0.20, green: 0.14, blue: 0.09)
    static let fadedInk = Color(red: 0.45, green: 0.37, blue: 0.29)
    static let rubric = Color(red: 0.66, green: 0.14, blue: 0.10)
    static let ochre = Color(red: 0.70, green: 0.50, blue: 0.13)
    static let verdigris = Color(red: 0.18, green: 0.47, blue: 0.40)
    static let crossInk = Color(red: 0.12, green: 0.10, blue: 0.08)
}

struct PaperBackground: View {
    var body: some View {
        ZStack {
            Parchment.paper
            RadialGradient(colors: [.clear, Parchment.paperDark.opacity(0.8)],
                           center: .center, startRadius: 200, endRadius: 700)
        }
        .ignoresSafeArea()
    }
}

extension View {
    func paperCard() -> some View {
        padding(14)
            .background(RoundedRectangle(cornerRadius: 6).fill(Parchment.card))
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Parchment.fadedInk.opacity(0.35), lineWidth: 1))
    }
}

enum EnochianFont {
    static let name = "EnochianDee"
    private static var registered = false

    static func register() {
        guard !registered else { return }
        registered = true
        if let url = Bundle.main.url(forResource: name, withExtension: "ttf") {
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }

    static func font(_ size: CGFloat) -> Font {
        register()
        return .custom(name, fixedSize: size)
    }
}

/// Shows a name or letter in Latin capitals or in Dee's script.
struct ScriptText: View {
    let text: String
    let size: CGFloat
    @AppStorage("showEnochian") private var enochian = false

    var body: some View {
        Text(text)
            .font(enochian ? EnochianFont.font(size * 1.05) : .system(size: size, weight: .semibold, design: .serif))
    }
}
