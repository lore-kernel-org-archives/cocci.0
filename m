From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 22 Jul 2014 17:22:54 +0200 (CEST)
Subject: [Cocci] [bug-cocci] Parse error
In-Reply-To: <20140721221300.GA17667@rlp>
References: <20140721221300.GA17667@rlp>
Message-ID: <alpine.DEB.2.10.1407221722040.2366@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 22 Jul 2014, Riccardo Lucchese wrote:

> Hello,
>
> spatch fails to parse the following line
>
> - if (!~e) S
>
> in the attached .cocci test case.
>
> Using
>
> - if (!(~e)) S
>
> instead, works fine.

It should work if you put a space between ! and ~.

julia
