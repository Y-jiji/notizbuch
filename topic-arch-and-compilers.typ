#import "template.typ": *
#show: setup

= Compilers & Architectures <compiler>

#summary[
    #tag[compiler-arch] In general, the boundary of computability is maintained by TCS people and logicians (see @tcs:division). Realistically, people also care about how to implement computation in our physical world. Given that intricacy of modern hardware, implementation can also be a very hard subject, especially when one want to compute efficiently. We ended up write compilers to do these for us, i.e. translating programs into machine code. 
    #tag[compiler-arch:misc-use] On the other hand, people also write compilers targeting not only machine code, and not only from high-level languages. In these scenarios, we also have different requirements for compilers. 
]

== Principles of Translation

#tag[translation] A binary operation $bullet arrow.b.dashed bullet$ is a translation between two transition systems $(arrow.r, S, sans("val"_s))$ and $(arrow.r.stroked, T, sans("val"_t))$  iff 
$
frac(
    s arrow.b.dashed t sp sp sp
    s op(arrow.r)^* s_* sp sp sp 
    t op(arrow.r.stroked)^* t_*
    ,
    s_* arrow.b.dashed t_*
)
$

#todo[Link transition system, star over arrow means evaluation]

== Tiger Compiler

=== Tiger Formalized

#tag[compiler:tiger:intro] Tiger programming language is designed for teaching purpose. Therefore, it is very simple compared to practical languages, but not too simple to contain common features. For example, it has nested functions and record types. 

#tag[compiler:tiger:syntax] 
Tiger language is an imperative language, where programmers can define variables and mutate them. This entry introduce the formal syntax of tiger, and also explain partially why it is formulated this way. 

The sort $sans("Bnd")$ serves as left values in common programming languages. They works just as expressions, but they can be assigned to. 

Functions are abstracted as a single sort because tiger don't have higher-order functions. Importantly, functions can be recursive or mutually recursive. Therefore, we write them as $sans(overline("Fun").overline("Fun"))$ so that we can use the functions inside the definitions before its definition. 

Another notable feature is that as $sans("var"("Exp"; "Bnd"."Cmd"))$ defines the $sans("Bnd")$ abstraction over $sans("Cmd")$, it is also possible to use this $sans("Bnd")$ inside a function declaration. 

#align(center, rect(stroke: none)[#table(columns: 3, align: left,
    $sans("Id")$,  $:: =$,  $sans("<A Fixed Set of Names>")$,
    $sans("Bnd")$, $:: =$,  $sans("Id")$,
    $$, $$,                 $sans("Bnd"["Exp"])$,
    $$, $$,                 $sans("Bnd").sans("Id")$,
    $sans("Typ")$, $:: =$,  $sans("record"{overline("Id": "Typ")})$,
    $$, $$,                 $sans("array"["Typ"])$,
    $$, $$,                 $sans("int")$,
    $$, $$,                 $sans("string")$,
    $$, $$,                 $sans("void")$,
    $sans("Fun")$, $:: =$,  $sans(overline("Exp")."Exp")$,
    $sans("Exp")$, $:: =$,  $sans("Exp") + sans("Exp")$,
    $$, $$,                 $sans("Exp") - sans("Exp")$,
    $$, $$,                 $sans("Exp") times sans("Exp")$,
    $$, $$,                 $sans("Exp") \/ sans("Exp")$,
    $$, $$,                 $sans("if" ("Exp") "then" "Exp" "else" "Exp")$,
    $$, $$,                 $sans("app"("Fun";overline("Exp")))$,
    $$, $$,                 $sans("seq"("Cmd";"Exp"))$,
    $$, $$,                 $sans("get"["Bnd"])$,
    $$, $$,                 $sans("arr"["Exp"; "Exp"])$,
    $$, $$,                 $sans("rec"{overline("Id": "Exp")})$,
    $$, $$,                 $sans("cmd(Cmd)")$,
    $sans("Cmd")$, $:: =$,  $sans("ret"("Exp"))$,
    $$, $$,                 $sans("set"["Bnd"]("Exp"))$,
    $$, $$,                 $sans("var"("Exp"; "Bnd"."Cmd"))$,
    $$, $$,                 $sans("if" ("Exp") "then" "Cmd")$,
    $$, $$,                 $sans("fun"(overline("Fun").overline("Fun"); overline("Fun")."Cmd"))$,
    $$, $$,                 $sans("while" ("Exp") "do" "Cmd")$,
    $$, $$,                 $sans("print"(overline("Exp")))$
)])

