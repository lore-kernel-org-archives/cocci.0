From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 20 Aug 2017 08:24:27 +0200
Subject: [Cocci] Checking evaluation of another script with SmPL
	constraints
In-Reply-To: <a9e1bd38-702d-6141-4a1f-1b7bb71f0698@users.sourceforge.net>
References: <a9e1bd38-702d-6141-4a1f-1b7bb71f0698@users.sourceforge.net>
Message-ID: <6f39b260-3ab3-8636-592c-37570ec33021@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Now I wonder about this software situation.

I can reduce my evolving SmPL script for another test.

* Using only simple strings for the constraints according to the two known
  function names in the implementation which should be found.
  http://elixir.free-electrons.com/linux/v4.12.8/source/fs/ecryptfs/keystore.c#L2536
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/ecryptfs/keystore.c?id=bb70832dd42b298d4303fd054bf18a78650ff04a#n2561

* Simplify a condition check


elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt delete_oom_message7b.cocci ../Probe/keystore-excerpt1.c
init_defs_builtins: /usr/local/lib64/coccinelle/standard.h
?
@@ -28,8 +28,6 @@ ecryptfs_add_global_auth_tok(struct ecry
 					GFP_KERNEL);
 	if (!new_auth_tok) {
 		rc = -ENOMEM;
-		printk(KERN_ERR "Error allocating from "
-		       "ecryptfs_global_auth_tok_cache\n");
 		goto out;
 	}
 	memcpy(new_auth_tok->sig, sig, ECRYPTFS_SIG_SIZE_HEX);


Such an update suggestion shows the expected test result while
the following command variant points other source code places out
for further development considerations.

elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt delete_oom_message7.cocci ~/Projekte/Linux/next-patched/fs/ecryptfs/keystore.c
?
@@ -2519,8 +2502,6 @@ int ecryptfs_add_keysig(struct ecryptfs_
?


How do you think about to clarify this software behaviour by reviewing
the attached source files?

Regards,
Markus
-------------- next part --------------
A non-text attachment was scrubbed...
Name: keystore-excerpt1.c
Type: text/x-csrc
Size: 1559 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170820/bd90807e/attachment.bin>
-------------- next part --------------
@deletion1@
constant message;
expression code, code2, error_code, target, X;
identifier action =~ "^kmem_cache_zalloc",
           log =~ "^printk",
           label, release, release2, var, var2;
statement es;
@@
 target = action(...);
 ... when != target = X
 if (!target)
 {
 <...
(
  release(...);
|
  var = code;
)
 ...>
- log(..., message, ...);
 <...
(
  release2(...);
|
  var2 = code2;
)
 ...>
(
  return error_code;
|
  goto label;
)
 }
 else
 es
