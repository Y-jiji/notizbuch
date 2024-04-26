#import "template.typ": *
#show: setup

= Neural Networks

#summary([#lorem(10)])[#lorem(50)]

== Low Rank Adaptation

=== Inference w/ Multiple LoRAs

In industry, companies like openai allow users to #link("https://web.archive.org/web/20240301122528/https://openai.com/blog/introducing-gpts", "customize language models") by uploading finetuning data. Consequently, it will results in multiple LoRAs served at the same time. Whereas intergrating LoRAs into base parameters is beneficial for a single language model, it is definitely a burden when serving multiple LoRAs. 

To serve multiple LoRAs, we better keep these LoRAs and engineer a custom CUDA kernel to compute them in parallel. Also, we have to mind batching and offloading strategy. 



