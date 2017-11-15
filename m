From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 16 Nov 2017 00:49:55 +0900
Subject: [Cocci] Coccinelle: badzero.cocci failure
In-Reply-To: <276207557.16617848.1510757806971.JavaMail.zimbra@inria.fr>
References: <CAK7LNATW91vf5Sa-vvJ7rLRNt+KRKPB=E5H_EOtOUgCB4WYmUA@mail.gmail.com>
 <alpine.DEB.2.20.1711141003410.2874@hadrien>
 <CAK7LNATw25OPNe_oqQNCmF=Uaw1Enjx9YRRBEHsZcAgupgHc8w@mail.gmail.com>
 <alpine.DEB.2.20.1711150721060.2147@hadrien>
 <CAK7LNAR=Un8B4e9-H7hOA+u=PH985xc1NBHRXoXQrSCs5hK7dQ@mail.gmail.com>
 <276207557.16617848.1510757806971.JavaMail.zimbra@inria.fr>
Message-ID: <CAK7LNASGr2O3wxt_9J-zjvttpc0joztmdT7NFZ5MK7NWEOp5gw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Thierry,

2017-11-15 23:56 GMT+09:00 Thierry Martinez <thierry.martinez@inria.fr>:
> Hi, Masahiro.
>
> Masahiro:
>> Fatal error: exception
>> Yes_prepare_ocamlcocci.LinkFailure("/tmp/ocaml_cocci_fdd282.cmxs")
>
> If you can rerun your test with coccinelle GitHub master, the
> LinkFailure exception will now be more verbose, in order to understand
> the problem.
>
> I suspect a mismatch between the version of OCaml you use to compile
> coccinelle, and the version of OCaml that coccinelle uses to compile
> OCaml scripts in rules.
>

Now I am out of the office
and working from home.
badzero.cocci works fine on my PC at home.

I suspect the difference of installed packages.


I will try the latest commit in the GitHub
tomorrow at the office.




Best Regards
Masahiro Yamada
