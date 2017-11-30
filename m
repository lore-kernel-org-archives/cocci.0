From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 30 Nov 2017 07:19:14 +0100 (CET)
Subject: [Cocci] Having rules span multiple files
In-Reply-To: <20171129215121.GX729@wotan.suse.de>
References: <20171129205814.GV729@wotan.suse.de>
 <alpine.DEB.2.20.1711292224510.2074@hadrien>
 <20171129215121.GX729@wotan.suse.de>
Message-ID: <alpine.DEB.2.20.1711300716120.2079@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 29 Nov 2017, Luis R. Rodriguez wrote:

> On Wed, Nov 29, 2017 at 10:28:43PM +0100, Julia Lawall wrote:
> > Anohter option is to create a file with lists of file names that should be
> > considered together.  So you could have:
> >
> > a/foo.c
> > a/xyz.c
> >
> > b/bar.c
> > b/mno.c
> > b/zzz.c
> >
> > Then use --file-groups with the name of this file.
>
> Ah, now we just need something which given a directory or config option
> infers the number of associated files to that config option. :)

Yes, but I have decided that that is not my problem :)

There is actually some effort in that direction in Coccinelle.  There is
and option --kbuild-info a file called kbuild.ml and a function called
parse_kbuild_info. I don't know if it is just redundant with respect to
--file-groups, or if it actually takes configuration files or make files
and tries to do something with them.  Maybe a project for an intern
someday.

julia
