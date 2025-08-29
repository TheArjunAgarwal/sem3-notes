#import "modules/notes.typ": *
#import "@preview/finite:0.5.0": *
#show: thm-rules

#let fold = $op("fold")$

#show: noteworthy.with(
  paper-size: "a4",
  language: "EN",
  title: "Theory of Computation",
  author: "Arjun Maneesh Agarwal",
  prof : "C Aiswarya",
  course-desc: [
    This is the first coutse about computablity course, we will see what can be computed and what can't be computed? We will try to define a computer (through models of computation) and try to answer these questions.
  ],
  contact-details: "thearjunagarwal.github.io", // Optional: Maybe a link to your website, or phone number
  toc-title: "Table of Contents"

)

= Random Quotes
#quote[
  This course is a difficult one, but if you work hard, it is easy.
]

= Introduction
While some people can compute squares, a toddler can't. This would make the core question extreamly philosphical, but as this is a computation course, we will focus on what computers can compute.
#definition(title: "Descision Problems")[
  A problem which given a *valid input* should have an boolean output (yes or no) is called a descision problem.
] 
This definition poses the problem: how do we define a valid input? 

Given the problem of determining if the input is prime, then "chennai" or "CMI" is not a valid input. But to restrict our outputs to boolean, we will put a restriction on the inputs that can be given to us; by constraining the language of communication itself!
= Formal Language Theory
#definition(title: "Languages")[
  A language is a set of words.
]
#definition(title: "Words")[
  A word is a sequence (of finite length) of letters from a finite alphabet. We tend to use $Sigma$ or $A$ to denote alphabets.
]
#definition(title: "Empty word")[
  A word with no letters is $epsilon$.
]
#definition(title: "Empty Language")[
  A language with no words is $emptyset$.
]
#definition(title: "Cannonical Language")[
  Given a descision problem, a cannonical language is the set of all words which have the answer 'yes' or 'true' when given as input to descision problem. 
]
#example[
  Given the alphabet ${0,1,dots,9}$, we can define languages such as:
  - even numbers
  - numbers with at least 5 length
  - numbers with 5 different letters.
  - number whoose last digit is 5 or 0
  - -First and last digit are the same.
]
#definition()[
  The set of all words given language $Sigma$ is $Sigma^*$. Thus, all languages $L subset.eq Sigma^*$.
]
#thm[Number of words is $aleph_0$.]
#proof[
  We can enumerate the words, provided an ordering on the alphabets. 
  
  For example, in the case of $Sigma = {0,1,dots, 9}$, our ordering would be:
$
epsilon, 0, 1, dots, 9, 00, 01, dots, 99, 000, dots 
$
]

This tells us that we have $2^(aleph_0)$ or uncountably infinite languages. Thus, by the cannonical language bijection, we can have uncountably infinite languages.

We can thus, not enumerate the languages and need some other way.

= Automata Theory
// Complete definition!!!!!
#definition(title: "Automata")[
  Automata is a directed graph which can have self loops.
  #automaton((
  q1:(),
  q2:()
)) 
]
// Aish's bad automata
#automaton((
  q1:(q2:"c", q4:"a,b"),
  q2:(q2:"a",q3:"c"),
  q3:(q4:"c"),
  q4:(q1:"b,a",q2:"a,b",q4:"c,b")
),
final: ("q4"),
layout:layout.grid.with(columns:2, spacing: 5)
)

This graph accepts the word "abaccabbbab".

Note that the graph need not have a single path for an letter in the alphabet, it can have none or multiple. If it is none, the word is rejected. If there are more than one paths from some letter, we have a non-deterministic finite automata which means, we have to try all the valid paths and see if it reaches a final state.
#example[
#automaton((
  q1:()
))
This automaton only accepts the accepts only the empty word.

#automaton((
  q1:(q1:"a,b,c")
),
initial: "q1",
final: none)
This automaton accepts only the empty langauage.
#automaton((
  q1:(q1:"a,b,c")
))
This automaton accepts all possible words.
]

