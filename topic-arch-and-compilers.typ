#import "template.typ": *
#show: setup("Topic")

= Architecture & Compilers

== Activation Records

=== Basic Subject

#definition("Activation Record")[
    An activation record is a block of memory allocated with an invocation of procedure. 
]

Typically, this concept usually involves stack allocation & calling conventions, i.e. the following problems needs to be addressed before we proceed engineering:
- When a function is invoked, where to put the parameters?
- What kind of computation can be done in registers?
- How to pass the computation results?

=== Considerations: Closure

For some languages, they support nested functions, or closure. Nested functions can access the local definitions of its parent function. Which means even when a function ends its scope, when a nested function is returned, these local definitions must be kept in storage. Therefore, for these kind of langauges, stack allocation may not work. 

#example("returning nested functions")[
    #align(center)[
        ```
        # both x and z should be stored on heap
        def f(x:int):
            z = x + 10
            def g(y:int):
                return x + y + z
            return g
        ```
    ]
]

Some advanced languages like rust or cpp use a smarter approach. They allow users to optionally pack storage into heap allocation, and force users to use heap allocation when they want to return callable objects (rust: through Sized trait bound + borrow checking, cpp: provide tools to handle or check validity). 

=== Considerations: Using Registers

By convention, some registers are *caller saved*, which means it is the caller's liablity to preserve the value of these registers, and callees can modify them arbitrarily as they see fit. Some registers are *callee saved*, which means the callee should preserve the value of these registers. 

=== Considerations: Stack Frames
