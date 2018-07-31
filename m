From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 31 Jul 2018 21:21:04 +0200 (CEST)
Subject: [Cocci] Compacting parameters into fewer lines
In-Reply-To: <CAOZdJXUFFTEQbrKMYzC_+Zf=TgzTOQZdD9NLqBRq7Pymjph9fg@mail.gmail.com>
References: <CAOZdJXUXp5gmU7_nBftF=5BrSF0u6tygH71uP2knBMJTjfdgkQ@mail.gmail.com>
 <alpine.DEB.2.20.1807311630350.7379@hadrien>
 <CAOZdJXUFFTEQbrKMYzC_+Zf=TgzTOQZdD9NLqBRq7Pymjph9fg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807312120160.2306@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 31 Jul 2018, Timur Tabi wrote:

> On Tue, Jul 31, 2018 at 9:33 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> >> Coccinelle does a pretty good job at compating parameters into fewer
> >> lines, but it's not always aggressive enough.  Is there a tuning
> >> parameter I can try?
> >
> >     "--max-width", Arg.Set_int Flag_parsing_c.max_width,
> >     "  column limit for generated code";
>
> $ spatch --sp-file ~/sw/dev/gpu_drv/chips_a/nv_printf.cocci
> --max-width 80 --dir . > /tmp/n.patch
> /usr/lib/coccinelle/spatch: unknown option '--max-width'.
>
> $ spatch --version
> spatch version 1.0.4 with Python support and with PCRE support
>
> >> -        DBG_PRINTF((DBG_MODULE_OS, DEBUGLEVEL_TRACEINFO,
> >> -                    "NVGVI: %s(), Null state\n",
> >> -                    __FUNCTION__));
> >> +        NV_PRINTF(LEVEL_INFO, "%s(), Null state\n",
> >> +                  __FUNCTION__);
> >
> > In this case, I think it is just leaving __FUNCTION__ where it is.
>
> So what decides when it moves a parameter and when it doesn't?
>
> > Please always send a semantic patch and a .c file if you have a concern
> > about something, even if you have sent them before.  Then I can treat the
> > problems one by one, and don't have to search around in my mailbox for the
> > relevant information.
>
> Attached.

Actually, you only sent the .cocci file.  I need a .c file too.  The
pretty printing may be quite sensitive to the specific layout of the code.

julia
