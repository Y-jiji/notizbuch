#import "template-theorem.typ": *
#import "template-summary.typ": *

#let blue  = rgb("#0000ff");
#let red   = rgb("#ff0000");
#let green = rgb("#00ff00");

#let setup(doc) = [
    #set heading(numbering: "I.1.")
    #set figure(numbering: num => (counter(heading).get().slice(1, -1) + (num,)).map(str).join("."))
    #show link: underline
    #show heading: it => [
        #set text(size: 1.5em - 0.1em * it.level)
        #if it.level > 1 {
            context counter(heading).get().slice(1).map(str).join(".")
            "."
        } else {
            pagebreak()
            "Topic "
            context counter(heading).display()
        }
        #if it.level < 3 {
            context counter(figure).update(0)
        }
        #it.body
        #v(0.5em)
    ]
    #doc
]