#import "template.typ": *
#show: setup("Topic")

= Fourier Analysis

#summary[
    Fourier analysis originates from a series of endavour in solving differential equations. Later, this technique reveals the structure of differential operator, and works well with other tools in functional analysis. 
]

== Motivating Examples

The motivation of fourier analysis mainly comes from physics. In this chapter, some important motivating examples from physics are listed to provide some basic intuition. 

=== Simple Harmonic Motion

The simplist possible equation of this type is simple harmonic motion. 

In physics, simple harmonic motion provides a model for a vibrating spring. 

#definition("Simple Harmonic Motion")[
    A simple harmonic motion $"SimpleHM"(y,k)$ is defined by a following equation:
    $
    bold("equation") #h(10pt) 
        &frac(dif^2 y, dif t^2)(t) + k^2 y(t) =0\
    bold("where") #h(10pt) 
        &k: RR^+, y: RR -> RR , \ 
        &y "is twice differentiable"
    $
]

#theorem("Solution to SimpleHM")[
    The solutions to simple harmonic motion $"SimpleHM"(y, k)$ is: 
    $
    \{y: exists a,b in RR: y(t) = a sin(k t) + b cos(k t) \}
    $
]

#proof("Theorem:Solution_to_SimpleHM")[
    Given $"SimpleHM"(y, k)$, we verify: 
    $
        frac(dif^2 y, dif t^2)(t) = - a k^2 sin(k t) - b k^2 cos(k t)
    $
    Then, for a solution $y$, we try to compute $(a,b)$ so that 
    $
        y(t) &= a sin(k t) + b cos(k t)\
        k^(-1) frac(dif y, dif t)(t) &= a cos(k t) - b sin(k t)
    $
    We observe that
    $
        g(t) = cos(k t) dot y(t) - sin(k t) dot  k^(-1) frac(dif y, dif t)(t)\
        frac(dif g, dif t)(t) = 0
    $
    By analogy
    $
        h(t) = sin(k t) dot y (t) + cos(k t) dot k^(-1) frac(d y, d t)(t)\
        frac(dif h, dif t)(t) = 0
    $
    Let $b = g(t)$ and $a = h(t)$, since $y(t) = h(t) dot sin(k t) + g(t) dot cos(k t)$. We have
    $
        y(t) = a dot sin(k t) + b dot cos(k t)
    $
]

=== Mechanical Wave <Heading-L3:Mechanical_Wave>

In this section, we mainly talk about a solution tactic called seperation of variables. 

This tactic can be used to reduce equations of several variables to equations with a single variable. 

However, we have to introduce mechanical wave first. This equation depicts not only the motion of a single point, but intertwined motion of particles on a string. 

This model originates from a multi-particle system: 
+ Like any model in classic physics, quantities like $y_((dot))$ are functions of time $t$ by default. 

