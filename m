From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 14 Sep 2016 16:16:19 +0200 (CEST)
Subject: [Cocci] Match #define in cocci
In-Reply-To: <CAHKzcEN9fcOk1HCar=u+htx=o61xF61VmbO9PeYPBaedTQYDcg@mail.gmail.com>
References: <CAHKzcEN9fcOk1HCar=u+htx=o61xF61VmbO9PeYPBaedTQYDcg@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1609141615560.3033@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 14 Sep 2016, Waldemar Rymarkiewicz wrote:

> Hi,
>
> I'm new to cocci and try to understand how all this things work. I
> have a problem with matching a #define  in a patch.
>
> I wan to match local definition
>
>    #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> and  add #undef  it first. The output should be like this
>
>    #undef  pr_fmt
>    #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> I tried many approaches but seems like parser have a problem with
> parsing #defines.
>
> Is that possible to achieve  what I expect in cocci ?

Could you send the exact semantic patch that you tried?  Coccinelle should
allos parsing #defines.

julia
