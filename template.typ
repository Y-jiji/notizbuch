#import "template-tag.typ": *
#import "template-summary.typ": *
#import "template-attributes.typ": *
#import "template-evagelion.typ": *
#import "template-algorithm.typ": *
#import "template-commute.typ": *
#import "template-math.typ": *

#let setup = doc => [
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
    // use heading
    #set heading(numbering: "I/1.1.")
    #set par(linebreaks: "optimized")
    // use relative numbering in figures
    #set figure(numbering: n => {
        let head = query(selector(heading).before(here())).last().location()
        let n = counter(figure).get().last() - counter(figure).at(head).last()
        str(counter(heading).display("I.").split(".").at(0))
        "/"
        (counter(heading).get().slice(1)).map(str).join(".")
        [\-#n]
    })
    // normal font
    #set text(font: font-normal, style: "normal", overhang: false)
    // italic font
    #show emph: it => {
        text(font: font-italic, style: "italic", it.body)
    }
    // 
    #show ref: it => strong([#it])
    // bold font
    #show strong: it => {
        text(font: font-bold, weight: "bold", it.body)
    }
    // change enumeration layout
    #set enum(numbering: n => [#h(0.25em) #str(n) .])
    // change bullet list layout
    #set list(marker: [#h(0.25em) $bullet$ #h(0.05em)])
    // add style to links
    #show link: underline
    #set heading(depth : 1, supplement: "Topic")
    #set heading(depth : 2, supplement: "Section")
    #set heading(depth : 3, supplement: "Section")
    #set heading(depth : 4, supplement: "Section")
    #set heading(depth : 5, supplement: "Section")
    #set heading(depth : 6, supplement: "Section")
    // add style to headings
    #show heading: it => context {
        set text(size: 1.6em - 0.1em * it.level)
        strong(
            if it.level > 1 [
                #counter(heading).get().slice(1).map(str).join("."). 
                #it.body
            ]
            else [
                #pagebreak()
                Chapter #counter(heading).display() #it.body
            ]
        )
        v(0.5em)
    }
    #doc
]