From: sandeepkishan108@gmail.com (Kishan Sandeep)
Date: Sun, 18 Dec 2016 15:13:19 +0530
Subject: [Cocci] Replace typedef INT with int
In-Reply-To: <alpine.DEB.2.20.1612180921360.2048@hadrien>
References: <CAJ3s=NAfRwWN5=F0nf+DsHSDv7dVLw9wrJaSUsL1FPs1ZexucA@mail.gmail.com>
 <alpine.DEB.2.20.1612180921360.2048@hadrien>
Message-ID: <CAJ3s=NBYpz_61j5aGOgVU8mzto9jrDUZcROvdALtqUak3d25sQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Thanks Julia for the reply. facing error while running with spatch.

$ *cat test.cocci*
@@
typedef INT;
@@

- INT
+ int

@@
@@

- typedef int INT;

Facing below error when run with - *spatch --sp-file  test.cocci file.c*

init_defs_builtins: /usr/share/coccinelle/standard.h
Fatal error: exception Failure("minus: parse error:
 = File "test.cocci", line 11, column 14,  charpos = 54
    around = 'INT', whole content = - typedef int INT;
")

please help me to resolve this.

Thanks!

On Sun, Dec 18, 2016 at 1:52 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:

>
>
> On Sun, 18 Dec 2016, Kishan Sandeep wrote:
>
> > Hi,
> >
> >
> > Please help me to write cocci script here -
> >
> > I have below typedef -
> >
> > typedef int INT;
> >
> > INT is used so-many files in the code. Now i want to remove this typedef
> and
> > want to replace with int.
>
> @@
> typedef INT;
> @@
>
> - INT
> + int
>
> @@
> @@
>
> - typedef int INT;
>
> julia
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20161218/3c391929/attachment.html>
