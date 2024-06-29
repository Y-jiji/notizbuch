#import "template-tag.typ": *
#import "template-summary.typ": *
#import "template-attributes.typ": *
#import "template-evagelion.typ": *
#import "template-algorithm.typ": *
#import "template-commute.typ": *
#import "template-math.typ": *

#let with-heading-setup(supplement: [Chapter], doc) = [
    // use strong for reference
    #show ref: it => strong([#it])
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
        str(counter(heading).display("I.").split(".").at(0))
        "/"
        (counter(heading).get().slice(1)).map(str).join(".")
        [\-#n]
    })
    // use heading
    #set heading(numbering: "I/1.1.", supplement: supplement)
    // add style to headings
    #show heading: it => {
        if it.supplement == none {}
        else {
            set text(size: 24pt - 4pt * (it.level - 1))
            strong(
                if it.level > 1 [
                    #counter(heading).get().slice(1).map(str).join("."). 
                    #it.body
                ]
                else [
                    #it.supplement #counter(heading).display() #it.body
                ]
            )
            v(calc.max(12pt - 2pt * (it.level - 1), 0pt))
        }
    }
    #doc
]

#let with-page-setup(supplement: [Chapter], doc) = [
    // set fg and bg color
    #set page(fill: bg-color)
    #set text(fill: fg-color)
    #set line(stroke: fg-color)
    #set table(stroke: none)
    // page numbering
    #set page(footer: context [
        #set align(center)
        #set text(8pt)
        #counter(page).display(
            "1 of 1",
            both: true,
        )
    ])
    // set a slightly larger margin
    #set page(margin: (x: 14%))
    // #set par(linebreaks: "optimized")
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
    #let doc = with-heading-setup(supplement: supplement, doc)
    #doc
]