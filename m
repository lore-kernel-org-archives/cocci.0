From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Mon, 29 Sep 2014 08:27:18 +0200
Subject: [Cocci] problem with Hashtbl in badzero.cocci
In-Reply-To: <alpine.DEB.2.02.1409282053010.2074@localhost6.localdomain6>
References: <20140928161629.GA23825@opentech.at>
 <alpine.DEB.2.10.1409281835210.2394@hadrien>
 <20140928170932.GA17746@opentech.at>
 <alpine.DEB.2.02.1409282053010.2074@localhost6.localdomain6>
Message-ID: <20140929062718.GA20388@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 28 Sep 2014, Julia Lawall wrote:

> On Sun, 28 Sep 2014, Nicholas Mc Guire wrote:
> 
> > On Sun, 28 Sep 2014, Julia Lawall wrote:
> > 
> > > On Sun, 28 Sep 2014, Nicholas Mc Guire wrote:
> > >
> > > >
> > > > HI !
> > > >
> > > >  make coccicheck in 3.16++
> > > >  is failing on Debian 7.6 with
> > > >
> > > > make coccicheck MODE=report -C /usr/src/linux-stable/ M=/usr/src/read_msr
> > > > make[1]: Entering directory `/usr/src/linux-stable'
> > > >
> > > > Please check for false positives in the output before submitting a
> > > > patch.
> > > > When using "patch" mode, carefully review the patch before submitting
> > > > it.
> > > >
> > > > 644 647
> > > > Fatal error: exception Failure("scriptmeta: parse error:
> > > >  = File "./scripts/coccinelle/null/badzero.cocci", line 22, column 0,
> > > > charpos =
> > > >  644
> > > >     around = 'let', whole content = let negtable = Hashtbl.create 101
> > > > ")
> > > > make[1]: Leaving directory `/usr/src/linux-stable'
> > > >
> > > > built spatch from source:
> > > >   $ git clone https://github.com/coccinelle/coccinelle
> > > >   $ git tag -> git checkout -b build coccinelle-1.0.0-rc21
> > > >   $ apt-get install python2.6-dev libpycaml-ocaml-dev \
> > > >           libmenhir-ocaml-dev menhir ocaml-native-compilers \
> > > >           ocamlduce camlp4-extra ocaml-findlib pkg-config \
> > > >           texlive-fonts-extra
> > > >   $ ./configure --with-python --with-menhir
> > > >   $ make all
> > > >   $ make install
> > > >
> > > >   $ spatch --version
> > > >     spatch version 1.0.0-rc21 with Python support and with Str regexp support
> > > >
> > > > is this a ocaml version issue ? or did I screw up something in the
> > > > config/build ?
> > >
> > > Could you try removing the @@ before let negtable, just to see if it
> > > works?
> > >
> > 
> > root at debian:/usr/src/linux/scripts/coccinelle/null# git diff badzero.cocci
> > diff --git a/scripts/coccinelle/null/badzero.cocci b/scripts/coccinelle/null/bad
> > index 5551da2..d6d1196 100644
> > --- a/scripts/coccinelle/null/badzero.cocci
> > +++ b/scripts/coccinelle/null/badzero.cocci
> > @@ -19,7 +19,6 @@ virtual org
> >  virtual report
> >  
> >  @initialize:ocaml@
> > -@@
> >  let negtable = Hashtbl.create 101
> >  
> >  @depends on patch@
> > 
> > 
> > but this now really blows up :)
> > 
> > 
> > make coccicheck MODE=report -C /usr/src/linux M=/usr/src/mce
> > make[1]: Entering directory `/usr/src/linux'
> > 
> > Please check for false positives in the output before submitting a patch.
> > When using "patch" mode, carefully review the patch before submitting it.
> > 
> > Usage: spatch --sp-file <SP> <infile> [-o <outfile>] [--iso-file <iso>] [options]
> > Options are:
> >   --sp-file                    <file> the semantic patch file
> >   -o                           <file> the output file
> > ...
> >   --help
> > 692 695
> > Fatal error: exception Failure("scriptmeta: parse error:
> >  = File "./scripts/coccinelle/null/badzero.cocci", line 22, column 0,  charpos = 692
> >     around = 'let', whole content = let negtable = Hashtbl.create 101
> > ")
> > make[1]: Leaving directory `/usr/src/linux'
> 
> This looks like the same problem on the same line as before?
>
yes but with the added usage message - with the original
badzero.cocci it will only dump the "Fatal error:..." but
no usage message. 

Will check if I can reproduce this on a second Debian 7.6 box
or if this is a local screwup and post the result.

thx!
hofrat
