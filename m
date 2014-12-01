From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 1 Dec 2014 09:52:21 +0300
Subject: [Cocci] [PATCH v2] fs-fat: Less function calls in
 fat_fill_super() after error detection
In-Reply-To: <87lhmu2jl8.fsf@devron.myhome.or.jp>
References: <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <5467B12C.4010602@users.sourceforge.net>
 <alpine.DEB.2.02.1411152117540.2225@localhost6.localdomain6>
 <54796B5E.5040707@users.sourceforge.net>
 <87sih22sn8.fsf@devron.myhome.or.jp>
 <alpine.DEB.2.10.1411291338530.2378@hadrien>
 <87lhmu2jl8.fsf@devron.myhome.or.jp>
Message-ID: <20141201065221.GA4994@mwanda>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Nov 29, 2014 at 10:59:47PM +0900, OGAWA Hirofumi wrote:
> Julia Lawall <julia.lawall@lip6.fr> writes:
> 
> >> iput() checks NULL of inode. What is wrong just remove NULL check,
> >> instead of adding new jump labels?
> >
> > Personally, I prefer that code that can be statically determined not to
> > need to be executed not to be executed.  It can make the code easier to
> > understand, because each function is only called when doing so is useful,
> > and it can be helpful to static analysis.
> 
> Hm, first of all, we want to prevent the bugs. More labels are more
> chances of bug (and we don't care micro optimize on this error path),
> isn't it?  Increasing the chance of bugs and bothers developers for
> analyzer sounds like strange.

Oh wow!  Absolutely not.  "One Err Bugs" are one of the most common
kinds of bugs we have in the kernel.  This is where you have just one
error label and the bugs look like this:

err:
	kfree(foo->bar);
	kfree(foo);

but foo is NULL.  Mixing the error paths together it always creates
confusion.  I fix so many of these bugs...  We get a few new ones every
week.

Meanwhile Markus's error labels are absolutely useless.  They give no
indication of what going to the label does.

regards,
dan carpenter
