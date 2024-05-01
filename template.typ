#import "template-theorem.typ": *
#import "template-summary.typ": *
#import "template-attributes.typ": *
#import "template-eva.typ": *

#let setup(kind) = doc => context [
    // use heading
    #set heading(numbering: "I.1.")
    // use relative numbering in figures
    #set figure(numbering: n => {
        let head = query(selector(heading).before(here())).last().location()
        let n = counter(figure).get().last() - counter(figure).at(head).last()
        (counter(heading).get().slice(1) + (n,)).map(str).join(".")
    })
    // normal font
    #set text(font: font-japanese, style: "normal", lang: "ja")
    #set text(font: font-normal, style: "normal", lang: "en")
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
    // add style to headings
    #show heading: it => {
        set text(size: 1.5em - 0.1em * it.level)
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