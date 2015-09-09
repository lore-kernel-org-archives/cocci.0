From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 9 Sep 2015 22:51:04 +0200
Subject: [Cocci] Spatch fail on v1.0.2
In-Reply-To: <CAB3z_Rqaiz1f9TLbpwjU0kZ2yJKKAK-CBdkD8oOQAcLWyA0FRw@mail.gmail.com>
References: <CAB3z_Rqaiz1f9TLbpwjU0kZ2yJKKAK-CBdkD8oOQAcLWyA0FRw@mail.gmail.com>
Message-ID: <55F09BB8.3010701@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Spatch available at: https://gist.github.com/kbingham/96477177dd20a72b1c2f
> 
> Run it on a linux kernel tree:
> 
> with spatch v.1.0.2 I get the following:
> 
> kbingham at CookieMonster:/opt/projects/linaro/hikey/kernel$ spatch
> --linux-spacing --sp-file patches/i2c-dt.cocci . --in-place
> init_defs_builtins: /home/kbingham/.opam/system/lib/coccinelle/standard.h
> 1115 1116
> Fatal error: exception Failure("plus: parse error:
>  = File "patches/i2c-dt.cocci", line 66, column 1,  charpos = 1115
>     around = ')', whole content =       )
> ")
> kbingham at CookieMonster:/opt/projects/linaro/hikey/kernel$ spatch --version
> spatch version 1.0.2 with Python support and with PCRE support
> 
> 
> However, re-installing v.1.0.0 executes fine:
> 
> kbingham at CookieMonster:/opt/projects/linaro/hikey/kernel$ spatch --version
> spatch version 1.0.0-rc22 with Python support and with PCRE support

You show another interesting version comparison.

I suggest to be a bit more careful when you try this tool out installed
in a few directories in parallel.
I would expect that the command calls should reference a directory explicitly
so that potential misunderstanding can be avoided.

Do you eventually use separate test systems for the development
of semantic patch scripts?

Regards,
Markus
