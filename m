From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 30 Oct 2015 14:08:31 +0100 (CET)
Subject: [Cocci] Release 1.0.3: Clarification around SmPL conjunctions
In-Reply-To: <5631F344.9080804@users.sourceforge.net>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <5631F344.9080804@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1510301405330.2364@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 29 Oct 2015, SF Markus Elfring wrote:

> > * There is now support for conjunctions ( & ... & ).  As for a
> > disjunction, the () and & should be in column 0.  A conjunction requires
> > two patterns to match against a given piece of code in a consistent way.
>
> When will corresponding descriptions appear also in the manual?

I have added something.  It will be available in the next release.

> How does this software extension differ in the handling of several changes
> in patch scripts together without using an ampersand?

The & combines patterns that must match at the same place, with a
consistent metavariable environment.  If you have two separate rules, they
can match anywhere.  Also, if you put matches in multiple branches of a
conjunction, you may run the risk of an already tagged token error, if the
two branches make changes to the same tokens. Two different rules can make
changes the same tokens with no problem.

julia
