From: jeffm@suse.com (Jeff Mahoney)
Date: Wed, 15 Jun 2016 10:49:05 -0400
Subject: [Cocci] [BUG?] Missing closing bracket
In-Reply-To: <alpine.DEB.2.10.1606141815550.2950@hadrien>
References: <74413eb7-b789-ed75-bf86-a44871b0f93b@suse.com>
 <alpine.DEB.2.10.1606141815550.2950@hadrien>
Message-ID: <bc2338b8-6901-f47e-ab6a-b4f318bbe52e@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 6/14/16 12:19 PM, Julia Lawall wrote:
> On Tue, 14 Jun 2016, Jeff Mahoney wrote:
> 
>> Hi all -
>>
>> I'm working on a project to transform the btrfs code into something more
>> approachable by cleaning up some unnecessary code.  The specific issue
>> I'm running into right now is that fs/btrfs/transaction.c gets stuck.
>> After playing around with some matching rules last night, I believe I
>> found a bug where Coccinelle is misinterpreting a closing bracket.  This
>> is code originally from btrfs_commit_transaction_async, but I've pared
>> it down to the minimum to reproduce the problem.
>>
>> I had originally encountered this with v1.0.4 but have reproduced with
>> v1.0.5+ (commit 8906ed7e4dda8b).  I'd appreciate any help you can give
>> in sorting this out.
>>
>> Here's the test code:
>> ------>8------
>> int func(struct btrfs_trans_handle *trans, struct btrfs_root *root)
>> {
>>         if (!root) {
>>                 return err;
>>         }
>>
>>         __sb_writers_release(root->fs_info->sb, SB_FREEZE_FS);
>>
>>         return 0;
>> }
>> ------8<------
>>
>> The rules are:
>>
>> ------>8------
>> @root_fs_info@
>> identifier func;
>> identifier R;
>> parameter list[npspre] pspre;
>> parameter list[npspost] pspost;
>> @@
>> func(pspre, struct btrfs_root *R, pspost)
>> {
>> ...
>> R->fs_info
>> ...
>> }
>>
>> @fs_info_helper@
>> identifier root_fs_info.func;
>> identifier root_fs_info.R;
>> idexpression struct btrfs_fs_info *F;
>> @@
>> func(...)
>> {
>> * ... when != F = R->fs_info;
>> }
>> ------<8------
>>
>> And the output:
>>
>> ------>8------
>> jeffm at starscream:/src/git/linux/linux-upstream> spatch --sp-file
>> btrfs-cleanup3.cocci tmp.c
>> init_defs_builtins: /usr/lib64/coccinelle/standard.h
>> HANDLING: tmp.c
>> diff =
>> --- tmp.c
>> +++ /tmp/cocci-output-8357-3ffc6d-tmp.c
>> @@ -1,9 +1,5 @@
>>  int func(struct btrfs_trans_handle *trans, struct btrfs_root *root)
>>  {
>> -	if (!root) {
>> -		return err;
>>  	}
>>
>> -	__sb_writers_release(root->fs_info->sb, SB_FREEZE_FS);
>> -	return 0;
>>  }
>> ------8<------
>>
>> ... and we end up with:
>>
>> ------>8------
>> int func(struct btrfs_trans_handle *trans, struct btrfs_root *root)
>> {
>>         }
>>
>> }
>> ------<8------
>>
>> If I turn that match rule into:
>> - ... when != F = R->fs_info;
>>
>> I get:
>> --- tmp.c
>> +++ /tmp/cocci-output-8603-f3e3b9-tmp.c
>> @@ -6,11 +6,5 @@ int btrfs_commit_transaction_async(struc
>>  				   struct btrfs_root *root,
>>  				   int wait_for_unblock)
>>  {
>> -	if (!root) {
>> -		return err;
>> -	}
>> -
>> -	__sb_writers_release(root->fs_info->sb, SB_FREEZE_FS);
>> -
>> -	return 0;
>> +}
>>  }
> 
> Thanks for the report.  It is probably related to the return err somehow.
> I will look into it.  A temporary solution might be obtained by doing the
> following in the functions of interest:
> 
> - return e;
> + Return(e);
> 
> But that might not be acceptable for your real application.

If it's an obvious transformation, I can reverse it later easily enough.
 That worked, it handles the brackets correctly now.

> By the way, you shouldn't actually apply the patch you get from a semantic
> patch that has * in the leftmost column.  The resulting semantic patch is
> only intended to be looked at, and to be used with emacs's diff mode (or
> something similar).  But you get essentially the same result with - in the
> leftmost column, so that isn't the problem here.

Yep.  I was using the match rule as a way to track down what it was
doing without requiring it to modify the code.  The real ruleset uses
-/+ rules.

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
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160615/8016d1c0/attachment.asc>
