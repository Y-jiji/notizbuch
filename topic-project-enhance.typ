#import "template.typ": *
#show: with-setup

= Extending Existing Project

#summary[
    #tag[pragmatic:mod] If you participate in a open source project, or start working on a lab assignment, you may find each of them sucks in their own way, while several of them suck less. Usually, to add new features to existing projects, one has to navigate through several layers, while trying not to break anything. This requires a fast and tight grasp of relevant modules by merely read the code. 
]

== `SELECT ... ORDER BY ...` in MiniOB

=== Background

#tag[miniob:intro] MiniOB is an educational database system, built by the Oceanbase Team as an internal training facility. Later Oceanbase hosted a database implementation contest, and used MiniOB as the prototype system (https://github.com/oceanbase/miniob). From the participants' comments that I collected, this codebase is really a shitbase. 

#tag[miniob:environment] Luckily, MiniOB provides script for environment configuration. The `build.sh` in the root directory will install some library files in your system, which is sort of disgusting. Also, MiniOB only compiles with GCC. 

=== Code Reading : Lifecycle of a Transaction

#tag[miniob:order-by:parse]

#task[Where to find YACC?]

=== Modification

#tag[miniob:order-by:parse:mod] To modify the parser, one have to add an optional clause to existing `SELECT` statement parser. 
