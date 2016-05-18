From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 18 May 2016 14:42:20 -0700
Subject: [Cocci] [RFC 0/3] coccinelle: add initial control flow
	documentation and extend tests
Message-ID: <1463607743-11947-1-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This adds some initial control flow documentation, I wanted to add some
basic control flow diagrams as well with self generated diagrams from
Coccinelle however I had issues figuring out what to use with dot to
make it fit within the margins. We can skip that, but I thought adding it
would also help document support and example use case for that feature
as well.

The tests/remove-code-in-branch1* was more collateral effort as I
saw a removal of a statement from a branch that only had one statement
left an empty brace. I hope we can discuss here what the expected
outcome should be. I figured removing the empty code may be an
optional optimization, however it was still unclear how to resolve this
if that's desirable. Would it be up to Coccinelle or would that be
an optional isomorphism ? I noticed no current isomorphisms seem to
remove code like this so it was unclear what to do.

The following rule for instnace can deal with it.

@ remove_empty_branch @
expression E;
@@
                                                                                
-if (E) {}

Luis R. Rodriguez (3):
  tests: add test to remove single statement from branch
  tests: add basic series of tests for exists and forall
  coccinelle: add control flow documentation

 docs/manual/Makefile               |   6 +-
 docs/manual/cocci_syntax.tex       | 249 +++++++++++++++++++++++++++++++++++++
 docs/manual/flow1.c                |  10 ++
 docs/manual/flow2.c                |  11 ++
 tests/exists1.c                    |  20 +++
 tests/exists1.cocci                |   9 ++
 tests/exists1.res                  |  21 ++++
 tests/exists2.c                    |  21 ++++
 tests/exists2.cocci                |  13 ++
 tests/exists2.res                  |  23 ++++
 tests/exists3.c                    |  21 ++++
 tests/exists3.cocci                |  12 ++
 tests/exists3.res                  |  23 ++++
 tests/exists4.c                    |  22 ++++
 tests/exists4.cocci                |  13 ++
 tests/exists4.res                  |  21 ++++
 tests/remove-code-in-branch1.c     |   7 ++
 tests/remove-code-in-branch1.cocci |   4 +
 tests/remove-code-in-branch1.res   |   4 +
 19 files changed, 509 insertions(+), 1 deletion(-)
 create mode 100644 docs/manual/flow1.c
 create mode 100644 docs/manual/flow2.c
 create mode 100644 tests/exists1.c
 create mode 100644 tests/exists1.cocci
 create mode 100644 tests/exists1.res
 create mode 100644 tests/exists2.c
 create mode 100644 tests/exists2.cocci
 create mode 100644 tests/exists2.res
 create mode 100644 tests/exists3.c
 create mode 100644 tests/exists3.cocci
 create mode 100644 tests/exists3.res
 create mode 100644 tests/exists4.c
 create mode 100644 tests/exists4.cocci
 create mode 100644 tests/exists4.res
 create mode 100644 tests/remove-code-in-branch1.c
 create mode 100644 tests/remove-code-in-branch1.cocci
 create mode 100644 tests/remove-code-in-branch1.res

-- 
2.7.2
