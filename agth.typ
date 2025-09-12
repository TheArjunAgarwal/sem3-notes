#import "modules/notes.typ": *
#import "@preview/finite:0.5.0": *
#import "@preview/game-theoryst:0.1.0" : *
#show: thm-rules

#show: noteworthy.with(
  paper-size: "a4",
  language: "EN",
  title: "Algorithmic Game Theory",
  author: "Arjun Maneesh Agarwal",
  prof : "Prajakta Nimbhorkar",
  course-desc: [
    + Games and Equilibria : We are assuming games where everyone is acting selfishly. When everyone doesn't wish to switch strategies, we get an equilibrium.
      - We will see two-player games and multiplayer games.
      - Equilibrium and existence and computation.
    + Mechanism Design : Given multiple selfish agents, we need to make a mechanism that encourages (or discourages using hardness) the behavior we wish to encourage.
      - We will see auctions, voting etc.
    + Fair Division: This is an allocation problem where we want to allocate some resources in a 'fair' (or less unfair) way.
      - Distributing divisible and indivisible resources fairly among agents, given valuation.
      - EF, EQ, PROP and its relaxations.
  ],
  contact-details: "thearjunagarwal.github.io", // Optional: Maybe a link to your website, or phone number
  toc-title: "Table of Contents"
)
#pagebreak()

= Games and Equilibria
We make the following assumptions:

+ Rationality/selfishness : Each agent attempts to maximize own payoff and believes others will do so as well as well has knowledge of same behavior being
+ Intelligence: Agents have enough computational resources to take into account the strategies and behaviors of others.
+ Common Knowledge: $P, S_i, mu$ are known to everyone and everyone knows that everyone knows them and so on.

== Braess's Paradox
Taking the example of traffic, let the network be:
#automaton((
  s:(u:"x", v:"1"),
  u:(t:"1"),
  v:(t:"x"),
  t:(none),
),
layout:layout.grid.with(columns: 2, spacing: 3)
)
In this case, the equilibrium is $1.5$ hours as traffic is divided in the two paths. Let's say the authorities build a bridge:
#automaton((
  s:(u:"x", v:"1"),
  u:(t:"1", v:"0"),
  v:(t:"x", u:"0"),
  t:(none),
),
layout:layout.grid.with(columns: 2, spacing: 3)
)

This will lead to a (weak) equilibrium of $2$ hours as all agents take the route s-v-u-t.

This is called Braess's Paradox. 

#note[
  We have actually seen this example occur almost verbatim in Seoul where the demolition of a bridge in 2005, solved a 2 decade old traffic problem.

  Furthermore, Steinberg and Zangwill, 1983; showed that in a random network, Braess's paradox is approximately $50%$ likely to occur in an random network.

  It is also a consideration in google maps where the navigation sometimes suggests a longer route, not to avoid a pre-existing traffic jam, but to avoid creating one. (This is why google map is not referentially transparent and may suggest two people different routes between same places at same time)

  #todo[]
]
== Prisoner's Dilemma
#nfg(
  players: ("P1", "P2"),
  s1: ($C$, $D$),
  s2: ($C$, $D$),
  [$4,4$], [$5,1$], 
  [$1,5$], [$2,2$],
)
Here both players have incentive to deviate from the mutually best case as confessing (strongly) dominates denial and hence, is a Nash equilibrium.

Let's define these words formally.


#definition(title : "Game")[
  To define a game we need to know the players and strategies for each player. Thus, a game $G = (P, S, mu)$ where for $i$ in $P$, $S_i$ in $S$ denotes the set of possible strategies for player $i$.

  In a particular play of the game denoted as $s$, $i$ plays strategy $s_i$ forming the strategy profile or game vector $(s_1, s_2, dots, s_n)$.

  We denote the payoffs or costs of the game for player $i$ using a function $mu_i : S_1 times S_2 times dots times S_n -> RR$ which takes the game vector and tells the payoff for player $i$. $mu : S_1 times S_2 times dots times S_n -> RR^n; mu(s) = (mu_1 (s), mu_2 (s), dots, mu_n (s))$ is the payoff vector returning function.

  Finally, for conciseness, we sometimes denote the choices for all players except $i$ as $s_(-i)$. Thus, $mu_i (s_i, s_(-i))$
]

#definition(title: "Strongly Dominant Strategy")[
  Player $i$'s strategy $hat(s_i)$ is a *Strongly Dominant Strategy* to the strategy $s_(-i)$ of other players if:
  $
  mu_i (hat(s_i), s_(-i)) > mu_i (s'_i, s_(-i)) forall s'_i in S_i
  $
]
#definition(title: "Weakly Dominant Strategy")[
  Player $i$'s strategy $hat(s_i)$ is a *Weakly Dominant Strategy* to the strategy $s_(-i)$ of other players if:
  $
  mu_i (hat(s_i), s_(-i)) >= mu_i (s'_i, s_(-i)) forall s'_i in S_i
  $ and 
  $
  exists s'_i in S_i op("s.t.") mu_i (hat(s_i), s_(-i)) > mu_i (s'_i, s_(-i)) 
  $
]

#definition(title: "Weakly Dominant Strategy / Best Response(BR) ")[
    Player $i$'s strategy $hat(s_i)$ is a *best response* to the strategy $s_(-i)$ of other players if:
  $
  mu_i (hat(s_i), s_(-i)) >= mu_i (s'_i, s_(-i)) forall s'_i in S_i
  $
  or if $hat(s_i)$ solves $max_(S_i) mu_i (s_i, s_(-i))$.
    #footnote[
    Sometimes we can replace the actual strategies by others by $p$, which is $i$'s belief of others' choices. This is often done in econ, but here, one of our assumptions (Common knowledge) allows us to not need it. The BR word is also from Econ.
  ]
]

