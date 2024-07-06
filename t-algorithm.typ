#import "t-attributes.typ": *

#let with-dejavu-font(x) = [// normal font
    #set text(font: "DejaVu Sans Mono", style: "normal", overhang: false, size: 10pt)
    // italic font
    #show emph: it => {
        text(font: "DejaVu Sans Mono", style: "italic", it.body, fill: green)
    }
    // bold font
    #show strong: it => {
        text(font: "DejaVu Sans Mono", weight: "bold", it.body, fill: blue)
    }
    #set block(above: 1em, below: 1em, breakable: true)
    #x
]

#let nest(head, content) = with-dejavu-font([
    #head
    #context {
        // compute height
        let height = measure(content).height;
        // the indent hint line
        place(line(start: (0.75em, -0.25em), end: (0.75em, height - 0.5em), stroke: 0.25pt + black))
        place(line(start: (0.75em, height - 0.5em), end: (1.2em, height - 0.5em), stroke: 0.25pt + black))
        move(dx: 1.8em, content)
    }
])

#let algo-function(name, args, content) = nest[*function* #name#args][#content]
#let algo-while(cond, content) = nest[*while* #cond *do*][#content]
#let algo-for(var, from, to, content) = nest[*for* #var *from* #from *to* #to][#content]
