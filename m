From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 16 Nov 2017 11:19:20 +0900
Subject: [Cocci] Coccinelle: badzero.cocci failure
In-Reply-To: <CAK7LNASGr2O3wxt_9J-zjvttpc0joztmdT7NFZ5MK7NWEOp5gw@mail.gmail.com>
References: <CAK7LNATW91vf5Sa-vvJ7rLRNt+KRKPB=E5H_EOtOUgCB4WYmUA@mail.gmail.com>
 <alpine.DEB.2.20.1711141003410.2874@hadrien>
 <CAK7LNATw25OPNe_oqQNCmF=Uaw1Enjx9YRRBEHsZcAgupgHc8w@mail.gmail.com>
 <alpine.DEB.2.20.1711150721060.2147@hadrien>
 <CAK7LNAR=Un8B4e9-H7hOA+u=PH985xc1NBHRXoXQrSCs5hK7dQ@mail.gmail.com>
 <276207557.16617848.1510757806971.JavaMail.zimbra@inria.fr>
 <CAK7LNASGr2O3wxt_9J-zjvttpc0joztmdT7NFZ5MK7NWEOp5gw@mail.gmail.com>
Message-ID: <CAK7LNAQ_MVM=QmE-jO+KLFe5oFq9ss+VitRX9WKcUN=_mPJHBg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Thierry,


2017-11-16 0:49 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Thierry,
>
> 2017-11-15 23:56 GMT+09:00 Thierry Martinez <thierry.martinez@inria.fr>:
>> Hi, Masahiro.
>>
>> Masahiro:
>>> Fatal error: exception
>>> Yes_prepare_ocamlcocci.LinkFailure("/tmp/ocaml_cocci_fdd282.cmxs")
>>
>> If you can rerun your test with coccinelle GitHub master, the
>> LinkFailure exception will now be more verbose, in order to understand
>> the problem.
>>
>> I suspect a mismatch between the version of OCaml you use to compile
>> coccinelle, and the version of OCaml that coccinelle uses to compile
>> OCaml scripts in rules.
>>
>
> Now I am out of the office
> and working from home.
> badzero.cocci works fine on my PC at home.
>
> I suspect the difference of installed packages.
>
>
> I will try the latest commit in the GitHub
> tomorrow at the office.
>
>

I tested the latest coccinelle
on my PC at office.

The result is as follows:


$ spatch --version
spatch version 1.0.6-00359-g1a8f958 compiled with OCaml version 4.02.3
Flags passed to the configure script: --prefix=/home/masahiro
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expresssions: PCRE
$ spatch --sp-file nothing.cocci kernel/kmod.c
init_defs_builtins: /home/masahiro/bin/../lib/coccinelle/standard.h
Using native version of ocamlc/ocamlopt/ocamldep
ocamlopt.opt -shared -o /tmp/ocaml_cocci_d59676.cmxs -g -I
/usr/lib/ocaml  -I /home/masahiro/bin/../lib/coccinelle/ocaml
/tmp/ocaml_cocci_d59676.ml
Compilation OK!
Loading ML code of the SP...
implementation mismatch on Coccilib
Fatal error: exception
Yes_prepare_ocamlcocci.LinkFailure("/tmp/ocaml_cocci_d59676.cmxs",
"implementation mismatch on Coccilib")




I use Ubuntu 16.04 LTS

$ cat  /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=16.04
DISTRIB_CODENAME=xenial
DISTRIB_DESCRIPTION="Ubuntu 16.04.2 LTS"


I checked install.txt
and I confirmed all of the following packages are installed on my PC.

On Debian/Ubuntu, install the following packages
 - pkg-config (optional, but strongly recommended)
 - ocaml-native-compilers (or alternatively ocaml)
 - ocaml-findlib
 - menhir and libmenhir-ocaml-dev (optional, bundled)
 - libpcre-ocaml-dev (optional, bundled)
 - texlive-fonts-extra (for the documentation)




-- 
Best Regards
Masahiro Yamada
