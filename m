From: ralphs@netwinder.org (Ralph Siemsen)
Date: Sat, 5 Apr 2014 11:54:21 -0400
Subject: [Cocci] Trivial question about renaming prototypes in .h files
Message-ID: <20140405155421.GA20098@harvey.netwinder.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi all,

Is it possible to apply sematic patches to prototypes in header files?
I've experimented with the various -include options, and have tried several
different versions of spatch, but I can't seem to make this work.
I'm using the basic example 13.1 from the main_grammar.pdf document:

@@
@@
-foo()
+bar()

This works fine when applied to .c files, but it does not seem to want to
rename prototypes in header files. Renaming the .h to a .c does not seem
to work either.

Am I missing something obvious?

In case it matters:
- spatch version 1.0.0-rc15 with Python support and with PCRE support
- also tried with 1.0.0-rc20
- I've tried invoking it with:
  - spatch --sp-file rename.cocci --no-show-diff --in-place --dir .
  - spatch --sp-file rename.cocci --all-includes -I. foo.h
  - spatch --sp-file rename.cocci foo.h
  - and many more variations

Thanks,
Ralph
