From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 8 Jul 2015 09:41:37 +0200 (CEST)
Subject: [Cocci] [cocci] Ask for help
In-Reply-To: <559C74ED.8060305@samsung.com>
References: <559B8E1F.2090803@samsung.com>
 <alpine.DEB.2.10.1507071043210.2516@hadrien> <559BA5E5.9000709@samsung.com>
 <alpine.DEB.2.10.1507071349591.2492@hadrien> <559C74ED.8060305@samsung.com>
Message-ID: <alpine.DEB.2.10.1507080940440.3823@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

It works a little better like this.  But you may end up with an empty
declaration if all variables are changed.

@exists@
type T1;
identifier i,i1;
@@

++ struct type_b *i;
- struct type_a *i;             // only change the type name
<...                 // there may not be an i =... on every control flow
path
T1 i1;               // allow other type_a declarations
...>
i = foo();

julia