An possible exam problem could be, given a language, make an automaton to check for them.
#exercise[
  Given: $Sigma = {0,1}$\
  + Language: Set of all words of length $>= 3$
  + Language: Set of all even binary numbers.
]
#solution[
  #automaton((
    q1: (q2:(0,1)),
    q2:(q3:(0,1)),
    q3:(q4:(0,1)),
    q4:(q4:(0,1))
  ))
  A Deterministic solution is:
  #automaton((
    q1: (q1:(1), q2:(0)),
    q2:(q2:(0), q1:(1)),
  ))
  But we can also make a non-deterministic solution:
  #automaton((
    q1: (q1:(1), q2:(0)),
    q2:(),
  ))
  Here the non-determisim turns up as we don't know if we are on the last letter of the word or not.
]

#exercise[
  Language such that it contains binary numbers that are divisible by $3$.
]
#solution[
  #automaton(
    (
    q1 : (q1:(0), q2:(1)), // Make end
    q2 : (q1:(1), q3:(0)),
    q3 : (q3:(1), q2:(0))
    ),
    labels:(
      q1 : "0",
      q2: "1",
      q3: "2"
    ),
    initial: "q1",
    final: "q1",
    )
]
#idea(title: "Functional Automata")[
  Instead of denoting auatomata using the diagram, we can use a Functional approach. An automata is $(Q, Sigma, Delta, s, F)$ where $Q$ is the set of states, $Sigma$ the alphabet, $Delta$ a function of type $Q times Sigma -> 2^Sigma$ #footnote[In deterministic case, we take $Q times Sigma -> Sigma$.], $S subset.eq Q$ is the set of start states and $F subset.eq Q$ is set of final states.

  We can think of $Q, Sigma, s, F$ as broiler plate and $delta$ as where the real magic happens.
]
If one looks at the type of $delta$, we can clearly see some equivalence to `foldr` or `foldl`. Indeed, an automata is can be denoted as function: `automata :: ` $[Sigma] -> delta -> $ 
#todo[]

#definition(title: "Run")[
  A run of $cal(A)$ on $w$ is:
  $
  q_0 ->^(a_1) q_1 ->^(a_2) q_2 ->^(a_3) dots ->^(a_n) q_n
  $
  where $q_0 in S$, $(q_(i-1), a_i, q_i) in delta$.
]
#definition(title:"Accepting Runs")[
  A run is called accepting if $q_n in F$.
]
#definition(title: "Language of Automata")[
  $
  L(cal(A)) = {w | cal(A) "has an accpeting run on" w}
  $
]

#exercise[
  Given $Sigma = {a, b}$
  + First and second last letter are the same. The lower sub-questions are hints.
  + First letter is an $a$
  + Second last letter is an $a$
  + 2 and 3 first and second last letters are $a$.
]<ex1>
#solution[
  #automaton(
    (
    q0 : (q1:("a")),
    q1 : (q1:("a,b"), q2:("a")),
    q2 : (q3:"a,b"),
    q3 : (none),

    q4 : (q5:("b")),
    q5 : (q5:"a,b", q6:"a"),
    q6 : (q7:"a,b"),
    q7: (none),
    
    q8 : (q9 : "a,b"),
    q9 : (q10 : "a,b"),
    q10 : (none)
  ),
  initial: "q0,q4,q8",
  final: "q3,q7,q10",
  layout: layout.grid.with(columns: 4, spacing: 2)
  )#footnote[Aish's solution.]
  #automaton(
  (
    q0 : (q1:("a"), q4:("b"), q7:"a,b"),
    q1 : (q1:("a,b"), q2:("a")),
    q2 : (q3:"a,b"),
    q3 : (none),
    q4 : (q4:("a,b"), q5:("b")),
    q5 : (q3:"a,b"),
    q7 : (q3 : "a,b")
  ),
  final: "q3",
  layout: layout.grid.with(columns: 2, spacing: 3)
  ) #footnote[Neel's solution]
]

This implies if we have an automata for $L_1$ and $L_2$ then we have an automata for $L_1 union L_2$ by just keeping both together. 

