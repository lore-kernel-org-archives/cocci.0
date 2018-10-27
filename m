From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 27 Oct 2018 20:08:33 +0200 (CEST)
Subject: [Cocci] sending out trewide patches
In-Reply-To: <20181027171438.GD4170@linux.ibm.com>
References: <alpine.DEB.2.21.1810270831160.3588@hadrien>
 <20181027171438.GD4170@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.1810272008140.5204@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 27 Oct 2018, Paul E. McKenney wrote:

> On Sat, Oct 27, 2018 at 08:38:02AM +0200, Julia Lawall wrote:
> > Hello,
> >
> > At OSS Europe, I got some questions about how to send out large
> > Coccinelle-generated patches.  Coccinelle provides a tool tools/splitpatch
> > (go to the tools subdirectory of the Coccinelle distribution and run make)
> > that splits patches by set of maintainers (the default), by directory
> > (--dirmerge option), or by file (--nomerge option).  There is a file
> > tools/splitpatch.README that explains the various ways that it can be
> > used, but the simplest is to create a patch normally using
> > git format-patch -s, obtaining eg 0001-changes.patch, and then run
> >
> > splitpatch 0001-changes.patch
> >
> > The output will include a 0001-changes.cover file, a set of
> > 0001-changesN.patch files with the various split patches, and a
> > 0001-changes.cmd file for sending it off with git send-email.
> >
> > This is available in the latest github version of Coccinelle.  Comments
> > are welcome.
>
> Thank you, Julia!  I will give it a try.
>
> 							Thanx, Paul
>
> PS.  And in case you didn't make it there...  ;-)
>
> 	https://www.spatchchicken.co.uk/
> 	https://www.spatchchicken.co.uk/about-us.html

Amazing.  Thanks!

julia
