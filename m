From: nicstange@gmail.com (Nicolai Stange)
Date: Wed, 18 May 2016 18:32:15 +0200
Subject: [Cocci] [PATCH v6 2/8] debugfs: prevent access to removed
	files' private data
In-Reply-To: <573C87B8.902@oracle.com> (Sasha Levin's message of "Wed, 18 May
 2016 11:18:16 -0400")
References: <1458652280-19785-1-git-send-email-nicstange@gmail.com>
 <1458652280-19785-3-git-send-email-nicstange@gmail.com>
 <573C80C8.6090307@oracle.com> <87r3czxvea.fsf@gmail.com>
 <573C87B8.902@oracle.com>
Message-ID: <87mvnnxr74.fsf@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Sasha Levin <sasha.levin@oracle.com> writes:

> On 05/18/2016 11:01 AM, Nicolai Stange wrote:
>> Thanks a million for reporting!
>> 
>> 1.) Do you have lockdep enabled?
>
> Yup, nothing there.
>
>> 2.) Does this happen before or after userspace init has been spawned,
>>     i.e. does the lockup happen at debugfs file creation time or
>>     possibly at usage time?
>
> So I looked closer, and it seems to happen after starting syzkaller, which
> as far as I know tries to open many different debugfs files.
>
> Is there debug code I can add it that'll help us figure out what's up?

Could you try the patch below? I stared at the new full_proxy_open() for
a while now and had to recognize the fact that if the original real_fops'
->open() fails, then its owning module's reference won't ever get
dropped :(

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 6eb58a8..2e663d4 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -263,10 +263,14 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
        if (real_fops->open) {
                r = real_fops->open(inode, filp);

-               if (filp->f_op != proxy_fops) {
+               if (r) {
+                       replace_fops(filp, d_inode(dentry)->i_fop);
+                       goto free_proxy;
+               } else if (filp->f_op != proxy_fops) {
                        /* No protection against file removal anymore. */
                        WARN(1, "debugfs file owner replaced proxy fops: %pd",
                                dentry);
+                       replace_fops(filp, d_inode(dentry)->i_fop);
                        goto free_proxy;
                }
        }


I don't see directly how this could lead to lockups, but I think it's
better to rule out the obvious before inserting more or less random
printks...

Thank you very much again,

Nicolai
