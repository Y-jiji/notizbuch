#import "template-attributes.typ": *

// paint eigth note
#let eigth(x, k, h, c, mark) = {
    let y = -k * h / 8
    let p = h / 4 * 0.5
    place(bottom, dx: x, dy: y - p/2)[#ellipse(
        height: (h/4-p), 
        width : (h/4-p)*1.5, 
        fill  : c,
        stroke: none,
    )]
    if calc.abs(mark - 0.0) >= 0.0001 {
        let dec = if calc.abs(mark - 0.1) < 0.0001 {
            [♯]
        } else if calc.abs(mark - 0.2) < 0.0001 {
            [♭]
        } else {
            [♮]
        }
        place(bottom, dx: x + h/4, dy: y)[#text(size: h/2, fill: c, weight: "bold")[#dec]]
    }
    {
        let x = x + (h/4-p)*1.5 - h/48
        let d = if k <= 100000 { h/6 } else { -h/6 }
        let y = if k <= 100000 {
            y - 3*h/4 + d - h/8
        } else {
            y + 3*h/4
        }
        place(bottom, dx: x, dy: y)[#polygon(
            fill: c.transparentize(20%), 
            stroke: c + h/24,
            (0pt, 0pt),
            (0pt, h/4 - p),
            (h*7/24, h/4 + d - p),
            (h*7/24, 0pt + d),
        )]
    }
    {
        let x = x + (h/4-p)*1.5 - h/48
        let y = if k <= 100000 { y } else { y + 3*h/4 };
        place(bottom, dx: x, dy: y - h/8)[#line(
            stroke: h/24 + c, 
            start : (0pt, 0pt), 
            end   : (0pt, 3*h/4),
        )]
    }
}


// paint eigth note
#let sixteenth(x, k, h, c, mark) = {
    let y = -k * h / 8
    let p = h / 4 * 0.5
    place(bottom, dx: x, dy: y - p/2)[#ellipse(
        height: (h/4-p), 
        width : (h/4-p)*1.5, 
        fill  : c,
        stroke: none,
    )]
    if calc.abs(mark - 0.0) >= 0.0001 {
        let dec = if calc.abs(mark - 0.1) < 0.0001 {
            [♯]
        } else if calc.abs(mark - 0.2) < 0.0001 {
            [♭]
        } else {
            [♮]
        }
        place(bottom, dx: x + h/4, dy: y)[#text(size: h/2, fill: c)[#dec]]
    }
    {
        let x = x + (h/4-p)*1.5 - h/48
        let d = if k <= 100000 { h/6 } else { -h/6 }
        let y = if k <= 100000 {
            y - 3*h/4 + d - h/8
        } else {
            y + 3*h/4
        }
        place(bottom, dx: x, dy: y)[#polygon(
            stroke: c + h/24,
            fill: none, 
            (0pt, 0pt),
            (0pt, h/8),
            (h*7/24, h/8 + d),
            (h*7/24, 0pt + d),
        )]
    }
    {
        let x = x + (h/4-p)*1.5 - h/48
        let y = if k <= 100000 { y } else { y + 3*h/4 };
        place(bottom, dx: x, dy: y - h/8)[#line(
            stroke: h/24 + c, 
            start : (0pt, 0pt), 
            end   : (0pt, 3*h/4),
        )]
    }
}

// paint quater note
#let quater(x, k, h, c, mark) = {
    let y = -k * h / 8
    let p = h / 4 * 0.5
    place(bottom, dx: x, dy: y - p/2)[#ellipse(
        height: (h/4-p), 
        width : (h/4-p)*1.5, 
        fill  : c,
        stroke: none,
    )]
    if calc.abs(mark - 0.0) >= 0.0001 {
        let dec = if calc.abs(mark - 0.1) < 0.0001 {
            [♯]
        } else if calc.abs(mark - 0.2) < 0.0001 {
            [♭]
        } else {
            [♮]
        }
        place(bottom, dx: x + h/4, dy: y)[#text(size: h/2, fill: c, weight: "bold")[#dec]]
    }
    let y = if k <= 100000 { y } else { y + 3*h/4 };
    place(bottom, dx: x + (h/4-p)*1.5 - h/48, dy: y - h/8)[#line(
        stroke: h/24 + fg-color, 
        start : (0pt, 0pt), 
        end   : (0pt, 3*h/4),
    )]
}

#let staff(w: 100%, h: 2cm, ..data) = rect(width: w, height: h, stroke: 0.5pt + fg-color, inset: 0pt, outset: 0pt, fill: bg-color)[
    // display staff lines
    #for i in (0,1,2,3,4) {
        place(bottom, dy: -i/4*h)[#line(stroke: 0.5pt + fg-color, length: 100%)]
    }
    // display key
    #place(bottom)[#text(size: h, fill: fg-color)[𝄞]]
    // compute length
    #let len = data.pos().len()
    // display each note on staff
    #for (j, (sym, c, k)) in data.pos().enumerate() {
        if sym == "quater" { for t in k {
            quater(h+j/len*(w - h), int(t), h, c, t - int(t))
        }}
        if sym == "eigth" { for t in k {
            eigth(h+j/len*(w - h), int(t), h, c, t - int(t))
        }}
        if sym == "sixteenth" { for t in k {
            sixteenth(h+j/len*(w - h), int(t), h, c, t - int(t))
        }}
    }
]

#let g(x) = ("g", x)
#let qua(c: fg-color, ..x) = ("quater", c, x.pos().sorted())
#let eig(c: fg-color, ..x) = ("eigth" , c, x.pos().sorted())
#let six(c: fg-color, ..x) = ("sixteenth", c, x.pos().sorted())
#let rest(x) = ("rest", x)

#set text(font: "Palatino Linotype")
#set page(fill: bg-color)

#staff(h: 1cm, w: 4cm,
    six(-1, 0, 1, 2, 3), qua(-1, 0, 1), eig(0, 1, 2, 3)
)