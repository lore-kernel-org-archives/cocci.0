From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 15 Sep 2014 14:02:42 +0200 (CEST)
Subject: [Cocci] Semantic patches for more file formats?
In-Reply-To: <5416D3C6.9050800@users.sourceforge.net>
References: <5416D3C6.9050800@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1409151400300.2672@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 15 Sep 2014, SF Markus Elfring wrote:

> Hello,
>
> I hope that more files which can also contain data formats that are
> different from source code for the C programming language will be
> supported by a future semantic patch language implementation.
> https://github.com/coccinelle/coccinelle/blob/e2b56772bae0860cd8cf3aa7c4a06d5a9154128f/changes.txt#L3
>
> Do you know any approaches for such a software evolution?

It would require rewriting almost all of the code.  Unless someone wants
to pay for it, and someone is available who is interested in and competant
to do the work, it will never happen from our side.  There are enough
interesting things to do on C code so we have no personal motivation for
investing in it.

julia
