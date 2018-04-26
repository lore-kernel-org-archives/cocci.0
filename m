From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 26 Apr 2018 11:22:46 +0100 (WEST)
Subject: [Cocci] [cocci-bug] coccinelle 1.0.6: OpenMP #pragma directive
 leads to function ignore
In-Reply-To: <20180426102122.GB7703@localhost>
References: <20180426081209.GA7703@localhost>
 <alpine.DEB.2.20.1804260925270.2402@hadrien>
 <20180426102122.GB7703@localhost>
Message-ID: <alpine.DEB.2.20.1804261121540.7389@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 26 Apr 2018, Michele Martone wrote:

> On 20180426 at 09:25, Julia Lawall wrote:
> > On Thu, 26 Apr 2018, Michele Martone wrote:
> >
> > > Dear Prof. Lawall and Coccinelle team,
> > >
> > > I'm an enthusiastical, however still beginner use of Coccinelle.
> > >
> > > While running spatch 1.0.6 on a long OpenMP-enabled listing, I
> > > noticed that the presence of the C line:
> > >  #pragma omp parallel for reduction(+:I) private(I)
> > > seems to prevent restructuring of the function containing it.
> > > If I simplify the pragma to something like
> > >  #pragma omp parallel
> > > the problem disappears.
> > >
> > > Is there anything I can do to restructure large codes containing
> > > many of such similar lines ?
> > >
> > > In the attachment you find a test case and the output I experience.
> >
> > Thanks for the report.  We can try to make the parsing of #pragmas more
> > flexible.
> >
> > julia
>
> Dear Julia,
>
> thanks for the quick response!
>
> I'll be waiting for Coccinelle-sided developments then.
>
> May I ask what would you recommend now to circumvent this ?
>
> From the SmPL v1.0.6 Grammar I am not aware of any way to
> e.g. ignore pragma lines as they were comments.
>
> So the best what comes to my mind is to:
>
>  - comment #pragma lines
>  - compute semantic patch
>  - apply   semantic patch
>  - uncomment #pragma lines
>
> If there is any better solution, please let me know.

I don't see any other solution, sorry.  For some other parsing issues, it
might be possible to define a macro, but that is not possible here.

julia
