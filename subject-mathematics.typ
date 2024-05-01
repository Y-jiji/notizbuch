#import "template.typ": *
#show: setup("Topic")

#build-cover(595.28pt-5cm, 841.89pt-5cm, 2.5cm, 2.5cm, "Mathematical", "Analysis", "解析", "か", "いせき")
#include "topic-fourier-analysis.typ"
#include "topic-differential-geometry.typ"

#pagebreak()
#build-cover(595.28pt-5cm, 841.89pt-5cm, 2.5cm, 2.5cm, "Advanced", "Algebra", "代数", "だ", "いすう")
#include "topic-finite-linear-space.typ"