#definition(title: "Strongly Dominated Strategy Equilibrium")[
  Informally, this is when all players are playing dominant strategies.

  It is a strategy profile $(s^*_1, s^*_2, dots, s^*_N)$ is a SDSE if for each $i$, her choice $s_i^*$ is strongly dominant to all .
]

#definition(title : "Nash Equilibrium(NE)")[
Informally, this is when all players are playing BR to each other.

Formally, it is a strategy profile $(s^*_1, s^*_2, dots, s^*_N)$ is a NE if for each $i$, her choice $s_i^*$ is a best response to $s^*_(-i)$.
]

#remark[
  The reason Nash equilibrium is important is as it leads to no-regrets as no individual can do strictly better by deviating holding others fixed. Second, as it is a self-fulfilling prophecy (we will see what this means).
]

== Pollution Control
Let there be $n$ countries with the cost of pollution control being $3$. If a country doesn't control pollution, it adds cost $1$ to each country.

This leads to the dark case of no one controlling pollution. We can check that if only $k$ countries control pollution, all have incentive to not control.

#definition[
  A dominant strategy is what is best for a player regardless of whatever strategy the rest of the players choose to adopt. 
]

== RPS
#nfg(
  players: ("P1", "P2"),
  s1: ($R$, $P$, $S$),
  s2: ($R$, $P$, $S$),
  [$0,0$], [$1,-1$], [$-1,1$],
  [$1,-1$],[$0,0$], [$-1,1$],
  [$0,0$], [$-1,1$],[$1,-1$]
  )

There is no pure Nash equilibrium here. But allowing randomized strategy, we can get an equilibrium.

#definition(title:"Mixed Strategy")[
  A mixed strategy $p_i$ is a randomization over $i$'s pure strategies.
  - $p_i (s_i)$ is the probability $i$ assigns to the pure strategy $s_i$.
  - $p_i (s_i)$ could be zero for some $i$.
  - $p_i$ could be one (in case of a pure strategy).
]


#definition(title : "Mixed Strategy Profile")[
  A mixed strategy profile is a tuple $(p_1, p_2, dots, p_n)$ where each $p_i$ is a mixed strategy for player $i$. It represents the joint behavior of all players where each one plays a randomized strategy independently.
]

#definition(title : "Expected Payoff")[
  The expected payoff for player $i$ is:
  $
  sum_((s_1, dots, s_n) in S_1 times dots times S_n) mu_i (s_i, s_(-i)) product_(a = 1)^n p_a (s_a)
  $
]

#definition(title:"Mixed Strategy Nash Equilibrium")[
  A mixed strategy profile $(p^*_1, p^*_2, dots, p^*_n)$ is a mixed strategy NE (MSNE) if for each player $i$, $p^*_i$ is a BR to $p^*_(-i)$. That is:
  $
  mu_i (p^*_i, p^*_(-i)) >= mu_i (sigma_i, sigma_(-i)^*) forall sigma_i in "probability distribution over" S_i
  $
]

#thm(title:"Nash's Theorem")[
  Every bimatrix game has a (pure or mixed) Nash equilibrium.
]

#thm[
  For zero-sum games, it is polytime; otherwise, it is PPAD-hard.
]

PPAD-hard $=>$ NP-Hard $<==>$ NP $=$ co-NP. This is open and unknown.

== Sealed Bids Auctions
There is one seller and $n$ buyers and one item that the seller wants to sell.

Buyers have non-negative valuations over this item $v_i$.

The rules of this auction are that each buyer submits a sealed bid $b_i$ be the bid amounts. The highest bid gets the item (in case of ties, by the lower index).

If buyer $i$ gets the item, and pays $t_i$, then their $mu_i= v_i - t_i$ and payoff for other buyers is $0$.

#definition(title:"First Price Auctions")[
In first price auction, $t_i = b_i$.
]

#definition(title: "Second Price Auction")[
  Buyer who gets the items (say $i$) pays the second highest bid
  ]

#thm[
  Second price auction is weakly revealing (that is it is a weakly dominant strategy to bid truthfully).
]
#proof[
  We will analyze for $v_i$ and then see that the same holds with small changes.
]

== Battle of the Sexes
#definition[
  We represent a situation where two agents must simultaneously take an action where each of them prefers one option over the other but prefer coordination over doing different things. And example occurrence would be #footnote[Which is extremely stereotypical and doesn't represent the author and hopefully the prof's views.]:

  #nfg(
    players: ("Husband", "Wife"),
    s1 : ("Cricket", "Music"),
    s2 : ("Cricket", "Music"),
    [2,1],[0,0],
    [0,0], [1,2]
  )
]
We can try to brute force this. Let's look at the payoffs for both the players
$
mu_1(sigma_1, sigma_2) =& sigma_1(C) sigma_2(C) mu_i (C,C) + \
  &sigma_1(C) sigma_2(D) mu_i (C,D) + \
  &sigma_1(D) sigma_2(C) mu_i (D,C) + \
  &sigma_1(D) sigma_2(D) mu_i (D,D)\
  &=2 sigma_1 (C) sigma_2 (C) + sigma_1 (D) sigma_2 (D)\
  &= 2 sigma_1 (C) sigma_2 (C) + (1 - sigma_1 (C)) (1 - sigma_2 (C))\
  &= 3 sigma_1 (C) sigma_2 (C) - sigma_1 (C) - sigma_2 (C) + 1
$
And similarly
$
mu_2 = 3 sigma_1 (C) sigma_2 (C) - 2 sigma_1 (C) - 2 sigma_2 (C) + 2
$