+ There are tracks on a plane #text(blue, [(blue, dashed line in @Figure:Vibrating_Particles_on_Tracks)])
+ These tracks are uniformly distanced #text(red, [($h$ in @Figure:Vibrating_Particles_on_Tracks)])
+ There are particles moving along each track #text(green, [($#circle(width: 5pt, stroke: green)$ in @Figure:Vibrating_Particles_on_Tracks)])
+ Each particle is affected only by its neighbouring particles. Vertical component of the force given by $y_(j+1)$ to $y_(j)$ is $h^(-1)k(y_(j+1) - y_(j))$ . 
+ Each particle has weight $rho h$ (when we vary $h$, the total weight of this particle string don't change)

#illustration("Vibrating Particles on Tracks")[
    // picture size
    #let width  = 10cm;
    #let height = 5cm;
    // marker size
    #let s = 5pt;
    #let c = circle(width: s, stroke: green);
    #let computex(x) = x / 5 * width + 0.5 * width;
    #let jp(dx, dy, content) = context [
        #let s = measure(content);
        #place(bottom + left, dx: dx - s.width / 2, dy: dy - s.height / 2)[#content]
    ]
    #rect(width: width, height: height, inset: 0pt, outset: 0pt, stroke: none, {
        let data = range(-2, 3).map(x => {
            let y = calc.cos(x + 0.8) * calc.cos(x + 0.6);
            let y = -y * 0.3 * height - 0.2 * height;
            let tick(t) = if x > 0 { $#t _ (n+#x)$ }
                            else if x == 0 { $#t _ (n)$ } 
                            else { $#t _ (n#x)$ };
            let x = computex(x);
            (x, y, tick("x"), tick("y"))
        })
        // ellipis
        jp(
            computex(-2.5) - 3 * s, 
            -0.20 * height, 
            $dots dots$
        );
        jp(
            computex(3) - 6 * s, 
            -0.20 * height, 
            $dots dots$
        );
        // the line
        for item in data {
            let placey(dy, content) = jp(item.at(0), dy, content);
            // y circle and y_(...)
            placey(-0.40 * height + item.at(1), c);
            placey(-0.50 * height + item.at(1), item.at(3));
            // x circle and x_(...)
            placey(-0.10 * height, item.at(2));
            // vertical line
            place(
                bottom + left, 
                dx: 0pt, dy: 0pt, 
                line(
                    stroke: (dash: "dashed", thickness: 0.7pt, paint: blue),
                    start: (item.at(0), -0.20 * height),
                    end:   (item.at(0), -0.40 * height + item.at(1))
                )
            );
        }
        for item in data.slice(0, -1).zip(data.slice(1)) {
            // link between two lines
            let i = item.at(0);
            let i = (i.at(0), -0.40 * height + i.at(1) - s);
            let j = item.at(1);
            let j = (j.at(0), -0.40 * height + j.at(1) - s);
            place(bottom + left, dx: 0pt, dy: 0pt, line(start: i, end: j));
        }
        // the width marker (h)
        let dist = data.at(2).at(0) - data.at(1).at(0);
        place(bottom + left, 
            dx: 0.5 * data.at(1).at(0) + 0.5 * data.at(2).at(0) - dist/2,
            dy: -0.20 * height,
            [#text(red, $overbrace(#h(dist), display(h))$)]
        )
    })
]

To derive a continuous extra, we first write $y_(n)(t)$ as $u(t, x_(n))$ . 

By Newton's second law, we have: 

$
    rho h frac(pp^2 u, pp t^2) (t, x_(n)) = h^(-1)k (u(t, x_(n)+h) + u(t, x_(n)-h) - 2 dot u(t, x_(n)))
$

When $h -> 0^+$ and let $c = sqrt(rho slash k)$, the last equation turns into: 

#definition("Mechanical Wave")[
    A mechanical wave is defined by equation 
    $"MechanicalW"(u, c, f, g)$, which is the following: 
    $
        bold("equation") #h(10pt)
        & frac(1, c^2) dot frac(pp^2 u, pp t^2)(x, t) = frac(pp^2 u, pp x^2)(x, t) \
        & f(x) = u(x, 0) \
        & g(x) = frac(pp u, pp t)(x, t:0)\
        & u(0, t) = u(pi, t) = 0 \
        bold("where") #h(10pt)
        & u: [0,pi] times RR -> RR\
        & f,g,h: RR -> RR,#h(0.4em) c: RR^+\
        & u "is continuously twice differentiable"\
        & u "is bounded"
    $
]

#comment("Definition:Mechanical_Wave")[
    Regarding degree of freedom, differential expressions look just like difference expressions. 
    For example, second order difference have $3$ free variables, which is also applicable to second order differential. 
]

#comment("Definition:Mechanical_Wave", alter: "Differential Symbol")[
    The current symbols used in mathematics is very annoying. 
    For example, when we write
    $
        frac(pp f, pp x)(y,x), frac(pp f, pp x)(x,y), frac(pp f, pp x)(y,z)
    $
    How do we know which entry is the partial differentiation applied?
    To avoid this kind of confusion, here we first "name the entry", and then apply the differentiation. 
    $
        frac(pp f, pp x)(y:x,x:y), frac(pp f, pp x)(a,x:b), frac(pp f, pp x)(x:y,z)
    $
]

