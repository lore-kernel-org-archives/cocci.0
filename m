From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 24 May 2016 22:23:30 +0200 (CEST)
Subject: [Cocci] Improvements for building the Coccinelle software
In-Reply-To: <20160524200828.GA7425@suse.de>
References: <alpine.DEB.2.02.1605232230510.2052@localhost6.localdomain6>
 <CAB=NE6UA7+tMax4nGoznvGNwuD0VabuOP71zMzs8rmQS_9Ls9Q@mail.gmail.com>
 <alpine.DEB.2.02.1605232246310.2052@localhost6.localdomain6>
 <20160523211952.GY11948@wotan.suse.de>
 <alpine.DEB.2.02.1605232334130.2052@localhost6.localdomain6>
 <CAB=NE6Xt1iy2FtOq6DCvDnidh-r9Y+9KC1AFB=PccHVg4YXB1g@mail.gmail.com>
 <alpine.DEB.2.02.1605232343420.2052@localhost6.localdomain6>
 <20160523214931.GA11948@wotan.suse.de>
 <541922c4-84ae-cc7c-4baf-dbd7ace43961@suse.de>
 <1361a24e-9dc5-db4f-d347-370db8d126dc@users.sourceforge.net>
 <20160524200828.GA7425@suse.de>
Message-ID: <alpine.DEB.2.10.1605242221190.4826@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 24 May 2016, Olaf Hering wrote:

> On Tue, May 24, SF Markus Elfring wrote:
>
> >
> > > There is now a pullrq to fix a bug in configure.ac,
> >
> > I am curious when the script "setup/cocci.m4" will be updated.
> > https://github.com/coccinelle/coccinelle/pull/70
>
> When a new release is cut the release manager runs autogen.sh. In an
> ideal world everyone runs autogen.sh because keeping
> automake/autoconf/.. uptodate is cheap. The world failed to do that.
> Thats why each and every pkg includes a configure script. Some store
> them even in the SCM.

Sorry, but I'm not sure to understand what you are suggesting here (or
if you are suggesting something).  In any case, the releases of Coccinelle
should contain a configure script, to my recollection.  The github
version does not.

thanks,
julia

> > Would you like to improve the involved build scripts any more?
> > https://github.com/coccinelle/coccinelle/issues/42
>
> What improvements do you have in mind?
>
> > > and also a new pkg named ocaml-parmap to replace the built-in copy.
> >
> > How much do you care for software bundling?
>
> If certain software has dependencies its not the task of that software
> to provide them. So, drop the bundled stuff.
>
> Olaf
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
