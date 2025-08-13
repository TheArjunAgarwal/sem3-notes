#import "modules/notes.typ": *
#import "@preview/finite:0.5.0": *
#show: thm-rules

#let int = $integral$
#let vol = $op("vol")$

#show: noteworthy.with(
  paper-size: "a4",
  language: "EN",
  title: "Calculus II",
  author: "Arjun Maneesh Agarwal",
  prof : "Krishna Hanumanthu",
  course-desc: [
    The course is mainly about multivarible integration.

    Grades in the course will be based on the following weightage:
  30% Homework, in-class quiz, 35% Midsem and 35% Final.

  Do all probelms sent, as doing problems is doing mathematics, regardless if they are collected or not. These HW PSETs (regardless of if they are graded) can and will appear in Quizes, Midsems and Finals.

  This course is based on Spivak's "Calculus on Manifolds" (ch 3, 4). We will also use other sources, like the notes on moodle (by TR Ramdas). Other books for some parts and excercises are: Rudin's "Principles of Mathematical Analysis", Apostal's "Mathematical Analysis".
  ],
  contact-details: "thearjunagarwal.github.io",
  toc-title: "Table of Contents"
)

= Hanumanthu's Wisdom
#quote[Let us all agree that for calculations integrals are useless and hopefully, none of us will need to do them again.]

= 5 Auguest, 2025
== Review of One Variable Integration
A typicall function we integrated looked like:
$
f : [a,b] -> RR
$
Assuming $a, b in RR$ and $a < b$.
#definition(title: "Upper and Lower sums")[
  The upper sum is of the form
  $
  U(P, f) = sum_(i=1) (t_i - t_(i-1)) sup_(t_(i-1) <= x <= t_i) f(x)
  $
  And the lower sum is of the form:
  $
  L(P, f) = sum_(i=1) (t_i - t_(i-1)) inf_(t_(i-1) <= x <= t_i) f(x)
  $
]

$
int_(underline(a))^b f(x) dif x = sup_p(L(P, f))
int_(a)^(overline(b)) f(x) dif x = inf_p(U(P, f))
$
If $int_(underline(a))^b f(x) dif x = int_(a)^(overline(b)) f(x) dif x$, our function is integrable.

Note, this is always true when $f$ is continous but it is not an if and only if statement.

We will now try to genralize this to two variables. The main jump is from $1$ to $2$ variables, beyond this, what is true for $2$ is true for $150$.

= 7 Auguest, 2025
== Review of One Variable Integration, cont.
$f : [a, b] -> RR$ is bounded.\
$
int_(underline(a))^b f <= int_(a)^(overline(b)) f\
=> sup L(p, f) <= inf U(p,f)
$
#definition(title: "Riemaan Integrablity")[
  $f$ is Riemaan integrable if:
  $
  int_(underline(a))^b f = int_(a)^(overline(b)) f
  $
]

#prop(title: "Proposition(Cauchy Critarion for Integrablity)")[
  $f : I = [a, b] -> RR$ bounded,
  $
  f "is integrable" <==>& "given" epsilon > 0, exists "partition" R "of" I op("s.t.") \
  & U(R, f) - L(R, f) < epsilon
  $
]
#proof[
  $(==>)$ Assume $f$ is integrable. Let $epsilon > 0$;
  
  Choose $P op("s.t.")$
  $
  int_(underline(a))^b f - L(P, f) < epsilon/2
  $

  Choose $Q op("s.t.")$
  $
  U(Q, f) - int_(a)^(overline(b)) f < epsilon/2
  $

  Adding,
  $
  U(Q, f) - P(P, f) < epsilon
  $

  Choose a refinement $R = P union Q$ and we are done.

  $(<==)$ $forall "partitions" R$,
  $
  0 <= int_(a)^(overline(b)) f - int_(underline(a))^b f <= U(R, f) - L(R, f)
  $
]

