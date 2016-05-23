From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 23 May 2016 23:44:10 +0200 (CEST)
Subject: [Cocci] github update
In-Reply-To: <CAB=NE6Xt1iy2FtOq6DCvDnidh-r9Y+9KC1AFB=PccHVg4YXB1g@mail.gmail.com>
References: <alpine.DEB.2.02.1605222116490.2250@localhost6.localdomain6>
 <20160523163721.GT11948@wotan.suse.de>
 <alpine.DEB.2.02.1605232230510.2052@localhost6.localdomain6>
 <CAB=NE6UA7+tMax4nGoznvGNwuD0VabuOP71zMzs8rmQS_9Ls9Q@mail.gmail.com>
 <alpine.DEB.2.02.1605232246310.2052@localhost6.localdomain6>
 <20160523211952.GY11948@wotan.suse.de>
 <alpine.DEB.2.02.1605232334130.2052@localhost6.localdomain6>
 <CAB=NE6Xt1iy2FtOq6DCvDnidh-r9Y+9KC1AFB=PccHVg4YXB1g@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1605232343420.2052@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 23 May 2016, Luis R. Rodriguez wrote:

> On Mon, May 23, 2016 at 2:37 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> >
> > On Mon, 23 May 2016, Luis R. Rodriguez wrote:
> >
> >> On Mon, May 23, 2016 at 10:49:43PM +0200, Julia Lawall wrote:
> >> >
> >> >
> >> > On Mon, 23 May 2016, Luis R. Rodriguez wrote:
> >> >
> >> > > On Mon, May 23, 2016 at 1:31 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >> > > > Could you see if OpenSuse has libpcre-ocaml-dev, and if so install it?
> >> > >
> >> > > It doesn't, and nothing quite like it either.
> >> >
> >> > Oops :(
> >> >
> >> > I found this:
> >> >
> >> > http://rpm.pbone.net/index.php3/stat/4/idpl/33152402/dir/opensuse/com/ocaml-pcre-7.1.6-2.d_l_ocaml.3.x86_64.rpm.html
> >>
> >> Thanks, that doesn't work on the latest opensuse, I modified the spec
> >> file from the SRPM [0] to use the latest release, which seems to be 7.2.3 [1]
> >> and installed ocaml-rpm-macros and ocaml-findlib-devel to be able to build
> >> it but it seems that requires an 'ocaml-oasis' [2], downloaded that, tried
> >> to configure and that seems to require ocamlmod, ocamlify, and some 'odn'
> >> thing... I give up. Are all these new dependencies really needed ?
> >
> > Ideally you can configure Coccinelle not to use pcre.  You could try
> > --disable-pcre.  But at one point, that flag was not working, and I
> > checked with Sebastien who said that he didn't get a chace to fix it, so
> > I'm not optimistic.  But maybe it is at least worth trying.
> >
> > Also, I'm not sure that what I found is going to help, because I see that
> > the configure contains:
> >
> > pcre library:     $HAVE_PCRE    (requires the dev version of libpcre)
> >
> > And the one I suggested is not the dev version.
> 
> Thanks, I tried  --disable-pcre on both github repo and the gforge
> tree and compilation still fails on the pcre error as noted earlier.
> I'll have to live with testing only the latest coccinelle on debian.
> That works great.

OK, thanks.  It looks like the relese notes for Coccinelle will have to 
discourage the use of 4.03...

julia
