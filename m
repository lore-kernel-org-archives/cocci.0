From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 18 May 2016 10:43:58 +0200 (CEST)
Subject: [Cocci] Build configuration challenges around "Menhir"
In-Reply-To: <a3fa0af3-b679-124d-09c3-60385e6ad34f@users.sourceforge.net>
References: <CAB=NE6X4mqH+Vj41bba4e7y7vYKqhpsC5dqHUZLrmDKtA1XVwA@mail.gmail.com>
 <alpine.DEB.2.02.1605172250560.2064@localhost6.localdomain6>
 <CAB=NE6V=aqW8VC4OML6vc+hJHkbcfH3dBzo==3uVRAuZK8Mv6A@mail.gmail.com>
 <alpine.DEB.2.02.1605180711280.2031@localhost6.localdomain6>
 <a3fa0af3-b679-124d-09c3-60385e6ad34f@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1605181043320.2887@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 18 May 2016, SF Markus Elfring wrote:

> >> error: the file parser_cocci_menhir.ml is needed, which requires
> >> preprocessing by menhir to obtain it from parser_cocci_menhir.mly.
> >> However, menhir is not enabled.
> >
> > Indeed, it is not there.  I guess it was decided that people who use
> > github should have the capability to generate everything from scratch.
> > But I don't really know...  Will check.
>
> Are there a few build challenges left over for proper configuration checks
> around the bundling (or other source) of this software library?

Please find them and report on them rather than making vague questions.

julia

>
> https://github.com/coccinelle/coccinelle/blob/cd539cd12ad0674d5a8f4c33f6c21ae00aec8e57/configure.ac#L152
> https://github.com/coccinelle/coccinelle/blob/db45d7549bdde52f95bf2885ef652a42862854bb/setup/fake-menhir.sh#L5
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