Using $mu_1 (sigma^*_1, sigma^*_2) >= mu_1 (sigma_1, sigma_2*) forall sigma_1 in Delta(S_1)$
$
 sigma^*_1 (C) [3 sigma_2 (C) - 1] >= sigma_1(1) [3 sigma_2 (C) - 1] forall sigma_1 (c) in (0,1)
$
Similarly
$
 sigma^*_2 (C) [3 sigma_1 (C) - 2] >= sigma_2(1) [3 sigma_1 (C) - 2] forall sigma_2 (c) in (0,1)
$
If $3 sigma^*_2(C) - 1 > 0 => angle.l (1,0), (0,1) angle.r$.

If $3 sigma^*_2(C) - 1 < 0 => angle.l (0,1), (1,0) angle.r$.

If $3 sigma^*_2(C) - 1 = 0 => angle.l (2/3,1/3), (1/3,2/3) angle.r$.

== Properties of MSNE
Expected payoff for player $i$ will be:
$
mu_i (p_1, p_2, dots, p_n) &= sum_((s_1, dots, s_n) in S_1 times dots times S_n) mu_i (s_i, s_(-i)) product_(a = 1)^n p_a (s_a)\
&= sum_(s_i in S_i) sum_(s_(-i) in S_(-i)) p_i (s_i) p_(-i)(s_(-i)) mu_i (s_i, s_(-i))\
&=  sum_(s_i in S_i) p_i (s_i) sum_(s_(-i) in S_(-i)) p_(-i)(s_(-i)) mu_i (s_i, s_(-i))\
&=  sum_(s_i in S_i) p_i (s_i) mu_i (s_i, p_(-i) ) \
$
This makes the utility of a player a convex combination of thier pure stratergy payoffs.

#definition(title : "Convex Combination")[
  A convex combination of $a_1, a_2, dots, a_n$ is $sum_(i=1)^n lambda_i a_i$ where $lambda_i in [0,1]$ and $sum_(i=1)^n lambda_i  = 1$.
]

An obvious observation is that convex combination of $a_1, dots, a_n <= max {a_i}$.

Which implies that the payoff with mixed stratergy is less than equal to max payoff with a pure strategy $s_i$. This implies:
$
max_(sigma_i in Delta(S_i)) mu_i (sigma_i, sigma_(-i)) = max_(s_i in S_i) mu_i (s_i, sigma_(-i))
$
#thm[
  $(sigma^*_1, dots, sigma^*_n)$ is a MSNE if and only if $forall i in N$
  + $mu_i (s_i, sigma^*_(-i))$ is the same for all $s_i in $ support of $sigma^*_i$.
  + $mu_i (s_i, sigma^*_(-i)) >= mu_i (s^*_i, sigma^*_(-i)) forall s'_i in.not $ support of $sigma^*_i, s_i in $ support of $sigma^*_i$. 
]

#remark(title: "Implications")[
Each player gets the same payoff for any pure strategy in the support of the MSNE strategy.
]

= Equilibrium Computation
== Computing a SDSE
#example[
  #nfg(
    players: ($P_1$, $P_2$),
    s1: ($A$, $B$, $C$),
    s2: ($D$, $E$, $F$),
    [4,3],[5,1],[6,2],
    [2,1],[8,4],[3,6],
    [3,0],[9,6],[2,8])
    Notice, $E$ is dominated by $F$ as $forall i, mu_2(F, s_(-i)) > mu_2(E, s_(-i))$. THis practically makes the game:
    #nfg(
    players: ($P_1$, $P_2$),
    s1: ($A$, $B$, $C$),
    s2: ($D$, $F$),
    [4,3],[6,2],
    [2,1],[3,6],
    [3,0],[2,8])
    Now $A$ dominates $B,C$ and after elimination, $D$ will dominate $E$ and we will be left with the nash equilibrium of $4,3$.
]
Also note, $(A,D)$ is a PSNE.

Note, this algorithm by no means gives all the nash equilibrium, if there are multiple. We don't run into such issues with SDSE as only one can exist by the definition of Strict dominance.

#example[
#nfg(
  players: ($P_1$, $P_2$),
  s1:($A$,$B$,$C$),
  s2:($D$,$E$,$F$),
  [3,1],[0,1],[0,0],
  [0,1],[4,1],[0,0],
  [1,1],[1,1],[5,0]
)
We can eliminate $F$ as $D,E$ are strictly better.
#nfg(
  players: ($P_1$, $P_2$),
  s1:($A$,$B$,$C$),
  s2:($D$,$E$),
  [3,1],[0,1],
  [0,1],[4,1],
  [1,1],[1,1]
)
Here, we can eliminate $C$ as if $P_2$ plays $D$ or $E$, we are better off playing $A$ or $B$ respectively.

Another way to argue the same is $mu_1((A+B)/2, s_(-i)) > mu_1(C,s_(-i))$.
]
#note[
 Here, playing $C$ is called the Bayesian Equilibrium as it is safe. 
]

#example[
  #nfg(
  players: ($P_1$, $P_2$),
  s1:($A$,$B$,$C$),
  s2:($X$,$Y$,$Z$),
  [7,7],[4,2],[1,8],
  [2,4],[5,5],[2,3],
  [8,1],[3,2],[0,0]
)
We can get the gurentee finding the nash equilibrium by identifying the highest entry per row and column wrt the respective players.
#nfg(
  players: ($P_1$, $P_2$),
  s1:($A$,$B$,$C$),
  s2:($X$,$Y$,$Z$),
  [$underline(7)$,7],[4,2],[1,$overline(8)$],
  [2,4],[$underline(5),overline(5)$],[2,3],
  [$underline(8)$,1],[3,$overline(2)$],[0,0]
)
Making $(5,5)$ the PSNE.
]
#algo[
  For the column player, mark the maximum entry for them.

  For the row player, mark the maximum entry for them.

  The intersections are PSNEs.
]

