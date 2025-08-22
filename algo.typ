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
#soln[
  We can take the worst case scenario and say the recursion tree has depth $log_(10/9) n $. Every level of recursion has total work $Theta(n)$.

  The time speant at leaves is $2^d$ where $d$ is the depth. Thus, $2^(log_(10/9) n)$

  Thus, we take total time $
  c n log_(10/9)(n) + 2^(log_(10/9) n)\
  = O(n log n) + n^(1/log(10/9))\
  = O(n^7)
  $
  Thus, we have a time complexity of $O(n^7)$.#footnote[This is an extreme upper bound. The actual number comes much closer to $n log(n)$ as the longest and shortest branches differ by a lot!]
]

== Master Method
$
T(n) = a T(n/b) + O(n^d)
$

Making the recursion tree, we have $log_b (n)$ depth. The work at some depth $k$ will be $a^k (n/b^k)^d$. We will have $a^(log_b(n))$ leaves.

Thus, the total work will be
$
T(n) = n^d (underbrace( 1 + a/b^d + a^2/b^(2d) + dots, log_b (n))) + a^(log_b n )
$

Note,
#todo[Copy from CS-161 slides!]

#thm(title: "Theorem(Master's Theorem)")[
  $
  T(n) = a T(n/b) + O(n^d) => T(n) = cases(
    O(n^(log_b (a))) & "if" a/b^d > 1\
    O(n^d) & "if" a/b^d < 1\
    O(n^d log(n)) & "if" a/b^d = 1
  )
  $#footnote[
    There is absolutly nothing this theorem masters. It was name orignating from CLRS and other than working for some 'common algorithms' it is far inferior to just making the tree yourself.
  ]
]

= Divide And Conquer Algorithms
#idea[
  + Break the input into smaller, disjoint parts.
  + Recurse on the parts.
  + Combine the solutions.
]

Step 1 and step 3 are normally where the work happens. For example in merge sort, we do almost no work in spliting and linear work in combining. On the other hand in quick sort, we do linear work in splitting and no work in combining.

== Convex Hull
Given $n$ points $p in RR^2$ where $p = (x,y)$, the convex hull is the smallest polygon such that a line between any two points in inside or on the boundry of the hull.

We can strech a rubber band over the points (which are nails) and let it go.

A dumb algorithm is just checking every combination. This is roughly $O(n!)$.

#psudo(title:"Convex Hull in cubic time")[
  + For all $p, q in P subset.eq RR^2$
    + Check if $op("sign")(p,q,r)$ is same for all $r in P backslash {p,q}$
      + Include $p,q$ in solution
]
We have already gone from $n!$ to $O(n^3)$.

Another option is to pick the lowest point and then sort by angles and pick the lowest points, one by one. This is called a Jarvis Search.

Although, we have included this in the divide and conquer section for a reason!

We will divide the points in two parts and then try to recombine.

#psudo(title:"Divide and Conqour Convex Hull combining")[
  + $i = 1$
  + $j = 1$
  + *while* $(y(i, j+1) > y(i,j) "or" y(i-1,j) > y(i,j))$
    + *if* $y(i, j+1) > y(i,j)$: move right pointer $arrow.cw.half$
    + $j = j+1 mod q$ {q := \# in the right hand side}
  + else
    + i = i-1 mod (p) {p := \# in the left hand side}
+ return $(a_i, b_j)$ as upper tangent 
]

== Selection Problem
#definition(title:"Selection Problem")[
  *Input:* A set $A$ of $n$ distinct numbers and an index $i$, $1 <= i <= n$

  *Output:* The element $x in A$ that is larger than exactly $i-1$ elements of $A$
]
A randomized algorithm is easy to see:
#psudo(title:"Quick Select")[
 + pick $x in A$ random
 + Compute $k = op("rank")(x)$ -- x is the kth smallest element in A
 + $B = {y in A | y < x}$
 + $C = {y in A | y > x}$
 + if $k == i$
  + return x
+ if i < k
  + QuickSelect(B, i)
+ if i > k
  + QuickSelect (C, i-k)  
]
Out biggest problem in this algorithm is the fact that the worst case complexity is $O(n^2)$.

The average case complexity is $O(n)$.

Can we do better? 

Yes!

Let's pick the pivot by the process