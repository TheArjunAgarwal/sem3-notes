#import "modules/notes.typ": *
#import "@preview/finite:0.5.0": *
#import "@preview/game-theoryst:0.1.0" : *
#import "@preview/mannot:0.2.2": markrect

#let boxed(..args) = markrect(..args)
#show: thm-rules

#let varphi = $phi.alt$

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
]
We also would like to define the term 'cost of anarchy' here which refers to the ratio of equilibrium payouts (or cost) divided by optimal payouts(or cost). In this case, anarchy was $2/1.5 = 4/3$ times costlier.
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

PPAD-hard $=>^?$ NP-Hard $<==>$ NP $=^?$ co-NP. This is open and unknown.

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
  In such an auction setting (regret less, envy less, fee less auctions), our payoff is zero unless we win.

  What agents are hence trying to avoid is the so called 'winner's curse. Hence, we can restrict the analysis to bidding as if we know we will win.

  In that case, bidding your value is weakly dominant as if everyone is bidding their value; you can't do better by 
  
  - bidding lower than your value, $tilde(v) < v$, as another agent may have valuation $v^*$ such that $tilde(v) < v^* < v$ and will now win instead of you.
  - bidding above your valuation, $tilde(v) > v$, as another agent may have valuation $v^*$ such that $tilde(v) > v^* > v$ and you will win instead of them; However, with the winners curse.
]
#note[
  This is the only weakly dominant equilibrium. Although, this is by far not the only nash equilibrium. $(v_1, 0, dots, 0)$ is a NE; $(v_2, v_1, 0, dots, 0)$ is a NE; and so on.

  This is called a Bayesian Nash Equilibrium as given our beliefs of the nature of the world, this maximizes our payoff. (Here the belief is that all valuations (in some radius around ours) are likely and that we may win).
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
This makes the utility of a player a convex combination of their pure strategy payoffs.

#definition(title : "Convex Combination")[
  A convex combination of $a_1, a_2, dots, a_n$ is $sum_(i=1)^n lambda_i a_i$ where $lambda_i in [0,1]$ and $sum_(i=1)^n lambda_i  = 1$.
]

An obvious observation is that convex combination of $a_1, dots, a_n <= max {a_i}$.

Which implies that the payoff with mixed strategy is less than equal to max payoff with a pure strategy $s_i$. This implies:
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
We can get the guarantee finding the nash equilibrium by identifying the highest entry per row and column wrt the respective players.
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
For any strategy,  $i$ of $P_1$ and $P_2$ will choose a strategy such that,
- $P_1$ chooses $max_i min_j a_(i j)$ (maximin)
- $P_2$ will choose $min_j max_i a_(i j)$. (minimax)

If maximin and minimax are equal, we are done and the value is the nash equilibrium.

#definition(title: "Maximin-Minimax")[
  The maximin value refers to $max_(i in S_1) min_(j in S_2) a_(i j)$.

The minimax value refers to $min_(j in S_2) max_(i in S_1) a_(i j)$.
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

#definition(title:"Mixed Strategy in 2 player zero sum game")[
  Let $|S_1| = m$ and $|S_2| = m$. Let $x = (x_1, x_2, dots, x_n)$ be a mixed strategy for $P_1$ and $y = (y_1, y_2, dots, y_n)$ be a mixed strategy for $P_2$.

  The expected payoff is $sum^n_(i=1) sum^m_(j=1) x_i y_j a_(i j) = x^T A y$
]

We can define maximin and minimax values here as:
#definition(title:"Maximin-minimax")[
  maximin value = $max_(x in Delta(S_1)) min_(y in Delta(S_2)) x^T A y$

  minimax value = $min_(y in Delta(S_2)) max_(x in Delta(S_1)) x^T A y$
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
  DIY. It's just transposing stuff here and there.
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
Ler $(N, <s_i>, <mu_i>)$ be the game where $N = {1,2,dots,n}$, $S_i$ is strategy set for player $i$, with $|S_i| = m forall i$ and and $mu_i : S_i times S_(-i) -> RR$ is the payoff function for player $i$.

Mixed strategy $sigma_i$ is a probability distribution over $S_i$.

$Delta_i$ of $Delta(S_i)$ denotes the set of all mixed strategies for player $i$. $Delta = Delta_1 times Delta_2 times dots times Delta_m$.

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
We want to define $B, f$ such that the Nash Equilibrium is the fixed point of $f$. Define $B = Delta$.

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
f(sigma) := rho\
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
The idea is that instead of the payoff's being variables, we can sort of normalize them to $1$ and then make a system of linear equations using it. This will 

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
While the polytope itself doesn't define nash equilibria but some of it's vertex do. We will hop from vertex to vertex up to some condition to get nash equilibria.

At Nash equilibrium, by the stability condition, $n$ of the equations in 

${x_i >=_(i in [n]) 0, (R y)_i <= 1}$

and $m$ of the equations in 

${y_i >=_(i in [m]) 0, (x^T C)_i <= 1}$.

Thus, $m+n$ many equalities the NE must have. That implies NE is a vertex of $P$.

The vertex $x,y = (arrow(0)_n, arrow(0)_n)$ is not a NE. This is called an artificial equilibrium.

A vertex $x>0$ $R y_i < 1$ but $x_2 = 0, R_2 y = 1, dots$ is not a NE. Strategy $1$ has $+$ve prov but not max payoff.

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

== Mixed Nash Equilibrium in 2 Player Games
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
  NP is a class of decision problems with yes/no answer and there exists a polytime verifiable certificate for a yes answer.
]
Our problem is not a decision problem. So what do we do?
#definition(title: "Functional NP (FNP)")[
  If there is a certificate (solution), output one.

  Note, the certificate should be polytime verifiable.
]
Clearly, MNE $in$ FNP. So can we show MNE is FNP-Complete.
#thm[
  If MNE is FNP-Complete, NP $=$ co-NP
]
#note[
  It is believed that NP $!=$ co-NP, not as strongly as P $!=$ NP but strongly enough. It is still open nonetheless.
]
#example[
  Take your favorite NP-complete problem. The instructor took Hamiltonian Path.

  Let's there be a reduction from Hamiltonian Path to MNE. 
  
  Input will be a graph $G$ in which we want to compute the Hamiltonian path.

  Reduction will be something that takes a graph $G$ and converts it into an instance of 2-Player Game $Gamma$ with the property: 
  
  $G$ has a Hamiltonian path $<==>$ $Gamma$ has a MNE which maps back to "yes"

  $G$ has no Hamiltonian path $<==>$ $Gamma$ has a MNE which maps back to "no"
]

Let's take a slightly less ambitious goal.
#definition(title : "TFNP")[
  Total FNP is the class of FNP problems that always have a solution.
]
This still doesn't help us out as there are no known TFNP problems.

So we go down to PPAD, a class contained in TFNP.
#definition(title : "PPAD")[
  Polynomial Parity Argument Directed version is a complexity class defined by a canonical problem called the #underline[*end of line*] problem.
]
#definition(title : "End of Line")[
  Given $G$ possibly exponential sized graph with polytime algorithm (or circuit) to determine neighbors of a given vertex.

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
  Given a lattice as an input with the lattice points colored in three colors with every boundary being forbidden to use one color. The intermediate vertices can have any color (from the 3).

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
  For example, in Prisoner's Dilemma:
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
  Can we circumvent the hardness of Nash Equilibrium by computing say the $epsilon$-Nash Equilibrium?
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
#algo[. 
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

= Fair Division
#definition(title:"Division")[
  $angle.l X_1, X_2, dots, X_n angle.r$ a division of $[0,1]$ if
  $
  X_i subset [0,1],\
  X_i inter X_j = emptyset\
  union.big_(i=1)^n X_i = [0,1]
  $
]
#definition(title: "Envy Free")[
  Given $n$ agents and their valuation functions $v_i$, and we want to divde a cake $[0,1]$ then $angle.l X_1, X_2, dots, X_n angle.r$ a EF division if
  $
  forall i, j in [n]; v_i (X_i) >= v_i (X_j)
  $
]
#prob[Envy Free Cake Division on 2 agents]
#solution[
  This is rather easy. We ask one agent to cut and other to choose.

  Another idea is that I keep moving the knife and when an agent is satisfied say at $a$, I cut the cake there and give them the piece $[0,a]$ as 
]
#prob[
  Envy Free Cake Division with 3 agents
]<cake-cutting>
#prob[Given an apartment with $n$ rooms and rent $k$, we want to divide the apartment between $n$ roomates with valuation functions $v_i : [n] times [0,k] -> [0,1]$.]<rent-division>
== Detour: Sperner's Lemma
#definition(title: "Sperner Coloring on Triangles")[
  #image("agth-pics/sperner-big.png")
  Given a triangle $A B C$ divided into triangles, a coloring of vertices such that
  - Each of the three vertices $A$, $B$, and $C$ of the initial triangle has a distinct color.
  - The vertices that lie along any edge of triangle $A B C$ have only two colors, the two colors at the endpoints of the edge. For example, each vertex on $A C$ must have the same color as $A$ or $C$. 
]
#thm(title: "Sperner's Lemma in Triangles")[
  Given any Sperner colored triangulation, there exists odd numver of fully colored elementary triangle (has all three colors.)
]
#cor[
  Given any Sperner colored triangulation, there exists atleast one of fully colored elementary triangle.
]