== Two Player Zero Sum Games
#definition(title:"Two Player Zero Sum Games")[
  A game with:
  - $N = {1,2}$
  - $S = {S_1, S_2}$
  - $mu = {mu_1, mu_2}$
  - $mu_1 (s_1, s_2) = -mu_2 (s_1, s_2)$
]
In these games, we only need to specify the payoffs for one player. We, by convention, do this for the row player.
#nfg(
  players: ($A$, $B$),
  s1:($$,$$,$$),
  s2:($$,$$,$$),
  [2],[1],[1],
  [-1],[1],[2],
  [1],[0],[1]
)
For any stratergy,  $i$ of $P_1$ and $P_2$ will choose a stratergy such that,
- $P_1$ chooses $max_i min_j a_(i j)$ (maxmin)
- $P_2$ will choose $min_j max_i a_(i j)$. (minmax)

If maxmin and minmax are equal, we are done and the value is the nash equilibrium.

#definition(title: "Maxmin-Minmax")[
  The maxmin value refers to $max_(i in S_1) min_(j in S_2) a_(i j)$.

The minmax value refers to $min_(j in S_2) max_(i in S_1) a_(i j)$.
]

If a PSNE exists, we will get it by this process.

If there is no PSNE, this obviously doesn't work. 
#nfg(
  players: ("P1", "P2"),
  s1: ($R$, $P$, $S$),
  s2: ($R$, $P$, $S$),
  [$0$], [$-1$], [$1$],
  [$1$],[$0$], [$-1$],
  [$-1$], [$1$],[$0$]
  )
We can also discuss Saddle points.
#definition(title:"Saddle Point")[
  $(i,j)$ is a saddle point of a matrix $A$ if $a_(i j) >= a_(k j) forall k$ and $a_(i j) <= a_(i l) forall l$
]
#thm[
  If $i,j$ and $k,h$ are saddle points, then $(i,h)$ and $k,j$ are also saddle points.
]
#proof[
  $
  a_(i j) >= a_(k j) >= a_(k h) >= a_(i h) >= a_(i j)
  $
  And we are done by squeeze theorem.
]

#definition(title:"Mixed Stratergy in 2 player zero sum game")[
  Let $|S_1| = m$ and $|S_2| = m$. Let $x = (x_1, x_2, dots, x_n)$ be a mixed strategy for $P_1$ and $y = (y_1, y_2, dots, y_n)$ be a mixed strategy for $P_2$.

  The expected payoff is $sum^n_(i=1) sum^m_(j=1) x_i y_j a_(i j) = x^T A y$
]

We can define maxmin and minmax values here as:
#definition(title:"Maxmin-minmax")[
  maxmin value = $max_(x in Delta(S_1)) min_(y in Delta(S_2)) x^T A y$

  minmax value = $min_(y in Delta(S_2)) max_(x in Delta(S_1)) x^T A y$
]

#lem[
  $
  min_(y in Delta(S_2)) x^T A y = min_(j in S_2) sum_(i=1)^m a_(i j) x_i
  $
]
#proof[
  It is obvious that
  $
    min_(y in Delta(S_2)) x^T A y <= min_(j in S_2) sum_(i=1)^m a_(i j) x_i 
  $
  as $S_2 subset.eq Delta(S_2)$.

  To do the other way round,
  $
  x^T A y = sum_(j=1)^n y_j sum_(i=1)^m x_j a_(i j)\
  >= sum_(i=1)^n y_j min_(k in S_2) sum_(i=1)^m x_i a_(i k)\
  = min_(k in S_2) sum_(i=1)^m x_I a_(i k) dot sum_(i=1)^n y_j  \
  = min_(k in S_2)  sum_(i=1)^m x_I a_(i k)
  $
  Thus, by squeeze theorem, we are done.
]

== Linear Programming for the the win
We make an LP for the row player as:

The row player has to to maximize $min_(j in S_2) sum_(i=1)^m a_(i j) x_i$ with the constrains $sum_(i=1)^m x_i = 1, x_i >= 0 forall i in {1,2,dots, m}$.

Equivalently, maximize $z$ with the constrains $z <= sum_(i=1)^m a_(i j) x_i forall j in {1,2, dots, n}$, $sum_(i=1)^n x_i = 1$, $x_i >= 0 forall i in [m]$.

#exercise(title:"Column Player's LP")[
  Define the column players LP.
]
#soln[
 minimize $w$ such that $w >= sum_(j=1)^n a_(i j ) y_j forall i in [m]$, $sum_(j=1)^n y_j = 1$, $y_j >= 0$ forall $j in [n]$. 
]

=== Duel of LP
#example(title:"Toy LP")[
  max $3 x_1 + 2 x_2 + x_3$ with constraints
  + $x_1 + x_2 + x_3 <= 2$
  + $3x_1 + x_3 <=4$
  + $x_1 + x_2 + x_3 <= 5$
  + $x_1, x_2, x_3 >= 0 $
]
We can get an upper bound by $3 * "eq" 3 => 3x_1 + 3x_2 + 3x_3 <= 15$.

We can get a better upperbound by $"eq" 1 + "eq" 2 => 3x_1 + 3x_2 + 3x_3 <= 9$.

The idea is that as atleast one coefficient is bigger, the sum is bigger and is an upperbound.

But doing this for all combinations is going to be painfully time consuming. Let's try to do this algebraically and let the coefficients of equation 1,2,3 be $y_1, y_2, y_3$ in the linear combination.

