import SwiftUI

/// A square of a 12 x 13 tablet (row 0 at the top, column 0 at the left).
struct C: Hashable {
    let r: Int
    let c: Int
    init(_ r: Int, _ c: Int) { self.r = r; self.c = c }
}

/// One source's reading: who prints it and what they print.
struct V: Hashable {
    let source: String
    let text: String
    init(_ source: String, _ text: String) { self.source = source; self.text = text }
}

enum Element: String, CaseIterable, Identifiable {
    case air, water, earth, fire
    var id: String { rawValue }

    var name: String { L(["風", "水", "地", "火"][index], ["Air", "Water", "Earth", "Fire"][index]) }
    var direction: String { L(["東", "西", "北", "南"][index], ["East", "West", "North", "South"][index]) }
    var tabletTitle: String { L("\(direction)の物見の塔（\(name)）", "Watchtower of the \(direction) (\(name))") }
    var index: Int { Element.allCases.firstIndex(of: self)! }

    var color: Color {
        switch self {
        case .air: return Color(red: 0.85, green: 0.66, blue: 0.13)
        case .water: return Color(red: 0.16, green: 0.38, blue: 0.66)
        case .earth: return Color(red: 0.33, green: 0.42, blue: 0.20)
        case .fire: return Color(red: 0.72, green: 0.18, blue: 0.13)
        }
    }
}

enum NameCategory: String, CaseIterable, Identifiable {
    case holyName, king, senior, calling, commanding, kerubicRuler, kerubic, servient, servientPrefixed
    var id: String { rawValue }

    var title: String {
        switch self {
        case .holyName: return L("三つの聖なる名", "Three Holy Names")
        case .king: return L("大いなる王", "Great King")
        case .senior: return L("六人の長老", "Six Seniors")
        case .calling: return L("呼ぶ名（縦）", "Calling Name")
        case .commanding: return L("命じる名（横）", "Commanding Name")
        case .kerubicRuler: return L("ケルブを統べる名", "Kerubic Ruler")
        case .kerubic: return L("ケルブの天使", "Kerubic Angels")
        case .servient: return L("仕える天使", "Servient Angels")
        case .servientPrefixed: return L("仕える天使（頭文字つき）", "Servient, Prefixed")
        }
    }

    var short: String {
        switch self {
        case .holyName: return L("神の名", "God Names")
        case .king: return L("王", "King")
        case .senior: return L("長老", "Seniors")
        case .calling: return L("呼ぶ名", "Calling")
        case .commanding: return L("命じる名", "Commanding")
        case .kerubicRuler: return L("統べる名", "Ruler")
        case .kerubic: return L("ケルブ", "Kerubic")
        case .servient: return L("仕える天使", "Servient")
        case .servientPrefixed: return L("頭文字つき", "Prefixed")
        }
    }

    var glossaryKey: String {
        switch self {
        case .holyName: return "threeHolyNames"
        case .king: return "greatKing"
        case .senior: return "sixSeniors"
        case .calling: return "callingName"
        case .commanding: return "commandingName"
        case .kerubicRuler: return "kerubicRulingName"
        case .kerubic: return "kerubicAngels"
        case .servient: return "servientAngels"
        case .servientPrefixed: return "servientPrefixed"
        }
    }

    /// Belongs to one of the four lesser angles rather than the whole tablet.
    var isSubAngle: Bool { ![.holyName, .king, .senior].contains(self) }
}

enum Status {
    case verified, supported, unverified

    var label: String {
        switch self {
        case .verified: return L("複数の資料で一致", "Agreed by 2+ sources")
        case .supported: return L("1つの資料で確認", "One source")
        case .unverified: return L("資料により綴りが違う", "Spelling varies")
        }
    }

    var color: Color {
        switch self {
        case .verified: return Parchment.verdigris
        case .supported: return Parchment.ochre
        case .unverified: return Parchment.rubric
        }
    }
}

enum Planet: String {
    case mars, jupiter, luna, venus, mercury, saturn

    var name: String {
        switch self {
        case .mars: return L("♂ 火星", "♂ Mars")
        case .jupiter: return L("♃ 木星", "♃ Jupiter")
        case .luna: return L("☽ 月", "☽ Moon")
        case .venus: return L("♀ 金星", "♀ Venus")
        case .mercury: return L("☿ 水星", "☿ Mercury")
        case .saturn: return L("♄ 土星", "♄ Saturn")
        }
    }
}

/// A name read from the tablet.
struct N: Identifiable, Hashable {
    let category: NameCategory
    let sub: Int?
    let name: String
    let cells: [C]
    let status: Status
    let sources: [String]
    let variants: [V]
    var planet: Planet? = nil
    /// Letter added from the Tablet of Union (not on the tablet itself).
    var prefix: String? = nil

    init(_ category: NameCategory, sub: Int?, name: String, cells: [C], status: Status,
         sources: [String], variants: [V], planet: Planet? = nil, prefix: String? = nil) {
        self.category = category; self.sub = sub; self.name = name; self.cells = cells
        self.status = status; self.sources = sources; self.variants = variants
        self.planet = planet; self.prefix = prefix
    }

    var id: String { "\(category.rawValue)-\(sub ?? -1)-\(name)-\(cells.first.map { "\($0.r).\($0.c)" } ?? "")" }

    func subAngleTitle(in tablet: Tablet) -> String? {
        guard let sub else { return nil }
        let e = Element.allCases[sub]
        return L("\(tablet.element.name)の塔の「\(e.name)」の小角", "\(e.name) of \(tablet.element.name)")
    }
}

struct CellNote: Hashable {
    let cell: C
    let readings: [V]
}

struct Tablet: Identifiable {
    let element: Element
    let union: String
    let rows: [String]
    let notes: [CellNote]
    let names: [N]
    var id: String { element.rawValue }

    func letter(_ cell: C) -> Character {
        let row = Array(rows[cell.r])
        return row[cell.c]
    }

    func note(_ cell: C) -> CellNote? { notes.first { $0.cell == cell } }

    func names(through cell: C) -> [N] { names.filter { $0.cells.contains(cell) } }

    func names(_ category: NameCategory) -> [N] { names.filter { $0.category == category } }

    /// Which lesser angle (0 = top-left ... 3 = bottom-right) a square belongs to; nil on the Great Cross.
    static func subAngle(of cell: C) -> Int? {
        if cell.r == 6 || cell.c == 5 || cell.c == 6 { return nil }
        return (cell.r < 6 ? 0 : 2) + (cell.c < 5 ? 0 : 1)
    }

    static func isGreatCross(_ cell: C) -> Bool { subAngle(of: cell) == nil }

    /// The Calvary Cross of a lesser angle: its third column and second row.
    static func isCalvaryCross(_ cell: C) -> Bool {
        guard subAngle(of: cell) != nil else { return false }
        let r0 = cell.r < 6 ? 0 : 7
        let c0 = cell.c < 5 ? 0 : 7
        return cell.c == c0 + 2 || cell.r == r0 + 1
    }
}

struct GlossaryTerm: Identifiable {
    let key: String
    let term: String
    let termJa: String
    let en: String
    let ja: String
    var id: String { key }
    var title: String { L(termJa, term) }
    var body: String { L(ja, en) }
}

enum WatchtowerData {
    static func tablet(_ element: Element) -> Tablet { tablets[element.index] }
    static func term(_ key: String) -> GlossaryTerm? { glossary.first { $0.key == key } }
}

/// Japanese when the device prefers Japanese, otherwise English.
func L(_ ja: String, _ en: String) -> String {
    (Locale.preferredLanguages.first ?? "en").hasPrefix("ja") ? ja : en
}
