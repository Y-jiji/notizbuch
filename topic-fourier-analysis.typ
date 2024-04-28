#import "template.typ": *
#show: setup

= Fourier Analysis

#summary([#lorem(10)])[#lorem(50)]

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

=== Temporal-spatial Wave Equation

In this section, we mainly talk about a solution tactic called seperation of variables. 

This tactic can be used to reduce equations of several variables to equations with a single variable. 

However, we have to introduce temporal-spatial wave equation first. This equation depicts not only the motion of a single point, but intertwined motion of particles on a string. 

This model originates from a multi-particle system: 
- Like any model in classic physics, quantities like $y_((dot))$ are functions of time $t$ by default. 
- There are tracks on a plane #text(blue, [(blue, dashed line in #ref(label("Vibrating Particles on Tracks")))])
- These tracks are uniformly distanced #text(red, [($h$ in #ref(label("Vibrating Particles on Tracks")))])
- There are particles moving along each track #text(black, [($#circle(width: 5pt)$ in #ref(label("Vibrating Particles on Tracks")))])
- Each particle is affected only by its neighbouring particles. Vertical component of the force given by $y_(j+1)$ to $y_(j)$ is $h^(-1)k(y_(j+1) - y_(j))$ . 
- Each particle has weight $rho h$ (when we vary $h$, the total weight of this particle string don't change)

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

To derive a continuous version, we first write $y_(n)(t)$ as $u(t, x_(n))$ . 

By Newton's second law, we have: 

$
    rho h frac(partial^2 u, partial t^2) (t, x_(n)) = h^(-1)k (u(t, x_(n)+h) + u(t, x_(n)-h) - 2 dot u(t, x_(n)))
$

When $h -> 0^+$ and let $c = sqrt(rho slash k)$, the last equation turns into: 

#definition("Spatial Temporal Wave")[
    A spatial temporal wave is defined by equation 
    $"SpatialTW"(u, a, b, c, f,g,h,k)$, which is the following: 
    $
        bold("equation") #h(10pt)
        & frac(1, c^2) dot frac(partial^2 u, partial t^2)(t, x) = frac(partial^2 u, partial x^2)(t, x) \
        & f(x) = u(0, x) \
        & g(x) = frac(partial u, partial t)(t=0, x)\
        & h(x) = u(t, a) \
        & k(x) = u(t, b) \
        bold("where") #h(10pt)
        & u: [a,b] times RR -> RR\
        & f,g,h,k: RR -> RR \
        & a,b: RR, #h(4pt) c: RR^+\
        & u "is twice differentiable"
    $
]

#comment("Spatial Temporal Wave")[
    Regarding degree of freedom, differential expressions look just like difference expressions. 
    For example, second order difference have $3$ free variables, which is also applicable to second order differential. 
]

#theorem("Solution to SpatialTW")[
    
]

#proof("Solution to SpatialTW", version: "A")[
    One observation is that taking $u(x, t) = v(x + c t)$ or $u(x, t) = w(x - c t)$ solves this equation. 
    Therefore, we may want to figure out if all solutions can be decomposed as $u(x, t) = v(x - c t) + w(x + c t)$ . \
    Apply change of variables: $(xi, zeta) <- (x - c t, x + c t)$ to equation
    $
        (frac(partial u, partial x)(x, t), 
        frac(partial u, partial t)(x, t))
        =
        (frac(partial hat(u), partial xi)(xi, zeta), 
        frac(partial hat(u), partial zeta)(xi, zeta))
        mat(
            display(frac(partial xi, partial x)), display(frac(partial xi, partial t));
            display(frac(partial zeta, partial x)), display(frac(partial zeta, partial t));
        )
    $
    Again, for $display(frac(partial^2 u, partial x^2)(x, t))$, change of variables gives:
    $
        (frac(partial^2 u, partial x^2)(x, t), 
        frac(partial^2 u, partial x partial t)(x, t))
        =
        
    $
]

#proof("Solution to SpatialTW", version: "B")[
    Another solution is given by seperation of variables. 
    We assume $u(x, t) = phi(x) dot psi(t)$ and try to solve $phi$ and $psi$ . 
]

=== Heat Diffusion

=== Miscellaneous & Exercises

== Fourier Series

== Fourier Transformation

