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

#let TODO(content) = [
    // never remove this new line!

    #text(green, style: "normal", [[TODO: #content]])
]

#let tagged(meta, name, justification, breakable, content) = [
    // x
    #place[#figure(supplement: meta)[]#label(to-string[#meta:#name.replace(" ", "_")])]
    #text(blue, font: "Liberation Serif")[\[#meta #counter(figure).display()\]] #h(1pt)
    #content
]

#let link-tag(meta, adposition, target, extra, alter, breakable, content) = [
    #if alter != none {
        place[#figure(supplement: meta)[]#label(to-string[#meta:#alter.replace(" ", "_")])]
    } else if extra == none {
        place[#figure(supplement: meta)[]#label(to-string[#meta:#target])]
    } else {
        place[#figure(supplement: meta)[]#label(to-string[#meta\-#extra.replace(" ", "_"):#target])]
    }
    #text(blue, font: "Liberation Serif")[\[#meta #counter(figure).display()\] $<-$ \[#ref(label(target))\]] #h(1pt)
    #content
]

#let prf(name, extra: none, breakable: true, alter: none,  content) = link-tag("P", "☯", name, extra, alter, breakable, content)

#let rmk(name, extra: none, breakable: true, alter: none, content) = link-tag("R", "on", name, extra, alter, breakable, content)

#let col(name, extra: none, breakable: true, alter: none, content) = link-tag("C", "of", name, extra, alter, breakable, content)

#let fig(name, breakable: false, content) = tagged("F", name, center, breakable, content)

#let def(name, breakable: true, content) = tagged("D", name, left, breakable, content)

#let thm(name, breakable: true, content) = tagged("T", name, left, breakable, content)

#let eg(name, breakable: true, content) = tagged("E", name, left, breakable, content)

#let lem(name, breakable: true, content) = tagged("L", name, left, breakable, content)