#definition(title: "Simplex")[
  A 0 simplex is just a point.

  A 1 simplex is a line.

  A 2 simplex is a triangle.

  A 3 sinpmex is a tetrahedron.

  So on and so fourth.
]

#definition(title:"Facet")[
  Choosing $n$ vertices from a $n+1$-simplex is called a facet.
]
#figure(image("agth-pics/sperner-tetra.png"), caption: [Sperner Tetrahedron])
#definition(title: "Sperner Coloring")[
  Given a $n$ simplex divided into $n$ simplices, we call a coulering Sperner if:
  - Each of the boundry vertices of the initial simplex has a distinct color.
  
  - The vertices that lie along any facet $i$ (named after the boundry vertice not in the facet) doesn't have color $i$.
]
#thm(title: "Sperner's Lemma")[
  Any Facet of a sperner colored simplex is also sperner colored, also, number of rainbow elementary $n$-simplices is odd.
]
#proof[
  #definition(title: "Door")[
    Door is a facet of elementary simplex if it has labels $angle.l 1 dots n angle.r$. For a $3$ simplex (triangle), it is edges with vertices colored $(1,2)$.
  ]

#lem[
  We have an odd number of doors per facet.
]

  We will now induct on $n$.

  #figure(image("agth-pics/sperner-1d.png"), caption: [Proof for 1D case])

  (B) For $1$ simplex, We are obviously done as $1-2$ rainbow will be there.

  (S) Let Sperner hold for $n-1$ simplex.

  #figure(image("agth-pics/sperner-2dproofvis.png", height: 40%), caption: [Visualization for the inductive step in 2D])

  For an $n$ simplex, The $n$ facet is $n-1$ simplex and by induction, we will have odd number of doors via Sperner.

  We can now enter via doors and lock them behind us. If we end up in a room, it is rainbow.

  If we exit the building, we will close the door we left through and close it behind us.

  If some rainbow room is unreachable, we claim that if we were to start there, we would end up walking to another unreachable rainbow room. Thus, the unreachable rooms come in pairs.

  Thus, we have odd number of rainbow rooms, proving the Sperner's Lemma.
]
== Back to Fair Division
=== Cake-Cutting Problem
We will solve a general version of @cake-cutting also called the cake-cutting problem. For $n$ agents, We consider any $n−1$ vertical cuts parallel to the side of the cake, dividing the cake into $n$ pieces. Such a way of cutting is called a cut-set. 
#idea[
Observe that in a particular cut-set, if we ask all players which part do they prefer and get all different answers, then that cut-set gives an envy-free division (because every one gets the piece he/she prefer the most). We will use Sperner’s lemma to prove that there must exists such cut-set, as well as finding one.

The idea is that Sperner allows us to gurentee that there is a triangle part with all vertices of different color. So given continuity aka small change in cut-set causes small change in preference; we can make a Sperner coloring of the linear programming simplex and get an approximate. Tha's exactly what the solution is.
]

#soln[
  Consider every possible cut-set that divides the cake into $n$ (maybe empty) pieces. Let $x_i$ be the proportion of ith leftmost part. We have $x_1 + x_2 + dots + x_n = 1$ and $x_i >= 0$ for every $i = 1, 2, dots , n$.
  
  In the $n$-dimensional space, consider a polytope formed by linear programmming  $x_1 + x_2 + dots + x_n = 1$ and $x_i >= 0$ for every $i = 1, 2, dots , n$. The resulted polytope is a regular $(n − 1)$-simplex.
  
  Then, we triangulate that simplex into smaller regular $(n − 1)­$ simplices with each having side length less than $epsilon$, for a small enough $epsilon$, as well as writing numbers $1, 2, dots, n$ on the vertices in a way that every elementary $(n − 1)$-simplex has vertices with all different numbers.

  #example[
    #image("agth-pics/ef-continous-example.png")
    In that figure, the resulted polytope is a regular triangle (regular $2$-simplex). We then divide it into $k^2$ smaller regular triangles, for some integer $k$ as big as we want. Then, we write a number on each vertex $1, 2, 3$ in a cyclic order such that every elementry triangle has all three vertices with different numbers.
  ]

  Then, at each vertex with coordinates $(x_1, x_2,dots, x_n)$ with number $i$, we ask player $i$ that which piece of cake that he/she prefers if the sizes of pieces of cake is $x_1, x_2,dots, x_n$, respectively. We then color that vertex according to the answer.

  #example[
    We ask player 1 that if the sizes of three pieces are $0, 0,$ and $1$, respectively, which piece does he/she prefer. We then color that vertex according to the answer.
  ]
  
  Observe that, in each of the $k$-dimensional face of the polytope, one ore more of the coordinates must be zero.

  #example[
    The second coordinate along the left edge of the triangle is always zero, hence, no one chooses that piece.
  ]

  As, no people prefer the piece with size zero, so the color of vertices on each face must be the same as one of the corners of that face. Therefore, the color labeling of vertices in the simplex is a Sperner labeling.

  By Sperners’ lemma, there must be at least one elementery $(n − 1)$­ simplex that has vertices with different colors. We then divide the cake by the cut-set represented by any interior point of that $(n−1)$-simplex.
  
  Since the size of each elementry simplex is less than $epsilon$, by the continuous preference assumption, all people will be satisfied with that cut-set.
  ]

  The algorithm this solution leads to is named *Simmons’ Algorithm* as it was devloped by Forrest Simmons in 1980.

=== Harmounious Rent Problem
We will now look into solving @rent-division using Sperner’s lemma.

One possible attempt is to consider every possible assignment of price to each bedroom. i.e. set the price of room $i$ to be $x_i$ such that $x_1 + x_2 + dots + x_n = S$, when $S$ is the total price of the apartment, and $x_i >= 0$ for every $i = 1, 2, dots , n$. 

Then, we consider the $(n − 1)­$ simplex obtained from the linear programming and color it like in the cake-cutting problem. 

However, this problem is different from the cakecutting problem in one aspect. In the cake-cutting problem, the bigger the piece of cake is, the higher chance people will want it; however, in this problem, the higher the price of a room is, the lower chance people will want that room. This would mean our simplex could look like:

#image("agth-pics/ef-rent-coloring.png", height: 40%)

#idea[
  If we could comehow turn every corner into a face and every face to a corner, we would be done.

  Can that be done?
]
Yes. We transform each $k$ face to $n-k-1$ face (for a $n$ simplex).
#figure(image("agth-pics/spener-duel.png"), caption:[We have marked the vertices, points on line and colored an elementry cell to show how it transforms.])

 Let the triangulation of $S^∗$ inherit a labelling via this correspondence with $S$. One may now verify that the labelling of $S^*$ is a Sperner labelling! Hence,there exists a fully labelled elementary simplex of $S^*$, which corresponds to a fully
labelled elementary simplex of $S$, as desired. We can now present the solution.

#solution[
A constructive algorithm is obtained by following “trap-doors” in Sperner’s lemma. Choose an $epsilon$ smaller than the rental difference for which housemates wouldn’t care (a penny?). Following trap-doors corresponds to suggesting pricing schemes and then asking various players, “Which piece would you choose if the rooms were priced like this?” Once a fully labelled elementary simplex is found, any point inside it corresponds to an $epsilon$-approximate rent-partitioning.]

However, we can also solve this without ever needing to go through this dualization process.
#solution[
Each person first pays the full rent price and then assigns to each room a “rebate” price that a person who takes that room will get. Then, we can use Simmons’ Algorithm to assign rooms to people.#footnote[The reason we didn't lead with this is as this fails in the case of where there is a room that nobody wants it even if it is free, someone may end up with that room with a negative price. We normally assume against it, that is called the *no “free closets" assumption* where free closets are rooms in which no one would live, even if free. This solution makes that assumption, while the other one doesn't.]
]