#definition(title: "Continuity")[
  Given an $epsilon$ and $x$, if there is a $delta$ such that if $y$ is $delta$-close to $x$, then $f(y)$ is $epsilon$-close to $y$.
]
#definition(title: "Uniform Continuity")[
  Given an $epsilon$, there is a $delta$ such that if $x$ and $y$ are $delta$-close; then $f(x), f(y)$ are $epsilon$-close.
]
#definition(title: "Compactness")[
  #todo[]
]
#thm[
  $f: [a,b] -> RR$ is continous $==> $ $f$ is integrable on $[a,b]$
]
#proof[
  #claim[$f$ is uniformly continous on $[a,b]$.]
  #todo[Proof of claim.]

  Ler $epsilon > 0$. Thus, there exists a $delta > 0 op("s.t.") forall x,y in [a,b]$.
  $
  |x - y | < delta => |f(x) - f(y)| < epsilon
  $
  Choose a partition $P= union.big_i I_i op("s.t.") I_(i+1).- I_i < delta$.
  $
  => sup_(x in I_i) f(x) - inf_(x in I_i) f(x)\
  = max_(x in I_i) f(x) - min_(x in I_i) f(x)\
  < epsilon\
  => U(p,f) - L(p,f) < epsilon sum_(i) I_(i+1) - I_(i) = epsilon (b-a)
  $
  Thus, by Cauchy Critarion, we are done.
]

We can take $
V = {f: [a,b] -> RR | f "is Rieman integrable"}
$
which is a vector space. 

Integration is a linear map from $V -> RR$.

#thm[
  $f : [a,b] -> RR$ is integrable.

  Define $F: [a,b] -> RR; y |-> int_(a)^y f(x) dif x$.

  - F is continous
  - Further, if $f$ is continous at $x_0 in [a,b]$, then $F$ is diffrentiable at $x_0$ and $F'(x_0) = f(x_0)$
]
#thm[
  $F : I = [a,b] -> RR$ and diffrentiable, $F' = f$ is integrable on $I$, then:
  $
  int_a^b f(x) dif x = F(b) - F(a)
  $
]
== Integration in $RR^n$
The main set we will deal with is $R := [a_1, b_1] times [a_2, b_2] times dots times [a_n, b_n] $.

We define $vol(R) = Pi_(i=1)^n (b_i - a_i )$

Most often, $n = 2$.

We can make partitions of $[a_1, b_1]; [a_2, b_2]; dots$ and just take the cartition products.

#definition(title: [Partion index on $R^2$])[
  Given a $k_1$ partition of $[a, b]$ and a $k_2$ partition on $[c, d]$.
  $
  a = t_(1,0) < t_(1,1) < dots < t_(1, k_1) = b\
  c = t_(2,0) < t_(2,1) < dots < t_(2, k_2) = d\
  $
  This gives us $R_(i,j) = [t_(1,i), t_(1, i+1)] times [t_(2, j), t_(2, j+1)]$; where $0 <= i <= k_1-1; 0<= j <= k_2 - 1$.
]
#example[
  Consider $R = [2,5] times [3,7]$.

  $2 < 4 < 5$, $t_(1,0) = 2 < t_(1,1) = 4 < t_(1,2) = 5$
  
  $3 < 4 < 6 < 7$, $t_(2,0) = 3 < t_(2,1) = 4 < t_(2,2) = 6 < t_(2,3) = 7$
]
== Exactly re-doing Riemaan integration!
Let $f : R -> RR$, $R subset.eq RR^2$ and be bounded.

$
L(p, f) = sum_(0<= i <= k_1 - 1\
0<= j <= k_2 - 1 ) (inf_(x in R_(i,j)) f(x)) (vol(R_(i,j)))
$

$
U(p, f) = sum_(0<= i <= k_1 - 1\
0<= j <= k_2 - 1 ) (sup_(x in R_(i,j)) f(x)) (vol(R_(i,j)))
$

If $cal(P)$ is a refinement of $cal(Q)$, then:
$
L(cal(P), f) >= L(cal(Q), f)\
U(cal(P), f) <= U(cal(Q), f)\
$
Let $cal(R) = cal(P) union cal(Q)$ aka a common refinement.
$
=> U(cal(P), f) >= L(cal(Q), f)
$

#example(title:"Common Refinement")[
  Let $cal(P) = (2 < 4 < 5) times (3 < 4 < 6 < 7)$ and $cal(Q) = (2 < 2.5 < 3 < 3.2 < 5) times (3 < 5 < 7)$;
  then $
  cal(R) = cal(P) union cal(Q) \
  = (2 < 2.5 < 3 < 3.2 < 4 < 5) times (3 < 4 < 5 < 6 < 7) 
  $
]

