From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 30 Mar 2014 13:30:23 +0200
Subject: [Cocci] Improvements for source code analysis with inclusion of
	header files
Message-ID: <5338004F.3090303@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

Some filter patterns can be specified in the semantic patch language so that
they will also work without inclusion of header files. Some other source code
analysis approaches will need all relevant data (e. g. macros and type
declarations) from them.

Various compilers provide a functionality to store processed information from
such headers in an alternative data format.
http://en.wikipedia.org/wiki/Precompiled_header

Would another intermediate form help to reduce analysis and transformation time
by the Coccinelle software here?

How do you think about to store the results from a step "precompilation" like
corresponding abstract syntax graphs in a kind of dedicated data base?
http://en.wikipedia.org/wiki/Graph_database#Graph_database_projects

Regards,
Markus
