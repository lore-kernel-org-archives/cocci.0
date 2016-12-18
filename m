From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 18 Dec 2016 11:04:05 +0100 (CET)
Subject: [Cocci] Replace typedef INT with int
In-Reply-To: <CAJ3s=NBYpz_61j5aGOgVU8mzto9jrDUZcROvdALtqUak3d25sQ@mail.gmail.com>
References: <CAJ3s=NAfRwWN5=F0nf+DsHSDv7dVLw9wrJaSUsL1FPs1ZexucA@mail.gmail.com>
 <alpine.DEB.2.20.1612180921360.2048@hadrien>
 <CAJ3s=NBYpz_61j5aGOgVU8mzto9jrDUZcROvdALtqUak3d25sQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1612181103460.2048@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 18 Dec 2016, Kishan Sandeep wrote:

> Thanks Julia for the reply. facing error while running with spatch.
>
> $ cat test.cocci
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
> Facing below error when run with - spatch --sp-file? test.cocci file.c
>
> init_defs_builtins: /usr/share/coccinelle/standard.h
> Fatal error: exception Failure("minus: parse error:
> ?= File "test.cocci", line 11, column 14,? charpos = 54
> ??? around = 'INT', whole content = - typedef int INT;
> ")
>
> please help me to resolve this.

Just try switching the order of the rules.

julia
