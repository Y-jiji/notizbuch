#import "template-theorem.typ": *
#import "template-summary.typ": *
#import "template-attributes.typ": *
#import "template-evagelion.typ": *

#let setup(kind) = doc => context [
    // use heading
    #set heading(numbering: "I/1.1.")
    #set par(linebreaks: "optimized")
    // use relative numbering in figures
    #set figure(numbering: n => {
        let head = query(selector(heading).before(here())).last().location()
        let n = counter(figure).get().last() - counter(figure).at(head).last()
        str(counter(heading).display("I.").split(".").at(0))
        "/"
        (counter(heading).get().slice(1) + (n,)).map(str).join(".")
    })
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
                #kind 
                #counter(heading).display() #it.body
            ]
        )
        v(0.5em)
    }
    #doc
]