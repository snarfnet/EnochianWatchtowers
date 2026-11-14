import SwiftUI

/// The four tablets in their Golden Dawn places around the Black Cross.
struct GreatTableView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                PaperBackground()
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        Text(L("1584年6月25日、クラクフ。エドワード・ケリーが水晶の中に見た文字を、ジョン・ディーが一マスずつ書き取りました。4枚の板に、天使たちの名前が縦・横・渦巻きに隠れています。",
                               "Cracow, 25 June 1584. Edward Kelley saw letters in the crystal and John Dee wrote them down square by square. The names of angels are hidden in the four tablets: down, across and in a whirl."))
                            .font(.subheadline).foregroundColor(Parchment.ink)
                            .fixedSize(horizontal: false, vertical: true)

                        greatTable

                        VStack(alignment: .leading, spacing: 10) {
                            Text(L("統合の板（黒い十字の文字）", "Tablet of Union (letters of the Black Cross)"))
                                .font(.headline).foregroundColor(Parchment.rubric)
                            HStack(alignment: .top, spacing: 14) {
                                UnionGrid(side: 34)
                                if let term = WatchtowerData.term("tabletOfUnion") {
                                    Text(term.body).font(.footnote).foregroundColor(Parchment.ink)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                        .paperCard()

                        ForEach(Element.allCases) { el in
                            NavigationLink(value: el) { tabletRow(el) }
                        }
                    }
                    .padding(14)
                }
            }
            .navigationTitle(L("大テーブル", "The Great Table"))
            .navigationDestination(for: Element.self) { TabletView(tablet: WatchtowerData.tablet($0)) }
            .navigationDestination(for: N.self) { name in
                if let t = WatchtowerData.tablets.first(where: { $0.names.contains(name) }) {
                    TabletView(tablet: t, selected: name)
                }
            }
            .toolbar { ScriptToggle() }
        }
    }

    private var greatTable: some View {
        VStack(spacing: 6) {
            HStack(spacing: 6) { mini(.air); mini(.water) }
            HStack(spacing: 6) { mini(.earth); mini(.fire) }
        }
        .padding(6)
        .background(Parchment.crossInk)
        .overlay(Rectangle().stroke(Parchment.ink, lineWidth: 2))
    }

    private func mini(_ el: Element) -> some View {
        NavigationLink(value: el) {
            ZStack(alignment: .bottom) {
                TabletGrid(tablet: WatchtowerData.tablet(el), compact: true)
                Text(el.name + "・" + el.direction)
                    .font(.caption.weight(.bold)).foregroundColor(.white)
                    .padding(.horizontal, 8).padding(.vertical, 3)
                    .background(Capsule().fill(el.color))
                    .padding(4)
            }
        }
    }

    private func tabletRow(_ el: Element) -> some View {
        let t = WatchtowerData.tablet(el)
        let king = t.names(.king).first?.name ?? ""
        let holy = t.names(.holyName).map(\.name).joined(separator: " ")
        return HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 4).fill(el.color).frame(width: 8)
            VStack(alignment: .leading, spacing: 3) {
                Text(el.tabletTitle).font(.headline).foregroundColor(Parchment.ink)
                Text(L("神の名 ", "Names of God ") + holy).font(.footnote).foregroundColor(Parchment.fadedInk)
                Text(L("王 ", "King ") + king).font(.footnote).foregroundColor(Parchment.fadedInk)
            }
            Spacer()
            Image(systemName: "chevron.right").foregroundColor(Parchment.fadedInk)
        }
        .paperCard()
    }
}
