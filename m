From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 17 Jan 2016 09:47:20 +0100 (CET)
Subject: [Cocci] script code on metavariables
Message-ID: <alpine.DEB.2.02.1601170938000.2026@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Some time ago, the idea of putting constraints expressed as scripts was 
discussed 
(http://article.gmane.org/gmane.comp.version-control.coccinelle/1928).

This has now been implemented, only for position variables and only for 
ocaml scripting:

The basic notation is:

position p : script:ocaml(params) { expression };

Params can only be inherited metavariables.  Due to parsing constraints, 
the expression has to be a C expression, even though the script language 
is OCaml.  Fortunately, it is possible to make an OCaml function call that 
looks just like a C function call.  The expression can also refer to the 
metavariable p being defined.  The expression should return true or false, 
ie true if the proposed value of p is acceptable as a match, and false if 
it is not.

A real-life example is:
position jp : script:ocaml() { check_in_a_hunk("P",plus_hunks,jp) };

Any thoughts about the syntax?  For example, I don't think that the 
script: and the { } are strictly necessary from a parsing point of view.

This could be extended to other metavariable types, and eventully to 
Python.

thanks,
julia
