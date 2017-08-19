From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 19 Aug 2017 21:30:41 +0200
Subject: [Cocci] Checking evaluation of a regular expression for a SmPL
	constraint
Message-ID: <a9e1bd38-702d-6141-4a1f-1b7bb71f0698@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

Today I published the update suggestion ?[PATCH 1/3] ecryptfs: Delete 21 error
messages for a failed memory allocation?.
https://patchwork.kernel.org/patch/9910539/
https://lkml.kernel.org/r/<1dcce3db-c162-c6bc-d1a8-bcf427248a77@users.sourceforge.net>

I noticed during the preparation of this change that the implementation of
the function ?ecryptfs_add_global_auth_tok? was not automatically found as
an update candidate.
A detailed regular expression is involved for a special constraint in
an evolving SmPL script.

I can pass the specified regular expression also to the program ?pcre2test?
(version 10.23-2.5) which indicates a successful match for an identifier
like ?kmem_cache_zalloc? then.

Now I wonder about this software situation.
Would anybody like to test once more if another mismatch can be observed
around such regex evaluation within the Coccinelle software?

Regards,
Markus