Note that the number of finite state automata are countable. Hence, there are only a countable number of languages we can recognize.

#definition(title:"Recognizable Languages")[A language which can be recognized using a finite state non-deterministic automata is called Recognizable Language.]

We can see that the set of recognizable langauages is closed under union. What about intersection?

#definition(title : "Deterministic Finite State Automata")[
  A DFA is an automata is $(Q, Sigma, delta, s, F)$ where $Q$ is the set of states, $Sigma$ the alphabet, $delta$ a function of type $Q times Sigma -> Sigma$, $S subset.eq Q$ is the set of start states and $F subset.eq Q$ is set of final states.

  We can think of $Q, Sigma, s, F$ as broiler plate and $delta$ as where the real magic happens.
]

#exercise[
  Now make a DFA solving the above excercise.
]
#solution[
  Once we read the first character, we will branch into two sub-automata. We will show the automata for $a$ (that is the string starts with $a$).

  We will see the side case for the length $2$ later. If we assume that the string is of the form `[a:xs]` and  `length xs >= 2`, we can make a autmata by simply storing care a two character state.
  #automaton(
    (
      Ia:(a:"a", Ia:"b"),
      a:(aa:"a", ab:"b"),
      aa:(aa:"a", ab:"b"),
      ab:(a:"a", Ia:"b")
    ),
    final: ("aa","ab"),
    layout: layout.snake.with(columns: 2, spacing: 7)
  )


We can accomadate the edge case by simply adding a special `Iap2` denoting the initial case with possiblity of length $2$ and move to the full automata once this is ruled out.

#automaton(
    (
      Iap2:(ap2:"a", Ia:"b"),
      ap2:(aa:"a", ab:"b"),
      aa:(aa:"a", ab:"b"),
      ab:(a:"a", Ia:"b"),
      Ia:(a:"a", Ia:"b"),
      a:(aa:"a", ab:"b")
    ),
    final: ("aa", "ab", "ap2"),
    layout: layout.snake.with(columns: 2, spacing: 7)
  )
  We will denote this as $cal(A)_a$ and the analogue for $b$ as $cal(A)_b$.

  This makes the final automata:
  #automaton(
    (
      q0:(q1:"a", q2:"b"),
      q1: none,
      q2: none
    ),
    final:none,
    labels: (
      q1: [$cal(A)_a$],
      q2: [$cal(A)_b$]
    )
  )
  The full code to make the automaton is given below (not rendered for space purposes).
  ```
  #automaton(
  (
    q0:(Iap2:"a", Ibp2:"b"),

    // A_a branch
    Iap2:(ap2:"a", Ia:"b"),
    ap2:(aa:"a", ab:"b"),
    Ia:(a:"a", Ia:"b"),
    a:(aa:"a", ab:"b"),
    aa:(aa:"a", ab:"b"),
    ab:(a:"a", Ia:"b"),

    // A_b branch (symmetrical to A_a)
    Ibp2:(bp2:"b", Ib:"a"),
    bp2:(bb:"b", ba:"a"),
    Ib:(b:"b", Ib:"a"),
    b:(bb:"b", ba:"a"),
    bb:(bb:"b", ba:"a"),
    ba:(b:"b", Ib:"a")
  ),
  final: ("ap2", "aa", "ab", "bp2", "bb", "ba"),
)
```
]
== Subset Construction
#example[
  We will try to convert this to a DFA by keeping track of states we could be in
  #automaton(
    (
      q1:(q2:"a,b", q1:"b", q5:"a"),
      q2:(q2:"b", q1:"b", q5:"a"),
      q3:(q3:"a,b"),
      q4:(q3:"b", q5:"a"),
      q5:(q5:"a,b"),
      q6:(q4:"b")
    ),
    initial: ("q1", "q4"),
    final: ("q1", "q2", "q5"),
    layout: layout.snake.with(columns: 2, spacing: 3)
  )
  with initial states $q_1$ and $q_4$.
  We will begin at ${1,4}$ and then move to all states where we could be. That is:
  $
  delta(S, a) = union.big_(s in S) Delta(s, a)
  $
  and the state space be $2^Q$ of the NFA. In practice, we don't use all the $2^Q$ directly and instead build the thing one by one considering letter by letter to avoid talking about subsets which can't ever be created. Remember, in DFA, we have 1 trasition per alphabet.
  #algo[
    