#theorem("Solution to MechanicalW")[
    Solution to $"MechanicalW"(u, c, f, g)$ can be written as $u(x,t)=v(x - c t) + w(x + c t)$ , where $v$ and $w$ are $2 pi$-periodic functions. 
    #TODO[definition of $T$-periodic function]
    $
        v(x) = cases(
            & display(1/2 f(x) -1/2 integral_0^x c^(-1)g(x^*) dif x^*) 
                & "where" x in [0,pi]\
            & -w(2pi - t)
                & "where" x in (pi, 2pi)\
        )\
        w(x) = cases(
            & display(1/2 f(x) +1/2 integral_0^x c^(-1)g(x^*) dif x^*)
                & "where" x in [0, pi]\
            & -v(2pi -t)
                & "where" x in (pi, 2pi)
        )
    $
]

#proof("Theorem:Solution_to_MechanicalW", extra: "A")[
    One important observation is that taking $u(x, t) = v(x - c t)$ or $u(x, t) = w(x + c t)$ solves this equation. 
    Therefore, we may want to figure out if all solutions can be decomposed as $u(x, t) = v(x - c t) + w(x + c t)$ . \
    Apply change of variables: 
    $
        mat(xi; zeta) = mat(1, -c; 1, c;)mat(x;t) \
        u(x,t) 
        = hat(u)(x-c t, x + c t) \
            frac(pp^2 u, pp x^2)(x,t) 
            - frac(1, c^2)frac(pp^2 u, pp t^2)(x,t) 
        = 4frac(pp^2 hat(u), pp xi pp zeta)(xi: x - c t,zeta: x + c t) 
        = 0
    $
    With the conditions above, we have
    $
        frac(pp hat(u), pp xi)(xi, zeta) = frac(pp hat(u), pp xi)(xi, 0)\
        hat(u)(xi, zeta)
        = integral_(xi^*=0)^(xi) frac(pp hat(u), pp xi^*)(xi^*, zeta) dif xi^* 
            + hat(u)(0, zeta)
        = hat(u)(xi,0)
            + hat(u)(0,zeta)
            - hat(u)(0,0)
    $
    Let $v(xi) = hat(u)(xi, 0)- hat(u)(0,0)$ and $w(zeta)=hat(u)(0,zeta)$ .
    Using the following equations $forall x in [0, pi]$:
    $
        cases(
            display(
                u(x, 0) = v(x) + w(x) = f(x)
            ) \
            display(
                frac(pp u, pp t)(x, t:0)
                    = -c frac(pp v, pp x)(x) + c frac(pp w, pp x)(x) 
                    = g(x)
            )
        )
    $
    Therefore, when $forall x in [0, pi]$
    $
        v(x) = 1/2 f(x) -1/2 integral_0^x c^(-1)g(x^*) dif x^* - C\
        w(x) = 1/2 f(x) +1/2 integral_0^x c^(-1)g(x^*) dif x^* + C
    $
    Apply boundary conditions $u(pi, t) = u(0, t) = 0$, we find that $forall t in RR^+$
    $
        v(-c t) + w(c t) = 0\
        v(pi -c t) + w(pi + c t) = 0
    $
    Take $display(t = t^*-frac(pi,c))$ and $t = t^*$ where $t^* > pi/c$, we find that:
    $
        w(-pi + c t^*) = w(pi + c t^*)
    $
    Therefore, $w$ are $2 pi$-periodic on $RR^+$, which also means $v$ is $2pi$-periodic on $RR$. 
    For $t in [pi, 2pi]$:
    $
        w(t)=-v(2 pi - t) = -1/2 f(2pi -t) + 1/2 integral_0^(2pi -t) c^(-1)g(x^*) dif x^* + C\
        v(t)=-w(2 pi - t) = -1/2 f(2pi -t) - 1/2 integral_0^(2pi -t) c^(-1)g(x^*) dif x^* - C
    $
]

