import SwiftUI

struct TabletView: View {
    let tablet: Tablet
    @State private var category: NameCategory
    @State private var selected: N?
    @State private var cell: C?

    init(tablet: Tablet, selected: N? = nil) {
        self.tablet = tablet
        _category = State(initialValue: selected?.category ?? .king)
        _selected = State(initialValue: selected ?? tablet.names(.king).first)
    }

    var body: some View {
        ZStack {
            PaperBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    TabletGrid(tablet: tablet, highlight: cell == nil ? selected : nil, selectedCell: cell) { tapped in
                        withAnimation(.easeOut(duration: 0.15)) { cell = (cell == tapped) ? nil : tapped }
                    }
                    .padding(.horizontal, 4)

                    if let cell { CellCard(tablet: tablet, cell: cell) { name in
                        withAnimation { self.cell = nil; category = name.category; selected = name }
                    } }

                    categoryPicker
                    namesList
                    if let selected, cell == nil { NameCard(tablet: tablet, name: selected) }
                }
                .padding(12)
            }
        }
        .navigationTitle(tablet.element.tabletTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { ScriptToggle() }
    }

    private var categoryPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(NameCategory.allCases) { cat in
                    Button {
                        withAnimation { category = cat; cell = nil; selected = tablet.names(cat).first }
                    } label: {
                        Text(cat.short)
                            .font(.footnote.weight(.semibold))
                            .foregroundColor(category == cat ? Parchment.paper : Parchment.ink)
                            .padding(.horizontal, 11).padding(.vertical, 7)
                            .background(Capsule().fill(category == cat ? Parchment.rubric : Parchment.card))
                            .overlay(Capsule().stroke(Parchment.fadedInk.opacity(0.4)))
                    }
                }
            }
        }
    }

    private var namesList: some View {
        let names = tablet.names(category)
        return VStack(alignment: .leading, spacing: 0) {
            Text(category.title).font(.headline).foregroundColor(Parchment.rubric).padding(.bottom, 6)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 104), spacing: 6)], spacing: 6) {
                ForEach(names) { name in
                    Button {
                        withAnimation(.easeOut(duration: 0.2)) { selected = name; cell = nil }
                    } label: {
                        VStack(spacing: 2) {
                            ScriptText(text: name.name, size: 16)
                                .foregroundColor(selected == name ? Parchment.paper : Parchment.ink)
                                .lineLimit(1).minimumScaleFactor(0.6)
                            if let sub = name.sub {
                                Text(Element.allCases[sub].name)
                                    .font(.caption2).foregroundColor(selected == name ? Parchment.paper.opacity(0.8) : Element.allCases[sub].color)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 46)
                        .background(RoundedRectangle(cornerRadius: 5).fill(selected == name ? Parchment.rubric : Parchment.card))
                        .overlay(alignment: .topTrailing) {
                            if name.status == .unverified {
                                Circle().fill(selected == name ? Parchment.paper : Parchment.rubric).frame(width: 6).padding(5)
                            }
                        }
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Parchment.fadedInk.opacity(0.3)))
                    }
                }
            }
        }
        .paperCard()
    }
}

