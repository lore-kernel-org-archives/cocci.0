From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Oct 2018 18:57:39 +0200 (CEST)
Subject: [Cocci] Searching for parameter usages of pte_alloc()
In-Reply-To: <20181011164934.GA213196@joelaf.mtv.corp.google.com>
References: <20181010211125.GA128537@joelaf.mtv.corp.google.com>
 <93da55ff-c807-6587-7ef3-3d2af820117d@users.sourceforge.net>
 <20181011154346.GA186033@joelaf.mtv.corp.google.com>
 <alpine.DEB.2.20.1810111746210.3392@hadrien>
 <20181011162840.GA199386@joelaf.mtv.corp.google.com>
 <alpine.DEB.2.20.1810111833410.3392@hadrien>
 <20181011164934.GA213196@joelaf.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1810111853050.3392@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 11 Oct 2018, Joel Fernandes wrote:

> On Thu, Oct 11, 2018 at 06:40:22PM +0200, Julia Lawall wrote:
> > > Sure, so if I have code like this:
> > > #define pte_alloc_one(mm, vmaddr) ((pte_t *) page_table_alloc(mm))
> > >
> > > I want to have a rule that does:
> > > - #define pte_alloc_one(mm, vmaddr) ((pte_t *) page_table_alloc(mm))
> > > + #define pte_alloc_one(mm) ((pte_t *) page_table_alloc(mm))
> > >
> > > So far everything I tried only works for functions so I was wondering how one
> > > do this with macros.
> >
> > Maybe
> >
> > @r@
> > position p;
> > identifier i,a,b;
> > @@
> >
> > #define i(a,b)@p <+...b...+>
> >
> > @@
> > position p != r.p;
> > identifier i,a,b;
> > expresssion e;
> > @@
> >
> > - #define i(a,b)@p e
> > + #define i(a) e
> >
> > The rule r finds #defines that refer to the second argument, and records
> > their position in p, while the second rule finds all other #defines with
> > two arguments.
>
> Thanks a lot, I will try these.
>
> > Of course, you would want to use a regular expression for the macro name,
> > or do something to avoid changing all two argument macros.
> >
> > Macros are often defined in header files, so you may want to use the
> > command line options --no-includes --include-headers.  --no-includes means
> > ignore header files when they are included into .c files and
> > --include-headers means treat both .c an .h files.  Otherwise, you only get
> > .c files.
>
>  I am using --include-headers. I didn't get the --no-includes use with
>  --include-headers though.
>
> What happens if I don't pass --no-includes?  Do the header files included
> from C files also get matched then? Then in that case I shouldn't need to
> pass anything (neither --include-headers nor --no-includes) and all included
> headers from C files should also be matched/parsed/patched - since every
> header should atleast be included *somewhere* otherwise its existinence is
> pointless. Could you help me understand this better? Thanks a lot!

1. Coccinelle desn't know about the make file.  So there are many header
files that it may not be able to find.

2. Many header files are irrelevant to your problem and included in many
.c files, meaning that if you rely on the .c files to get the prcessing of
the .h files, you will be processing the same code over and over.

If you use --no-includes --include-headers then every files will be
processed and it will be processed only once.

Including headers, which can be done with eg --all-includes (all files
mentioned explicitly in the .c file) or --recursive-includes (files
included by other .h files) is useful if you need type information in
processing the .c file and if the processing of the .h file relies on
information present in the .c file.  If you only need type information
then the option --include-headers-for-types is useful, as the headers will
only be taken into account during the type inference phase, and then
ignored during matching and transformation, whih provides a significant
performance benefit.

julia
