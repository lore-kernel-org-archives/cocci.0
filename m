From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 22 Oct 2012 19:05:37 +0200 (CEST)
Subject: [Cocci] licensing concerns with cocci patches
In-Reply-To: <CAF6rxgkr4aQ-b8HpxJ9w8FMOTL63w7GFJqF5FD5MOwaJ3Kni5w@mail.gmail.com>
References: <CAF6rxgkr4aQ-b8HpxJ9w8FMOTL63w7GFJqF5FD5MOwaJ3Kni5w@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1210221902220.3683@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 22 Oct 2012, Eitan Adler wrote:

> Hi,
>
> I am interested in adding cocci scripts to the FreeBSD tree as a suite
> of scripts that can be used to help find bugs.  I have some concerns
> about the license of the "semantic patches" I found.  In particular
> quite a few of them are GPLv2 (andand.cocci, ifaddr.cocci,
> isnull.cocci, etc). Ordinarily the product of GPL software isn't GPLed
> but these seem different as the result is merely a transformation of
> patch template.
>
> Is the output of spatch + a GPL semantic patch GPL or can we license
> it under a free software license?

My understanding is that the output of a semantic patch should not be GPL.
But I am not an expert.  In any case, that is the intent.  We would
certainly be happy that the scripts be part of BSD.

julia
