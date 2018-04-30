From: michelemartone@users.sourceforge.net (Michele Martone)
Date: Mon, 30 Apr 2018 09:47:28 +0200
Subject: [Cocci] [cocci-bug] coccinelle 1.0.6: OpenMP #pragma directive
 leads to function ignore
In-Reply-To: <alpine.DEB.2.20.1804300940580.2351@hadrien>
References: <20180426081209.GA7703@localhost>
 <alpine.DEB.2.20.1804260925270.2402@hadrien>
 <20180426102122.GB7703@localhost>
 <alpine.DEB.2.20.1804300842440.2351@hadrien>
 <20180430073930.GA20750@localhost>
 <alpine.DEB.2.20.1804300940580.2351@hadrien>
Message-ID: <20180430074728.GB20750@localhost>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 20180430 at 09:42, Julia Lawall wrote:
> 
> 
> On Mon, 30 Apr 2018, Michele Martone wrote:
> 
> > On 20180430 at 08:43, Julia Lawall wrote:
> > > On Thu, 26 Apr 2018, Michele Martone wrote:
> > >
> > > > On 20180426 at 09:25, Julia Lawall wrote:
> > > > > On Thu, 26 Apr 2018, Michele Martone wrote:
> > > > >
> > > > > > Dear Prof. Lawall and Coccinelle team,
> > > > > >
> > > > > > I'm an enthusiastical, however still beginner use of Coccinelle.
> > > > > >
> > > > > > While running spatch 1.0.6 on a long OpenMP-enabled listing, I
> > > > > > noticed that the presence of the C line:
> > > > > >  #pragma omp parallel for reduction(+:I) private(I)
> > > > > > seems to prevent restructuring of the function containing it.
> > > > > > If I simplify the pragma to something like
> > > > > >  #pragma omp parallel
> > > > > > the problem disappears.
> > > > > >
> > > > > > Is there anything I can do to restructure large codes containing
> > > > > > many of such similar lines ?
> > > > > >
> > > > > > In the attachment you find a test case and the output I experience.
> > > > >
> > > > > Thanks for the report.  We can try to make the parsing of #pragmas more
> > > > > flexible.
> > > > >
> > > > > julia
> > > >
> > > > Dear Julia,
> > > >
> > > > thanks for the quick response!
> > > >
> > > > I'll be waiting for Coccinelle-sided developments then.
> > > >
> > > > May I ask what would you recommend now to circumvent this ?
> > > >
> > > > From the SmPL v1.0.6 Grammar I am not aware of any way to
> > > > e.g. ignore pragma lines as they were comments.
> > > >
> > > > So the best what comes to my mind is to:
> > > >
> > > >  - comment #pragma lines
> > > >  - compute semantic patch
> > > >  - apply   semantic patch
> > > >  - uncomment #pragma lines
> > > >
> > > > If there is any better solution, please let me know.
> > >
> > > The problem is now fixed in the github version of Coccinelle.
> > >
> > > julia
> >
> > That is good news -- thank you :-)
> >
> > Handling such pragma lines opens new ranges of use for Coccinelle!
> >
> > On my side, I just followed install.txt:
> >
> > #!/bin/bash
> > set -e
> > set -x
> > trap "read" EXIT # will block for input on error
> > git clone https://github.com/coccinelle/coccinelle.git
> > cd coccinelle
> > ./autogen
> > ./configure
> > make # it stops here
> > # make install
> >
> > and it reaches:
> >
> > ...
> > OCAMLOPT  enter.ml
> > OCAMLC    main.mli
> > OCAMLOPT  main.ml
> > OCAMLOPT  -o spatch.opt
> > /usr/lib64/ocaml/libbigarray.a(bigarray_stubs.o): In function `caml_ba_deserialize':
> > /home/abuild/rpmbuild/BUILD/ocaml-4.03.0/otherlibs/bigarray/bigarray_stubs.c:979: undefined reference to `caml_umul_overflow'
> > /home/abuild/rpmbuild/BUILD/ocaml-4.03.0/otherlibs/bigarray/bigarray_stubs.c:985: undefined reference to `caml_umul_overflow'
> > collect2: error: ld returned 1 exit status
> > File "caml_startup", line 1:
> > Error: Error during linking
> > Makefile:609: recipe for target 'spatch.opt' failed
> > make: *** [spatch.opt] Error 2
> > rm parsing_cocci/lexer_cli.ml parsing_cocci/parser_cocci_menhir.ml.d parsing_cocci/parser_cocci_menhir.mli.d parsing_cocci/lexer_script.ml parsing_cocci/lexer_cocci.ml parsing_c/lexer_c.ml
> > + read
> >
> > It's my first experience building any ocaml-based software, so
> > I would appreciate any hint how to proceed further, if possible.
> 
> Oops, I'll forward this to my engineer, who knows about building issues.
> I'm not sure if he will answer before Wednesday, due to the holiday.
> What is your OS?

 $ cat /etc/os-release 
 NAME="openSUSE Leap"
 VERSION="42.3"
 ID=opensuse
 ID_LIKE="suse"
 VERSION_ID="42.3"
 PRETTY_NAME="openSUSE Leap 42.3"
 ANSI_COLOR="0;32"
 CPE_NAME="cpe:/o:opensuse:leap:42.3"

thanks!
