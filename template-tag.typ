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

#let task-collector = state("task-collector", ())

#let task(content) = [

    // never remove this new line!
    #text(green, style: "normal", [#place[#figure(kind: "task", supplement: none)[]#label(to-string(content))] [TODO: #content]])
    #task-collector.update(x => { x.push((to-string(content), label(to-string(content)))); x })
]

#let task-display() = context table(
    columns: 2,
    ..{
        let map = it => ([#ref(it.at(1))], [#it.at(0)]);
        task-collector.final().map(map).flatten()
    }
)

#let tag(name) = strong[
    #place[#figure(kind: "Entry", supplement: none)[  ]#label(to-string[#name])]
    \{#counter(figure).display()\}
]