#psudo(title:"DFA to NFA")[
      + def delta(a, S, nfaDelta):
      + ans = []
      + for s in S:
        + k = nfaDelta(a,s)
        + if k not in ans:
          + push k ans
      + return ans
    
    + def func(alphabet, nfaDelta, S, nfaFinal):
      + initial = S
      + dfaDelta = []
      + final = []
      + unVisited = Queue [S]
      + checked = []
      + while unVisited is not empty:
      + state = pop unVisited
      + for s in state:
      + if state in nfaFinal:
        + push s final
        + break
        + for a in alphabet:
          + k = delta(a, S)
          + DFA[state][a] = k
          + if k in checked:
            +continue
          + else:
            + push k unVisited 
      + return(alphabet, checked, initial, dfaDelta, final)
]

  ]
  Running this algo, we will get:
  #todo[Will just program this!]
]

#thm[Our algorithm indeed creates a DFA which accepts the same langauage.]
#proof[
  We will prove this by induction taking the induction hypothesis to be the stronger statement that if and only if 
  #todo[
    to get from Kozen in func style!
  ]
]

#thm[Given two recognizable languages $L_1$, $L_2$ and $L_3$:
+ $L_1 union L_2$ is recognizable.
+ $L_1 inter L_2$ is recognizable.
+ $not L_1$ and $not L_2$ are recognizable.
]
#proof[
  #todo[]
]

== Epsilon Automata
Consider the automate with $epsilon$ or $e$ trasitions meaning that they can be taken willy-nilly.
#automaton(
  (
    q1:(q2:("a","e"), q1:"b"),
    q2:(q2:"a", q3:"b", q4:"a"),
    q3:(q3:"a", q1:"a", q4:"b"),
    q4:(q1:("a","b"), q2:"e")
  ),
  initial: ("q1", "q4"),
  final: "q3",
  layout: layout.snake.with(columns: 2, spacing: 6)
)

We can make a epsilon free NFA by changing all epsilon paths from source as sources and changing all epsilon paths by scheme $a ->^epsilon b ->^\# c |-> a ->^(\#) c$ (forward closure) ... #todo[]

#definition(title: "Concatination")[
  Equavalent to `++` in Haskell.

  $epsilon dot epsilon = epsilon$, 
  
  $u dot v = u v$
]

#thm[
  DFA = NFA = $epsilon$-NFA
]

#proof[By the above sections!]

Given:
$
  cal(A)_1 = (Q^1, Sigma, Delta^1, Q^1_0, Q^1_F)\
  cal(A)_2 = (Q^2, Sigma, Delta^2, Q^2_0, Q^2_F)\
$
We will try to define $cal(A) = cal(A)_1 times cal(A)_2$
$
cal(A) = cal(A)_1 times cal(A)_2\
= (Q^1 times Q^2, Sigma, Delta, Q^1_0 times Q^2_0, Q_F)\
"where" Delta = {((q_1, q_2), a, (q'_1, q'_2)) | (q_1, a, q'_1) in Delta^1, (q_2, a, q'_2) in Delta^2}\
"and" Q^(union)_F =Q^1_F times Q_2 union Q^1 times Q^2_F
$

This construction fails if the $Delta$ is underdefined, and we will sometimes need to add the trap states.

#example(title : "Using the Construction")[
  #automaton(
    (
      q1 : (q1: "a", q2:"b"),
      q2:(q2:("a", "b"))
    ),
    final: "q1"
  )

  #automaton(
    (
      q3 : (q3: "a", q4:"b"),
      q4:(q4:("a", "b"))
    ),
    final: "q3"
  )

We can combine these to get:
]

