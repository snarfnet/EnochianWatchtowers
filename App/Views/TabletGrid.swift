import SwiftUI

/// A 12 x 13 tablet. Lesser angles are tinted with their element, the Great Cross is inked dark,
/// and the squares of a selected name are numbered in reading order.
struct TabletGrid: View {
    let tablet: Tablet
    var highlight: N? = nil
    var selectedCell: C? = nil
    var compact = false
    var onTap: ((C) -> Void)? = nil
    @AppStorage("showEnochian") private var enochian = false

    var body: some View {
        GeometryReader { geo in
            let side = min(geo.size.width / 12, geo.size.height / 13)
            VStack(spacing: 0) {
                ForEach(0..<13, id: \.self) { r in
                    HStack(spacing: 0) {
                        ForEach(0..<12, id: \.self) { c in
                            square(C(r, c), side: side)
                        }
                    }
                }
            }
            .frame(width: side * 12, height: side * 13)
            .overlay(Rectangle().stroke(Parchment.ink, lineWidth: compact ? 1 : 2))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .aspectRatio(12.0 / 13.0, contentMode: .fit)
        // Without a tap handler, let taps reach an enclosing NavigationLink.
        .allowsHitTesting(onTap != nil)
    }

    @ViewBuilder
    private func square(_ cell: C, side: CGFloat) -> some View {
        let order = highlight?.cells.firstIndex(of: cell)
        let isCross = Tablet.isGreatCross(cell)
        let letter = String(tablet.letter(cell))
        ZStack {
            Rectangle().fill(Parchment.paper)   // the tints are translucent; keep them light on any background
            Rectangle().fill(fill(cell, isCross: isCross, highlighted: order != nil))
            if !compact || side > 9 {
                Text(letter)
                    .font(enochian && !compact ? EnochianFont.font(side * 0.5)
                          : .system(size: side * 0.52, weight: isCross ? .bold : .medium, design: .serif))
                    .foregroundColor(order != nil ? .white : (isCross ? Parchment.paper : Parchment.ink))
                    .minimumScaleFactor(0.5)
            }
            if let order, !compact, highlight!.cells.count > 1 {
                Text("\(order + 1)")
                    .font(.system(size: max(side * 0.22, 7), weight: .bold))
                    .foregroundColor(.white.opacity(0.9))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(2)
            }
            if !compact, tablet.note(cell) != nil {
                Circle().fill(Parchment.rubric).frame(width: max(side * 0.13, 3))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(2)
            }
        }
        .frame(width: side, height: side)
        .overlay(Rectangle().stroke(Parchment.ink.opacity(compact ? 0.15 : 0.3), lineWidth: 0.5))
        .overlay(Rectangle().stroke(Parchment.rubric, lineWidth: selectedCell == cell ? 3 : 0))
        .contentShape(Rectangle())
        .onTapGesture { onTap?(cell) }
    }

    private func fill(_ cell: C, isCross: Bool, highlighted: Bool) -> Color {
        if highlighted { return Parchment.rubric }
        if isCross { return Parchment.crossInk.opacity(0.88) }
        let sub = Element.allCases[Tablet.subAngle(of: cell)!]
        return sub.color.opacity(Tablet.isCalvaryCross(cell) ? 0.38 : 0.16)
    }
}

/// The Tablet of Union (Black Cross letters), 4 rows of 5.
struct UnionGrid: View {
    var side: CGFloat = 34
    @AppStorage("showEnochian") private var enochian = false

    private let rows = ["EXARP", "HCOMA", "NANTA", "BITOM"]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(rows.indices, id: \.self) { r in
                HStack(spacing: 0) {
                    ForEach(Array(rows[r].enumerated()), id: \.offset) { c, ch in
                        Text(String(ch))
                            .font(enochian ? EnochianFont.font(side * 0.5) : .system(size: side * 0.5, weight: .bold, design: .serif))
                            .foregroundColor(Parchment.paper)
                            .frame(width: side, height: side)
                            .background(c == 0 ? Parchment.crossInk : Element.allCases[r].color.opacity(0.85))
                            .overlay(Rectangle().stroke(Parchment.paper.opacity(0.4), lineWidth: 0.5))
                    }
                }
            }
        }
        .overlay(Rectangle().stroke(Parchment.ink, lineWidth: 2))
    }
}
