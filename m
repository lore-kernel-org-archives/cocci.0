From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Tue, 20 Jan 2015 09:33:00 +0100
Subject: [Cocci] Possible to install on OSX?
In-Reply-To: <DA6D9998-6B28-4982-BC25-04787C96111B@gmail.com>
References: <0F92B6B9-47F3-4A44-8D5A-ED04BC698EF0@gmail.com>
 <alpine.DEB.2.10.1501172308080.2777@hadrien>
 <A2929B64-B34C-4910-8486-16F7E2D2573C@gmail.com>
 <20150119092140.GE1907@pl-59055.rocqadm.inria.fr>
 <71E56961-AF04-469A-8B8D-A3F9BB77C261@gmail.com>
 <20150119155110.GA24065@pl-59055.rocqadm.inria.fr>
 <DA6D9998-6B28-4982-BC25-04787C96111B@gmail.com>
Message-ID: <20150120083300.GA8575@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear Eliseo,

> I have some good news, finally.
> I can build and install if I omit the menhir part.
> I mean, starting from a clean checkout, and after applying your patch,
> if I just do ./configure and make, instead of make distclean,
> ./configure and make, then it works.

Good!

> Which mainly solves my problem for now. I would like to be able to
> solve the menhir issue too, but that can wait.

I can confirm what Julia says. Actually, menhir is bundled with
coccinelle, so one one other possibility is to remove the one installed
by the package manager completely, to make sure it's the one that comes
with coccinelle which is used. That way, you won't even need the patch I
sent yesterday, because the menhir that comes with Coccinelle is older
and also more tolerant.

> Just one more thing, then. I?m not sure if plain ./configure, as I?ve
> used, is enough to be able to use python with smpl patches.

It seems so.

> Do I need ./configure ?-enable-python for that? If I do that, I get
> config errors (log attached).

No, I don't thinkyou need it. Looking at the config.log you have sent
yesterday, it seems that there are some python development files that
are not installed, so perhaps it would be good for you to see whether
your package namanger provides such a package, like python-2.7-dev or
so, and to install it.

hth,

S?bastien.