#proof("Theorem:Solution_to_MechanicalW", extra: "B")[
    Another solution is given by seperation of variables. 
    We assume $u(x, t)$ can be written as superpositions of $\{phi(x) dot psi(t): (phi, psi)\}$ and try to solve $phi$ and $psi$ . 
    This gives us $exists lambda<0:$
    $
        cases(
            display(phi(z) - lambda frac(dif^2 phi, dif x^2)(z) = 0)\
            display(psi(z) - frac(lambda, c^2) frac(dif^2 psi, dif x^2)(z) = 0)
        )
    $
    Here we must have $lambda < 0$, or otherwise it gives the trivial solution or a divergent solution over time, which violates the condition that $u$ is bounded. \
    Solving these equations as $display("SimpleHM"(phi, 1/sqrt(lambda)))$ and $display("SimpleHM"(phi, c/sqrt(lambda)))$ . 
    A valid base solution (regardless of boundary conditions) can be written as
    $
        u(x,t) = sin(m(x-zeta)) dot cos(m c(t-theta))
    $
    where $zeta$ and $theta$ are free parameters, and for simpliciy, we write $lambda$ as $m^(-2)$. \
    Applying boundary condition $u(0,t)=u(pi,t)=0$ . It is clear that
    $
        sin(-m zeta) = 0\
        sin(-m(pi -zeta)) = 0\
    $
    We can conclude that $m zeta$ is divisible by $pi$ and $m pi$ is divisible by $pi$. Therefore, $m$ must be an integer and $m zeta$ can be omitted inside $sin(dot)$ function. 
    $
        u(x,t)=sin(m x)dot cos(m c(t-theta))
    $
    #TODO[Uniqueness of solution given by Fourier Series]
]

#comment("Proof-B:Theorem:Solution_to_MechanicalW")[
    Historically, some famous mathematicians like Gauss incline strongly to @Proof-A:Theorem:Solution_to_MechanicalW. Their main reason is that @Proof-B:Theorem:Solution_to_MechanicalW is not rigorious, because people generally don't believe functions can be decomposed into trigonometric series. This tendency lasts until, later Fourier formally proves the uniqueness of trigonometric decomposition in his study of heat flow (@Heading-L3:Heat_Flow). 
]

=== Heat Flow <Heading-L3:Heat_Flow>

While in @Heading-L3:Mechanical_Wave, we demonstrated how to solve differential equations with standing waves in @Proof-A:Theorem:Solution_to_MechanicalW and seperation of variables in @Proof-B:Theorem:Solution_to_MechanicalW, the method of standing waves are not applicable to many other differentiale equations. In this section, we introduce another physical problem: heat flow, and we will see that heat flow can be solved with seperation of variables. 

The thermal energy on a plate changes with time. Let's first suppose the plate is divided into small grids and inside seach grid, heat is transported instantly. Therefore, each grid internally have uniform temperature, as shown in @Figure:Heat_Flow_on_a_Plate. 

According to Newton's law of cooling, the adjacent tiles results in the following equation:
$
    kappa h^2 frac(pp u, pp t)(x_n, y_n, t) =
    rho (u(x_n, y_(n+1), t) - u(x_n, y_n, t))\
    + rho (u(x_n, y_(n-1), t) - u(x_n, y_n, t))\
    + rho (u(x_(n+1), y_n, t) - u(x_n, y_n, t))\
    + rho (u(x_(n-1), y_n, t) - u(x_n, y_n, t))
$

On the left hand side, $kappa h^2 u(x_n,y_n,t)$ is the thermal energy on a square, and the partial derivative describes how temperature changes over time. On the right hand side, $rho$ is the conductivity coefficient, and $u(x_((dot)), y_((dot)), t) - u(x_n, y_n, t)$ is the difference of temperature between adjacent grids. 

