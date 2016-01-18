From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 18 Jan 2016 11:11:29 +0100
Subject: [Cocci] script code on metavariables
In-Reply-To: <alpine.DEB.2.02.1601170938000.2026@localhost6.localdomain6>
References: <alpine.DEB.2.02.1601170938000.2026@localhost6.localdomain6>
Message-ID: <569CBA51.2040303@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Some time ago, the idea of putting constraints expressed as scripts was discussed
> (http://article.gmane.org/gmane.comp.version-control.coccinelle/1928).

I am curious if the discussion (from December 2011) will be continued
around a topic like "assignments and support for SmPL rule extensions".


> This has now been implemented,

Interesting ?


> only for position variables and only for ocaml scripting:

I hope that this software limitation can be changed anyhow
in the future.


> The basic notation is:
> 
> position p : script:ocaml(params) { expression };
> 
> Params can only be inherited metavariables.

Would you like to clarify the specification of such parameters
a bit more?


> Due to parsing constraints, the expression has to be a C expression,
> even though the script language is OCaml.

How do you think about to explain this restriction better?


> Fortunately, it is possible to make an OCaml function call that 
> looks just like a C function call.

I am unsure if I understand the consequences from this information
good enough.


> The expression can also refer to the metavariable p being defined.

Nice ?


> The expression should return true or false, ie true if the proposed value
> of p is acceptable as a match, and false if it is not.

Do you describe the introduction of generic predicate functions here?


> A real-life example is:
> position jp : script:ocaml() { check_in_a_hunk("P",plus_hunks,jp) };
> 
> Any thoughts about the syntax?  For example, I don't think that the 
> script: and the { } are strictly necessary from a parsing point of view.

I find that extra delimiter characters will help to make such
source code a bit easier to read.


> This could be extended to other metavariable types, and eventully to Python.

I am curious on corresponding software evolution.

Regards,
Markus
