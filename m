From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 17 Oct 2014 22:27:15 +0200 (CEST)
Subject: [Cocci] sgen problems
In-Reply-To: <20141017202400.GA2576@katana>
References: <20141017202400.GA2576@katana>
Message-ID: <alpine.DEB.2.10.1410172226450.2705@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 17 Oct 2014, Wolfram Sang wrote:

> Hi,
>
> so I was trying to convert my spatch from the platform-owner series to a
> Kernel-cocci with sgen. However, that didn't work and produced a corrupt
> cocci file (at least the name of the matching rules has been eaten). I
> used a self-compiled sgen from the Debian rc22. I attach the cocci and
> config file for easier reproducing. Does the sgen author read the list?
> Probably it would be easy to fix the broken file, but it seems more
> sustainable to me to fix the tool :)

I'm not sure whether the sgen author reads the list, but I will ask her to
fix the tool. Thanks very much for the feedback!

julia