$
x_1 (y_1 + 3 y_2 + y_3) + (y_1 + y_3) x_2  + (y_2 + y_3) x_3 <= 2 y_1 + 4y_2 + 5y_3
$
This leads to a LP

Minimize $2 y_1 + 4y_2 + 5y_3$ with the constraints:
- $y_1 + 3 y_2 + y_3 >= 3$
- $y_1 + y_3 >= 2 $
- $y_2 + y_3 >= 1$

#thm[
  The Row player LP and Column player LP are duel pairs.
]
#proof[
  #todo[Computation]
]

== Strong Duality
Optimum value of $f$ is the optimal value of its primal duel.

Ler $x^* = (x_1^*,x_2^*, x_3^*, dots , x_m^*), z^*$ be the optimum values for Row player.

$z^*$ must attain equality at some $j^* in [n]$ that is $z^* = sum_i a_(i j^*) x_i^*$ and $z^* <= sum_i a_(i j) x_i^* forall j in [n]$.

By lemma, $z^* = min_(j in S_2) sum_(i=1)^n x_i^* = min_(y in Delta(S_2)) x^*^T A y $ and similarly, $w^* = max sum_(j=1)^n a_(i j^*) y_i = max_(x in Delta(S_2)) x^T A y^*$.

Thus,
$
min_(y in Delta(S_2)) x^*^T A y = max_(y in Delta(S_2)) x^T A y^*
$

This is a nash equilibrium as no player can unilaterally increase payoff by moving.

== Existence of Nash Equilibrium (mixed) in finite strategic form games
Ler $(N, <s_i>, <mu_i>)$ be the game where $N = {1,2,dots,n}$, $S_i$ is stratergy set for player $i$, with $|S_i| = m forall i$ and and $mu_i : S_i times S_(-i) -> RR$ is the payoff function for player $i$.

Mixed strategy $sigma_i$ is a probability distribution over $S_i$.

$Delta_i$ of $Delta(S_i)$ denotes the set of all mixed stratergies for player $i$. $Delta = Delta_1 times Delta_2 times dots times Delta_m$.

Expected payoff from $delta_i$ for player $i$ is
$
mu_i (sigma_i) =^Delta sum_((s_1, dots, s_n) in S_1 times S_2 dots S_n) (product_(j=1)^n sigma_j (s_j)) mu_i (s_1, dots, s_n)
$

#definition[
  $sigma^*$ is a Nash Equilibrium if for every player $i$,
  $
  mu_i (sigma^*) >= mu_i (s_i, sigma_(-i)^*) forall s_i in S_i
  $
]
#thm(title:"Brouwer's Fixed Point Theorem")[
  Let $B$ be a closed, bounded convex set. Let $f :: B -> B$ be a continuous function, then $exists x in B op("s.t.") f(x) = x$
]
We want to define $B, f$ such that the Nash Equilibriium is the fixed point of $f$. Define $B = Delta$.

Define $f$ such that $sigma in Delta$ is not a NE then $f(sigma) != sigma$ NS IF $sigma^*$ is a NE then $f(sigma^*) = sigma^*$.

*Attempt 1*: Define $f(sigma) = rho$ where $rho in Delta, rho = (rho_1, rho_2 , dots, rho_n)$ such that
$
rho_i = arg max_(delta_i in Delta_i) mu_i (sigma_(-i), delta_i)
$
Recall, this is called the best response.

The problem is, this is not a function and if we apply a tie breaking rule, it is not continuous. We could use the powerset as the domain, but that would require Katakumi's fixed point which is more analytical than we wish to be. 

#example(title:"Matching Pennies")[
  #nfg(
  players: ($P_1$, $P_2$),
  s1:($H$,$T$),
  s2:($H$,$T$),
  [1, -1],[-1, 1],
  [-1, 1],[1, -1]
  )
  Let row player choose the mixed strategy $(p,1-p)$ and column player choose $(q, 1-q)$. The problem is
  $
  p > 1/2 => q = 0\
  p < 1/2 => q = 1\
  p = 1/2 => 0 <= q <= 1
  $
  This is an counter example to the continuity of $f$.
]

*Modifying $f$*: We first define a gain function of player $i$ for deviation to $s_(i j)$ from $sigma_i$.
$
g_(i j) = max {mu_i (sigma_(-i), s_(i j)) - mu_i (sigma), 0}
$
We now define $
f_(i j) sigma = (sigma_(i j) + g_(i j) (sigma))/(sum_(k=1)^m (sigma_(i k) + g_(i k)(sigma))) = (sigma_(i j) + g_(i j) (sigma))/(1 + sum_(k=1)^m g_(i k)(sigma))
$

We want 
$
sum_(k=1)^m f_(i k) (sigma) = 1
$

We will define $
f(sigma) = := rho\
f(sigma)= f(sigma_(11), dots, sigma_(1 m), dots, sigma_(n 1), dots sigma_(n m) )\
= (rho_1, dots, rho_(1m), dots, rho_(n 1), dots, rho_(n m)).
$

Let $sigma^*$ be a fixed point of $f$.

$
f_(i j) = sigma^*_(i j)\
sigma^*_(i j)  = (sigma_(i j) + g_(i j) (sigma))/(1 + sum_(k=1)^m g_(i k)(sigma))\
<==> g_(i j)(sigma^*) = 0 forall j\
$

#todo[Will complete from Solan...]

Thus, by Brower's, we are done. 

== Two Player Non-Zero Sum Games
#definition[
  Given players $1,2$ and strategy sets $S_1, S_2$ and payoff matrices $R$ for player $1$ and $C$ for player $2$. A mixed strategy $(x^*, y^*)$ is Nash Equilibrium if and only if
  $
  x^*^T R y^* >= (R y^*)_i forall i in [n]\
  x^*^T C y^* >= (x^*^T R) forall i in [n]
  $
  where the LHS are expected payoffs. Also $(M_i)$ is the $i^"th"$ position in the matrix. We could also write this as $e_i^T R y^*$ and $x^*^T R e_i$ respectively.
]

