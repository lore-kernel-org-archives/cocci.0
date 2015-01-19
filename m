From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 19 Jan 2015 16:08:49 +0000 (GMT)
Subject: [Cocci] Possible to install on OSX?
In-Reply-To: <DA6D9998-6B28-4982-BC25-04787C96111B@gmail.com>
References: <0F92B6B9-47F3-4A44-8D5A-ED04BC698EF0@gmail.com>
 <alpine.DEB.2.10.1501172308080.2777@hadrien>
 <A2929B64-B34C-4910-8486-16F7E2D2573C@gmail.com>
 <20150119092140.GE1907@pl-59055.rocqadm.inria.fr>
 <71E56961-AF04-469A-8B8D-A3F9BB77C261@gmail.com>
 <20150119155110.GA24065@pl-59055.rocqadm.inria.fr>
 <DA6D9998-6B28-4982-BC25-04787C96111B@gmail.com>
Message-ID: <alpine.DEB.2.10.1501191608220.3408@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 19 Jan 2015, Eliseo Mart?nez wrote:

> I have some good news, finally.
> I can build and install if I omit the menhir part.
> I mean, starting from a clean checkout, and after applying your patch, if I just do ./configure and make, instead of make distclean, ./configure and make, then it works.
>
> Which mainly solves my problem for now. I would like to be able to solve
> the menhir issue too, but that can wait. I need to study a bit what you
> said, and to get acquainted with OPAM before investigating further on
> that.

The intention is that you should not have to install menhir at all.

julia

> Just one more thing, then. I?m not sure if plain ./configure, as I?ve used, is enough to be able to use python with smpl patches.
> Do I need ./configure ?-enable-python for that? If I do that, I get config errors (log attached).
>
> Thanks
>
> > On 19 Jan 2015, at 16:51, S?bastien Hinderer <Sebastien.Hinderer@inria.fr> wrote:
> >
> > Dear Eliseo,
> >
> > There now seems to be a conflict between your installed menhir and a
> > library which is bundled with coccinelle.
> >
> > Since you have installed menhir, it should have installed menhirLib,
> > too, but apparently for some reason the installed one is not detected,
> > see these lines in the conig.log you have sent earlier:
> >
> > configure:12694: configuring package menhirLib
> > configure:12704: checking for OCaml findlib package menhirLib
> > configure:12720: result: not found
> > configure:12745: OCaml package menhirLib is not available
> > configure:12757: checking for a bundled substitute of menhirLib
> > ... and the bundled substitute is found but too old compared to your
> > installed menhir. So one possibility would be to figure out whether you
> > can find an older version of menhir that you caninstall rather than
> > using this one which is too recent.
> >
> > Another approach,if you are a bit familiar with ocaml findli or have
> > timeto investigate, is to try to register the installed version of
> > menhirLib with ocaml-findlib so that configure detects it.
> >
> > One other approach is to install the opam OCaml package manager and then
> > to install all the packages through it, because this is more likely to
> > work and rather easy and straightforward, let me know if you wouldlike
> > to do like this, I'll send you the necessary steps.
> >
> > S?bastien.
> > _______________________________________________
> > Cocci mailing list
> > Cocci at systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
>
