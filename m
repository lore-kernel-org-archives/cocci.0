From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Jul 2013 12:24:38 +0200 (CEST)
Subject: [Cocci] gboolean -> bool conversion
In-Reply-To: <51DE81CC.3010805@monom.org>
References: <51DE6A05.9050008@monom.org>
 <alpine.DEB.2.02.1307111026390.2253@hadrien> <51DE75BF.3060207@monom.org>
 <51DE81CC.3010805@monom.org>
Message-ID: <alpine.DEB.2.02.1307111221320.2253@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

How is the following:

@@
gboolean x;
@@

x =
(
- TRUE
+ true
|
- FALSE
+ false
)

@@
typedef bool;
@@

- gboolean
+ bool

Note that the order of the rules is important.  In your rules, you
converted gboolean to bool first, so the second rule would not find any
gbooleans.

Another problem with your rules was that it thought that gboolean and bool
were expressions.  So the first rule needed typedef declaration. In my
rule, I use gboolean as the type of a metavariable in the first rule, so
Coccinelle considers it to be a type thereafter.  But I need the typedef
on bool in the second rule.

Is that good enough for your purpose, or are too many values and
declarations being converted?

julia
