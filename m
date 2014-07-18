From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 18 Jul 2014 22:02:56 +0200 (CEST)
Subject: [Cocci] typo in config script ?
In-Reply-To: <20140718193508.GA25742@opentech.at>
References: <20140718193508.GA25742@opentech.at>
Message-ID: <alpine.DEB.2.02.1407182158270.2015@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 18 Jul 2014, Nicholas Mc Guire wrote:

> 
> HI !
> 
>  
>  while building rc21 ./configure ,,,,  outputs
> 
> ...
> optimized spatch: no    (overridable with --disable-opt)
> ...
> 
>  which should probably be --enable-opt ? 

I think (but I am not at all sure) that the issue is that the variable 
that produces "no" can actually be either yes or no at this point.  The 
message on the other hand is fixed, and it is assuming that the value is 
yes.  Were there some messages before related to ocamlopt.  Do you have 
ocamlopt installed on your machine?  Or do you have ocaml 3.11.2.  
Apparently that has a bug that precludes making an optimized version.  
There seem to be a bunch of other conditions that can cause this issue.  
Probably there should just be no overridable message if any of these 
problems occurs.

julia
