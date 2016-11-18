From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 18 Nov 2016 22:48:55 +0100 (CET)
Subject: [Cocci] Inclusion of script constraints in SmPL
In-Reply-To: <3463364f-746d-f73b-753b-7c3ead97341e@users.sourceforge.net>
References: <3c65eb92-8be0-be42-bf8e-893f3853df12@users.sourceforge.net>
 <alpine.DEB.2.20.1611152248150.2060@hadrien>
 <32639cf9-b644-0230-02a6-88d66925340e@users.sourceforge.net>
 <alpine.DEB.2.10.1611161152570.3153@hadrien>
 <6810eb15-839c-8aa5-6485-401d43ba1246@users.sourceforge.net>
 <alpine.DEB.2.10.1611161350550.3153@hadrien>
 <69c3643e-10b4-007a-f847-d0098f298e16@users.sourceforge.net>
 <alpine.DEB.2.10.1611161514250.3153@hadrien>
 <b90e8f82-aa00-0a11-1e38-53d8c4dfd9fd@users.sourceforge.net>
 <alpine.DEB.2.10.1611181842240.2963@hadrien>
 <5da250c3-e80f-8842-7e85-481cdf6a6259@users.sourceforge.net>
 <alpine.DEB.2.10.1611181901530.2963@hadrien>
 <24f0d5ad-aae9-70fc-cf66-bd62b001e463@users.sourceforge.net>
 <alpine.DEB.2.20.1611182105460.2139@hadrien>
 <3463364f-746d-f73b-753b-7c3ead97341e@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1611182246430.2139@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 18 Nov 2016, SF Markus Elfring wrote:

> >> https://github.com/coccinelle/coccinelle/blob/cbc751b30d9e02390d60ebed643c8e4a3fa0bb2b/tests/idcon_python.cocci#L1
> >
> > The syntax is curly brackets around a C expression.
>
> I do not understand this information completely at the moment.
>
>
> >>> Concretely, the script constraint code is initially parsed using a C parser,
> >>
> >> I find such an information interesting to some degree.
> >>
> >> Why do you pass data to a software component for ?C? at this place?
> >
> > Seemed convenient.
>
> I can not follow your views for software convenience with this detail so far.
>
>
> > Perhaps it could be possible to parse to a closing },
>
> I have got another idea in the meantime.
>
> I propose to distinguish these delimiters better for different use cases.
>
>
> > but your goal seems to be to put more complex terms in the script code
> > that might then include }, making things more complicated.
>
> I hope that it will be possible to pass growing programming scripts there.
>
>
> >> Have you got more control about the construction of a single function call?
> >
> > No.
>
> I find this answer strange.
>
>
> How do you think about to support cases like named and unnamed (ad hoc)
> predicates there?
>
> Examples:
>
>
> @ad_hoc_replacement@
> identifier ID: script:python() { return ID in ['a', 'c'] };
> @@
> -ID
> +36
>
>
> @initialize:python@
> @@
> def is_watched(id):
>     return id in ['a', 'c']
>
> @structured_replacement@
> identifier ID: script:python() ? is_watched;
> @@
> -ID
> +18

No interest in supporting either.  How are these so vastly better than:

@initialize:python@
@@
def is_watched(id):
    return id in ['a', 'c']

@structured_replacement@
identifier ID: script:python() { is_watched(ID) };
@@
-ID
+18

julia
