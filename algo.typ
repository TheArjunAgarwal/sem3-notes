#import "modules/notes.typ": *
#show: thm-rules

#show: noteworthy.with(
  paper-size: "a4",
  language: "EN",
  title: "Design and Analysis of Algorithms",
  author: "Arjun Maneesh Agarwal",
  prof : "Siddharth Pritam",
  course-desc: [
    Texbooks to be used are CLRS and Algorithms by Jeff Ericson.
  ],
  contact-details: "thearjunagarwal.github.io", // Optional: Maybe a link to your website, or phone number
  toc-title: "Table of Contents"
)

  // + *while* $m mod n != 0$
  //   + $r = n mod m$
  //   + $n = m$
  //   + $m= r$
  // + end *while*.
  // + *return* $m$


#proof(title:"Proof of correctness")[
  #claim[$m | n$, $gcd(m,n) = m$.]
  Trivial.

  #claim[$gcd(m,n) = gcd(n mod m, m)$]
  Assume $gcd(m,n) = a => m = a p, n = a q, p divides.not q$.

  Thus, $gcd(m,n) = gcd(a p, a q) = gcd( a (q mod p), a p)$
]

#idea(title: "How Fast?")[
  Let's try to see how fast doesn $n+m$ decrease. Let the next level be $m'$ and $n'$.

  Using the modulo condition, we can get $3(m' + n') = m' + n' + 2(m' + n') < p + p + 2q = 2(p+q)$.

  This implies the algorithm is lower bounded by $log_(3/2)(m'+n')$
]

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

#exercise[
  - $n$ vs $n log n$
  - $n^(log^2(n))$ vs $2^(log^2(n))$
  - $n^(log log n)$ vs $2^(log n log log n)$
]
#solution[
  We get:
  - $n = O(n log n)$
  - $n^((log(n))^2) = O(2^(log^2(n)))$ (by switching to same base)
  - $n^(log log n) = Theta(2^(log n log log n))$ (same trick!)
]

#exercise[
  If $f(n) = O(g_1(n))$ and $f(n) = O(g_2(n))$ is $f(n) = O(g_1(n) + g_2(n))$
]
#solution[
  Trivial enough really!
]

= Recuerence relation!
== Substitution Method
Given a recuerence, we guess the solution and then prove its correctness by induction.
#example[
$
T(n) = 2T(n/2)+ n
$
]
#solution[
  Just induction on $T(n) = c n log(n)$
]
#example[
  $
  T(n) = T(ceil(n/2)) + T(floor(n/2)) + 1
  $
]
#solution[
  Taking $T(n) = c n$ doesn't work as we get $T(n) = c n + 1$ which doesn't work.

  Let $T(n) = c n - d$ and we will deal with it later.
  $
  T(n) = c ceil(n/2) + c floor(n/2) - 2d + 1\
  = c n - 2d + 1\
  "should" = c n - d 
  $
  This works out for $d = 1$ and hence, we 'guess' $c n - 1$.
]
#example[
  $
  T(n) = 2 T(sqrt(n)) + log(n)
  $
]
#solution[
  Take $n = 2^m$
  $
  T(2^m) = 2(T(2^(m/2))) + 2\
  S(m) = 2 S(m/2) + m
  $
  This gives $S(m) = O(m log(m))$

  Thus, $T(n) = O(log(n) log(log(m)))$
]

#exercise()[
  $
  T(n) = T((9n)/10) + T(n/10) + Theta(n)
  $
]