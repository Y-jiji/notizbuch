#let summary(content) = [
    #align(center)[
        #pad(x: 10%, y: 2em)[
            #align(left)[
                #line(length: 100%, stroke: red)
                #pad(x: 2em)[_
                    #content
                _]
                #line(length: 100%, stroke: red)
            ]
        ]
    ]
]