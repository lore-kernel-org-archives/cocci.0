From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 26 Feb 2014 12:30:55 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
Message-ID: <530DD06F.4090703@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> But it is not surprising that a regular expression with over 5000 options 
> exceeds its capacity.

A source code search with the following pattern found 893 functions which check
their single parameter.

@safety_check@
identifier work, input;
type data_type;
position pos;
statement is, es;
@@
 void work at pos(data_type input)
 {
  ... when any
( if (input) is else es
| if (likely(input)) is else es
)
  ... when any
 }


Such a name list could be integrated into the following pattern variant.

@Delete_unnecessary_checks@
expression x;
identifier release =~ "^(?x)
(?:
   (?:kz?|slob_)free
|
   (?:
      # alternation/disjunction of 893 strings ...
   )
)$";
@@
-if (x)
    release(x);


I get an interesting result for example. Do you find it useful?

elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt --sp-file
delete_unnecessary_checks3.cocci /usr/src/linux-stable/fs/btrfs/inode.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: /usr/src/linux-stable/fs/btrfs/inode.c
diff =
--- /usr/src/linux-stable/fs/btrfs/inode.c
+++ /tmp/cocci-output-5030-250c49-inode.c
@@ -819,8 +819,7 @@ static u64 get_extent_allocation_hint(st
                        em = search_extent_mapping(em_tree, 0, 0);
                        if (em && em->block_start < EXTENT_MAP_LAST_BYTE)
                                alloc_hint = em->block_start;
-                       if (em)
-                               free_extent_map(em);
+                       free_extent_map(em);
                } else {
                        alloc_hint = em->block_start;
                        free_extent_map(em);
@@ -5137,8 +5136,7 @@ static int btrfs_dentry_delete(const str

 static void btrfs_dentry_release(struct dentry *dentry)
 {
-       if (dentry->d_fsdata)
-               kfree(dentry->d_fsdata);
+       kfree(dentry->d_fsdata);
 }

 static struct dentry *btrfs_lookup(struct inode *dir, struct dentry *dentry,
@@ -6362,8 +6360,7 @@ out:

        trace_btrfs_get_extent(root, em);

-       if (path)
-               btrfs_free_path(path);
+       btrfs_free_path(path);
        if (trans) {
                ret = btrfs_end_transaction(trans, root);
                if (!err)


Does the following pattern variant show also around 70 update candidates on your
software development system?

@is_unnecessary_check@
expression data;
identifier work;
identifier release =~ "^(?x)
(?:
   # Big regular expression for a metavariable constraint ...
)$";
position pos;
type t;
@@
 t work at pos(...)
 {
  ... when any
( if (data) release(data);
| if (likely(data)) release(data);
)
  ... when any
 }

elfring at Sonne:~/Projekte/Coccinelle/janitor> date && spatch.opt --sp-file
list_functions_with_unnecessary_checks1.cocci --dir /usr/src/linux-stable >
list_functions_with_unnecessary_checks1.txt 2>
list_functions_with_unnecessary_checks1-errors.txt && date
Mi 26. Feb 11:38:14 CET 2014
Mi 26. Feb 12:13:47 CET 2014


The log file contains messages like 'EXN:Invalid_argument("equal: abstract
value")'. Do they need further considerations?


Is this intermediate source code analysis result good enough to expand the
constructive discussion to a mailing list like "kernel janitors"?

Regards,
Markus
