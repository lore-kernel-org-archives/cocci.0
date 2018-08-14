From: luciano.coelho@intel.com (Luciano Coelho)
Date: Tue, 14 Aug 2018 16:09:33 +0300
Subject: [Cocci] New release after 1.0.7?
Message-ID: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Is there a plan for a new release after 1.0.7? 1.0.7 was not tagged and
no tarballs were released, so I'm not sure what is the status of it. 
Additionally, I've had problems compiling it, and bisected it to this
commit:

commit 7ab8f01b63d7cdec988e5f05065f3c18fdab7319 (refs/bisect/bad)
Author:     Thierry Martinez <thierry.martinez@inria.fr>
AuthorDate: Wed Jun 20 15:46:18 2018 +0200
Commit:     Thierry Martinez <thierry.martinez@inria.fr>
CommitDate: Wed Jun 20 15:46:18 2018 +0200

    Allow bytecode compilation for pyml/generate
    
    This change generalizes a patch submitted by
      Christopher Zimmermann <chrisz@openbsd.org>
    for allowing pyml/generate to be compiled by ocamlc if ocamlopt
    is not available.
    
    The rules are adapted from pyml-current/Makefile.

Nevertheless, the compilation problem I had seems to be fixed in the
latest master (commit 97695d059cd5).

We (in the Linux backports project) have made a change to support the
new attributes style[1], which was supposed to work with 1.0.6, but
that seems to be broken too.

We don't want to revert to using the pre-1.0.6 versions, so we are
waiting for new release to choose for our project.  So, my question
again, can we expect a new stable release any time soon?

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/commit/?id=98272f479c2126a135dfcb12484e93d5888164ab

--
Cheers,
Luca.