== Fair Division of indivisible goods
#definition(title: "Fair Division Setting")[
  Given a set of agents $[n] = {1 dots n}$, set of items/resources $Z = {z_1, z_2, dots, z_m}$ and set of utility functions $mu$ such that $v_i : op("pow")(Z) -> RR$ for agent $i$.

  A division is an allocation of items $(A_1, A_2, dots, A_n)$ such that $union.big_(i in [n]) A_i = Z$ and $forall i != j, A_i inter A_j = emptyset$.
]
We have types of valuations such that
#definition(title: "Valuations")[
  - *Additive* : $v_i (S) = sum_(z in S) v_i (z)$
  - *Subadditve* : $v_i (S union T) < v_i (S) + v_i (T)$ where $S inter T = emptyset$
  - *Submodular*: $v_i (S union) + v_i (S inter T) <= v_i (S) + v_i (T)$
  - *Supramodular*: $v_i (S union) + v_i (S inter T) >= v_i (S) + v_i (T)$
]

We normally make a *normalization* assumption that is $forall i, v_i (emptyset) = 0$. A stronger assumption which is sometimes made is called *strong normalization*#footnote[Non-standard term! Borrowed from Prof. Palavi Jain or Prof. Sushmita Gupta during COMSOC-2025 at IIT Jodhpur.]  where $v_i (Z) = 1$.

Another standardized assumption is *monotonicity* that is $forall S subset.eq T, v_i (S) <= v_i (T)$.

Assuming the valuations to be *Additive* is also a rather common assumption. We make it, unless stated otherwise.

We now we ask, what is fair?
=== Propotional Division
#definition(title: "Proptional")[
  If for all agents $i in [n], v_i (A_i) >= 1/n$, then the division satisfies *PROP*.

  We are making the strong normalization assumption here.
]
As we will show, PROP is possible for the divisible case (recall that the continuity condition for valuations in divisible settings imply additvity). 

However, it may not be possible for indivisible goods. Consider 2 agents and 1 item.
#remark[
  The 2 agent, 1 item case is a common counter example for indivisible fair division. It's genralization $n$ agents, $n-1$ items is also a counter example in many cases.
]
#psudo(title: "Moving Knife Algorithm (PROP for divisible goods with continous valuation)")[
  + We move a knife from left to right over a cake
  + As soon as the valuation is $1/n$ for an agent, they call stop.
  + We cut cake here.
  + The agent who calls stop is given the piece.
  + Continue with rest of cake and agents
]
#proof(title:"Proof of correctness")[
  All agents other than the last one call stop when they got a piece with proptional share.

  For the last agent, we know that $v_n ([0,1]) = 1$. Let $A = (A_1, dots, A_n)$ be the allocation vector.
  Then,
  $
  sum_(i in [n]) v_n (A_i) = v_n ([0,1]) = 1\
  $
  $
  "Notice," forall i in [n-1], v_n (A_i) < 1/n "as otherwise agent would have called stop"\
  => sum_(i in [n-1]) v_n (A_i) < (n-1)/n\
  therefore sum_(i in [n-1]) v_n (A_i) + v_n (A_n) = 1\
  => v_n (A_n) > 1/n
  $
]

Would such an algorithm work for the indivisible case (given additive valuations)?

#psudo(title:"Bag Filling Alogorithm")[
  + Add items to a bag till an agent says stop.
  + Give bag to agent and continue.
]
Why would this not work? Because unlike the above case where $v_i (A_i) = 1/n$ for all but last agent(they can have better aswell); here $v_i (A_i) >= 1/n$ and $forall z in A_i, v_i (A_i backslash z) < 1/n$. 

So can we modify it to maybe work? Not really as PROP is not gurenteed to exist. We can instead modify it to work for *PROP1*.
#definition(title: "PROP1")[
  An allocation is *PROP1* if and only if
  $
  forall i in A_i, exists z in Z backslash A_i "s.t." v_i (A_i) + v_i(z) >= 1/n
  $

  This can be genralized to *PROPc* where $c$ is the number of goods we get to add.
]
#psudo(title:"Bag Filling Alogorithm")[
  + Add items to a bag till an agent says stop.
  + Remove the last item and put it in a special bag
  + Give bag to agent and continue.
  + Once $n-1$ bags are given, give special bag to last agent.
]
The analysis is similer to the moving knife. We can also modify the algorithm a bit to get *PROPx* (if it exists).
#definition(title: "PROPx")[
  An allocation is *PROPx* if and only if

  $
  forall i in A_i, forall z in Z backslash A_i "s.t." v_i (A_i) + v_i(z) >= 1/n
  $
]
#proof(title: "Counter Example to existence of PROPx")[Consider an example with three agents with identical valuations; three large goods $a$, $a$, $b$; and $10$ small goods $c$. 

Each $a$ brings utility $0.15$ , $b$ brings utility $0.4$, and each $c$ brings $0.03$.

Check that, if Agent 1 gets only $c$s, and Agent 2 gets $b$, then PROPx fails.

However, PROPx also fails for Agent 1 who gets at most nine $c$s. If Agent 1 gets $b$, while Agents 2 and
3 get one $a$ each, then one of Agents 2 and 3 gets at most five $c$s (otherwise $a$ fails the EFX) and a total utility of $0.3$, so PROPx fails again.
]
#remark[
  The counter example was though of with $a$ with value $3/2$, $b$ with $4$ and $c$ with $3/10$ and then scalled to the case.

  This is another common counter example idea to make things almost equal but then divide it into parts.
]
#remark[
  Bag filling is a common approximation algorithm. It and it's modifications can be used to approximate a lot of bound based allocations. So keeping it in the back of mind is a good idea.
]

=== Envy Free Allocation
Recall, we discussed this for the divisible case and saw it always exists.
#definition(title: "EF")[
  An allocation is *EF* if and only if
  $
  forall i, j in [n] v_i (A_i) >= v_i (A_j)
  $

  We don't make the strong normalization here.
]
It doesn't always exist (2 goods, 1 agent counter example).
#thm[
  $"EF" => "PROP"$ but $"PROP" arrow.r.double.not "EF"$
]
#proof[
  FTSOC, let there be some EF allocation which is not PROP. That means there is some agent $i$ such that $v_i (A_i) < (v_i (Z))/n$. But,
  $
  sum_(j in [n]) v_i (A_j) = v_i (Z)\
  => sum_(j in [n], i != j) v_i (A_i) > v_i (Z) (n-1)/n\
  => exists j in [n] "s.t." v_i (A_j) > (v_i (Z))/n \
  => exists j in [n] "s.t." v_i (A_i) < v_i (A_j)
  $

  which contradicts EF. Thus, our assumption was false and thus, $"EF" => "PROP"$

  As for showing the converse doesn't hold, consider 3 agents and 3 goods with the following allocation.
  $
  mat(A\: boxed(1), 2, 2; B\: 2, boxed(1), 2; C\: 2, 2, boxed(1))
  $
]
#thm[
  Determining if EF exists is NP hard for even 2 agents.
]
#proof[
  Consider the partition problem with set $S = {s_1, s_2, dots, s_n}$. Consider an EF division instance with
  $
  mat(A\: s_1, s_2, dots, s_n; B\: s_1, s_2, dots, s_n)
  $
  The equivalence in solutions is trivial.
]

Can we weaken the case?
#definition(title: "EF1")[
  An allocation is EF1 if for any agents $i,j in [n]$
  $
  exists g in A_j "s.t."  v_i (A_i) >= v_i (A_j - g)
  $
  that is agents don't envy each other upto removal of one good.
]
#thm[
  EF1 always exists
]
#proof[
  #psudo(title: "Round Robin Algorithm")[
    + Order the agents arbitarily
    + for $i in [n]$:
      + if $Z = emptyset$: 
        + break
      + sort $Z$ with respect to $v_i$
      + $g$ = highest item
      + add $g$ to $A_i$
      + remove $g$ from $Z$
    + return $(A_1, A_2, dots, A_n)$
  ]
We claim this algorithm gives an EF1 allocation.

If $i < j$, then $i$ got to pick before $j$ every round and can't envy $j$.

If $i > j$, then $i$ can envy $j$ only over the first item as she passed on the other items and doesn't envy wrt to them.
]
#remark[
  Round Robin is also a class of algorithms which do work in a lot of cases.
]
#definition(title: "Chore")[
  A chore is something to be allocated which all agents value negitivly.
]
While it is clear that round robin works in only chore case, we can show it works to give an EF1 in a mix of goods and chore case.
#definition(title: "EF1")[
  An allocation of goods and chores is EF1 if for any agents $i,j in [n]$
  $
  exists g in A_j "s.t."  v_i (A_i) >= v_i (A_j - g)
  $
  or 
  $
  exists c in A_i "s.t." v_i (A_i - c) >= v_i (A_j)
  $
  that is agents don't envy each other upto removal of one good.
]
#psudo(title : "Double Round Robin")[
  + Order agents arbitarily
  + divide $Z = Z_g union Z_c$ where $Z_g$ is goods and $Z_c$ is chores
  + Forever:
    +  for $i in [n]$:
        + if $Z_c = emptyset$: 
          + break
        + sort $Z$ with respect to $v_i$
        + $c$ = highest item
        + add $c$ to $A_i$
        + remove $c$ from $Z_c$
  + Forever:
    + for $i$ in ${n, n-1, dots, 1}$:
      + if $Z_g = emptyset$: 
          + break
      + sort $Z$ with respect to $v_i$
      + $g$ = highest item
      + add $g$ to $A_i$
      + remove $g$ from $Z$
]
Showing this works is not very hard and the proof is almost identical to the goods only case.

