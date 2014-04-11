From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Fri, 11 Apr 2014 21:00:14 +0200
Subject: [Cocci] [PATCH] coccinelle: add pycocci wrapper
	for	multithreaded support
In-Reply-To: <alpine.DEB.2.02.1404110800120.2032@localhost6.localdomain6>
References: <1397152097-315-1-git-send-email-mcgrof@do-not-panic.com>
 <1397152289.4757.28.camel@jlt4.sipsolutions.net>
 <20140410175748.GK14815@wotan.suse.de>
 <534783DB.4080200@users.sourceforge.net>
 <alpine.DEB.2.02.1404110800120.2032@localhost6.localdomain6>
Message-ID: <20140411190014.GL14815@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Apr 11, 2014 at 08:01:04AM +0200, Julia Lawall wrote:
> 
> 
> On Fri, 11 Apr 2014, SF Markus Elfring wrote:
> 
> > > I checked the profile results, the reason the jobs finish is some threads
> > > had no work or little work.
> > 
> > Could you find out during the data processing which parts or files
> > result in a special application behaviour you would like to point out here?
> 
> I don't understand the question at all, but since the various files have 
> different properties, it is hard to determine automatically in advance how 
> much work Coccinelle will need to do on each one.

For the person who might work on enhancing multithreading support, I'd wonder
if there could be gains of actually putting an effort out first to evaluate
which files have one rule hit and then adding the file to an activity file lis
to later be spread between the threads. As you note though it is hard to
determine this in advance though given that each rule express any change.

I think one small change which could help, and likely not incur a drastic
immediate change on architecture could be to not let theads take files / jobs
list of files, but instead just take say:

	work_task_n = (files / jobs) / 10

The list of files needing work could then be kept on a list protected
against the threads, and each thread will only die if all the files
have been worked on already. This would enable keeping number_cpu
threads only, as each CPU would indeed be busy all the time.

BTW is the patch Acked-by Julia? Can we commit it :)

  Luis
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 835 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140411/c1479a3b/attachment.asc>