#tag[compiler:tiger:notation] In @compiler:tiger:syntax, we use overline to represent "a vector of". For example, $sans(overline("Exp"))$ means a vector of expressions. In engineering, representation like @compiler:tiger:syntax is generated after name resolution. 

#tag[compiler:tiger:statics] We introduce two judgements in the statics (as in @Book:PFPL).
#todo[The rule of typing and command ok]

#tag[compiler:tiger:dynamics] The dynamics of this language is more complicated then some practical programming languages, as it has mutable states. 
#todo[The rule of evaluation]

=== Tree IR Formalized

#tag[compiler:tiger:treeir] Tree IR is "featureless" a limited language. Compared to prevailing intermediate representations, like LLVM IR or Cranelift IR, Tree IR is not a static-single assignment language. 

#todo[Tree IR]

=== Tree IR Generation

#tag[compiler:tiger:static-link] As mentioned in @compiler:tiger:syntax, a function in tiger language can access variables in the outer scope. Therefore, during its execution, a function must maintain a correct environment where the variable can be accessed and modified correctly. In the book @Book:Tiger-Compiler, tiger compiler translates variable accessing into a chain of dereferences. This technique is called static link. It is called static link because it tracks the stack frame of the lexical outer function (instead of runtime, see @compiler:tiger:static-link:example). 

#tag[compiler:tiger:frame-or-ar] The term "activation record" and "frame" is used interchangeably in this book, which can be confusing. Here we just call them frames. 

#tag[compiler:tiger:static-link:example]
For example, in the following pseudocode: 
#align(center)[```
fun A() = 
    var x := 10;
    fun B() = 
        var y := 20;
        fun C() = 
            var z := 30;
            x + y + z
        C()
    fun D() = 
        var w := 20;
        B() + w
    D()
