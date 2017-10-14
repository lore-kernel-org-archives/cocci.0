From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 14 Oct 2017 17:53:10 +0200 (CEST)
Subject: [Cocci] make install broken
In-Reply-To: <d9d6a9c2-11b7-f9b2-4676-2b1a7ac40ac6@users.sourceforge.net>
References: <1791440820.5185535.1507765384109.JavaMail.zimbra@inria.fr>
 <85d845b3-148f-4169-c2af-ce904655e6dd@users.sourceforge.net>
 <3ac6bcd7-b8b9-b873-562f-2781d75870af@mykolab.com>
 <4e0328da-c280-335c-886f-0e3caa36914a@users.sourceforge.net>
 <0e4c97b2-bf8b-0014-e4bd-f2824776a565@mykolab.com>
 <30918ea5-3904-14c3-233d-15a071a80f02@users.sourceforge.net>
 <3efb0049-be4f-759f-82f1-fd9579d8bd16@mykolab.com>
 <d9d6a9c2-11b7-f9b2-4676-2b1a7ac40ac6@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1710141751200.2034@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 14 Oct 2017, SF Markus Elfring wrote:

> >> Which information are you missing from my software surprises?
> > You just showed the error that looks similar to mine.
>
> I have tried another rebuild of the current software out.
>
>
> > You miss the part about how you configured and installed it.
>
> Would you like to take another look at affected implementation details?
>
>
> > And what exact commit you've used.
>
> elfring at Sonne:~/Projekte/Coccinelle/20160205> make distclean && git checkout master && git pull && ./autogen && ./configure && echo "$(./version.sh)" && grep VERSION=1 Makefile.config
> ?
> 1.0.6-00335-g6e5973d4
> VERSION=1.0.6-00335-g6e5973d4
> elfring at Sonne:~/Projekte/Coccinelle/20160205> make world
> ?
>
>
> Sonne:~ # cd /home/elfring/Projekte/Coccinelle/20160205 && make install
> ?
> /usr/bin/install -c -m 755 spatch.opt /usr/local/bin/spatch
> /usr/bin/install -c -m 644 standard.h /usr/local/lib64/coccinelle
> /usr/bin/install -c -m 644 standard.iso /usr/local/lib64/coccinelle
> ?
> /usr/bin/install -c -m 644 python/coccilib/*.py \
>         /usr/local/lib64/coccinelle/python/coccilib
> ?
>
>
> elfring at Sonne:~> /usr/local/bin/spatch --version
> spatch version 1.0.6-00335-g6e5973d4 compiled with OCaml version 4.05.0
> ?
>
>
> elfring at Sonne:~/Projekte/Linux/next-patched> /usr/local/bin/spatch ~/Projekte/Coccinelle/janitor/use_seq_putc_or_seq_puts-20161027-a.cocci drivers/staging/irda/net/irlmp.c
> warning: Can't find macro file: /usr/local/bin/../lib/coccinelle/standard.h
> warning: Can't find default iso file: /usr/local/bin/../lib/coccinelle/standard.iso
> Python error: No module named coccilib.elems
>
>
> * How should the directory ?lib64? be determined for this use case?
>
> * Do I need to add any symbolic links temporarily?
>
> * Will it help to add an installation test to the software build system?

I think you have left out the most important information, which is your
OS.  I think it is OpenSuse, and I think we have gone through all of these
problems before.

julia
