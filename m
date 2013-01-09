From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Tue, 8 Jan 2013 22:13:19 -0200
Subject: [Cocci] #if defined ()
In-Reply-To: <CA+MoWDpH=vZAiSAY_RxqtZNtKz1Gm4A7v+RpMW1eca=j0oB1Gg@mail.gmail.com>
References: <CA+MoWDpH=vZAiSAY_RxqtZNtKz1Gm4A7v+RpMW1eca=j0oB1Gg@mail.gmail.com>
Message-ID: <CA+MoWDpFUNU2U73ybTH04FJEMFMpV-xb7skT5uT5C7AJBYTWew@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I found the answer under "11 Comments and preprocessor directives" on
the SMPL grammar: http://coccinelle.lip6.fr/docs/main_grammar.pdf

According to the document, is possible to add preprocessor if but is
not possible to parse preprocessor if. So I think is not yet possible.

On Tue, Jan 8, 2013 at 10:01 PM, Peter Senna Tschudin
<peter.senna@gmail.com> wrote:
> Hi,
>
> There is a recent commit on Linux Kernel:
> $ git show 37b44a0f04184998073633887d2f1e724aee130a
>
> commit 37b44a0f04184998073633887d2f1e724aee130a
> Author: Antti Palosaari <crope@iki.fi>
> Date:   Fri Jan 4 15:21:26 2013 -0300
>
>     [media] dvb_usb_v2: use IS_ENABLED() macro
>
>     replace:
>      #if defined(CONFIG_RC_CORE) || defined(CONFIG_RC_CORE_MODULE)
>     with:
>      #if IS_ENABLED(CONFIG_RC_CORE)
>
> Is it possible to write a semantic patch for this preprocessor code?
> Something like:
>
> @@
> constant i,j;
> @@
> -defined(i) || defined(j)
> +IS_ENABLED(i)
>
> Thanks!
> --
> Peter



--
Peter