#exercise[
  Concatinate two recognizable langauages.
]
#solution[
  Connect the end states of $L_1$ to all the start states of $L_2$ using $epsilon$. The automata retains the start states of $L_1$ and end states of $L_2$.

  Formally, if $(Q_1, Sigma, Delta_1, S_1, F_1)$ recognizes $L_1$ and $(Q_2, Sigma, Delta_2, S_2, F_2)$ recognizes $L_2$; then we can recognize $L_1 L_2 $ using the automata $(Q, Sigma, Delta, S, F)$ where 
  $
  Q = Q_1 union.plus Q_2\
  S = S_1\
  F = F_2\
  Delta = Delta_1 union.plus Delta_2 union.plus union.plus {(q_1, epsilon, q_2) | q_1 in F_1, Q_2 in S_2}
  $
]

== Closure Property of Recognizable Languages
We have already seen recognizable langauages are closed under boolean operations.

#definition(title:"Homomorphism")[
An homomorphism from $Sigma^* -> Gamma^*$ is a map with the properties:
- $h(u v) = h(u) h(v)$
- $h(epsilon) = epsilon$
]
In practice, to define an homomorphism, we just need to map $Sigma -> Gamma^*$ and extend that map. That is, the definition of the homomorphism only needs to be defined on the letters to be complete.
#example[
  Taking $Sigma = {a,b,c}$ and $Gamma = {0,1}$; we can have an homomorphism:
- $
  h_1&: \
  a &|-> 001\
b &|-> 10\
c &|-> 11\
$
- $
h_2&: \
a &|-> 00\
b &|-> 1\
c &|-> epsilon\
$
- $
h_3&:\
a &|-> 00\
b &|-> 00\
c &|-> 1 
  $
]

#thm[
If $L subset.eq Sigma^*$ and is recognizable then $h(L) = {h(w) | w in L} in Gamma^*$ is also recognizable where $h$ is an homomorphism.
]
#example[
  Let $h$ be the map:
  $
  a &|-> 001\
  b &|-> 10\
  c &|-> 11
  $
  Make the map for the homomorphic language given the automata here is:
  #automaton(
    (
      q1 : (q2 : "a,b", q1:"b"),
      q2 : (q2:"a,c", q3:"a", q4:"a,c"),
      q3:(q4:"b", q3:"c"),
      q4:(q1:"a,b")
    ),
    final: "q2,q4",
    layout: layout.snake.with(spacing: 6, columns: 2)
  )
]

#proof[
  #todo[]
]

#thm[
  If $L subset.eq Gamma^*$ is recognizable then $h^(-1)(L) = {w in Sigma^* | h(w) in L} subset.eq Sigma^*$ is recognizable. 
]
#claim[
  We claim that if $(Q, Gamma, Delta, S, F)$ is an automata recognizing $L$ then $h^(-1)(L)$ is recognized by $(Q, Sigma, Delta^*, S, F)$ where $Delta^* (q,x) = union.big fold(Delta (q, h(x)))$.
]

#definition(title: "Kleene Star")[
  The Kleene Star is an uniary operation on a language $L$ which returns:
  $
  union.big_(i = 0)^oo L^i 
  $
  Note, this is just arbitarry concatinations of $L$. Also, even if $epsilon in.not L$, still $epsilon in L^*$.
]
#thm[
  If $L$ is recognizable, $L^*$ is recognizable.
]
The idea is to add a new initial (as well as final) state and then link it to all old initial states via epsilon and from all the old final states from epsilon. 
#claim[
  If $L$ is recognizable by $(Q, Sigma, Delta, S, F)$ then $L^*$ is recognizable from $(Q union 1_k, Sigma, Delta', 1_k, 1_k)$ where $Delta' = Delta union {(1, epsilon, q) | q in S} union {(q, epsilon, 1) | q in F}$.
]

== Rational Language
#definition(title: "Class of Rational Languages")[
  Rational languages is the smallest class of langauages such that
  - Every finite language is in the class or equivalently $emptyset, {epsilon} in R $ and $ {k} in R$ for all $k in Sigma$ are in the class.
  - closed under union
  - closed under concatinations
  - closed under Kleene star

