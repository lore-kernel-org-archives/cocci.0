From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 7 Apr 2013 07:39:55 +0200 (CEST)
Subject: [Cocci] 1.0.0-rc17
Message-ID: <alpine.DEB.2.02.1304070739340.1972@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Version 1.0.0-rc17 has been released.  Some changes are:

- allow __ at the beginning of a struct or union name

- unparsing with precedence (insertion of parentheses when needed)

- Type metavariables no longer match a case where there is no type in the
C code.

- An expression list metavariable can now be attached with @ to a
parameter list metavariable, to allow using the parameter names as an
argument list.

julia
