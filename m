From: joe@perches.com (Joe Perches)
Date: Thu, 19 Jun 2014 09:59:12 -0700
Subject: [Cocci] [PATCH] Coccinelle: Script to drop parenthesis in the
 return statements
In-Reply-To: <alpine.DEB.2.10.1406191848020.2078@hadrien>
References: <20140619162954.GA4698@himangi-Dell>
 <1403195662.7875.5.camel@joe-AO725>
 <alpine.DEB.2.10.1406191848020.2078@hadrien>
Message-ID: <1403197152.9958.5.camel@joe-AO725>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2014-06-19 at 18:49 +0200, Julia Lawall wrote:
> On Thu, 19 Jun 2014, Joe Perches wrote:
> > On Thu, 2014-06-19 at 21:59 +0530, Himangi Saraogi wrote:
> > > This script detects the use of a parenthesis around return value ot the
> > > return statements and removes them as they are unnecessary and against
> > > the CodingStyle. A new directory called checkpatch is added for semantic
> > > patches that just make patches for what checkpatch does. This will help
> > > developers having checkpatch problems, to run the semantic patches in this
> > > directory on their code and fix some of them automatically.
> >
> > checkpatch already has --fix and --fix-inplace options that
> > do something similar.
> 
> OK.  Then it is not worth adding coccinelle scripts for simple changes
> like this one.
> 
> I guess that some of the more complex changes, like choosing an
> appropriate error message function, checkpatch does not do?

I'm not quite sure what you're suggesting.

You mean choosing pr_err vs pr_notice or something
like finding an active struct <foo> and converting
printks to <foo>_<level>(&foo, fmt, ...)

from:
{
	struct device *dev;
	...
	printk(KERN_ERR "msg", ...)
to:
	dev_err(dev, "msg", ...)

checkpatch definitely can not do that.

Is it something else?
