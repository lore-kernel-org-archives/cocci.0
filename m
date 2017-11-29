From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 29 Nov 2017 21:58:14 +0100
Subject: [Cocci] Having rules span multiple files
Message-ID: <20171129205814.GV729@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I've recently implemented support for a functionality which would allow us
to remove freezing calls on kthreads on filesystems *iff* the filesystem
implements support for filesystem freezing, this can be determined if
the filesystem implements the fs_freeze superblock callback. So the below
rule looks for the callback first, then looks to see if it has a kthread
implemented, and finally on the kthread fn, it removes any freeze calls.
This works quite nice on a filesystem where there is a match for all
the above in one file, for example fs/ext4/super.c, however it doesn't
work when say the fs_freeze is one file, and the kthread on another.

How could I get the rules to span multiple files?

@ has_freeze_fs @
identifier super_ops;
expression freeze_op;
@@

struct super_operations super_ops = {
	.freeze_fs = freeze_op,
};

@ has_kthread depends on has_freeze_fs @
identifier kthread_fn;
expression task;
@@

task = kthread_run(kthread_fn, ...);

@ remove_set_freezable depends on has_kthread @
identifier has_kthread.kthread_fn;
expression time;
@@

kthread_fn(...)
{
	<+...
(
-	set_freezable();
|
-	try_to_freeze();
|
-	freezable_schedule();
+	schedule();
|
-	freezable_schedule_timeout(time);
+	schedule_timeout(time);
)
	...+>
}