Notice, if one switches say $R$ for $R' = R+a$ that is
$
mat(delim: "[",
  r_(1,1) + a, dots, r_(1,m) + a;
  r_(2,1) + a, dots, r_(2,m) + a;
  dots.v, dots.v, dots.v;
  r_(n,1) + a, dots, r_(n,m) + a;
)
$
#claim[
  Set of NE for $(R', C)$ are same as that of $(R,C)$. This implies, by symmetry, that $(R, C+b)$ has same NEs as $(R,C)$.
]
#claim[
  Set of NE remain unchanged for $(1/a R,C)$ wrt $(R,C)$ and similarly the set of NE remains unchanged for $(R, 1/b C)$ wrt $(R,C)$.
]

This allows us to only deal with $R_(i,j), C_(i,j) in [0,1]$.

=== NE by Support enumeration
Let $S subset.eq [n]$, $T subset.eq [m]$ be set of strategies in the support of a NE that is $x_i > 0 quad  forall i in S$, $ y_i > 0 quad forall i in T$.

We will write a LP for this, named *LP[S,T]*.
$
"probability constraints" & cases(x_i >= 0 quad forall i in [n], y_i >= 0 quad forall i in [n],sum_(i=1)^n x_i = 1, sum_(i=1)^m y_i = 1)\

"NE Constraints" & cases((R y)_i &>= (R y)_j quad &forall i in S\, j in [n],
(x^T C)_i &>= (X^T C)_j quad &forall i in T\, j in [m])
$

#claim[
  A solution to the LP say $(x^*, y^*)$ is a NE.
]
#proof[
  If $x^*, y^*$ is not a NE then one of the players has an incentive to deviate to another pure strategy, which violates the NE constraints
]

#psudo(title:"NE algorithm by support enumeration")[
  + for each $S subset.eq [n], T subset.eq [m]$:
    + if *LP[S,T]* has a feasible solution $(x,y)$
      + return $(x,y)$
]
This clearly has a $2^(n+m) op("poly")(n+m)$ running time.

This is clearly not polytime. As we shall see, that the solution lies in complexity class PPAD and is hence, believed not to be possible in polytime.

=== Lemke-Howson Algorithm
Characterization of NE for this algorithm is using the translation and scaling transforms and using the fact that the max achievable payoff is always $1$ and the payoffs are $>= 0$. We say $(x^* /(sum^n x_i^*), y^* /(sum^m y_i^*))$ is a NE if:
$
x_i^* &= 0 quad "or" quad  (R y^*)_i &= 1 quad &forall i in [n]\
y_i^* &= 0 quad "or" quad  (x^*^T C)_i &= 1 quad &forall i in [m]
$
The idea is that instead of the payoff's being variabales, we can sort of normalize them to $1$ and then make a system of linear equations using it. This will 

#definition(title : "Polytope, Polyhedron, Half-Space, Vertex")[
  A bounded *polyhedron* is *polytope*.

  Intersection of *half-spaces* is called a *polyhedron*.

  Given a $n$ dimensional plane, the plane can be split into two parts by a $n-1$ dimensional hyper-plane. This is called *half-space*. For example $a x + b > 0$ defines a half-space in 2D while $a_1x_1 + a_2x_2 + a_3x_3 >= 0$ defines a half-space in 3D.

  *Vertex/Extreme Points* in $RR^k$ is the intersections of $k$ linearly independent hyper-planes.
]

Consider the polytope:
$
P = {(x,y) | x_i >=_(i in [n]) 0, y_i >=_(i in [m]) 0, (R y)_i <= 1, (x^T C)_i <= 1}
$
We are assuming non-degeneracy here.
#definition(title : "Non-Degeneracy")[
  Any set of $ >m+n$ constraints do not meet at one point.
]
While the polytope itself doesn't define nash equilibria but some of it's vertex do. We will hop from vertex to vertex upto some condition to get nash equilibria.

At Nash equilibrium, by the stability condition, $n$ of the equations in 

${x_i >=_(i in [n]) 0, (R y)_i <= 1}$

and $m$ of the equations in 

${y_i >=_(i in [m]) 0, (x^T C)_i <= 1}$.

Thus, $m+n$ many equalities the NE must have. That implies NE is a vertex of $P$.

The vertex $x,y = (arrow(0)_n, arrow(0)_n)$ is not a NE. This is called an artificial equilibrium.

A vertex $x>0$ $R y_i < 1$ but $x_2 = 0, R_2 y = 1, dots$ is not a NE. Stratergy $1$ has $+$ve prov but not max payoff.

Let $(hat(x), hat(y))$ be a vertex. Define a set of labels for each vertex. Define a set of labels for each vertex $(hat(x), hat(y))$ has a label $i in [n]$ if either $x_i = 0$ or $R_i y = 1$. Also $(hat(x), hat(y))$ has a label $n+j$ if $y_2 = 0$ or $x^T C^((j)) = 1$.

#claim[
  $(tilde(x),tilde(y))$ is a NE if and only if $H$ has all $m+n$ labels and $(tilde(x), tilde(y)) != (arrow(0)_n, arrow(0)_m)$ Under the non-degeneracy assumption.
]
*Goal* To find $(tilde(x), tilde(y)) != (arrow(0)_n, arrow(0)_m)$ and has all the labels.

So let's start at $(x_0 y_0) = (arrow(0)_n, arrow(0)_m)$.