We will now also discuss another algorithm which works when valuations are not additive, only monotonicity is given. We first show round robin doesn't work in this case.

Consider 2 agents with valuations over $A, B, C, D, E$ as $5,4,3,2,1$. By round robin, $1$ ends up with $A,C,E$ and $2$ with $B,D$. Setting valuations of ${A,C}, {C,E}$ and ${A,E}$ to be higher than ${B,D}$ is easy.

Someone may sugest choosing the best thing to add. Constructing a counterexample for that using the same idea is not hard.

So what do we do now?

#definition(title: "Envy Graph")[
  An envy graph is a graph in which each vertex represents an agent along with its partial allocations. There is a directed edge from vertex $i$ to vertex $j$ if agent $i$ envies agent $j$ under the current partial allocation.
]

#definition(title: "Envy Cycle")[
  An envy cycle is a directed cycle in the envy graph
]

#definition(title: "Source")[Source node is a node in the envy graph that does not have any
incoming edges.]

#psudo(title : "Envy Cycle Elimination")[
+ while there is an unallocated object $X$:
  + there is an unallocated object $X$
  + if the envy graph has a source vertex $v$ then
    + Allocate $X$ to $v$
  + else
    + Resolve cycles until a source vertex shows up
]

Resolving a cycle here is just moving a good from a person to another person till the cycle is not there. As we give out one good at a time, the envy at the end is all upto $1$ and hence, EF1 is achived.

It is easy to show that the number of edges strictly decrese after reduction. This implies we make atmost $O(n^2)$ cycle reductions. Thus, the algorithm is polytime.

=== Pareoto Optimality

#definition(title: "Pareto")[
  An allocation $A succ B$ if
  $
  forall i in [n] quad v_i (A_i) >= v_i (B_i)\
  exists j in [n] quad v_j (A_i) gt.nequiv v_i (B_i)
  $
]

#definition(title:"Pareto Optimal (PO)")[
  $A$ is Pareto optimal if there is no $B$ such that $B succ A$.

  Basically, $A$ is PO if you cannot make some agents better off without making enyone worse off.
]

Note, PO always exists and the proof if by the fact that giving everything to the same agent does achive that.

#definition(title: "Social Welfare")[
  Social welfare of allocation $A$ is
  $
  op("SW")(A) = sum_(i in [n]) v_i (A_i)
  $
]
#thm[
  If $
  A in arg max_(B in Pi_m (m)) op("SW")(B)
  $
  then $A$ is PO.
]
#proof[
  If $A$ is not PO, we can just switch the goods around and end up with higher valuation for some agents and hence, a higher social welfare which contradicts the maximality of social welfare.
]

So can we get a *EF1 + PO*? Trying to do pareto switches to EF1 doesn't work as:

$
mat(A\:, 1, 1 , dots, 1; B\:, 1, 1 , dots, 1; C\:, 0, 0 , dots, 0)
$
here the allocation $A_1 = {1,2,dots,10}, A_2 = {11,12,dots, 20}, A_3 = {21,22,dots,30}$ is EF but making pareto switches wull make it extremely envy prone.

Does the round robin algorithm work?
$
mat(A\:, boxed(2),2,boxed(2),2; B\:, 10,boxed(1),1,boxed(1))
$
This is not pareto optimal as switching $10 <-> 2$ and $2 <-> 1$ can be done.

Does Envy cycle agent elimination work?
$
mat(A\: boxed(10), 5, boxed(1), 1; B\: 1,boxed(1),5,boxed(10))
$

but this is not PO as switching $5 <-> 1$ and $1 <-> 5$ can be done.

So does a EF1 + PO allocation even exist?

#definition(title: "Nash Social Welfare")[
  $
  op("NSW")(A) = (product_(i in [n]) v_i (A_i))^(1/n)
  $
]
#definition(title: "Nash Optimal")[
We say $A$ is Nash Optimal if it is the largest set of agents $S$ who can simultaneously get positive values and take such a division which maximizes the geometric mean amoung $S$.
]

Working in an instance where $m >= n$ where $forall i in [n], forall g, v_i (g) > 0$.

#lem[
  If $A$ is Nash optimal then:
  + $A$ is PO
  + $A$ is EF1
]
#proof(title:"Proof of (1).")[
Suppose not. Say $B succ A$ then the set of people with non-zero utility in $B$, say $S' supset.eq S$ which is the set of peple with non zero utility in $A$. Thus,
$
op("NSW")(B) = product_(i in S') v_i (B_i) > product_(i in S) v_i (B_i)  >= product_(i in S) v_i (A_i)
$
which is a contradiction.
]
#proof(title:"Proof of (2).")[
  Suppose $A$ is Nash optimal but not EF1.

  That is $exists i, j$ such that
  $
  forall g in A_j v_i (A_i) < v_i (A_k - g)
  $

  Let $
  g^* = arg min_(g in A_k\ v_i (g) > 0) (v_k (g))/(v_i (g))
  $

  Construct a new allocation whith everything same but $v_i (B_i) = v_i (A_i) + v_i (g^*)$ and $v_j (B_j) = v_j (A_j) - v_j (g^*)$.

  We claim

  $
  (op("NSW")(B))/(op("NSW")(A)) > 1\
  <==> v_i (B_i) v_j (B_j) > v_i (A_i) v_j (A_j)\
  <==> [v_i (A_i) + v_i (g^*)][v_j (A_j) - v_j (g^*)] > v_i (A_i) v_j (A_j)\
  <==> v_i (A_i) v_j (A_j) + v_i (g^*) v_j (A_j) - v_i (A_i) v_j (g^*) - v_i (g^*) v_j (g^*) > v_i (A_i) v_j (A_j)\
  <==> 1 + (v_i (g^*))/(v_i (A_i )) -  (v_j (g^*))/(v_j (A_j)) - (v_i (g^*) v_j (g^*))/(v_i (A_i) v_j (A_j)) > 1\
  <==> v_j (A_j) > (v_j (g^*))/(v_i (g^*)) [v_i (A_i) + v_i (g^*)] quad "(by Vishwa bhaiya claims this to be true)"\
  $
  From the choice of $g^*$,
  $
  (v_j (g^*))/(v_i (g^*)) = theta\
  => (v_j (g))/(v_i (g)) >= theta\
  => v_j (g) >= theta v_i (g)
  $
  Using this,
  $
  (v_j (A_j))/(v_i (A_j)) >= theta =  (v_j (g^*))/(v_i (g^*))
  $
  Using envy freeness,
  $
  v_i (A_i) < v_i (A_j) - v_i (g^*)\
  v_i (A_i) + v_i (g^*) < v_i (A_j)\
  $

  We can multiply these to get

  $
  v_j (A_j) > (v_j (g^*))/(v_i (g^*)) [v_i (A_i) + v_i (g^*)] 
  $
  leading to a contradiction and completing the proof.
]

While NSWO is gurenteed to exist, it is NP hard to find and even hard to approximate. The question if EF1+PO can be done in poly time is open.

= Interlude: Mechanism Design
#definition(title:"Mechanism Design")[
  Till now we have been given players, game and strategies and we want to find outcome via the equilibrium.

  We will now do mechanism design where we are given the players and our ideal outcome and we want to come up with a game where the equilibrium is in line with our outcome.
]
#example()[
  In making a cricket tournament, we don't want players to lose on purpose to get an easier opponent later and have better medal odds.

  A faliure of this was the 2012 London Olympics where the women's badminton doubles was structured so badly that both teams were trying to lose in an extremely hard to watch match. Search "Wang Xiaoli / Yu Yang (CHN) vs Ha Jung-eun / Kim Min-jung (KOR)" if you want to see the match, the refree being tense and the crowd booing.

  They were later disqualified for unsportsperson like behavior. Although, trying to win by all legal means is sportsperson like in my book. Maybe they should have set the tournament better to never let this be incetivized in the first place.
  ]

Mechanism design is used to design tournaments, voting schemes and schemes to divide stuff.

