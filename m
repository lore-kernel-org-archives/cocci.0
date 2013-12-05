From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 5 Dec 2013 10:09:40 +0100 (CET)
Subject: [Cocci] 1.0.0-rc19 available
Message-ID: <alpine.DEB.2.10.1312051001290.2820@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

A new version of Coccinelle is available from the web page, and probably
soon from github.  Some new features are as follows:

* Improved indentation and newline introduction in pretty printer.

* Elimination of the reliance on grep for selecting files to process.
This makes it substantially faster to run Coccinelle on code bases for
which no indexing has been done, and gives some performance improvement
when indexing is used as well.

* Allow pattern matching on the contents of strings.  An example is found
in demos/format.cocci.  There are two new kinds of metavariables: format
and format list.  Format matches a single format description after a %.
Format list matches a sequence of format declarations (including the %)
and the intervening string text.  It is possible to specify the length of
a format list, just as one can specify the length of an expression list.

julia
