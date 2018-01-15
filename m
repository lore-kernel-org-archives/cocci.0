From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 15 Jan 2018 07:39:23 +0100 (CET)
Subject: [Cocci] Coccinelle: alloc_cast: Add more memory allocating
 functions to the list
In-Reply-To: <9eb82024-38fe-19d0-2aad-2e19869cf5a2@users.sourceforge.net>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
 <9eb82024-38fe-19d0-2aad-2e19869cf5a2@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1801150736580.2637@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > + at depends on context && r1@
>
> Will the use of a position variable be helpful here?

No.  There is no need to repeat the same check for each place where a
given type occurs.  If the type always looks the same, checking it once is
sufficient for all uses.

> > +  \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
>
> Did you consider to handle the relevant function names by a metavariable
> instead of a SmPL disjunction?

If you put the names into the constraints of a metavariable there will be
no file filtering based on the function names and the semantic patch will
run more slowly.

julia