= Auction Theory
== Single Item Auction
#definition(title: "Single Item Auction")[
  One seller wants to sell a single item, $n$ interested buyers (agents). Each agent has a value $v_i$ for the item.

  *Goal:* To give the item to an agent and get payment from that agent.

  *To decide:* Who gets the item? At what price?
]
We normally make the assumption that the agents are unaware of each other's valuations.
== Sealed Bid Auctions
#definition(title: "Single Item, Sealed Bid")[
  (1) Each bidder $i$ privately communicates a bid $b_i$ to the auctioneer.
  
  (2) The auctioneer decides who gets the good (if anyone).
  
  (3) The auctioneer decides on a selling price.
]
There is an obvious choice of $(2)$ being letting the highest bidder have the good. This is not always optimal from a revenue standpoint, but that is conversation for later.

We can implement $(3)$ as:
- *First Price Auction* Winner pays their bid
- *Second Price Auctio* Winner pays the next highest bid

#solution(title:"Reasoning About Auctions")[
  The following is taken from Pollak's notes on Game Theory.

  We claim that agents bid as if they know they will win. This is to avoid the so called 'winner's curse' where one has to pay more than their valuation.

  The proof is obvious as if your bid is such that you regret winning, you should not bid that amount. Furthermore, we make the assumption that an agent would like to have the object than not.

  Bidding below this amount is not optimal as say if you bid $y - epsilon$ where $y$ is the bid as if you know you win bid; then if an agent bids $y - epsilon/2$ and wins; the agent could be better off bidding $y - epsilon/2 + tilde(epsilon)$.

  This implies that it is weakly dominent to bid one's valuation in a second price auction as the payoff function is $0$ if you are not the highest bidder and $v_i - b_((2))$ otherwise.

  Similerly, bidding your value is weakly dominated in First Price Auction as the valuation function is $0$ if you are not the highest bidder and $v_i - b_(i)$ otherwise.
]
#definition(title: "Awesome Auctions")[
 We want an auction to have the following propoerties
- *Dominent Stratergy Incentive Compatible (DSIC)*: Truthful bidding must be a dominant stratergy.
- *Strong Performence Guarentee*: Maximize $sum x_i v_i$ or social surplus where $x_i$ is $1$ if $i$ wins and $0$ if $i$ loses, subject to the obvious feasibility constraint that $sum_(i=1)^n x_i <= 1$ as we have only one item.
- *Polytime Computablity*
]
An awesome auction is clearly desireable as truthful bidding is a dominant stratergy, the auction gurentees that the item will go to the agents who value it the most and the auction can be decided before the heat-death of the universe.
#claim[
  Second Price Auction is awesome.
]
== Sponsered Search Auction
Perhaps the most profitiable auction of all time. In 2014, it made around 98% of google's revenue#footnote[You know, back when it was search engine and advertisment company and not an AI obssesed mega corporation burning money left and right].

Similarly, not having a good sponsered search auction was one of the reasons behind the downfall of Yahoo.
#definition(title:"Sponsered Search Auction")[
Given $k$ add slots and and agents $j in [n]$ with per click value of $v_j$ of the agents. Assuming the click through rate of these slots is $alpha_i, i in k$. Thus, if agent $i$ gets slot $j$ then the value obtained is $alpha_j v_i_j$.

An auction to alot thee $k$ slots to $n$ agent is called an sponsered search auction.
]
#prob[Can we design an awesome sponsered search auction?]
#solution[
*Step 1* Assume that all agents bid their true values and choose an allocation rule that maximizes the social surplus and runs in polytime.

*Step 2* Design a payment rule that makes truthfulnes dominent.

*Step 3* Profit!
]

#claim[
  Greedy Assignment maximizes the social surplus.
]
#proof[
The proof is an follows from Rearrangement inequality.
]

The step 2 is easy and is done by something called 'Myerson's Lemma' which will be the focus of a lot of what is to come.

For step 3, well, that is left to the reader.

#remark(title: "A detour to Olympiad Inequalities")[
The statement and proof for Rearrangement Inequality and it's somewhat stronger cousin, Chebyshev’s Inequality are given below. They are quite common in Olympiad circles. 

My proofs are taken from Doorway to Math Olympiad#footnote[Which is an incomplete and unpublished textbook I was writing at some point. Hopefully, I'll complete it at some point and will need to edit this footnote.].
#thm(title: "Rearrangement Inequality")[
    If $a_1 <= dots <= a_n$ and $b_1 <= dots <= b_n$ then for any permutation (rearrangement) $c_1, dots, c_n$ of $b_1, dots, b_n$,\\
$
a_1 b_n + dots + a_n b_1 <= a_1 c_1 + dots +a_n c_n <= a_1 b_1 + dots + a_n b_n
$
]
#proof[
The proof of the Rearrangement Inequality can be handled with proof by contradiction. We will prove the maximization first, the minimization will follow from that.

Let us first consider the case where $n=2$. We can take $a_1 <= a_2$ and $b_1<= b_2$.
$
therefore (a_1-a_2)(b_1-b_2) <= 0\
<==> a_1b_1+a_2b_2-a_1b_2-a_2b_1 <= 0\
<==> a_1b_1+a_2b_2 <= a_1b_2+a_2b_1
$

Now for the general case. Let $a_1 <= a_2 <= dots <= a_n$ and $b_1 <= b_2 <= dots <= b_n$; and let's to the contrary assume that in the grouping maximizing the sum, $a_m$ is not paired with $b_m$. We'll instead assume that $a_m$ is paired with $b_l$ and $b_m$ is paired with $a_l$.

Hence we are claiming, $a_m b_l+a_l b_m <= a_m b_m+a_l b_l$ which is untrue as we showed above.

The minimization equality can be very easily proved by noting that if we have the set ${-b_1, -b_2, dots, -b_n}$, ordered in increasing order(which makes $b_1 <= b_2 <= b_3 dots <= b_n)$ and the set ${a_1, a_2, dots}$, ordered in decreasing order, then the maximum sum is just $-a_1 b_n - a_2 b_(n-1) + dots$. Whose negative is $a_1 b_n + dots + a_n b_1$ which will be the minimum possible value.
]
A more refined form of the rearrangement inequality is
#thm(title: "Chebyshev’s Inequality")[
If $a_1 <= a_2 <= ... <= a_n$ and $b_1 <= b_2 <= ... <= b_n$ then the following inequality holds:
$
n (sum_(i=1)^n a_i b_i) >= (sum_(i=1)^n a_i) (sum_(i=1)^n b_i)
$
On the other hand, if $a_1 <= a_2 <= ... <= a_n$ and $b_n <= b_(n-1) <= ... <= b_1$ then:
$
n (sum_(i=1)^n a_i b_i) <= (sum_(i=1)^n a_i) (sum_(i=1)^n b_i)
$
]

#proof[
The proof is simple. We know that $sum_(i=1)^n a_i b_i$ is maximal.
$
therefore sum_(i=1)^n a_i b_i >= a_1 b_1 + a_2 b_2 + ... + a_n b_n \
sum_(i=1)^n a_i b_i >= a_1 b_2 + a_2 b_3 + ... + a_n b_1 \
dots.v\
sum_(i=1)^n a_i b_i >= a_1 b_n + a_2 b_1 + ... + a_n b_(n-1)
$
Adding them will give us the inequality.
]
]
== Myerson's Lemma
Let's define everything formally
#definition(title: "Auction")[
  $n$ agents, one seller. Private valuations $v_i, i in [n]$. $X$ is the set of feasible aloocations of the items.

  Allocation and payment rules are:
  + Collect bids $b_i, i in [n]$ as input
  + Allocation rule $x(B) in X$ that is $x : RR^n -> X $
  + Payment rule $p(B) in RR^n$ that is $p : RR^m -> RR^n$
 
 Utility is $u_i (b) = v_i x_i (B) - p_i (B)$

 Where $p_i (B) in [0, b_i x_i (B)]$
]

#definition(title : "Implementable Allocation Rules")[
  An allocation rule $x$ is implementable if $exists$ a payment rule $p$ such that the sealed bid auction $(x,p)$ is DSIC.
]
#definition(title : "Monotone Allocation Rule")[
  An allocation rule $x$ is monotone if $
  forall i in [n], forall z > y, quad x_i (z, b_(-i)) > x_i (y, b_(-i))
  $
]
#definition(title : "Awesome Auctions?")[
We want an auction to have the following propoerties
- *Dominent Stratergy Incentive Compatible (DSIC)*: Truthful bidding must be a dominant stratergy.
- *Strong Performence Guarentee*: Maximize $sum x_i v_i$ or social surplus.
- Polytime Computablity
]#footnote[I am not sure if this is the real term for this. Will check at some point.]

