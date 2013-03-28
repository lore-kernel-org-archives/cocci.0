From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 28 Mar 2013 14:10:37 +0100 (CET)
Subject: [Cocci] Control flow query across files
In-Reply-To: <13CEBF2EC72707459166C3356C1FEC8B7C3B22E0@ST-PES-MBX-01.serma.local>
References: <13CEBF2EC72707459166C3356C1FEC8B7C3B22E0@ST-PES-MBX-01.serma.local>
Message-ID: <alpine.DEB.2.02.1303281408320.1928@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 26 Mar 2013, LANCIA Julien wrote:

>
> Hello,
>
> I?ve stumbled accross coccinelle and I?m interested in using it to perform queries on the control flow graph
> (quite similarly to what have been done in ?Finding Error Handling Bugs in OpenSSL using Coccinelle? by Lawall
> and al.).
>
> However, I wonder if it is possible to perform queries on the control flow graph that span across a single C
> file.
>
> ?
>
> An example to be clear:
>
> ?
>
> fileA.h : f(), g(), h()
>
> fileA.c : f() calls g() calls h() calls i()
>
> ?
>
> fileA.h : i() j() k()
>
> fileA.c : i() calls j() calls k()
>
> ?
>
> Is it possible with coccinelle to match the query
>
> f()
>
> ?
>
> k()
>
> ?
>
> that spans across fileA.c and fileB.c ?

No, ... doesn't work that way.  You can use the iteration facility to do
interprocedural analysis.  If you have the coccinelle source code, you can
see an example in demos/iteration.cocci

julia
