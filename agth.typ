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
  We represent a situtation where two agents must simultaniously take an action where each of them prefers one option over the other but prefer coordination over doing different things. And example occurrence would be #footnote[Which is extremely stereotypical and doesn't reprasent the author and hopefully the prof's views.]:

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
Each player gets the same payoff for any pure stratergy in the support of the MSNE stratergy.
]


