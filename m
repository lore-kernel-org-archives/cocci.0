From: paulmck@linux.ibm.com (Paul E. McKenney)
Date: Tue, 30 Oct 2018 13:54:13 -0700
Subject: [Cocci] sending out trewide patches
In-Reply-To: <20181030203533.GT4170@linux.ibm.com>
References: <alpine.DEB.2.21.1810270831160.3588@hadrien>
 <20181027171438.GD4170@linux.ibm.com>
 <alpine.DEB.2.21.1810272008140.5204@hadrien>
 <20181030194553.GR4170@linux.ibm.com>
 <alpine.DEB.2.21.1810302053070.2949@hadrien>
 <20181030200430.GS4170@linux.ibm.com>
 <alpine.DEB.2.21.1810302108310.2949@hadrien>
 <20181030203533.GT4170@linux.ibm.com>
Message-ID: <20181030205413.GA13518@linux.ibm.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Oct 30, 2018 at 01:35:33PM -0700, Paul E. McKenney wrote:
> On Tue, Oct 30, 2018 at 09:09:27PM +0100, Julia Lawall wrote:
> > 
> > 
> > On Tue, 30 Oct 2018, Paul E. McKenney wrote:
> > 
> > > On Tue, Oct 30, 2018 at 08:56:01PM +0100, Julia Lawall wrote:
> > > >
> > > >
> > > > On Tue, 30 Oct 2018, Paul E. McKenney wrote:
> > > >
> > > > > On Sat, Oct 27, 2018 at 08:08:33PM +0200, Julia Lawall wrote:
> > > > > >
> > > > > >
> > > > > > On Sat, 27 Oct 2018, Paul E. McKenney wrote:
> > > > > >
> > > > > > > On Sat, Oct 27, 2018 at 08:38:02AM +0200, Julia Lawall wrote:
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > At OSS Europe, I got some questions about how to send out large
> > > > > > > > Coccinelle-generated patches.  Coccinelle provides a tool tools/splitpatch
> > > > > > > > (go to the tools subdirectory of the Coccinelle distribution and run make)
> > > > > > > > that splits patches by set of maintainers (the default), by directory
> > > > > > > > (--dirmerge option), or by file (--nomerge option).  There is a file
> > > > > > > > tools/splitpatch.README that explains the various ways that it can be
> > > > > > > > used, but the simplest is to create a patch normally using
> > > > > > > > git format-patch -s, obtaining eg 0001-changes.patch, and then run
> > > > > > > >
> > > > > > > > splitpatch 0001-changes.patch
> > > > > > > >
> > > > > > > > The output will include a 0001-changes.cover file, a set of
> > > > > > > > 0001-changesN.patch files with the various split patches, and a
> > > > > > > > 0001-changes.cmd file for sending it off with git send-email.
> > > > > > > >
> > > > > > > > This is available in the latest github version of Coccinelle.  Comments
> > > > > > > > are welcome.
> > > > > > >
> > > > > > > Thank you, Julia!  I will give it a try.
> > > > >
> > > > > Does the following error message mean that I need a more up-to-date
> > > > > version of ocaml or some such?
> > > > >
> > > > > 							Thanx, Paul
> > > > >
> > > > > File "globals/config.ml", line 1:
> > > > > Error: The implementation globals/config.ml
> > > > >        does not match the interface globals/config.cmi:
> > > > >        The field `python_interpreter' is required but not provided
> > > > >        The field `ocaml_version' is required but not provided
> > > > >        The field `configure_flags' is required but not provided
> > > > >        The field `get_temp_dir_name' is required but not provided
> > > > > make: *** [globals/config.cmo] Error 2
> > > >
> > > > I'm not familiar with that.  I assume you started with the github version
> > > > of Coccinelle.  Then ./autogen and ./configure.  Then make.  A recent
> > > > version of OCaml would indeed be good.  Maybe running make distclean
> > > > before ./autogen would be good.  The inconsistencies suggest that you have
> > > > some old compiled code hanging around.  The build infrastructure has
> > > > changed a lot recently, so it might not be managing code that predates the
> > > > changes in a way that you would expect.
> > >
> > > Good point, that does work much better.  Now -this- error message
> > > seems to be me having an old ocaml:
> > >
> > > ocamlfind ocamlopt -c  -no-alias-deps stdcompat__weak.mli -o stdcompat__weak.cmi
> > > ocamlopt: unknown option `-no-alias-deps'.
> > >
> > > Will get a new one and see how it goes...  ;-)
> > 
> > What version do you have?  I thought that the makefile would detect
> > unsupported versions, so perhaps that check needs to be improved.
> 
> I am running 4.0.3 and now installing 4.0.5.

But, sad to say, I get the same coccinelle build error on v4.0.5 ocaml.

Enlightenment?

							Thanx, Paul