#definition(title : "Sponsered Search Auctions")[
$n$ agents, $k$ slots, $i^("th")$ slot has click through rate $alpha_i$ where $alpha_1 >= dots >= alpha_k$ and valuations $v_j$. Agent $j$ derives value $alpha_i v_j$ if $i^("th")$ slot is allocated to $j$.

We want to choose allocation and pricing rules.
]

#lem(title : "Myerson's Lemma")[
  + An allocation rule is implementable if and only if, it is monotone.
  + For any implementable allocation rule $exists$, unique pricing rule $p$ such that $(x,p)$ is DSIC.
  + $p$ is given by an explicit formula.
]
#proof[
  ($==>$)
    Assume $x$ is implementable with DSIC pricing $p$.
    Suppose $0 <= y <= z$
    
      (i) Suppose $b_i = z$ and $v_i = y$ and other agents have bids fixed at $b_(-i)$. This is the case of *overbidding*.

      As we want the DSIC property, by the power of abuse of notation, we shall now read $x_i (z) = z_i (z, b_(-i))$.

      $
      y x_i (z) - p_i (z) <= y x_i (y) - p_i (y)
      $

      (ii) Suppose $b_i = y$, $v_i = z$. This is the case of *underbidding*.
      $
      z x_i (y) - p_i (y) <= z x_i (z) - p_i (z)
      $

    We can write $ z (x_i (y) - x_i (z)) <= p_i (y) - p_i (z) <= y (x_i (y) - x_i (z))$

    $=> (z-y) (x_i (z) - x_i (y)) >= 0\
    => z >= y => x_i (z) >= x_i (y)$.
    
    ($<==$) Assume $x$ is monotone.
    $
    y(x_i (z) - x_i (y)) <= p_i (z) - p_i (y) <= z (x_i - x_i (y))
    $
    (i) $x$ is flat at $y$
    $
    lim_(z -> y^+) y(x_i (z) - x_i (y)) <= lim_(z -> y^+) p_i (z) - p_i (y) <= lim_(z -> y^+) z (x_i - x_i (y))\
    => p_i (z) = p_i (y)
    $
    for $z$ in neighborhood of $y$.

    (ii) $x$ has a step jump at $y$ of height $h$
    $
    lim_(z -> y^+) y(x_i (z) - x_i (y)) <= lim_(z -> y^+) p_i (z) - p_i (y) <= lim_(z -> y^+) z (x_i - x_i (y))\
    => y h <= p_i (z) - p_i (y) <= y h\
    => p_i (z) - p_i (y) = y h
    $
    jump i $x$ at $y$ implies a jump in $p$ at $y$.

    $
    therefore "Price at" y_l "when there are" l "jumps" y_1, y_2, dots, y_l\
    = sum_(i=1)^l y_i ("jump heignt at" y_i "in" x_i)
    $

    (iii) When $x$ is diffrentiable
    $
    lim_(z -> y) y(x_i (z) - x_i (y))/(z-y) <= lim_(z -> y) (p_i (z) - p_i (y))/(z-y) <= lim_(z -> y) (z (x_i - x_i (y)))/(z-y)\
    => y x'_i (y) <= p'_i (y) <= y x'_i (y)\
    => p'_i (y) = y x'_i (y)\
    => p_i (z) = integral_0^z p'_i (y) = integral_0^z y x'_i (y)\
    $

    #todo[Will copy from somewhere else!!!!]
]
== Knapsack Auctions
#definition[
  Seller's Capacity: $W$

  Buyer $i$ has requitement $w_i$.

  Goal: Allocate $x_i$ ammount to buyer $i in [n]$ such that $sum_(i=1)^n w_i x_i <= W$ where $x_i in {0,1}$.
]
The issue with using our normal strategy is welfare maximization (assuming truthful bidding) maximize $sum_(i=1)^n x_i b_i$.

This is NP Hard as this is litrally the Knapsack problem which is NP Hard!

*Can we modify the existing approximation algorithm to be monotone, retaining the approximation gurentee?* From [Chawla, Immorlica, Lucier 2012], it is not true in genral. As in we can't do a black box reduction that is we need to know about the instance and can't do so in a general way.

*Can there be a dominant stratergy that is different from truthful bidding?* 
#definition(title: "Revelation Principle")[
  For any mechanism $M$ which always has a dominent stratergy, then there is a mechanism $M'$ such that truthful bidding is dominant stratergy for $M'$.
]
#example(title: "'Silly' example")[
  Single item auction where seller runs a second price auction of bids $2 b_i$ when agents submit $b_i, i in [n]$. (Note, the agents bid say $b_1 > b_2 > dots$ then agent $i$ pays $2b_2$).

  Here dominant stratergy is $b_i = v_i / 2$.
]
#proof[
  Notice $b_i$ is always a function of $v_i$.

  For $M$, let the dominent strategy be $b_i = f_i (v_i)$.

  Let $M'$ be a mechanism which takes ${b_i}$ as inputs and runs mechanism $M$ on $f_i (B_i)$. Thus, dominant stratergy for $M'$ is $b_i = v_i$.
]

This implies DSIC is free if we can design a mechanism with dominant stratergy.

== Revenue Maximization
#example[
One Agent, one item. The agent valeus it $v$ which is private.
]
This general case is not solvalble. So we assume $v$ is drawn from a known probability distribution.
#exercise[
  Let's say seller's price is drawn from $v tilde "Uniform"[0,1]$ and seller sets the price to $r$. What $r$ maximizes revenue?
]
#soln[
  Expected revenue is $r PP(v > r) = r (1-r)$ which is maximized at $r = 1/2$ and hence, expected revenue is $1/4$.
]
#exercise[
  Let $v_1, v_2 tilde "Uniform"[0,1]$. What is expected revenue in a second price auction?
]
#soln[
  Revenue is clearly $EE (min(v_1, v_2))$. We can compute it by:
  $
  PP(x < min(v_1, v_2)) = 1- (1-x)^2 = F_X (x)\
  because EE(X) = integral_(0)^1 1 - F_X (x) dif x\
  => EE(X) = integral_(0)^1 (1-x)^2 dif x\
  = x^3/3 bracket.r_(-1)^0\
  = 1/3
  $
]
#exercise[
Let $v_1, v_2 tilde "Uniform"[0,1]$. What is expected revenue in a second price auction with reserve price $R$ (we don't sell below $R$)?]
#soln[
  Revenue is $0$ if $v_1, v_2 < R$; $R$ if $v_i > R, v_(-i) < R$ and $min(v_1, v_2)$ if $v_1, v_2 > R$.

  Thus, $
  EE("revenue") = 0 * R * R + R * 2 * (R * (1-R)) + (1-R)*(1-R) * EE(min(v_1, v_2) | v_1, v_2 > R)\
  = 0 R^2 + 2 R^2 (1-R) + (1-R)^2 EE(min(v_1, v_2) | v_1, v_2 > R)\
  = 2 R^2 (1-R) + (1-R)^2 (R + EE(min(u_1, u_2)) quad "where" u_1, u_2 tilde "unifomr"[0,1-R]\
  = 2 R^2 (1-R) + (1-R)^2 (R + (1-R)/3)\
  = 2 R^2 (1-R) + ((1-R)^2 (1+2R))/3
  $
  This achives maxima at $R = 1/2$.
]
#exercise[
Let $v_1, v_2, dots, v_n  tilde "Uniform"[0,1]$. What is expected revenue in a second price auction with reserve price $R$ (we don't sell below $R$)?]
#soln[
We use the order statistics notation.

  Revenue is $0$ if $v_((1)) < R$, $R$ if $v_((1)) > R; v_((2)) < R$ and $v_((2))$ if $v_((1)), v_((2)) >R$.

  Consider $
  PP(x < v_(2) < x+h) = n h (n-1) (1-x-h) x^(n-2) \
  => PP(v_(2) = x) = lim_(h -> 0) (PP(x < v_(2) < x+h))/h =  n (n-1) (1-x) x^(n-2)
  $.

  Thus,
  $
  EE("revenue") = underbrace(integral_R^1 n (n-1) (1-x) x^(n-2) x dif x, "selling at second price") + underbrace(R n R^(n-1) (1-R), "selling at reserve price") + underbrace(0, "not selling")\
  = n (n-1) integral_R^1 x^(n-1) - x^n dif x + n R^n (1-R)\
  = n(n-1) [1/(n) - 1/(n+1) - R^(n)/(n) + R^(n+1)/(n+1)] + n R^n (1-R)\
  $

  For $R = 1/2$
  $
  EE("revenue") = n(n-1) [1/n - 1/(n+1) - 1/(2^n n) + 1/(2^(n+1) (n+1))] + n/2^(n+1)
  $

And maximizing exoected revenue, we diffrentiate and set to 0
$
n (n-1) [- R^(n-1) + R^n] + n^2 R^(n-1)(1-R) - n R^n = 0\
=> n (n-1) [R - 1] + n^2 (1-R) - n R = 0\
=> (n-1)[R-1] + n (1-R) - R =0\
=> (1 - R)(n-1-n) - R = 0\
=> 1 - 2 R = 0\
=> R = 1/2
$
Thus, the revenue is maximized at $R = 1/2$.
]

== Revenue Maximizingin Auctions
Single parameter environments where each agent has a private valuatuion $v_i$ and $X$ is a set of feasible allocations.

*Our model* Single parameter environment where $v_i$'s are drawn form distributions $F_i, f_i$ which are independent and supported on $[0, v_(max)]$.

The goal is to design a DSIC aiction $(X, p)$ that maximizes the expected revenue.

Seller knows $F_i forall i in [n]$, $v_i$'s are private to the agents.

$
"Welfare" = sum_(i=1)^n x_i v_i\
EE("Welfare") &= EE[sum_(i=1)^n x_i (v) v_i]\
&= sum_(i=1)^n EE[x_i (v) v_i]\
&= sum_(i=1)^n integral_0^(v_(max)) x_i (v) v_i f_i (v_i) dif v_i \
\
\
\
"Revenue" = sum_(i=1)^n P_i (v)\
EE("Revenue") &= EE [sum_(i=1)^n P_i (v)]\
&= sum_(i=1)^n EE [P_i (v)]
$
By Myerson's lemma,
$
P_i (v_i, v_(-i)) = integral_0^(v_i) z x'_i (z, v_(-i)) dif z\
=> EE[P_i (v)] &= integral_(0)^(v_max) P_i (v) f_i (v_i) d v_i\
&= integral_0^(v_max) [integral_0^v_i z x'_i (z, v_(-i)) dif z] f_i (v_i) dif v_i
$
Notice, the region of integration is 
#todo[Nice drawing!]
Interchanging the integral
$
= integral_0^(v_max) [integral_z^(v_max) f_i (v_i) dif v_i] z x'_i (z) dif z\
= integral_0^(v_max) [F_i (v_max) - F_i (z)] z x'_i (z) dif z\
= integral_0^(v_max) [1- F_i (z)] z x'_i (z) dif z
$
Integrating by parts
$
= [(1-F_i (z)) z x_i (z)]_0^(v_max) - integral_0^(v_max) x_i (z) [ 1 - F_i (z) - z f_i (z)] dif z\
= (0 - 0) - integral_0^(v_max) x_i (z) f_i (z) [(1 - F_i (z))/(f_i (z)) - z] dif z\
= integral_0^(v_max) x_i (z) f_i (z) [z - (1 - F_i (z))/(f_i (z))] dif z
$
Now compare this to the welfare function:
$
integral_0^(v_(max)) x_i (v) v_i f_i (v_i) dif v_i
$
The only difference we get is the valuation. We call this the virtual valuation of the agent.
$
varphi_i (z) := Z - (1 - F_i (z))/(f_i (z))
$

