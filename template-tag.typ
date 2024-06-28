#import "template-attributes.typ": *
#import "@preview/xarrow:0.3.0": xarrow

#let pif = math.partial
#let sp = math.display(" ")

#let to-string(content) = {
    if content.has("text") {
        content.text
    } else if content.has("children") {
        content.children.map(to-string).join("")
    } else if content.has("body") {
        to-string(content.body)
    } else if content == [ ] {
        " "
    }
}

#let todo-collector = state("todo-collector", ())

#let todo(content) = [

    // never remove this new line!
    #text(green, style: "normal", [#place[#figure(kind: "todo", supplement: none)[]#label(to-string(content))] [TODO: #content]])
    #todo-collector.update(x => { x.push((to-string(content), label(to-string(content)))); x })
]

#let tag(name) = strong[
    #place[#figure(kind: "Entry", supplement: none)[  ]#label(to-string[#name])]
    \{#counter(figure).display()\}
]