From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 3 Dec 2015 10:20:13 +0100
Subject: [Cocci] Determination of syntax scopes with SmPL
Message-ID: <5660094D.2040206@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

The Coccinelle software takes special care for some details from source files.
These details correspond to specific data structures which are connected with
a syntax for their elements. Each structure member needs usually to be processed
in the context of the involved data type hierarchy.

I find that there are further software development challenges to express
special dependendencies and constraints for advanced source code analysis with
the semantic patch language around safe handling of syntax scopes like
the following.

1. Preprocessor statements
2. Function implementation
3. Global scope

I am looking for a bit more advice around data processing of identifiers
which can appear in ordinary C functions and the statement "#define".
How should an identifier be distinguished from its use within macro text
and at other source code places?

The SmPL ellipsis can be restricted to some degree.
http://coccinelle.lip6.fr/docs/main_grammar008.html#NEST

Does this construct need any extensions to limit a source code search on
a specific scope in the mentioned hierarchy?

Regards,
Markus
