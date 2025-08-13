#import "modules/notes.typ": *
#import "@preview/finite:0.5.0": *
#show: thm-rules

#let char = $op("char")$

#show: noteworthy.with(
  paper-size: "a4",
  language: "EN",
  title: "Algebra III (Ring Theory)",
  author: "Arjun Maneesh Agarwal",
  prof : "Clare D Cruz",
  course-desc: [
    Quiz 1 will be on 1st Monday of September aka 1st September

    Tutorial is on every Monday.
  ],
  contact-details: "thearjunagarwal.github.io",
  toc-title: "Table of Contents"
)

= Dumb thing Clare says
#quote[The most importent ring in CMI is *SUFFE-RING*. CMI kids have everything and they still complain, remember you are privlagged. I saw a kid who works in ice cream shop and then in evening goes to Loyala collage, he doesn't complain. You all shouldn't.]

= Ring Theory
#definition(title: "Ring")[
  A ring $R$ is a non-empty set with operations (denoted by $+$ and $dot$) such that:
  + $(R, +)$ is an abelian group
  + (Associativity) $a dot (b dot c) = (a dot b) dot c forall a,b,c in R$
  + (Distributive) $a dot (b + c) = a dot b + a dot c forall a,b,c in R$
  + (Ring with Unity) $exists 1_R op("s.t.") 1_R dot a = a dot 1_R = a forall a in R$  
]
#definition(title: "Subring")[
  Given a ring $S subset.eq R$ with closure property wrt $+, dot$ is called a subring.
]
#note[We normally assume $1_R != 0_R$ as otherwise, we will have a 0 ring.]
#definition(title: "Units of R")[
  The units of $R$ are
  $
  {r in R | exists s op(s.t.) r s=1_R}
  $
]
#note[$forall a in R, n in NN$, we denote by:
- $
n a = underbrace(a + a + dots + a, n "times")
$
- $- n a = - (n a)$
]

#lem[ // Lemma
  + $0 dot a = a dot 0 = 0 forall a in R$
  + $(-a)b = a(-b) = - (a b) forall a, b in R$
  + $(-a)(-b) = a b forall a,b in R$
  + $(n a) b = a(n b) = n (a b) forall a, b in R, forall n in NN$
  + $
  (sum_(i=1)^n a_i) dot (sum_(j=1)^m b_j) = sum_(i=1)^n sum_(j=1)^m a_i b_j
  $
]
#proof[
  + $0 dot a = (0+0) dot a = (0 dot a) + (0 dot a) => 0 dot a = 0$
  + $(-a) dot b + a dot b = (-a + a) dot b = 0 dot b = 0 "by 1"$
  + Follows from 2
  + Follows from distibutivity and induction.
  + Follows from induction.
]

#definition(title: "Zero Division")[
  An element $a in R$ is a left zero divisor if there exists a non-zero element $b in R op(s.t.) a b = 0$.

  An element $a in R$ is a left zero divisor if there exists a non-zero element $c in R op(s.t.) c a = 0$.
]

#definition(title : "Multiplicative Inverse")[
  An element $a in R$ is left (rep. right) invertible if $exists c in R$ (rep. $b in R$) $op(s.t.)$ $c a = 1$ (rep. $a b = 1$).

  $a$ is invertible if it is both left and right invertible.
]
#lem[For an invertible $a in R$, it's left and right inverses are equal.]
#proof[
  Let $a b = 1 = c a$, then:
  $
  b = 1 b &= (c a) b\
  &= c (a b)\
  &= c 1\
  &= c  
  $
]

#lem[
  The set of units form a group under multiplication say $(U(R), dot)$
]
#proof[
  Do at home!
]

#definition(title : "Division Ring")[
  A ring $m$ which every non-zero element is a unit is a division ring.
]

#definition(title:"Field")[A commutative division ring is a field.]

#definition(title: "Ideals")[
  $I subset.eq R$ is an ideal if
  + $(I, +)$ is an abelian group.
  + Left Ideal (rep. right ideal) if $forall r in R, x in I, r x in I$ (rep. $x r in I$)
]
#definition(title : "Homorphims")[
  If $R, S$ are rings, a map $f : R -> S$ is a homorphism if
  $
  forall a,b,c in R\
  bullet& (a +_R b) = f(a) +_S f(b)\
  bullet& f(a dot_R b) = f(a) dot_S f(b)\
  bullet& f(1_R) = 1_S
  $
  The last bullet is not part of the true definition, but it being violated leads to pathological and rather impractical stuff.
]

#definition(title: "Kernal and Image")[
  $
  ker f = {r in R | f(r) = 0}
  $#footnote[We don't take $f(r) =1$ as $1$ is not always present and homorphisms should have kernals, such definition opens us ip to a lot of weirdness.]
  $
  im f = {s in S | exists r in R op(s.t.) f(r) = s}
  $
]
#lem[
  $ker f$ is an ideal in $R$.

  $im S$ is a subring of $S$.
]

#definition(title: "Ring Quoitent")[
  $R/I = {a + I | a in R}$
]

#definition(title : "Addition and Multiplication in R/I")[
  $
  (a+I) + (b+I) = (a+b) + I\
  (a+I) (b+I) = a b + I
  $
]

#lem[
  If $I$ is a two sides ideal, then $R/I$ is a ring.
]
#proof[
  Verify thr properties.
]
#definition(title: "Center")[
  The center of a ring $R$ is:
  $
  C(R) = {c in R | c r = r c forall r in R}
  $
]
#thm[The center $C(R)$ is a subring of $R$]

