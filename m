From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 4 Jul 2017 18:59:39 +0200 (CEST)
Subject: [Cocci] Matching format strings
In-Reply-To: <20170704165655.yu7wwg7aomihs4of@eos.mistotebe.net>
References: <WM!65159de96edf810da1e56d42962da09a256f7f76b7d8eab05109b214b5dc8c18f88b6a34ac273725a5e7afd1a6bed1d7!@mailstronghold-2.zmailcloud.com>
 <20170704151108.2mvifcg7cyhztbh5@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041721300.11588@hadrien>
 <WM!e764e7a6685d1e3af9c59f905772f1c4a8db9db4c655054ccb07f1b8485096c0979716269a6920eeac860b62d25a700e!@mailstronghold-2.zmailcloud.com>
 <20170704160123.lilble53tmv5t5va@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041806150.11588@hadrien>
 <WM!cc508729d042cf12207adee814670b88c105ae73cdaf601fdeb9c3e26fa32e7df0d4d49f847a216810550421de0d8de6!@mailstronghold-3.zmailcloud.com>
 <20170704162732.urhtl54j3gbj3myh@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041837300.11588@hadrien>
 <WM!eb7db9be9e260b8b332afe997cbb4412d355372680c68c06376375f785c138afeda43804b4aaff43c0242a17ff2d826f!@mailstronghold-3.zmailcloud.com>
 <20170704165655.yu7wwg7aomihs4of@eos.mistotebe.net>
Message-ID: <alpine.DEB.2.20.1707041858400.11588@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > How about adding a timeout (eg --timeout 120) and then see how much is
> > left over.
>
> I get:
> timeout (we abort)
> Fatal error: exception Common.Timeout
>
> and no patch is produced, if I wait the 1028 seconds, I get the expected
> patch. I think that supports your hypothesis about trying to process the
> continue.

If you run Coccinelle on the whole directory, it should timeout on some
files, and then work on the other ones.  Indeed, if there is a timeout at
one point for a file then you won't get any patch for that file at all.

julia