#illustration("Heat Flow on a Plate")[
    // for padding
    #rect(stroke: none, inset: 10pt)[
        // draw rectangles in grid
        #let r = rect(stroke: blue, width: 3cm, height: 3cm, outset: 0pt, inset: 0pt)[]
        #grid(columns: 3, ..range(9).map(_ => r))
        // justified placement
        #let jp(dx, dy, content) = context [
            #let s = measure(content);
            #place(dx: dx - s.width / 2, dy: dy - s.height / 2)[#content]
        ]
        // color green
        #let cg(x) = [#set text(green) 
            #x]
        // 4 math.display as space
        #let d4 = for i in range(4) { math.display(" ") }
        // rotate 90 deg
        #let r9(x) = rotate(90deg, x)
        #jp(100%/3, -50%, [$xarrow(sym: <->, d4)$])
        #jp(50%, -100%/3, [#r9($xarrow(sym: <->, d4)$)])
        #jp(200%/3, -50%, [$xarrow(sym: <->, d4)$])
        #jp(50%, -200%/3, [#r9($xarrow(sym: <->, d4)$)])
        #jp(50%, -50%,      [$u(x_n,y_n,t)$])
        #jp(50%, -50%/3,    [$u(x_n,y_(n+1),t)$])
        #jp(50%, -250%/3,   [$u(x_n,y_(n-1),t)$])
        #jp(250%/3, -50%,   [$u(x_(n+1),y_n,t)$])
        #jp(50%/3, -50%,    [$u(x_(n-1),y_n,t)$])
        #jp(100% + 5pt, -250%/3, [#cg(r9($overbrace(d4 d4 d4 d4 d4 d4,h)$))])
        #jp(250%/3, -100% - 5pt, [#cg($overbrace(d4 d4 d4 d4 d4 d4,h)$)])
    ]
]

Write $x_(n+m)$ as $x_(n)+ m h$ and $y_(n+m)$ as $y_(n) + m h$, mimicing @Heading-L3:Mechanical_Wave, we can form a formal definition. 

#definition("Heat Flow")[
    $"HeatF"(u)$
    $
        bold("equation") #h(10pt)        
        & frac(pp u, pp t)(x,y,t) = frac(pp^2 u, pp x^2)(x,y,t) + frac(pp^2 u, pp y^2)(x,y,t)\
        bold("where") #h(10pt)
        & u:RR^3 -> RR
    $
    #TODO("Boundary Conditions")
]

=== Miscellaneous & Exercises

#definition("Laplacian")[
    For a function $u:RR times RR -> RR$, its Laplacian is defined as:
    $
        Delta(u) 
            = (x,y) |-> frac(pp^2 u, pp x^2)(x,y) + frac(pp^2 u, pp y^2)(x,y)
    $
]

#theorem("Polar Expression of Laplacian")[
    Let $hat(u)(r, theta) = u(r cos(theta), r sin(theta))$ where $hat(u): [0,+infinity) times [0, 2pi) -> RR$
    $
        Delta(u)(r cos(theta), r sin(theta))
            = frac(pp^2 hat(u), pp r^2)(r, theta)
            + frac(1, r)frac(pp hat(u), pp r)(r, theta)
            + frac(1, r^2)frac(pp^2 hat(u), pp theta^2)(r, theta)
    $
]

#proof("Theorem:Polar_Expression_of_Laplacian")[Use $x=r cos(theta)$ and $y=r sin(theta)$ as macro. 
    $
    frac(pp hat(u), pp r)(r, theta) &
        = cos(theta) frac(pp u, pp x)(x,y) 
        + sin(theta) frac(pp u, pp y)(x,y)\
    $
    $
    frac(pp^2 hat(u), pp r^2)(r, theta) &
        = cos^2(theta) frac(pp u, pp x)(x,y) 
        + sin^2(theta) frac(pp u, pp y)(x,y)\
        &+ 2 sin(theta) cos(theta) frac(pp^2 u, pp x pp y)(x,y)\
    $
    $
    frac(pp hat(u), pp theta)(r, theta) &
        = -r sin(theta) frac(pp u, pp x)(x,y)
        +r cos(theta) frac(pp u, pp y)(x,y)\
    $
    $
    frac(pp^2 hat(u), pp theta^2)(r, theta)
        &= -r cos(theta) frac(pp u, pp x)(x,y)
            -r sin(theta) frac(pp u, pp y)(x,y)\
        &+ r^2 sin^2(theta) frac(pp^2 u, pp x^2)(x,y)
            +r^2 cos^2(theta)frac(pp^2 u, pp y^2)(x,y)\
        &-2r^2 sin(theta) cos(theta) frac(pp^2 u, pp x pp y)(x,y)\
    $
    Adding them up proves the result
    $
        Delta(u)(x,y)
            = frac(pp^2 hat(u), pp r^2)(r, theta)
            + frac(1, r)frac(pp hat(u), pp r)(r, theta)
            + frac(1, r^2)frac(pp^2 hat(u), pp theta^2)(r, theta)
    $
]