#definition(title: "Module")[
  A left $R$ module $M$ ia an additive abelian group with the operation
  $
  R times M -> M\
  r,m |-> r m
  $
  satisfying:
  + $(r+s) m = r m + s m forall m in M; r,s in R$
  + $r(m+n) = r m + r n forall m, n in M; r in R$
  + $(r s) m = r (s m)$
  + $1 m = m$

  A right $R$ module $M$ ia an additive abelian group with the operation
  $
  M times R -> M\
  m, r |-> m r
  $
    satisfying:
  + $m (r+s)= m r + m s forall m in M; r,s in R$
  + $(m+n) r = m r + n r forall m, n in M; r in R$
  + $ (m r) s = m (r s)$
  + $m 1 = m$

Assuming $1 in R$.#footnote[Is sometimes not considered in rings, atleast in old books for more genrality. We shall take this as true to avoid ideals becomming rings.]
]

#definition(title:"Inregration Domain")[
  A ring $R$ such that $forall r,s in R; r s = 0 => r = 0$ or $s=0$ aka if it has no non-zero zero divisors.
]

#definition(title : "Division Ring")[
  A ring $R$ whoch evert non-zero element is invertible is a division ring.
]

#definition(title:"Field")[
  A commutative division ring is a field.
]

#note[
  In an integral domain. 
  $
  S subset.eq R "is a subring"\
  1_S in S, 1_R in R "are the identities"\
  1_S dot 1_S = 1_S in S, R\
  1_S dot 1_R = 1_R in R\
  1_S 1_S - 1_S 1_R = 0\
  1_S(1_S - 1_R) = 0\
  1_S = 1_R 
  $
  This implies that we havea natuataal homomorphism $phi : S -> R$, $s |-> r$.

  $phi(1_S) = 1_R = 1_S => 1_S |-> 1_R, 1_S = 1_R$
]

== Some Special Rings

#example(title: [On $ZZ$])[
  What are the ideas in $ZZ$?

  Wrt $+, n ZZ$ is a subgroup $(n in ZZ)$.

  #underline[*Need to see*] $forall r in ZZ$ and $alpha in ZZ,  alpha in n ZZ$.

$
&r(n alpha) in n ZZ\
&||\
&n (r alpha)\
&=> n Z "is an ideal!"
$

Proper ideas in $ZZ$ are of the form $n ZZ$ where $n != plus.minus 1$. $ZZ/(n ZZ) = {overline(0), overline(1), dots, overline(n-1)}$.

$(ZZ/(n ZZ), +$ is a group.

$(i + n ZZ) (j + n ZZ) = i j + n ZZ$

$ZZ/(n ZZ)$ is an integral domain and a field $<=> n$ is prime.
]
#example(title:[$ZZ$ and $ZZ/(p ZZ)$])[
  In $ZZ$, if we take any $r != 0$, $underbrace(r+r+dots + r, n r != 0 forall n > 0)$.\
  In $ZZ/(p ZZ)$, adding $overline(r), p$ times will give zero.
]

#definition(title:"Characteristic of a Ring")[
  The characteristic of a ring is the smallest integer $n > 0 op("s.t.") n r = 0 forall r in R$. If $n r != 0 forall n > 0$, we say $char(R) = 0$. For example, $char(ZZ) = 0$
  
  
  $char(ZZ/(p ZZ)) = p$
  $char(ZZ/(n ZZ)) = n$
]

#definition(title: "Polynomial Rings")[
  Let $R$ be a ring and $x_1, x_2, dots, x_n$ be variables.

  We define $
  S = R[X_1, dots, X_n] = sum alpha_((i_1, i_2 dots, i_n)) x_1^(i_1) x_2^(i_2) dots x_n^(i_n)
  $
]

#thm[If $R$ is a field, $R[X_1, dots, X_n]$ is an integral domain.]

#thm[$1_R = 1_S$]

#note[
  $R$ is a subring of $S$ aka constent polynomials.
]
#example[
  $
  S = R[X]\
  => f in S => f(x) = a_0 + a_1 x + dots + a_n x^n
  $
  Constent polynomials are of the form $f(x) = a_0$.
]
#example(title: [Ideals in $Z[X]$])[
#todo[by prof!!!]
]
#remark[
  If $R$ is a ring then, for $x in R, (x^i)$ is an ideal where $i$ ranges over $NN$.
]
#question[
  If $R$ is a ring and $I$ is a two sided ideal, what are the ideals in $R/I$.
]
#remark[
  We have a natuataal homomorphism
  $
  Pi : R -> R/I\
  r |-> r + I
  $
  If $J$ is an ideal in $R$, then $Pi(J) in R/I$ is an idea in $R/I$ and is the ideal $(J+I)/I ~>$ an ideal in $R/I$.
]
We shall now *_verify_* that $(J+I)/I$ is an ideal.
+ $
(a + b) + I  = (a + I) + (b + I) = (b+I)  + (a+I) = (b+a) + I\
 forall a,b in J\
$
+ Let $r+I in R/I, a + I in (J+I)/I,$ then
$(r+I)(a+I) = underbrace(r a, in J) + I in (J+I)/I$.

#definition[
  Let $phi : R -> S$ be a ring homomorphism.

  Let $I$ be an idea in $R$.

  Consierr $(phi(I)) dot S$, the idea generated by $phi(I).$ This is called extension of the ideal $I$ in $S$.
]

Let $J$ be an idea in $S$.

#definition[
  $
  K = {r in R | phi(r) in J}
  $
]
#exercise[
  $K$ is an ideal in $R$. $C$ is called contraction o $J$.
]
