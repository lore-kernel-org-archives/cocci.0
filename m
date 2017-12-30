From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 30 Dec 2017 18:49:54 +0100 (CET)
Subject: [Cocci] coccicheck failed on Ubuntu 16.04
In-Reply-To: <CAOMZO5BpqrvDCEm8Z_bP+aO9Re2XJC+xjXpjrW1VARhPAHHoNw@mail.gmail.com>
References: <CAOMZO5BpqrvDCEm8Z_bP+aO9Re2XJC+xjXpjrW1VARhPAHHoNw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1712301848150.9726@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 30 Dec 2017, Fabio Estevam wrote:

> Hi,
>
> I have installed coccinelle from github:
>
> $ spatch --version
> spatch version 1.0.6-00382-g2964968 compiled with OCaml version 4.02.3
> Flags passed to the configure script: [none]
> OCaml scripting support: yes
> Python scripting support: yes
> Syntax of regular expresssions: PCRE
>
> My Linux PC runs Ubuntu 16.04 and I get the following error when
> trying to run 'make coccicheck':
>
> $ make coccicheck MODE=report M=drivers/net/wireless/
>
> Please check for false positives in the output before submitting a patch.
> When using "patch" mode, carefully review the patch before submitting it.
>
> coccicheck failed
>
> Any ideas on how to fix this coccicheck failure?

Thanks for the report.  Could you try with V=1 and DEBUG_FILE=file.txt?
Then it should be possible to find out more about what it is complaining
about.

Note that these options are mentioned in "Debugging Coccinelle SmPL
patches" in Documentation/dev-tools/coccinelle.rst.  Otherwise, they are
not so easy to remember...

julia

>
> Thanks,
>
> Fabio Estevam
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
