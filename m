From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 15 Mar 2013 23:16:31 +0100 (CET)
Subject: [Cocci] "virtual rule patch not supported"
In-Reply-To: <CAAxaTiPSJzj=hPtsXfPjpmMw3RDqNyLJO=XjfBHUmPA6QUrgRA@mail.gmail.com>
References: <513D94DC.9090708@inria.fr>
 <alpine.DEB.2.02.1303130946150.1933@hadrien>
 <CAAxaTiOFoDmDm+38XhALBp0ZtMNbpg7D8td-K7H2A30PRGkgRA@mail.gmail.com>
 <51433832.1010906@inria.fr>
 <CAAxaTiPqLReMT5=8YZCmWWG4oQC0ARreo48qDwT1qCedXxBMsA@mail.gmail.com>
 <CAAxaTiPSJzj=hPtsXfPjpmMw3RDqNyLJO=XjfBHUmPA6QUrgRA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1303152315560.2013@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 15 Mar 2013, Nicolas Palix wrote:

> Alternatively, you could use 'make coccicheck MODE=report' as every
> cocci file currently provide at least this mode
> or we could swap patch and report for the chain mode.

If you do that, it should be the same as report, because every semantic
patch should provide report...

julia

>  linux $  find scripts/coccinelle -name *.cocci | wc -l
>       42
> npalix at lig-yttrium linux $ find scripts/coccinelle -name *.cocci -exec
> grep -H 'virtual context' \{} \; | wc -l
>       36
> npalix at lig-yttrium linux $ find scripts/coccinelle -name *.cocci -exec
> grep -H 'virtual report' \{} \; | wc -l
>       42
> npalix at lig-yttrium linux $ find scripts/coccinelle -name *.cocci -exec
> grep -H 'virtual org' \{} \; | wc -l
>       40
> npalix at lig-yttrium linux $ find scripts/coccinelle -name *.cocci -exec
> grep -H 'virtual patch' \{} \; | wc -l
>       24
>
> On Fri, Mar 15, 2013 at 4:11 PM, Nicolas Palix <nicolas.palix@imag.fr> wrote:
> > On Fri, Mar 15, 2013 at 4:03 PM, Brice Goglin <Brice.Goglin@inria.fr> wrote:
> >> Le 15/03/2013 15:49, Nicolas Palix a ?crit :
> >>> Hi,
> >>>
> >>> On Wed, Mar 13, 2013 at 9:47 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >>>> On Mon, 11 Mar 2013, Brice Goglin wrote:
> >>>>
> >>>>> Hello,
> >>>>> I am running the kernel 3.9-rc2 coccicheck script on some of my module,
> >>>>> and I get the following message:
> >>>>>   virtual rule patch not supported
> >>>> I guess it doesn't crash?  It is possible that some semantic patch just
> >>>> doesn't support the patch option.  I don't remember if it is possible to
> >>>> specify several options, and to have them tried in order?  That could be a
> >>>> nice feature.  If not, I think that there is an option that tries all of
> >>>> the options in a fixed order.  Nicolas?
> >>>>
> >>> According to the cocci files, every coccicheck mode could not be proposed.
> >>> It is indeed some time impossible to propose a bug correction because
> >>> several options are available for a single bug report and the semantic
> >>> patch is not designed to choose one.
> >>>
> >>> The current basic modes are: patch, report, context, org
> >>> The 'chain' mode tries the following mode is order: patch || report ||
> >>> context || org.
> >>> Recently, the 'rep+ctxt' mode have been added for report and context modes.
> >>>
> >>> If you haven't specify the mode, it defaults to chain. The patch mode
> >>> is thus tried first.
> >>> If it fails, coccicheck falls back to the report mode.
> >>>
> >>
> >> In short, this warning is harmless ?
> >
> > Indeed. But you will have various kind of output.
> >
> >>
> >> Should it be disabled in the kernel by default ? Most people that uses
> >> coccicheck in the kernel don't know much about it, and they don't write
> >> the rules directly, so they may be afraid by the warning just like me.
> >
> > One may improve the handling of the chain mode, and skip unavailable
> > modes instead of falling back to the next one in case of error...
> >
> > Do you volunteer ?
> >
> > By the way, thank you for the report.
> >
> >>
> >> Brice
> >>
> >
> >
> >
> > --
> > Nicolas Palix
>
>
>
> --
> Nicolas Palix
>
