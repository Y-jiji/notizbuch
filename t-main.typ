#import "t-tag.typ": *
#import "t-summary.typ": *
#import "t-attributes.typ": *
#import "t-cover.typ": *
#import "t-algorithm.typ": *
#import "t-commute.typ": *
#import "t-math.typ": *

#let with-head-setup(supplement: [Chapter], doc) = [
    // use strong font for reference
    #show ref: it => {
        if it.element == none [#strong[#it]]
        else [ #strong[$strong(angle.l)$#it$strong(angle.r)$] ]
    }
    // change enumeration layout
    #set enum(numbering: n => [#h(0.25em) #str(n) .])
    // change bullet list layout
    #set list(marker: [#h(0.25em) $bullet$ #h(0.05em)])
    // add style to links
    #show link: underline
    // use relative numbering in figures
    #set figure(numbering: n => {
        let head = query(selector(heading).before(here())).last().location()
        let n = counter(figure).get().last() - counter(figure).at(head).last()
        let l1 = str(counter(heading).display("I.").split(".").at(0))
        let l2 = (counter(heading).get().slice(1)).map(str).join(".")
        if l2 == none { [#l1$*$#n] } else { [#l1/#l2$*$#n] }
    })
    // use heading
    #set heading(numbering: "I/1.1.", supplement: supplement)
    // add style to headings
    #show heading: it => {
        set text(size: 24pt - 4pt * (it.level - 1))
        strong(
            if it.level > 1 [
                #counter(heading).get().slice(1).map(str).join("."). 
                #it.body
            ]
            else if supplement == none [#it.body]
            else [
                #it.supplement #counter(heading).display() #it.body
            ]
        )
        v(calc.max(12pt - 2pt * (it.level - 1), 0pt))
    }
    // page numbering
    #set page(footer: [
        #set align(center)
        #set text(8pt)
        #counter(page).display(
            "1 of 1",
            both: true,
        )
    ])
    #doc
]

#let with-page-setup(supplement: [Chapter], doc) = [
    // set fg and bg color
    #set page(fill: bg-color)
    #set text(fill: fg-color)
    #set line(stroke: fg-color)
    #set table(stroke: none)
    // set a slightly larger margin
    #set page(margin: (x: 14%))
    #set par(linebreaks: "optimized")
    // normal font
    #set text(font: font-normal, style: "normal", overhang: false)
    // italic font
    #show emph: it => {
        text(font: font-italic, style: "italic", it.body)
    }
    // bold font
    #show strong: it => {
        text(font: font-bold, weight: "bold", it.body)
    }
    #doc
]

#let with-setup(supplement: [Chapter], doc) = [
    #let doc = with-page-setup(supplement: supplement, doc)
    #let doc = with-head-setup(supplement: supplement, doc)
    #doc
]