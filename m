From: paulmck@linux.ibm.com (Paul E. McKenney)
Date: Tue, 30 Oct 2018 12:45:53 -0700
Subject: [Cocci] sending out trewide patches
In-Reply-To: <alpine.DEB.2.21.1810272008140.5204@hadrien>
References: <alpine.DEB.2.21.1810270831160.3588@hadrien>
 <20181027171438.GD4170@linux.ibm.com>
 <alpine.DEB.2.21.1810272008140.5204@hadrien>
Message-ID: <20181030194553.GR4170@linux.ibm.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Oct 27, 2018 at 08:08:33PM +0200, Julia Lawall wrote:
> 
> 
> On Sat, 27 Oct 2018, Paul E. McKenney wrote:
> 
> > On Sat, Oct 27, 2018 at 08:38:02AM +0200, Julia Lawall wrote:
> > > Hello,
> > >
> > > At OSS Europe, I got some questions about how to send out large
> > > Coccinelle-generated patches.  Coccinelle provides a tool tools/splitpatch
> > > (go to the tools subdirectory of the Coccinelle distribution and run make)
> > > that splits patches by set of maintainers (the default), by directory
> > > (--dirmerge option), or by file (--nomerge option).  There is a file
> > > tools/splitpatch.README that explains the various ways that it can be
> > > used, but the simplest is to create a patch normally using
> > > git format-patch -s, obtaining eg 0001-changes.patch, and then run
> > >
> > > splitpatch 0001-changes.patch
> > >
> > > The output will include a 0001-changes.cover file, a set of
> > > 0001-changesN.patch files with the various split patches, and a
> > > 0001-changes.cmd file for sending it off with git send-email.
> > >
> > > This is available in the latest github version of Coccinelle.  Comments
> > > are welcome.
> >
> > Thank you, Julia!  I will give it a try.

Does the following error message mean that I need a more up-to-date
version of ocaml or some such?

							Thanx, Paul

File "globals/config.ml", line 1:
Error: The implementation globals/config.ml
       does not match the interface globals/config.cmi:
       The field `python_interpreter' is required but not provided
       The field `ocaml_version' is required but not provided
       The field `configure_flags' is required but not provided
       The field `get_temp_dir_name' is required but not provided
make: *** [globals/config.cmo] Error 2