#TODO[Clean up the exercises]

== Fourier Series

=== Basic Definitions

Fourier series is defined for functions with bounded domain. 

#definition("Fourier Coefficient")[
    For a function $f: [a, b] -> RR$ . 
    Its $n$-th Fourier coefficient $hat(f) = "FourierCoeff"(f): ZZ -> CC$ is defined as:
    $
        &hat(f)(n) = frac(1,b-a) integral_a^b f(x) exp(-2pi i n x slash L) sp dif x\
        &"where" i "is the imaginary unit"\
        &"where" L "is" b - a
    $
]

#definition("Fourier Series")[
    For a function $f: [a, b] -> RR$ . 
    Its $n$-th partial sum in Fourier series $tilde(f) = "FourierS"(f): NN -> [a, b] -> CC$ is defined as:
    $
        &tilde(f)(n)(x) = sum_(m=-n)^n hat(f)(n)(x) exp(2 pi i m x slash L)\
        &"where" i "is the imaginary unit"\
        &"where" L "is" b - a\
        &"where" hat(f) "is" "FourierCoeff"(f)
    $
]

It is natural to ask if Fourier series converges to the original function, and if Fourier coefficients give a unique description of a function. But from a technical point of view, we know that changes on a finite set of points will not be reflected in Fourier coefficients, so we may have to work on a weaker one. 

#theorem("Weak Convergence of FourierS")[
    If $f: [a, b] -> RR$ is a Riemann integrable function, then for any $x$ where $f$ is continuous at $x$: 
    $
       &lim_(n -> infinity) tilde(f)(n)(x) = f(x) \
       &"where" tilde(f) "represents" "FourierS"(f)
    $
]

#proof("Theorem:Weak_Convergence_of_FourierS")[
    Let $hat(f)$ be the Fourier coefficients of $f$, and set $L=b-a$. 
    We also define:
    $
        f^(\\)(n)(x) = f(x) - sum_(m=-n)^n hat(f)(n) exp(2 pi i m x slash L)
    $
    Now we want to prove $display(lim_(n -> infinity) f^(\\)(n)(x) = 0)$ where $f$ is continuous at $x$. 
    Since $f$ is continous at $x$, so is $f^(\\)(n)$. 
    For each given $epsilon$, there must exists $delta$ such that 
    $
        forall x^* in (x-delta, x+delta): 
            |f^(\\)(n)(x^*) - f^(\\)(n)(x)| < epsilon
    $
    For any given $n$, we can pick an $display(epsilon(n) = 1/2|f^(\\)(n)(x)|)$ to acquire a single-signed short interval. 
    However, for any $n$, the following integral must be $0$ 
    $
        lim_(n->infinity) integral_a^b (zeta + cos((2pi(x-a))/(b-a)))^m f^(\\)(n)(x) dif x = 0
    $
]

#theorem("Convergence of Trigonometric Series")[
    For a function $f: [a, b] -> RR$ , if $f$ is square Lebesgue integrable, then except for a set $E$ of measure zero, 
    $
        forall x in [a,b] backslash E: lim_(n -> infinity) tilde(f)(n)(x) = f(x)
    $
]

#theorem("Convergence of FourierS")[
    For a function $f: [a, b] -> RR$ , if $f$ is square Lebesgue integrable, then except for a set $E$ of measure zero, 
    $
        forall x in [a,b] backslash E: lim_(n -> infinity) tilde(f)(n)(x) = f(x)
    $
    #TODO[Definition of square Lebesgue integrable]
    #TODO[Proof of this theorem]
]

#collary("Theorem:Convergence_of_FourierS", alter: "Uniqueness of FourierS")[
    If functions $f$ and $g$ on $[a,b] -> RR$ have the same Fourier coefficients, then except for a set $E$ of measure zero,
    $
        forall x in [a,b] backslash E: f(x) = g(x)
    $
]

=== Convolutions

=== Good Kernels

== Fourier Transformation
