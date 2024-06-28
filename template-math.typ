#let annotated-symbol(
    sym, annot, 
    breakpoints: 2/5, 
    breakpoint-padding: 0%,
    scale-mid: 1
) = {
    assert(
        type(sym) == "symbol", 
        message: "Input needs to be a symbol, is actually " + type(sym)
    )
    assert(
        type(annot) == "content", 
        message: "Annotation needs to be of type content, is actually " +
            type(annot)
    )
    assert(
        (type(breakpoints) == "integer" or type(breakpoints) == "float") 
        and breakpoints < 0.5,
        message: "breakpoints must be a number less than 1/2, is actually " +
            str(breakpoints) +
            ", of type " +
            type(breakpoints)
    )
    assert(
        type(breakpoint-padding) == "length" or 
        type(breakpoint-padding) == "relative length" or
        type(breakpoint-padding) == "ratio",
        message: "breakpoint-padding must be a length, relative length or ratio, is actually " +
            type(breakpoint-padding)
    )
    assert(
        type(scale-mid) == "integer" or type(scale-mid) == "float",
        message: "scale-mid must be a number, is actually " + 
            type(scale-mid)
    )
    
    let sym-content = [#sym]

    style(styles => {
        let s = measure(sym-content, styles)
        let a = measure(math.script(annot), styles)
        let out-segment-length = s.width * breakpoints
        let mid-segment-length = s.width * (1 - 2 * breakpoints)
        let factor = a.width / mid-segment-length * scale-mid

        let sym-back = box(
            width: out-segment-length, 
            height: s.height, 
            clip: true,
            place(left, 
                sym-content
            )
        )

        let sym-middle = box(
            width: mid-segment-length,
            height: s.height,
            clip:true,
            place(left, 
                dx: -out-segment-length,
                sym-content
            )
        )

        let sym-front = box(
            width: out-segment-length, 
            height: s.height, 
            clip: true,
            place(left, 
                dx: -(out-segment-length + mid-segment-length),
                sym-content
            )
        )

        let scaled-sym = box(
            width: 2 * out-segment-length + factor * mid-segment-length,
            height: s.height
        )[
            #place(left + top,
                sym-back
            )
            #place(left + top,
                dx: out-segment-length + breakpoint-padding,
                scale(x: factor * 100%, origin: left, sym-middle)
            )
            #place(left + top,
                dx: out-segment-length + factor * mid-segment-length + 2 * breakpoint-padding,
                sym-front
            )
        ]

        math.attach(
            math.limits(scaled-sym),
            t: annot
        )
    })
}