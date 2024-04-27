#import "template-theorem.typ": *
#import "template-summary.typ": *

#let blue  = rgb("#0000ff");
#let red   = rgb("#ff0000");
#let green = rgb("#00ff00");

#let setup(doc) = [
    #set heading(numbering: "I.1.")
    #set figure(numbering: n => {
        let head = query(selector(heading).before(here())).last().location()
        let n = counter(figure).get().last() - counter(figure).at(head).last()
        (counter(heading).get().slice(1) + (n,)).map(str).join(".")
    })
    #show link: underline
    #show heading: it => [
        #set text(size: 1.5em - 0.1em * it.level)
        #if it.level > 1 {
            counter(heading).get().slice(1).map(str).join(".")
            "."
        } else {
            pagebreak()
            "Topic "
            counter(heading).display()
        }
        #it.body
        #v(0.5em)
    ]
    #doc
]