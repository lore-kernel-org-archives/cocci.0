From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 23 Feb 2017 20:37:15 +0100 (CET)
Subject: [Cocci] Include files in .cocci?
In-Reply-To: <CA+MoWDriccK191SXY=7W7QbMmbD=2NCzO=RCVcv_m4sUc0Q+7Q@mail.gmail.com>
References: <CA+MoWDriccK191SXY=7W7QbMmbD=2NCzO=RCVcv_m4sUc0Q+7Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1702232035440.2103@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 23 Feb 2017, Peter Senna Tschudin wrote:

> Hi,
>
> Is there a way to include .cocci files from another .cocci file? If
> I'm to write a library of rules I use, can I avoid maintaining
> multiple copies of the rules?

Experiment with variants of include "foo.cocci" and #include "foo.cocci".
I think you can do this only at the beginning of a file.

Another approach would be to just use cpp, if you don't have any #includes
or #defined in your rules.

julia

>
> Thanks a lot!
>
> --
> Peter
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
