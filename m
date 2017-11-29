From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 29 Nov 2017 22:49:40 +0100
Subject: [Cocci] Having rules span multiple files
In-Reply-To: <a7dcad88-b159-6874-1f71-ac05a2dbc584@mykolab.com>
References: <20171129205814.GV729@wotan.suse.de>
 <a7dcad88-b159-6874-1f71-ac05a2dbc584@mykolab.com>
Message-ID: <20171129214940.GW729@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Nov 29, 2017 at 10:21:00PM +0100, Michael Stefaniuc wrote:
> On 11/29/2017 09:58 PM, Luis R. Rodriguez wrote:
> > I've recently implemented support for a functionality which would allow us
> > to remove freezing calls on kthreads on filesystems *iff* the filesystem
> > implements support for filesystem freezing, this can be determined if
> > the filesystem implements the fs_freeze superblock callback. So the below
> > rule looks for the callback first, then looks to see if it has a kthread
> > implemented, and finally on the kthread fn, it removes any freeze calls.
> > This works quite nice on a filesystem where there is a match for all
> > the above in one file, for example fs/ext4/super.c, however it doesn't
> > work when say the fs_freeze is one file, and the kthread on another.
> > 
> > How could I get the rules to span multiple files?
> You mean treat multiple .c files as a single compilation unit?
> Just pass all those files together on the command line:
> spatch foo.c bar.c
> or
> spatch fs/ext4/*.c

Neat that works, thanks!

  Luis
