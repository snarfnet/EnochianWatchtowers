import SwiftUI

/// Every name on the four tablets, searchable.
struct NamesView: View {
    @State private var query = ""
    @State private var category: NameCategory? = nil

    private func names(in tablet: Tablet) -> [N] {
        let q = query.trimmingCharacters(in: .whitespaces).uppercased()
        return tablet.names.filter { n in
            (category == nil || n.category == category) &&
            (q.isEmpty || n.name.contains(q) || n.variants.contains { $0.text.uppercased().contains(q) })
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Picker(L("種類", "Kind"), selection: $category) {
                        Text(L("すべて", "All")).tag(NameCategory?.none)
                        ForEach(NameCategory.allCases) { Text($0.title).tag(NameCategory?.some($0)) }
                    }
                    .foregroundColor(Parchment.ink)
                }
                .listRowBackground(Parchment.card)

                ForEach(WatchtowerData.tablets) { tablet in
                    let list = names(in: tablet)
                    if !list.isEmpty {
                        Section {
                            ForEach(list) { n in
                                NavigationLink(value: n) { row(n, tablet: tablet) }
                                    .listRowBackground(Parchment.card)
                            }
                        } header: {
                            Text(tablet.element.tabletTitle)
                                .font(.footnote.weight(.bold)).foregroundColor(tablet.element.color).textCase(nil)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(PaperBackground())
            .searchable(text: $query, prompt: L("名前で探す（例：BATAIVAH）", "Search names (e.g. BATAIVAH)"))
            .navigationTitle(L("天使の名簿", "Names"))
            .navigationDestination(for: N.self) { name in
                if let t = WatchtowerData.tablets.first(where: { $0.names.contains(name) }) {
                    TabletView(tablet: t, selected: name)
                }
            }
            .toolbar { ScriptToggle() }
        }
    }

    private func row(_ n: N, tablet: Tablet) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                ScriptText(text: n.name, size: 17).foregroundColor(Parchment.ink)
                Text([n.category.title, n.subAngleTitle(in: tablet), n.planet?.name].compactMap { $0 }.joined(separator: " · "))
                    .font(.caption).foregroundColor(Parchment.fadedInk)
            }
            Spacer()
            if n.status == .unverified {
                Text(L("異読あり", "Variants")).font(.caption2.weight(.bold)).foregroundColor(Parchment.rubric)
            }
        }
    }
}