Fix label $J$, relax the constraint $x_1 = 0$; $x_2 = dots = x_n = 0, y_1 = dots = y_n = 0 x_1 > 0$.

This new vertex, say $(x_1, y_1)$ doesn't have label $1$, but has a duplicate label $in {n+1, dots, n+m}$, say $k = 1$.

We relax the corresponding to the old duplicate label and proceed.

At any point, say $t$ if $(x_t, y_t)$ have all the labels, output it as a NE. 

#claim[
  For any $i != j$, $(x_i, y_i) != (x_j, y_j)$
]
#proof[
  $(x_t, y_t)$ has all labels and $(x_0, y_0)$ is $(0,0)$.

  All intermediate vertices $(x_i, y_i)$ with duplicate labels $k_i$ have only two neighbors, corresponding to the duplicates. With only two ways of coming, there are only two ways of going, ensuring that we can never repeat vertices.
]

#cor[
  Every game has odd number of nash equilibrium.
]
#cor[
  The odds in a mixed nash equilibrium are rational.
]

== Mixed Nash Equilibriium in 2 Player Games
$N = {1,2}, S_1 = [n], S_2 = [m]$ with payoff matrices $R,C$.

Characterization of MNE is
$
P : "set of points" (x,y) in RR^(m+n) "s.t."\
x >= 0 forall i in [n]\
R_i y <= 1 forall i in [n]\
y_j >= 0 forall j in [m]\
x^T C_j >= 0 forall j in [m]
$
$(x,y) in P$ is a MNE if and only if
$
forall i in [n], "either" x_i = 0 "or" R y_i = 1 : "Label" i "cases"\
forall j in [n], "either" x_j = 0 "or" x^T C_j = 1 : "Label" n+j "cases"
$
$(x,y)$ has all labels in $[m + n]$.

#underline[*Non-Degeneracy assumption*] $=>$ exactly $m+n$ labels for any vertex of $P$.

Note $(0,0)$ has all labels but is not a NE.

#psudo(title: "Lemke-Hawson Algorithm")[
  + Start at $(0,0)$, fix label $1$.
  + Relax the constraint $equiv "label" 1$ (ie $x = 0$)
  + Goto next vertex $(x^((1)),y^((1)))$
    + Either all labels exist $=>$ MNE
  + Or a duplicate label $k$ exists
    + Relax the "old" constraint $equiv$ label $k$
  + Goto $(x^((2)), y^((2)))$
  + so on...
  + Let $(x^((0)), y^((0))), dots, (x^((t)), y^((t)))$ be the visited vertices.
  + All $(x^((i)), y^((i))), 0 < i < t$ miss label $1$.
]

This algorithm is clearly exponential time as our polytope may have exponential vertices.

The edges we visit form a graph, specifically a path where the first and last vertex have degree $1$ and the other vertices have degree $2$.

== Complexity of algorithm
As with most problems in computer science, we want to know how hard it is. After all after being saddened by not getting a polytime algorithm, we want to show it is unlikely that anyone else will#footnote[Unless P = NP which is still unlikely.].

The problem in showing that it is NP lies in the definition of NP itself.

#definition(title: "NP")[
  NP is a class of decision problems with yes/no answer and there exists a polytime verifiable certicificate for a yes answer.
]
Our problem is not a decision problem. So what do we do?
#definition(title: "Functional NP (FNP)")[
  If there is a certificate (solution), output one.

  Note, the certicificate should be polytime verifiable.
]
Clearly, MNE $in$ FNP. So can we show MNE is FNP-Complete.
#thm[
  If MNE is FNP-Complete, NP $=$ co-NP
]
#note[
  It is believed that NP $!=$ co-NP, not as strongly as P $!=$ NP but strongly enough. It is still open nonetheless.
]
#example[
  Take your favorite NP-complete problem. The instructor took Hamililtonian Path.

  Let's there be a reduction from Hamililtonian Path to MNE. 
  
  Input will be a graph $G$ in which we want to compute the Hamililtonian path.

  Reduction will be something that takes a graph $G$ and converts it into an instance of 2-Player Game $Gamma$ with the property: 
  
  $G$ has a Hamililtonian path $<==>$ $Gamma$ has a MNE which maps back to "yes"

  $G$ has no Hamililtonian path $<==>$ $Gamma$ has a MNE which maps back to "no"
]

Let's take a slightly less ambitious goal.
#definition(title : "TFNP")[
  Total FNP is the class of FNP problems that always have a solution.
]
This still doesn't help us out as there are no known TFNP problems.

So we go down to PPAD, a class contained in TFNP.
#definition(title : "PPAD")[
  Polynomial Parity Argument Directed version is a complexity class defined by a cannonical problem called the #underline[*end of line*] problem.
]
#definition(title : "End of Line")[
  Given $G$ possibly exponential sized graph with polytime algorithm (or circuit) to determine neighbours of a given vertex.

  Every vertex has in-degree $<= 1$ and out-degree $<= 1$.

  Q: Given a source, find a sink (any sink, not the one corresponding to the source!)
]
#thm[
  NME is PPAD complete
]
#proof(title :"High Level Proof")[
  NME is in PPAD by the Lemke-Hawson algorithm. We do this reduction in 2 steps.
  + Reduce End of Line to (approx) Brower's Fixed Point.    
  + Reduce approx Brower Fixed Point to approx MNE.

We will do the first part by an intermediate step called *Sperner Lemma*.