$
=> "Expected Revenue" &= sum_(i=1)^n integral_0^(v_(max)) varphi_i (v) v_i f_i (v_i) dif v_i\
&= sum_(i=1)^n EE[varphi_i (z) x_i (z)]\
&= EE [sum_(i=1)^n varphi_i (z) x_i (z)]\
&= "expected virtual welfare"
$

#example(title: "Virtual Valuation")[
Let's consider $F_i tilde "uniform" [0,1]$.

Then $F_i (z) = Z, f_i (z) = 1$. This implies
$
varphi_i (z) = z - (1-z)/1 = 2z - 1
$
Notice, $phi_i (z) <= 0$ for $z <= 1/2$. This implies that if all the virtual prices are below $0$, the seller should not sell/allocate item to anyone.
]
#example(title : "Single Item Auction")[
  Let $F_1, F_2 dots$ are iid. How to design $(x,p)$?

  *Goal* $forall v$ maximize $sum_(i=1)^n varphi_i (v) x_i (v)$. Is such an $x$ monotone?

  We need $phi_i (v)$ to be increasing in $v$. A distribution $F_i$ such that $phi_i (v) = v - (1- F_i (v))/(f_i (v))$ is increasing is called "regular".

  Allocation rule: Allot the item to the agent with max virtual valuation $=>$ second price auction with reserve price $varphi^(-1) (0)$ where $varphi = varphi_i forall i$.
]

#remark(title: "A digression on Regular Distribution")[
  $
  varphi(v) = v - (1- F(v))/(f(v)) = v - 1/h(v)
  $
  where $h$ is called the hazard rate of the distribution. 
  
  Regular functions are characterised by the strict convexity of $1/(1 − F(x))$ for the distribution (given we can differentiate, this is easy to prove given someone, somehow makes this hypothesis). Details on the characterisation if smoothness assumption is not made can be found in #link("https://doi.org/10.1007/s00199-012-0705-3.")[Ewerhart, 2012].

It uses weird probability theory things like Dini Derivative and Prekopa-Borel theorem etc which is way beyond the amount of math I know.
]

= Matching Theory
#definition(title: "Stable Matching")[
  Sets $A,B$ where:
  - $|A| = |B|$ 
  - each $a in A$ has an ordering on $B$ say $Pi_a$
  - each $b in B$ has an ordering on $a$ say $Pi_b$

*Goal* To find a stable matching ie each $a in A$ is paired with $b in B$ and vice versa and $exists.not$ a blocking pair.
]
#definition(title : "Blocking Pair")[
  $(a,b)$ is a blocking pair for matching $M$ if $a$ prefers $b$ over $M(a)$ and $b$ prefers $a$ over $M(b)$ as per $Pi_a$ and $Pi_b$.
]
A simple greedy algorithm for this is the deferred acceptence algorithm.
#algo(title: "Deferred Acceptence or Gale-Sharpley")[
  Each round: 
1. Boys who are without a provisional match propose to the their top girl who is yet to reject them 
2. Each Girl rejects all but the favourite offer received that round + her provisional match.
3. Each Boy crosses off the rejecting girls from their list.
4. Repeat till everyone has a provisional match. These are final matches.
]
#psudo(title: "Deferred Acceptence or Gale-Shapley")[
  + $M = emptyset$
  + while ($exists$ an unmatched $a in A$ who has not yet proposed to some $b in B$)"
    + $a$ proposes to their most prefered $b in B$ as per $Pi_a$
      + if $b$ is not matched:
        + $b$ accepts $a$, $M."insert"((a,b))$
      + else:
        + if $M(b) = a'$ and $b$ prefers $a$ over $a'$:
          + $M."remove"((a',b))$
          + $M."insert"((a,b))$
        + else:
          + $b$ rejects $a$
]
Proving the termination of the algorithm is trivial as all agents prefer being matched then unmatched and no prposal is made twice. This also gurentees execution in $O(n^2)$ time. The proof of correctness follows as:
#proof(title: "Proof of Correctness:")[
  #lem[
  For all women, their provisional match in round $t + 1$ is better or equal to match in round $t$. 
]
#proof(title: "Proof of Lemma")[
  Obvious by induction.
]

  FTSOC, let DAA scheme match $(m,w)$ and $(m', w')$, which is unstable. As $m$ prefers $w'$ more then $w$, it must have proposed $w'$. But in a later round, $w'$ has a worse match. This contradicts the above lemma, thus, the proof of correctness follows from contradiction.
]
#definition(title: "Stable Partner")[
  $b$ is a stable partner of $a$ if there exists a stable matching $M$ such that $(a,b) in M$.
]

#thm[
  The output $M$ of DA gives every $a in A$ hus best possible stable partner.
]
#proof[
  #lem[
    No stable partner rejects $a$
  ]
  #proof[
    We proceed the contradiction.

    Let $(a,b) in M$ and $(a, b') in M'$ such that
    $
    a: dots b' dots b dots
    $
    and rejection of $a$ by $b'$ be the first rejection of a stable partner.

    For $M$ to be stable, $b'$ must prefer $M(b) = a'$ over $M'(b) = a$.
    $
    b : dots a' dots a dots
    $

    For $M'$ ot be stable, $a'$ must prefer $M'(a')$ over $M(a')$. But then $a'$ must have been rejected by $M'(a')$ before $a$ was rejected by $b'$ in DA.

    This contradicts the fact that rejection of $a$ by $b'$ be the first rejection of a stable partner.

    Thus, by infinite descent, we have a contradiction.
  ]