We will now define:
$
int_(underline(R)) f(x) dif x = sup_p L(p, f)
$
$
overline(int_(R)) f(x) dif x = inf_p U(p, f)
$

These will exist as by fixing a partion, we can get a upper bound for $L(p, f)$ and a lower bound for $U(p, f)$.

This gives the exact same definition for Riemaan integrablity in a multivarible case aswell.

= 12 August, 2025
We had $R in RR^n$ a rectangle with a function $f : R -> RR$ which is bounded.

We can partion $R$ by $P$ and define $L(P, f)$ and $U(P,f)$ similer to the one variable case.

We define 
$
int_R f := inf U = sup L
$

#example[
  $f : R -> RR$ is content function, that is $f(x_1, x_2, dots, x_n) = c$
]
#solution[
 Rather obviously
  $
  int_R f = c vol(R)
  $
]
#example[
  $f : [0,1] times [0,1] -> RR$ such that
  $
  f(x,y) = cases(
    0 quad x in QQ\
    \
    1 quad x in.not QQ  
  )
  $
]
#solution[
  This is just the Drinchlet function!
]

== Integration on more general subsets of $RR^n$
#definition(title: "Measure Zero")[
  Let $A subset.eq RR^n$ be a subset. We say that $A$ has measure $0$ if $forall epsilon > 0$ there is a cover ${U_1, U_2, dots}$ of $A$ by closed rectangles $U_i$ such that:
  $
  sum_(i=1)^oo vol(U_i) < epsilon
  $
]
#remark[
  + $A$ is finite $==>$ $A$ has measure $0$
  + $A$ is countable $==>$ $A$ has measure $0$
  + $B subset A$, $A$ has measure $0$ $==>$ $A$ is countable
  + $[0,1]$ doesn't have measure $0$.
]
#thm[
  Union of countable measure 0 sets is measure $0$.
]
#proof[
  #todo[From Spivak!]
]

#definition(title:"Content Zero")[
  $A subset.eq RR^n$ has content $0$ if $forall epsilon > 0$, there is a finite cover ${U_1, dots, U_k}$ of $A$ by closed rectangles such that $
  sum_(i=1)^l vol(U_i) < epsilon
  $
]
#thm[
  A has content 0 $==>$ $A$ has measure 0; but the converse is not true.
]
#thm[
  For a compact $A$, A has content 0 $<==>$ $A$ has measure 0
]
#thm[
  Let $R subset.eq RR^n$ be a closed rectangle, $f : R -> RR$ a bounded function.

  Then $f$ is integrable $<==>$ $B := {x in R | f "is not continous"}$ has measure 0.
]

#proof[
  Let $epsilon > 0$,
  $
  B_epsilon := {x in R | o(f,x) >= epsilon} subset.eq B
  $
  This implies $B_epsilon$ is measure $0$ as $B$ is measure 0.

  $B_epsilon$ is closed and bounded, thus, compact. That implies $B_epsilon$ is content 0 as it is measure 0.

  $
  ==> exists "closed rectangles" U_1, dots op("s.t.") \
  B_epsilon subset.eq union.big_(i=1)
  $
]

#example[
  $R in RR^n$ be a closed rectangle. If $f,g : R -> RR$ are integrable, so is $f dot g$.
]

Recall that if $f : A -> RR$ is a bounded function and $A in RR^n$.

Let $x in A$, $delta > 0$.
$
M(x,f, delta) := sup {f(a) | a in A, |x-a| < delta}\
m(x,f, delta) := inf {f(a) | a in A, |x-a| < delta}
$

We define osciallation of $f$ at $x$ as:
$
o(f,x) := lim_(delta -> 0) M(x, f, delta) - m(x, f, delta) 
$

#thm[
  If $f$ is continous at $x$ $<==>$ $o(f,x) = 0$
]

#thm[
  $A in RR^n$ is closed and $f : A -> RR$ is bounded. Let $epsilon > 0$, then:
  $
  {x in A | o(f,x) >= epsilon} "is closed"
  $
]