#lem(title:"Sperner's Lemma")[
  Given a lattice as an input with the lattice points colored in three colors with every boundry being forbidden to use one color. The intermediate vertices can have any color (from the 3).

  We define a triangle as 3 points in the same cell. That is a $1, 1, sqrt(2)$ right angle triangle where lengths are unit.

  Sperner's Lemma states that there exists a triangle with all vertices having distinct colors.
]
#definition(title : "Sperner's Lemma Problem")[
  Given a lattice as an input with the lattice points colored in three colors with every boundry being forbidden to use one color. The intermediate vertices can have any color (from the 3).

  We define a triangle as 3 points in the same cell. That is a $1, 1, sqrt(2)$ right angle triangle where lengths are unit.

  Find: a triangle with all vertices having distinct colors.
]

We can solve Brower Fixed Point on $f : [0,1]^2 -> [0,1]^2$, we want $x "s.t." f(x) = x$.

We can just declare $0^(degree)-120^(degree)$ as red, $120^(degree)-240^(degree)$ as yellow and $240^(degree)-360^(degree)$ as blue and color everything by this. We will use Sperner to find the approximate fixed point.

So our flow chart is
$
"End of Line" -> "Sperner Problem" -> "Approx Brower Fixed Point"\ -> "Arithmetic Circuit" -> "Game" -> "MNE"
$
]

== Alternatives to Nash Equilibrium
Some issues with Nash Equilibria are:
- It is hard to compute (unless PPAD $subset.eq$ P, which is unlikely)
- Many Nash Equilibria may exist, it is hence difficult to predict players behavior.
- Payoff at Nash Equilibrium may be much smaller than optimum (cost of anarchy)

#remark[
  For example, in Prisioner's Dilemma:
  #nfg(
  players: ("P1", "P2"),
  s1: ($C$, $D$),
  s2: ($C$, $D$),
  [$-5,-5$], [$-1,-10$], 
  [$-10, -1$], [$-2, -2$],
)
The optimal cases is $-2, -2$ but the Nash equilibrium is $-5, -5$ which makes the cost of anarchy $2.5$ and is not desireable from players point of view.
]

#prob[
  Can we circumvent the hardness of Nash Equilibriium by computing say the $epsilon$-Nash Equilibriium?
]
#definition(title: [$epsilon$-Nash Equilibrium])[
  $(sigma^*_1,dots, sigma^*_n)$ is a $epsilon-$NE if
  $
  forall i in [n] quad mu_i (sigma^*_i, sigma^*_(-i)) >= mu_i (sigma'_i, sigma^*_(-i)) - epsilon forall sigma'_i in Delta_i
  $
]
Unfortunately, this is also PPAD complete for all $epsilon$ as our proof for PPAD-hardness for NE uses approximate Brower's fixed point and more approximation won't really allow for any ease in computation.

#thm[
  Around each NE, there are $epsilon$-NE but converse may not hold as $exists$ games where an $epsilon$-NE is 'far' from any NE.
]
=== Corealated Equilibria
#example[
    #nfg(
  players: ("P1", "P2"),
  s1: ($C$, $M$),
  s2: ($C$, $M$),
  [$2,1$], [$0,0$], 
  [$0,0$], [$1,2$],
)
The NE are clearly $C$ and $M$ pure and $((2/3, 1/3) (1/3, 2/3))$ mixed. The expected payoffs of the equilibrium are:
$
(2,1), (1,2), (2/3, 2/3)
$
respectively where the mixed equilibrium is worse for both as they are assigning some probability to the undesireable $C M, M C$ options.
]

These are called Corealated equilibria.
#definition(title:[Corealated Equilibriium])[
#algo[
  Given $n$-players $[n]$, stratergy sets $S_1, dots, S_n$.

  - A coordinator declares a probability distribution on $S_1 times dots S_n$.

  - The coordinator 'privately' samples the joint distribution for a stratergy combination.

  - The coordinator tells player $i$ to play $s_i$

  Note: The player may choose to or not to heed the advice.
  ]
A distribution $D$ on $S_1 times dots times S_n$ is a CE if $forall i, forall b_i, b'_i in S_i$
$
EE_(s tilde D) [mu_i (b_i, s_(-i)) | s_i = b_i] >= EE_(s tilde D) [mu_i (b'_i, s_(-i)) | s_i = b_i]
$
Basically, the player is better off heeding the advice of the coordinator given everyone else is heeding the advice of the coordinator.
]

#example(title: "Chicken")[
  #nfg(
  players: ("P1", "P2"),
  s1: ($D$, $C$),
  s2: ($D$, $C$),
  [$0,0$], [$5,1$], 
  [$1,5$], [$4,4$]
  )
  This game comes from a dumb things teenagers did 'back in the day' #footnote[Nowadays, teenagers have better (read safer) things to do in their time. Unfortunately, social media fame, friendship graphs, min-maxing for university/NEET-JEE/Olympiads etc are much harder to study.] where they would drive towards each other at some speed and the first person to hit the breaks (Chicken out) would lose. The issue is if two hot headed (or stupid, albeit it is hard to tell the difference) drive into each other.

  We can see the Nash Equilibria are $(A,B), (B, A), (1/2 A, 1/2 B)$ whereas we can have a CE of $1/3 (A,B), 1/3 (B,A), 1/3 (B, B)$.
]

As John Green once said: "Turtles all the way down!", we will say Equilibria all the way down.

$
"Dominent Equilibria" subset.eq "Weakly Dominent Equilibria" subset.eq "Nash Equilibria" subset.eq "Corelated Equilibria"
$
where the equilibria from Nash onwards are gurenteed to exist and Corealated is easy to compute.

#thm[
  CE form a convex set
]

#algo[
  We can compute CE using LP:
  $
  sum_j A_(i j) p_(i j) >= sum_(j) A_(i' j) p_(i j)\
  sum_j B_(i j) p_(i j) >= sum_(i) B_(i j') p_(i h)\
  sum_(i, j) p_(i j) = 1\
  p_(i j) > 0 
  $
]