Bu the lemma, no stable partner rejects in DA. Thus, output of DA is such that every $a in A$ hus best possible stable partner.
]
A similer proof will show:
#thm[
  The output $M$ of DA simultaneously is such that $b in B$ has the worst possible stable partner.
]
#remark[
  Hannah Fry in "The Mathematics of Love" remarks on the above two theorems:

  This result does make some intuitive sense. If you put yourself out there, start at the top of the list, and work your way down, you’ll always end up with the best possible person who’ll have you. If you sit around and wait for people to talk to you, you’ll end up with the least bad person who approaches you. Regardless of the type of relationship you’re after, it pays to take the initiative.
  
  The difference in outcomes between those who do the asking and those who wait to be asked is particularly important when the stable marriage problem is applied beyond imaginary couples at a party: something the US government found out the hard way. Through the National Resident Matching Program, the US government has been using the Gale Shapley algorithm to match doctors to hospitals since the 1950s. Initially, the hospitals did the “proposing.” This gave the hospitals the students they wanted, but didn’t work well for doctors who had to move halfway across the country to accept their least bad offer. It meant the system ended up full of unhappy doctors and, hence, unhappy hospitals. The organizers gave doctors the role of proposer when they found that out.
  
  But it’s not just hospitals and Friday-night action. The Gale-Shapley matching algorithm has been exploited in a host of real-world scenarios: dental residencies, placement of Canadian lawyers, assignment of students to high schools, and the sorority rush. It’s so useful that there is a huge amount of academic literature dedicated to investigating a range of extensions and special cases—many of which still apply to the original dating problem.
  
  Mathematicians have adapted the method to allow both men and women to approach either gender simultaneously, and changed the rules to include ties in preference lists, or scenarios where you’d rather go home alone than hook up with the weird guy in the corner. Academics have even explored what happens when you have cheating men (not cheating women, though, strangely).
  
  The math in these special cases can get quite heavy in places (although there are lots of lovely references at the end of this book if you’re interested in finding out more). But for all the extensions and examples, the message remains the same: If you can handle the occasional cringe-inducing rejection, ultimately, taking the initiative will see you rewarded. It is always better to do the approaching than to sit back and wait for people to come to you. So aim high, and aim frequently: The math says so.
  ]
#thm[
  Let $M_1, M_2$ be two stable matchings. Form a set $S$ by assigning each $a in A$ his more preferred partner from $M_1, M_2$. 
  
  $S$ is a stable matching.
]

Let's now talk about the mechanism design aspects of this algorithm
#thm[
  DA is truthful for the proposing side by not for the reciving side.
]
#proof[
  Suppose $a in A$ submits a false list and get's a better partner.

  Let $M$ be the DA matching with true lists and $M'$ be the DA output with $A$ falsifing the list and $M'(a) = b' succ_a b =  M(a)$.

  Let $M(b') = a'$. This means $M'(a') succ_(a') M(a')$ as otherwise $(a',b')$ block $M'$.

  Similerly now, $M(M'(a'))$ will get a better partner and so on. But, we can't repeat $b$ at any point as that would contradict $M$'s stability by the no stable partner rejection lemma.

  But as the sets are finite, this leads to a contradiction.

  We can just make a counter example to show the second part of the statement.
  #todo[The counterexample]
]

#remark[
  The socially maximal matching is NP complete to find via a reduction from Quadratic Programming.

  However, Quadratic programming is solvable by Quantumn Computers in poly-time; hence, we can solve socially maximal matching on a Quantumn computer. It's implemtation (named MIT-Qute, to be prononunced Meet Cute) in Quiskit came in second at MIT's Quantumn Hackethon. You can see it #link("https://www.eecs.mit.edu/at-the-mit-quantum-hackathon-a-community-tackles-quantum-computing-challenges/")[here].
]
#remark[
  This genralizes to Stable Roomates problem. An $O(n^2)$ algorithm for it exists and was given by Robert Irving. I had implemented it in Haskell (in $O(n^2 log(n))$ to prevent use of Hash maps. With hash maps, it is $O(n^2)$) and the code can be found 
]

For more data in this regard, check out Grusfield and Irving's "Stable Matching: Structure and Algorithms".

== Hourse Allocation
#prob[
  There are $N$ agents and each agent has a house. Each agent also has a preference ordering over all houses.

  *Goal:* Design an exchange mechanism so that the resulting matching allocation $Pi$ is stable.   
]
#example[
$
mat(a\:, h_b, h_c , h_a; b\:, h_c, h_a , h_b; c\:, h_a, h_b, h_c)
$
In this case the permutation $Pi = h_b, h_c, h_a$ makes everyone happy.

But
$
mat(a\:, h_b, h_c , h_a; b\:, h_a, h_c , h_b; c\:, h_a, h_b, h_c)
$
Here, as $Pi = h_b, h_c, h_a$ is not gonna work as $a,b$ can make a blocking coalition switching their houses.
]

#definition(title: "Stable Allocation")[
  $Pi$ is stable if there is no blocking colaition with respect to $Pi$
]
#definition(title: "Blocking Coalition")[
  Given $Pi$, if there i a subset of agents $A subset.eq N$ such that $exists sigma : A -> A$ such that $forall i in A, sigma_i succ.eq Pi_i$ and $exists i in A, sigma_i succ Pi_i$.
]
#psudo(title: "Top Trading Cycle Algorithm")[
+ N' = N
+ while $N' != emptyset$
  + Construct a graph where $(i,j) in E <==> h_j$ is $i's$ most favorite house amoung $j in N'$.
  + If $exists$ a cycle $C = angle.l i_1, dots, i_k angle.r$:
    + perform an exchange $Pi_(i_1) = h_(i_2), dots, Pi_(i_k) = h_(i_1)$
    + Delete $i_1, dots, i_k$ from $N$.
+ return the resulting allocation $Pi$
]
Detecting the cycle takes $O(V+E)$ time, here, every agent(vertex) only has one edge, hence $O(V + V) = O(V)$. Every turn, atleast $1$ agent is removed from the list. This gives a worst case
$
O(N) + O(N-1) + dots +O(N) = O(N^2)
$
complexity.
#thm[
  $Pi$ is a stable allocation
]
#proof[
  FTSOC let $Pi$, outputed by TTC is unstable. Thus, $exists A subset.eq N$ and $sigma : A -> A$ such that $forall i in A, sigma_i >= Pi_i$ and $exists i in A, sigma_i > Pi_i$.

  We begin by partitioning the agents into itterations based on the round they were alloted their house.
  $
  N_1 : "Agents that get house in round 1"\
  N_2 : "Agents that get house in round 2"\
  dots.v\
  N_t: "Agents that get house in round" t\
  dots.v
  $
  Notice, $A subset.eq N_t$ for some $t$ is not possible as all the agents got their best house in $N backslash (N_1 union dots union N_(t-1))$ by TTC. Thus, no coalition is formed.

  Thus, $A$ has to be over two of the parts of the partition. Let $a,b in A$ such that $a in N_i$ and $b in N_j$, $i < j$.
  $
  i = min k "s.t." A inter N_k != emptyset
  $
  #image("agth-pics/bad-image.png", height: 40%)
  #todo[
    Make bad image $->$ good image
  ]
  In $Pi$, $a$ gets top choice from $N backslash (N_1 union dots union N_(i-1))$
  $
  therefore Pi_a > sigma_a = h_b "for" a\
  => a in.not A
  $
]
#thm[
  $Pi$ is unique stable allocation.
]
#proof[
  #idea[Let $Pi'$ be another stable allocation. We can get this by inducting on the number of itterations. If $Pi, Pi'$ are same upto to $t$ itterations, it will be same in $t+1$.]
]
#definition(title: "Stratergyproof")[
  By Stratergyproofness, here we mean that no agent can get a better house in $Pi$ by submitting a false list.
]
#thm[
  The TTC algorithm is stratergyproof.
]
#proof[
  An agent can put a false preference, putting up a false outgoing edge but not a false incoming edge. Hence, they can't get anything better in an earlier round and thus, can't get better by lying.
]
This makes the algorithm quite robust, despite being simple.
#remark[
  The problem has been studied in a number of settings.
  - Envyfreeness : Defining envy as $i arrow_"envy" j$ if $Pi_i prec_i Pi_j$, can we allocate in an envy free fashion?
  - Popular: An allocatation $Pi$ is popular, if for any other allocatation $sigma$, atleast $50%$ agents prefer $Pi$ over $sigma$.
]
== Kidney Exchange
#prob[
  There are paitients who need kidney transplant and there are doners willing to donate a kidney.

  However, patient-donor pairs may be incompatible. In that case, sometimes we can exchange donors to get compatible donations. We also don't want huge cycles as some donor once their paitient recives a donation, they can walk out.
]
The last condition is there as a hospital can do only a number of transplants at once. The threshold we will see is $2$ as taking $3$ makes the problem NP hard (although approximation algorithms) exist.