import SwiftUI

struct GlossaryView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                PaperBackground()
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(WatchtowerData.glossary) { term in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(term.title).font(.headline).foregroundColor(Parchment.rubric)
                                if L("ja", "en") == "ja" {
                                    Text(term.term).font(.caption.italic()).foregroundColor(Parchment.fadedInk)
                                }
                                Text(term.body).font(.subheadline).foregroundColor(Parchment.ink)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .paperCard()
                        }
                        sources
                    }
                    .padding(14)
                }
            }
            .navigationTitle(L("用語と出典", "Terms & Sources"))
        }
    }

    private var sources: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(L("文字と名前の出典", "Where the letters and names come from"))
                .font(.headline).foregroundColor(Parchment.rubric)
            Text(L("板の文字は1587年の改訂テーブル（大英図書館 Sloane MS 3191、J. H. Peterson の翻刻）をもとにし、ゴールデン・ドーンの方式で名前を読み出しています。名前ごとに、同じ綴りを載せている資料と、違う綴りを載せている資料を示しました。資料によって文字が違うマスには赤い点がついています。",
                   "The tablet letters follow the 1587 reformed table (British Library Sloane MS 3191, as transcribed by J. H. Peterson), and the names are read out by the Golden Dawn method. Each name lists the sources that print the same spelling and those that print another. Squares that the sources read differently carry a red dot."))
                .font(.footnote).foregroundColor(Parchment.ink)
                .fixedSize(horizontal: false, vertical: true)
            ForEach([
                "John Dee, Sloane MS 3191 (Tabula bonorum angelorum invocationes), ed. J. H. Peterson",
                "Meric Casaubon (ed.), A True & Faithful Relation (London, 1659)",
                "Golden Dawn, Book H (Clavicula Tabularum Enochi)",
                "Aleister Crowley, Liber Chanokh, The Equinox I (7-8), 1912",
                "kondor.de, The Four Watchtowers",
                "Benjamin Rowe, Enochian Temples (1992); The Book of the Seniors",
            ], id: \.self) { Text("・" + $0).font(.caption).foregroundColor(Parchment.fadedInk) }
            Text(L("エノク文字の字形は、ディー自身の1583年の文字表（Sloane MS 3188）からなぞったものです。",
                   "The Enochian glyphs are traced from Dee's own 1583 table (Sloane MS 3188)."))
                .font(.caption).foregroundColor(Parchment.fadedInk)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .paperCard()
    }
}
