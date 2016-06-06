From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 6 Jun 2016 11:26:37 +0200 (CEST)
Subject: [Cocci] Coccinelle v1.0.5
Message-ID: <alpine.DEB.2.10.1606061112180.2909@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Coccinelle v1.0.5 is now available.  Here are the main changes:

* Python 3 is now supported.  Regrettably, this required changes to Pycaml
such that only the version distributed as part of Coccinelle can be used.
We hope to improve this situation in the future, but this strategy seemed
to be the most expeditious one to be able to make a release.

* A --tmp-dir option is available to name the directory that should hold
the output generated when using the -j.  Preiously, the name of this
directory was determined automatically from the semantic patch.

* --defined and --undefined arguments now apply to #if as well as #ifdef.

* Coccinelle is compatible with the latest release of OCaml, version
4.03.0

* Include files are now parse before the .c files that include them (quite
strangely, they were previously parsed afterwards).  This makes more
typedef information available when parsing the .c file, and can reduce
parse errors.

* Various improvements in the pretty printing of C code.

* Python support for some features that were previously only available in
OCaml scripts, namely iteration (see demos/python_iteration.{c,cocci}) and
construction of metavariable values of various types
(tests/python_mdecl.{c,cocci} and tests/python_mdeclp.{c,cocci})

A more complete list of changes, including to the pycocci wrapper, is
available here: http://coccinelle.lip6.fr/distrib/changes.html

julia
