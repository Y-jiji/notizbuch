#import "template.typ": *
#show: setup("Topic")

#build-eva(595.28pt-5cm, 841.89pt-5cm, 2.5cm, 2.5cm, "Mathematical", "Analysis", "解析", "か", "いせき")
#include "topic-fourier-analysis.typ"
#include "topic-differential-geometry.typ"

#pagebreak()
#context build-eva((595.28pt-5cm).to-absolute(), (841.89pt-5cm).to-absolute(), 2.5cm, 2.5cm, "Advanced", "Algebra", "代数", "だ", "いすう")
#include "topic-finite-linear-space.typ"

#pagebreak()
#context build-eva((595.28pt-5cm).to-absolute(), (841.89pt-5cm).to-absolute(), 2.5cm, 2.5cm, "Contemplated", "Math", "数学", "反省", "はんせい")
#include "topic-soft-and-hard-math.typ"