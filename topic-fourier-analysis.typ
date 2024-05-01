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
        &frac(dd^2 y, dd t^2)(t) + k^2 y(t) =0\
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

#proof("Solution to SimpleHM")[
    Given $"SimpleHM"(y, k)$, we verify: 
    $
        frac(dd^2 y, dd t^2)(t) = - a k^2 sin(k t) - b k^2 cos(k t)
    $
    Then, for a solution $y$, we try to compute $(a,b)$ so that 
    $
        y(t) &= a sin(k t) + b cos(k t)\
        k^(-1) frac(dd y, dd t)(t) &= a cos(k t) - b sin(k t)
    $
    We observe that
    $
        g(t) = cos(k t) dot y(t) - sin(k t) dot  k^(-1) frac(dd y, dd t)(t)\
        frac(dd g, dd t)(t) = 0
    $
    By analogy
    $
        h(t) = sin(k t) dot y (t) + cos(k t) dot k^(-1) frac(d y, d t)(t)\
        frac(dd h, dd t)(t) = 0
    $
    Let $a = g(t)$ and $b = h(t)$.
    We have
    $
        y(t) = a dot cos(k t) + b dot sin(k t)
    $
]

=== Mechanical Wave

In this section, we mainly talk about a solution tactic called seperation of variables. 

This tactic can be used to reduce equations of several variables to equations with a single variable. 

However, we have to introduce mechanical wave first. This equation depicts not only the motion of a single point, but intertwined motion of particles on a string. 

This model originates from a multi-particle system: 
+ Like any model in classic physics, quantities like $y_((dot))$ are functions of time $t$ by default. 

+ There are tracks on a plane #text(blue, [(blue, dashed line in #ref(label("Vibrating Particles on Tracks")))])
+ These tracks are uniformly distanced #text(red, [($h$ in #ref(label("Vibrating Particles on Tracks")))])
+ There are particles moving along each track #text(black, [($#circle(width: 5pt)$ in #ref(label("Vibrating Particles on Tracks")))])
+ Each particle is affected only by its neighbouring particles. Vertical component of the force given by $y_(j+1)$ to $y_(j)$ is $h^(-1)k(y_(j+1) - y_(j))$ . 
+ Each particle has weight $rho h$ (when we vary $h$, the total weight of this particle string don't change)

#illustration("Vibrating Particles on Tracks")[
    // picture size
    #let width  = 10cm;
    #let height = 5cm;
    // marker size
    #let s = 5pt;
    #let c = circle(width: s);
    #let computex(x) = x / 5 * width + 0.5 * width;
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
        place(
            bottom + left, 
            dx: computex(-2.5) - 3 * s, 
            dy: -0.20 * height, 
            $dots dots$
        );
        place(
            bottom + left, 
            dx: computex(3) - 6 * s, 
            dy: -0.20 * height, 
            $dots dots$
        );
        for item in data {
            let placey(dy, content) = place(
                bottom + left, 
                dx: item.at(0) - s/2, 
                dy: dy + s/2, 
                content
            );
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
            let i = (i.at(0), -0.40 * height + i.at(1));
            let j = item.at(1);
            let j = (j.at(0), -0.40 * height + j.at(1));
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
        & u "is continuously twice differentiable"
    $
]

#comment("Mechanical Wave")[
    Regarding degree of freedom, differential expressions look just like difference expressions. 
    For example, second order difference have $3$ free variables, which is also applicable to second order differential. 
]

#comment("Mechanical Wave", extra: "about differential")[
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
]

#proof("Solution to MechanicalW", extra: "A")[
    One important observation is that taking $u(x, t) = v(x + c t)$ or $u(x, t) = w(x - c t)$ solves this equation. 
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
        = integral_(xi^*=0)^(xi) frac(pp hat(u), pp xi^*)(xi^*, zeta) dd xi^* 
            + hat(u)(0, zeta)
        = hat(u)(xi,0)
            + hat(u)(0,zeta)
            - hat(u)(0,0)
    $
    Let $v(xi) = hat(u)(xi, 0)- hat(u)(0,0)$ and $w(zeta)=hat(u)(0,zeta)$ .
    $
        u(x, 0) 
            = v(x) + w(x) = f(x) \
        frac(pp u, pp t)(x, t:0)
            = -c frac(pp v, pp x)(x) + c frac(pp w, pp x)(x) = g(x)
    $
    Therefore, when $x in [0, pi]$
    $
        v(x) = 1/2 f(x) -1/2 integral_0^x c^(-1)g(x^*) dd x^*\
        u(x) = 1/2 f(x) +1/2 integral_0^x c^(-1)g(x^*) dd x^*
    $
    #TODO[How to extend this result over $t$ ?]
]

#proof("Solution to MechanicalW", extra: "B")[
    Another solution is given by seperation of variables. 
    We assume $u(x, t)$ can be written as superpositions of $\{phi(x) dot psi(t): (phi, psi)\}$ and try to solve $phi$ and $psi$ . 
    This gives us
    $
        cases(
            display(phi(z) - lambda frac(dd^2 phi, dd x^2)(z) = 0)\
            display(psi(z) - frac(lambda, c^2) frac(dd^2 psi, dd x^2)(z) = 0)
        )
    $
    #TODO[In book, there is no formal proof for (lamba < 0), so I'm stuck. May be after reviewing fourier series I'll be able to do this. ]
]

=== Heat Diffusion

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

#proof("Polar Expression of Laplacian")[Use $x=r cos(theta)$ and $y=r sin(theta)$ as macro. 
    $
    frac(pp hat(u), pp r)(r, theta) &
        = cos(theta) frac(pp u, pp x)(x,y) 
        + sin(theta) frac(pp u, pp y)(x,y)\
    frac(pp^2 hat(u), pp r^2)(r, theta) &
        = cos^2(theta) frac(pp u, pp x)(x,y) 
        + sin^2(theta) frac(pp u, pp y)(x,y)\
        &+ 2 sin(theta) cos(theta) frac(pp^2 u, pp x pp y)(x,y)\
    frac(pp hat(u), pp theta)(r, theta) &
        = -r sin(theta) frac(pp u, pp x)(x,y)
        +r cos(theta) frac(pp u, pp y)(x,y)\
    frac(pp^2 hat(u), pp theta^2)(r, theta) &
        = -r cos(theta) frac(pp u, pp x)(x,y)
        -r sin(theta) frac(pp u, pp y)(x,y)\
        &+ r^2 sin^2(theta) frac(pp^2 u, pp x^2)(x,y)\
        &-2r^2 sin(theta) cos(theta) frac(pp^2 u, pp x pp y)(x,y)\
        &+r^2 cos^2(theta)frac(pp^2 u, pp y^2)(x,y)
    $
    Adding them up proves the result
    $
        Delta(u)(x,y)
            = frac(pp^2 hat(u), pp r^2)(r, theta)
            + frac(1, r)frac(pp hat(u), pp r)(r, theta)
            + frac(1, r^2)frac(pp^2 hat(u), pp theta^2)(r, theta)
    $
]

== Fourier Series

== Fourier Transformation

