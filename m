From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 14 Nov 2017 10:07:28 +0100 (CET)
Subject: [Cocci] Coccinelle: badzero.cocci failure
In-Reply-To: <CAK7LNATW91vf5Sa-vvJ7rLRNt+KRKPB=E5H_EOtOUgCB4WYmUA@mail.gmail.com>
References: <CAK7LNATW91vf5Sa-vvJ7rLRNt+KRKPB=E5H_EOtOUgCB4WYmUA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1711141003410.2874@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> coccicheck failed
> $ cat cocci-debug.txt
> /home/masahiro/bin/spatch -D report --no-show-diff --very-quiet
> --cocci-file scripts/coccinelle/null/badzero.cocci --dir . -I
> ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I
> ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I
> ./include/uapi -I ./include/generated/uapi --include
> ./include/linux/kconfig.h --jobs 8 --chunksize 1
> Fatal error: exception
> Yes_prepare_ocamlcocci.LinkFailure("/tmp/ocaml_cocci_18c9f9.cmxs")

Does your Coccinelle support OCaml?  I'm not sure what is the proper way to
check for this, but in my coccinelle/config.log file I have

FEATURE_OCAML='1'

spatch --version gives:

spatch version 1.0.6-00147-g19f9421 compiled with OCaml version 4.02.3
Flags passed to the configure script: [none]
Python scripting support: yes
Syntax of regular expresssions: Str

I'm not sure why it doesn't give feedback on whether OCaml scripting is
supported.  I will check on this.

julia
