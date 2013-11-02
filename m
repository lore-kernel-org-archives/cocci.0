From: josh@joshtriplett.org (Josh Triplett)
Date: Sat, 2 Nov 2013 08:05:20 -0700
Subject: [Cocci] [PATCH] coccinelle: Add a script to find and remove
 unnecessary ifs with no body
In-Reply-To: <alpine.DEB.2.02.1311021550330.2261@hadrien>
References: <20131102143236.GA18084@leaf>
 <alpine.DEB.2.02.1311021550330.2261@hadrien>
Message-ID: <20131102150520.GV15704@leaf>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Nov 02, 2013 at 03:51:50PM +0100, Julia Lawall wrote:
> On Sat, 2 Nov 2013, Josh Triplett wrote:
> 
> > This script matches code like:
> >
> > if (foo) {}
> >
> > and either eliminates it (if foo has no side effects) or replaces it
> > with foo (if foo has side effects).
> >
> > Works perfectly in report mode; the results of patch mode are
> > semantically correct but may still benefit from further simplification.
> 
> Actually, I would get rid of the patch mode.  Looking through some of the
> results, I don't see any where just deleting the code is the right thing
> to do.  They all look like cases where the developer wanted to remember to
> think more about the problem.

I observed several where the patch seemed entirely correct, with no
FIXME/TODO/XXX comments associated with the conditional.

Nonetheless, I don't mind removing the patch mode if you don't think
it's worthwhile.  I'll send a v2.

- Josh Triplett
