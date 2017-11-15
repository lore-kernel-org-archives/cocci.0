From: thierry.martinez@inria.fr (Thierry Martinez)
Date: Wed, 15 Nov 2017 15:56:46 +0100 (CET)
Subject: [Cocci] Coccinelle: badzero.cocci failure
In-Reply-To: <CAK7LNAR=Un8B4e9-H7hOA+u=PH985xc1NBHRXoXQrSCs5hK7dQ@mail.gmail.com>
References: <CAK7LNATW91vf5Sa-vvJ7rLRNt+KRKPB=E5H_EOtOUgCB4WYmUA@mail.gmail.com>
 <alpine.DEB.2.20.1711141003410.2874@hadrien>
 <CAK7LNATw25OPNe_oqQNCmF=Uaw1Enjx9YRRBEHsZcAgupgHc8w@mail.gmail.com>
 <alpine.DEB.2.20.1711150721060.2147@hadrien>
 <CAK7LNAR=Un8B4e9-H7hOA+u=PH985xc1NBHRXoXQrSCs5hK7dQ@mail.gmail.com>
Message-ID: <276207557.16617848.1510757806971.JavaMail.zimbra@inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi, Masahiro.

Masahiro:
> Fatal error: exception
> Yes_prepare_ocamlcocci.LinkFailure("/tmp/ocaml_cocci_fdd282.cmxs")

If you can rerun your test with coccinelle GitHub master, the
LinkFailure exception will now be more verbose, in order to understand
the problem.

I suspect a mismatch between the version of OCaml you use to compile
coccinelle, and the version of OCaml that coccinelle uses to compile
OCaml scripts in rules.

Thank you for helping us investigating this.
Best regards.
-- 
Thierry Martinez.

----- Original Message -----
> From: "Masahiro Yamada" <yamada.masahiro@socionext.com>
> To: "Julia Lawall" <julia.lawall@lip6.fr>
> Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, "Linux Kbuild mailing list"
> <linux-kbuild@vger.kernel.org>, "Nicolas Palix" <nicolas.palix@imag.fr>, cocci at systeme.lip6.fr
> Sent: Wednesday, November 15, 2017 9:23:11 AM
> Subject: Re: [Cocci] Coccinelle: badzero.cocci failure
> 
> Hi Julia,
> 
> 
> 2017-11-15 15:22 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
> >
> >
> > On Tue, 14 Nov 2017, Masahiro Yamada wrote:
> >
> >> Hi Julia,
> >>
> >>
> >> 2017-11-14 18:07 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
> >> >> coccicheck failed
> >> >> $ cat cocci-debug.txt
> >> >> /home/masahiro/bin/spatch -D report --no-show-diff --very-quiet
> >> >> --cocci-file scripts/coccinelle/null/badzero.cocci --dir . -I
> >> >> ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I
> >> >> ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I
> >> >> ./include/uapi -I ./include/generated/uapi --include
> >> >> ./include/linux/kconfig.h --jobs 8 --chunksize 1
> >> >> Fatal error: exception
> >> >> Yes_prepare_ocamlcocci.LinkFailure("/tmp/ocaml_cocci_18c9f9.cmxs")
> >> >
> >> > Does your Coccinelle support OCaml?  I'm not sure what is the proper way
> >> > to
> >> > check for this, but in my coccinelle/config.log file I have
> >> >
> >> > FEATURE_OCAML='1'
> >>
> >>
> >> Yes.  I also see this line in my config.log
> >>
> >>
> >> > spatch --version gives:
> >> >
> >> > spatch version 1.0.6-00147-g19f9421 compiled with OCaml version 4.02.3
> >> > Flags passed to the configure script: [none]
> >> > Python scripting support: yes
> >> > Syntax of regular expresssions: Str
> >>
> >> My version output looks like follows:
> >>
> >> $ spatch --version
> >> spatch version 1.0.6-00345-g2ca0bef compiled with OCaml version 4.02.3
> >> Flags passed to the configure script: --prefix=/home/masahiro
> >> Python scripting support: yes
> >> Syntax of regular expresssions: PCRE
> >>
> >>
> >> > I'm not sure why it doesn't give feedback on whether OCaml scripting is
> >> > supported.  I will check on this.
> >
> > Can you try the following semantic patch (called eg nothing.cocci):
> >
> > @script:ocaml@
> > @@
> >
> > ()
> >
> > on any .c file, ie
> >
> > spatch --sp-file nothing.cocci test.c
> >
> 
> 
> Thanks for the simple test semantic patch!
> 
> 
> 
> I noticed  1.0.4 is OK,
> but 1.0.5 is NG
> 
> I guess this is a problem on Coccinelle side.
> 
> 
> I git-bisect:ed and the first bad commit bad was:
> 
> 
> commit cd539cd12ad0674d5a8f4c33f6c21ae00aec8e57
> Author: S?bastien Hinderer <Sebastien.Hinderer@inria.fr>
> Date:   Tue Mar 15 12:06:00 2016 +0100
> 
>     Get rid of the --enable-release configure option.
> 
> 
> 
> 
> $ spatch --version
> spatch byte-code version 1.0.4-00212-g8238ba5 compiled with OCaml version
> 4.02.3
> Flags passed to the configure script: --prefix=/home/masahiro
> Python scripting support: yes
> Syntax of regular expresssions: PCRE
> $ spatch  --sp-file nothing.cocci kernel/kmod.c
> init_defs_builtins: /home/masahiro/lib/coccinelle/standard.h
> Using native version of ocamlc/ocamlopt/ocamldep
> ocamlc.opt -c /tmp/ocaml_cocci_23600a.cmo -g -I /usr/lib/ocaml  -I
> /home/masahiro/lib/coccinelle/ocaml /tmp/ocaml_cocci_23600a.ml
> Compilation OK!
> Loading ML code of the SP...
> HANDLING: kernel/kmod.c
> $ spatch --version
> spatch native version 1.0.4-00213-gcd539cd compiled with OCaml version 4.02.3
> Flags passed to the configure script: --prefix=/home/masahiro
> Python scripting support: yes
> Syntax of regular expresssions: PCRE
> $ spatch  --sp-file nothing.cocci kernel/kmod.c
> init_defs_builtins: /home/masahiro/lib/coccinelle/standard.h
> Using native version of ocamlc/ocamlopt/ocamldep
> ocamlopt.opt -shared -o /tmp/ocaml_cocci_fdd282.cmxs -g -I
> /usr/lib/ocaml  -I /home/masahiro/lib/coccinelle/ocaml
> /tmp/ocaml_cocci_fdd282.ml
> Compilation OK!
> Loading ML code of the SP...
> implementation mismatch on Iteration
> Fatal error: exception
> Yes_prepare_ocamlcocci.LinkFailure("/tmp/ocaml_cocci_fdd282.cmxs")
> 
> 
> --
> Best Regards
> Masahiro Yamada
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