end
```]
The important observation is: when a function is called, its stack frame has fixed size. We use `(-> ...)` to represent static link. 
#align(center)[```
A: x (NULL)
B: y (-> A)
C: z (-> B)
D: w (-> A)
```]
Consider a tree of functions, a function can only call its siblings or direct children. Therefore, we can create static links by tracking relative depth of a function call. In this example, when calling `B` inside `D`, `A` have relative depth `1`, `B` have relative depth `2`, and `D` have relative depth `2`. Because `D` and `B` have the same level, `D` just pass `B` the static link passed to it. For `C`, because `C` is one level deeper than `B`, we can just pass `C` that static link pointing to `B`. 

#tag[compiler:tiger:static-link:translation]
In short, (same level + d) `->` trace back `d` levels and pass it as first argument. The extended example is in @compiler:tiger:static-link:example. 

#tag[compiler:tiger:external]
The calling convention in tiger doesn't fit into the correpsondent calling convention of the ISA (static link is always passed as the first argument). Therefore, we must handle external functions differently. 

=== Canonicalization

#tag[compiler:tiger:assem] Tree IR is still several steps from machine code (register-based, particularly). First, we need to canonicalize the Tree IR (@compiler:tiger:canon:motivation). Second, we need to select an instru for each Tree IR instru (@compiler:tiger:instru). And finally, we allocate register or stack variables to virtual temporary variables (@compiler:tiger:reg). 

#tag[compiler:tiger:canon:motivation]
Before we generate machine code, we have to transform the Tree IR so that: 
+ Non-control-flow instrus in Tree IR can be directly translated to machine code. 
+ Dividing instrus into basic blocks, where in each basic block there is no control-flow intructions, control-flow graph is aligned to machine code. 

// #tag[compiler:tiger:canon]
#todo[Algorithm for Canonicalization]

=== Instruction Selection

#tag[compiler:tiger:instru] 

#tag[compiler:tiger:instru:maximal-much] 

#tag[compiler:tiger:instru:dp]

#todo[Maximal Munch and DP]

=== Register Allocation

#tag[compiler:tiger:reg] To allocate a register to each temporary variable, we need to first figure out how data is carried in temporary variables, so that allocating registers will not disrupt the semantics in Tree IR (@compiler:tiger:live:motivation). Then, we find and mark temporary variables with pre-allocated registers (@compiler:tiger:reg:prealloc). After that, we build a graph whose nodes are local variables and whose edges either connects variables with the same data, or variables that cannot share one register (@compiler:tiger:reg:interfere). Finally, we try to allocate registers to each variable, or modify the original program if allocation fails (@compiler:tiger:reg:color-or-spill) and start from beginning. 

#tag[compiler:tiger:live:motivation] To allocate physical registers to local variables, we have to trace how local variables are defined and used in our program. When a pair of local variables are not used together, we can allocate the same register to them. For this purpose, we need to analyze co-active local variables. 

#tag[compiler:tiger:live:instr] We can observe that one instruction in Tree IR may *read* a variable or *write* a variable. A variable's value after *writing* is independent from its previous value. And when we allocate a physical register to a variable, we don't want a variable *read* by afterward instructions to be *overwritten* by other instructions. When a variable's current value can possibly be read by afteward instructions, we say this variable is an *active variable*. We can compute active variables before an instruction using the active variables after an instruction. 
#align(center)[
    ```
    B[I] = { Active Variables Before Instruction (I) }
    A[I] = { Active Variables  After Instruction (I) }
    R(I) = { Variables    Read By Instruction (I) }
    W(I) = { Variables Written By Instruction (I) }
    B[I] = R(I) ∪ (A[I] \ W(I))
    ```
]
Of course, for instructions that might consecutively execute, say `I,J`, we have `A[I] ⊃ B[J]`. These can be known from control flow graph. 

#tag[compiler:tiger:live:bb] Although we still have to allocate a register to each temporay variable for each instruction (@compiler:tiger:live:instr), the interaction between one basic blocks and other instructions can be streamlined during liveness analysis. Each basic block has its own *read* and *write* set. We can verify the following: 
#align(center)[
    ```
    B[BB] = { Active Variables Before BB's First Instruction (BB[0])  }
    A[BB] = { Active Variables  After BB's Last  Instruction (BB[-1]) }
    R(BB) = REDUCE({}, |S, I| R(I) ∪ S \ W(I), REV(BB))
    W(BB) = REDUCE({}, |S, I| W(I) ∪ S       , REV(BB))
    B[BB] = R(BB) ∪ (A[BB] \ W(BB))
    // where `BB` is considered a sequence of instructions 
    //      (in the order of execution)
    // where `REV` returns a reversed list. 
    // where `REDUCE` is just like reduce in python functools
    ```
]
For each given `BB`, if we know `A[BB]`, computing `A[I]` and `B[I]` should be very straight forward for each `I` in `BB`, since between each pair of consecutive instructions `BB[X]` and `BB[X+1]`, we have `A[BB[X]] = B[BB[X+1]]`. 

#tag[compiler:tiger:live] We call the algorithm for computing `A[...]` and `B[...]` for each instruction `LIVENESS`. (see @compiler:tiger:live:bb, @compiler:tiger:live:instr). 
#align(center)[#rect(stroke: none)[
    ```
    LIVENESS(PROCEDURE) =
        A = { BB: R(BB) for BB in PROCEDURE.BB }
        B = { BB: {}    for BB in PROCEDURE.BB }
        loop:
            find Some(BB): B[BB] != R(BB) ∪ (A[BB] \ W(BB)):
                B[BB] = R(BB) ∪ (A[BB] \ W(BB))
                PREV  = PROCEDURE.CONTROL-FLOW.PREV(BB)
                for BP in PREV:
                    A[BP] = A[BP] ∪ B[BB]
            else: break
        A' = { I: {} for I in PROCEDURE }
        B' = { I: {} for I in PROCEDURE }
        for BB in PROCEDURE.BB:
            B'[BB[ 0]] = B[BB]
            A'[BB[-1]] = A[BB]
            for I in REV(BB):
                A'[I] = B'[I.NEXT]
                B'[I] = R(I) ∪ A'[I] \ W(I)
        return A'
    ```
]]

#tag[compiler:tiger:reg:prealloc] For the currently translated function and function calls, the input arguments of and the return value might be pre-allocated. We also consider the side-effect of function calls, some of the registers are modified by the callee, so we must not use them to save data across function calls. 

#tag[compiler:tiger:reg:interfere] Using result `LIVENESS` algorithm @compiler:tiger:live, we can build an interference graph with the following algorithm: 
#align(center)[#rect(stroke: none)[
    ```
    BUILD-IGRAPH(PROCEDURE) = 
        A = LIVENESS(PROCEDURE)
        E = {  }
        for I in PROCEDURE:
            A' = A[I]
            if I.IS_MOVE:
                for X, Y in R(I) × W(I):
                    E = E ∪ { (X, Y, true) }
                    E = E ∪ { (Y, X, true) }
                A' = A' \ R(I)
            for X, Y in W(I) × (A' ∪ W(I)) where X != Y:
                E = E ∪ { (X, Y, false) }
                E = E ∪ { (Y, X, false) }
        V = { X: none for X in PROCEDURE.VARS }
        for I in PROCEDURE:
            for X, R in I.PREALLOCATED:
                V[X] = R
        for X in PROCEDURE.ARGS:
            V[X] = X.PREALLOCATED
        return GRAPH(V, E)
    ```
]]

#todo[Fix the build algorithm]

#tag[compiler:tiger:reg:color-or-spill] Using the result of @compiler:tiger:reg:interfere, we can obtain an interference graph. However, for a fixed-size set of registers, assign each variable a register can be a hard task, because coloring graph with a fixed set of colors so that no adjacent nodes have the same color is NP-hard. Instead, we use a simple heuristics: 
#align(center)[
    ```
    REG-ALLOC(PROCEDURE, REGS) = 
        IGRAPH  = BUILD-IGRAPH(PROCEDURE)
        JGRAPH  = COPY(IGRAPH)
        STACK   = []
        MERGE   = {}
        COLOR   = IGRAPH.V
        while not IGRAPH.IS-EMPTY():
            find Some(V): IGRAPH.DEG(V) < SIZE(REGS):
                STACK.PUSH(V)
                IGRAPH.REMOVE(V)
                continue
            find Some(U, V): IGRAPH.CAN-COALECSE(U, V):
                for (X, Y, M) in IGRAPH.E where X == U or Y == U:
                    IGRAPH.E = IGRAPH.E \ { (X, Y, M) }
                    if X == U: X = V
                    if Y == U: Y = V
                    if X == Y: continue
                    IGRAPH.E = IGRAPH.E ∪ { (X, Y, M) }
                IGRAPH.REMOVE(U)
                MERGE[U] = V
                continue
            find Some(U, V): (U, V, true) ∈ IGRAPH.E:
                IGRAPH.E = IGRAPH.E \ { (U, V, true ) , (V, U, true ) }
                IGRAPH.E = IGRAPH.E \ { (U, V, false) , (V, U, false) }
            else:
                V = IGRAPH.SELECT-SPILL()
                STACK.PUSH(V)
                IGRAPH.REMOVE(V)
        while not STACK.IS-EMPTY():
            V = STACK.POP()
            find Some(R): R ∈ REGS \ { COLOR[U] for U in JGRAPH.ADJ(V) }:
                COLOR[V] = R
            else:
                PROCEDURE.ACTUAL-SPILL(V)
                return REG-ALLOC(PROCEDURE, REGS)
        return COLOR, MERGE
    ```
]

#tag[compiler:tiger:reg:coalesce] In @compiler:tiger:reg:color-or-spill, we left out `IGRAPH.CAN-COALESE` and `IGRAPH.SELECT-SPILL` as two seperate procedures. In this entry, we solve `CAN-COALECSE`. One observation is that when we coalesce to nodes, we will obtain a node with larger degree, which may directly result in spill. Alternatively, if we don't coalesce, we just waste one register and an instruction. Therefore, we have to be *conservative* about moves. There are two mainstream heuristics: 
- Briggs: In the neighbors of the merged node, less than K neighbors has degree more than K. 
- George: Merging node `a` and `b` is safe iff for all `a`'s neighbor `t`, `t` is either `b`'s neighbor or `t` has degree less than K. 

#tag[compiler:tiger:reg:spill] To select a spill variable, we want to decide the spilling expense. We usually think the variables have larger spilling expense when it is defined and used in a loop. Moreover, if it has larger degree, we are more likely to result in an actually spill. The spilling cost is usually computed as: 
#align(center)[
    ```
    COST(V, GRAPH, PROCEDURE) = 
        X = #{I : V ∈ R(I) ∧ IN-LOOP(I, PROCEDURE)}
        X = #{I : V ∈ W(I) ∧ IN-LOOP(I, PROCEDURE)} + X
        X = 10 * X
        X = #{I : V ∈ R(I) ∧ ¬IN-LOOP(I, PROCEDURE)} + X
        X = #{I : V ∈ W(I) ∧ ¬IN-LOOP(I, PROCEDURE)} + X
        return X / GRAPH.deg(V)
    IN-LOOP(I, PROCEDURE) = 
        for TRACE in PROCEDURE.CONTROL-FLOW.TRACES where I ∈ TRACE:
            if TRACE.IS-LOOP: return true
        return false
    ```
]

#tag[compiler:tiger:reg:sethi-ullman] There is a simplified algorithm (Sethi-Ullman) for tree-shaped expressions. It recursively evaluates the largest number of registers for each tree: 
- Each leaf node needs one register. 
- Each non-leaf nodes needs `max(SETHI-ULLMAN(CHILDREN[0]), SETHI-ULLMAN(CHILDREN[1]))` registers or `SETHI-ULLMAN(C) + 1` registers when every child needs the same amount of registers. 