All languages in this set are called Rational langauages.
]
#exercise()[
If $Sigma = {a,b,c}$, 

(i) is $Sigma^*$ rational?\
(ii) is language with all second letters $a$ rational?\
(iii) is language with words that contain $c c$ rational?\
(iv) is langauage with words not containing consecutive $c$'s rational?
]
#solution[
 (i) Obviosuly as $Sigma^* = ({a} union {b} union {c})^*$.\
 (ii) Can be reprasented as $Sigma {a} Sigma^*$.\
 (iii) Can be reprasented using $Sigma^* {c c} Sigma^*$.\
 (iv) $(a+b)^*(c(a+b)(a+b)^*)^*(c+ epsilon)$#footnote[Aish's solution].

 A better solution by Neel was $(c+epsilon)((a+b)^+ (c+epsilon))^*$
]

#idea(title : "Regex Notation")[
  We can use a regex like notation where $union <-> plus$ and dropping the brakets and dots and $a^+ = a a^*$.
]

#thm[All Rational Languages are Recognizable]
#proof[We can identify the atoms $a,b,c,emptyset, epsilon$ etc and the operators are also closed under Finite Autmata.]

#thm(title:"Kleene's Theorem")[
  Every Recognizable language is rational.
]
#proof[
  We claim that:
  #automaton(
    (
      q1: (q1: "e11", q2:"e12"),
      q2: (q2: "e22", q1:"e21")
    )
  )

  We can see that the rational expression is $(e_(11)  + e_(12)e^*_(22)e_(21))^* e_(12) e^*_(22)$.

#automaton(
  (
    q1:(q1:"e")
  )
)
We can get the rational expression as $e^*$.

  #automaton(
    (
      q1 : (q3:"a", q1:"b", q4:"a"),
      q2:(q2:"a", q5:"b"),
      q3:(q2:"a+b", q4:"e + b"),
      q4:(q1:"b", q4:"a"),
      q5:(q4:"b")
    ),
    final:"q2",
    layout: layout.grid.with(spacing: 5.7, columns:  2)
  )
  We will now remove a state, say q3.
    #automaton(
    (
      q1 : (q2:"a(a+b)", q1:"b", q4:"a(e+b) + a"),
      q2:(q2:"a", q5:"b"),
      q4:(q1:"b", q4:"a"),
      q5:(q4:"b")
    ),
    final:"q2",
    layout: layout.grid.with(spacing: 3, columns:  2)
  )

  We will now remove q4.

  #automaton(
    (
      q1 : (q2:"a(a+b)", q1:"b + (a(a+b) + a)a*b",),
      q2:(q2:"a", q5:"b"),
      q5:(q1:"ba*b")
    ),
    final:"q2",
    layout: layout.linear.with(spacing: 3)
  ) 

  We can now remove q5.
  #automaton(
    (
      q1 : (q2:"a(a+b)", q1:"b + (a(a+b) + a)a*b",),
      q2:(q2:"a", q1:"bba*b")
    ),
    final:"q2",
    layout: layout.linear.with(spacing: 3)
  ) 
  Using the above case, we can get the rational expression. 

]

#thm[
$
  (e_1 + e_2)^* = e_1^* e_2^*
$
]

#todo[2 classes worth of notes]

We have show rational, recognizable and regular langauages are the same things with the former being equal by Kleene's and the latter by Myhill-Nerode.

We also saw closure properties as well as proof techniques for non-recognizablity such as fooling sets and pumping lemma.

We also saw that there is a unique minimal automata.

We can note NFA to DFA conversion takes exponential nodes.

Rational to NFA takes linear nodes.

NFA to Rational takes exponential nodes.

Membership where we are given a word $w$ and a 
#footnote[I don't trust half these numbers. Aish is dumb dumb.]

Does a fiven NFA accept only a finite number of words?

Given two automata $cal(A)_1$ and $cal(A)_2$, is $L(cal(A)_1) = L(cal(A)_2)$?

DFA minimization is polynomial in number of nodes and size of alphabets.
















































