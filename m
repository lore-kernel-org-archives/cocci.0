From: jeffm@suse.com (Jeff Mahoney)
Date: Tue, 14 Jun 2016 12:12:55 -0400
Subject: [Cocci] [BUG?] Missing closing bracket
Message-ID: <74413eb7-b789-ed75-bf86-a44871b0f93b@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi all -

I'm working on a project to transform the btrfs code into something more
approachable by cleaning up some unnecessary code.  The specific issue
I'm running into right now is that fs/btrfs/transaction.c gets stuck.
After playing around with some matching rules last night, I believe I
found a bug where Coccinelle is misinterpreting a closing bracket.  This
is code originally from btrfs_commit_transaction_async, but I've pared
it down to the minimum to reproduce the problem.

I had originally encountered this with v1.0.4 but have reproduced with
v1.0.5+ (commit 8906ed7e4dda8b).  I'd appreciate any help you can give
in sorting this out.

Here's the test code:
------>8------
int func(struct btrfs_trans_handle *trans, struct btrfs_root *root)
{
        if (!root) {
                return err;
        }

        __sb_writers_release(root->fs_info->sb, SB_FREEZE_FS);

        return 0;
}
------8<------

The rules are:

------>8------
@root_fs_info@
identifier func;
identifier R;
parameter list[npspre] pspre;
parameter list[npspost] pspost;
@@
func(pspre, struct btrfs_root *R, pspost)
{
...
R->fs_info
...
}

@fs_info_helper@
identifier root_fs_info.func;
identifier root_fs_info.R;
idexpression struct btrfs_fs_info *F;
@@
func(...)
{
* ... when != F = R->fs_info;
}
------<8------

And the output:

------>8------
jeffm at starscream:/src/git/linux/linux-upstream> spatch --sp-file
btrfs-cleanup3.cocci tmp.c
init_defs_builtins: /usr/lib64/coccinelle/standard.h
HANDLING: tmp.c
diff =
--- tmp.c
+++ /tmp/cocci-output-8357-3ffc6d-tmp.c
@@ -1,9 +1,5 @@
 int func(struct btrfs_trans_handle *trans, struct btrfs_root *root)
 {
-	if (!root) {
-		return err;
 	}

-	__sb_writers_release(root->fs_info->sb, SB_FREEZE_FS);
-	return 0;
 }
------8<------

... and we end up with:

------>8------
int func(struct btrfs_trans_handle *trans, struct btrfs_root *root)
{
        }

}
------<8------

If I turn that match rule into:
- ... when != F = R->fs_info;

I get:
--- tmp.c
+++ /tmp/cocci-output-8603-f3e3b9-tmp.c
@@ -6,11 +6,5 @@ int btrfs_commit_transaction_async(struc
 				   struct btrfs_root *root,
 				   int wait_for_unblock)
 {
-	if (!root) {
-		return err;
-	}
-
-	__sb_writers_release(root->fs_info->sb, SB_FREEZE_FS);
-
-	return 0;
+}
 }

-Jeff

-- 
Jeff Mahoney
SUSE Labs

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 881 bytes
Desc: OpenPGP digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160614/7190b375/attachment.asc>