struct NameCard: View {
    let tablet: Tablet
    let name: N

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                Text(name.name).font(.system(size: 30, weight: .bold, design: .serif)).foregroundColor(Parchment.ink)
                Spacer()
                Text(name.name).font(EnochianFont.font(30)).foregroundColor(Parchment.rubric)
            }
            Text([name.category.title, name.subAngleTitle(in: tablet), name.planet?.name].compactMap { $0 }.joined(separator: " · "))
                .font(.subheadline.weight(.semibold)).foregroundColor(Parchment.fadedInk)
            if let prefix = name.prefix {
                Text(L("頭の「\(prefix)」は板の上ではなく、統合の板の「\(tablet.union)」の行から足した文字です。",
                       "The first letter \(prefix) is not on the tablet; it comes from the Tablet of Union line \(tablet.union)."))
                    .font(.footnote).foregroundColor(Parchment.ink)
            }
            if let term = WatchtowerData.term(name.category.glossaryKey) {
                Text(term.body).font(.footnote).foregroundColor(Parchment.ink)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Divider()
            Label(name.status.label, systemImage: name.status == .unverified ? "exclamationmark.circle" : "checkmark.seal")
                .font(.footnote.weight(.semibold)).foregroundColor(name.status.color)
            if !name.sources.isEmpty {
                Text(L("同じ綴り：", "Same spelling: ") + name.sources.joined(separator: "、"))
                    .font(.caption).foregroundColor(Parchment.fadedInk)
            }
            ForEach(name.variants, id: \.self) { v in
                Text("\(v.source)：\(v.text)").font(.caption).foregroundColor(Parchment.rubric)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .paperCard()
    }
}

struct CellCard: View {
    let tablet: Tablet
    let cell: C
    let open: (N) -> Void

    var body: some View {
        let letter = String(tablet.letter(cell))
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 14) {
                Text(letter).font(.system(size: 38, weight: .bold, design: .serif)).foregroundColor(Parchment.ink)
                Text(letter).font(EnochianFont.font(38)).foregroundColor(Parchment.rubric)
                VStack(alignment: .leading) {
                    Text(L("\(cell.r + 1)行 \(cell.c + 1)列", "Row \(cell.r + 1), column \(cell.c + 1)"))
                        .font(.subheadline.weight(.semibold)).foregroundColor(Parchment.ink)
                    Text(place).font(.caption).foregroundColor(Parchment.fadedInk)
                }
            }
            if let note = tablet.note(cell) {
                Text(L("このマスは資料によって文字が違います", "Sources read this square differently"))
                    .font(.footnote.weight(.semibold)).foregroundColor(Parchment.rubric)
                ForEach(note.readings, id: \.self) { v in
                    Text("\(v.source)：\(v.text)").font(.caption).foregroundColor(Parchment.ink)
                }
            }
            let through = tablet.names(through: cell)
            if !through.isEmpty {
                Text(L("このマスを通る名前", "Names through this square"))
                    .font(.footnote.weight(.semibold)).foregroundColor(Parchment.fadedInk)
                FlowNames(names: through, open: open)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .paperCard()
    }

    private var place: String {
        if let sub = Tablet.subAngle(of: cell) {
            return L("「\(Element.allCases[sub].name)」の小角", "\(Element.allCases[sub].name) lesser angle")
                + (Tablet.isCalvaryCross(cell) ? L("・カルバリー十字", " · Calvary Cross") : "")
        }
        return L("大中央十字", "Great Central Cross")
    }
}

struct FlowNames: View {
    let names: [N]
    let open: (N) -> Void

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 96), spacing: 6)], alignment: .leading, spacing: 6) {
            ForEach(names) { n in
                Button { open(n) } label: {
                    VStack(spacing: 1) {
                        Text(n.name).font(.system(size: 14, weight: .semibold, design: .serif)).foregroundColor(Parchment.ink)
                        Text(n.category.short).font(.system(size: 9)).foregroundColor(Parchment.fadedInk)
                    }
                    .frame(maxWidth: .infinity, minHeight: 38)
                    .background(RoundedRectangle(cornerRadius: 5).fill(Parchment.paper))
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Parchment.fadedInk.opacity(0.3)))
                }
            }
        }
    }
}

struct ScriptToggle: View {
    @AppStorage("showEnochian") private var enochian = false

    var body: some View {
        Button {
            enochian.toggle()
        } label: {
            Text("ABC")
                .font(enochian ? .footnote.weight(.bold) : EnochianFont.font(17))
                .foregroundColor(Parchment.rubric)
        }
        .accessibilityLabel(L("ローマ字とエノク文字を切り替え", "Switch between Latin and Enochian script"))
    }
}
