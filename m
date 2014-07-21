From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 21 Jul 2014 21:47:21 +0200 (CEST)
Subject: [Cocci] [bug-cocci] "badly compiled mcode" error
In-Reply-To: <20140721184219.GA7903@rlp>
References: <20140721184219.GA7903@rlp>
Message-ID: <alpine.DEB.2.02.1407212146130.2039@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 21 Jul 2014, Riccardo Lucchese wrote:

> Hello,
> 
> While testing a larger semantic patch I came across the following
> error:
> """
> init_defs_builtins: /usr/share/coccinelle/standard.h
> Fatal error: exception Failure("badly compiled mcode")
> """
> 
> Here, I can reproduce it by running spatch --parse-cocci on the
> attached test.cocci.
> 
> $ spatch --version
> spatch version 1.0.0-rc21 with Python support and with PCRE support

I can indeed reproduce it, although I have never seen that before.  I will 
look into it tomorrow.  You can avoid the problem by disabling 
isomorphisms, eg --iso-file empty.iso where empty.iso is an empty file.  
But maybe you need isomorphisms for another rule...

julia
