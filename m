From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 11 Apr 2014 22:04:34 +0200 (CEST)
Subject: [Cocci] Software parallelisation?
In-Reply-To: <CAGrdgiUtFnTCH+HmhfLhxTmp=btBqx3mYJGQLN6AeaUnxW=YSw@mail.gmail.com>
References: <1397152097-315-1-git-send-email-mcgrof@do-not-panic.com>
 <1397152289.4757.28.camel@jlt4.sipsolutions.net>
 <20140410175748.GK14815@wotan.suse.de>
 <alpine.DEB.2.02.1404102131390.2201@localhost6.localdomain6>
 <5347ACF3.9040308@users.sourceforge.net>
 <CAGrdgiUtFnTCH+HmhfLhxTmp=btBqx3mYJGQLN6AeaUnxW=YSw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1404112154260.2064@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 11 Apr 2014, Jesper Louis Andersen wrote:

> 
> On Fri, Apr 11, 2014 at 10:50 AM, SF Markus Elfring
> <elfring@users.sourceforge.net> wrote:
>       Would you like to share any more ideas about corresponding
>       software
>       improvements?
> 
> 
> The quick answer: It is currently somewhat hard. Ocaml is not multi-threaded
> because it does not have a garbage collector able to execute in multiple
> threads at the same time. This is being worked on seriously now, but is at
> least 2-3 years out on the horizon for a stable solution.
> 
> So to make cocci faster on the inside requires some multi-processing
> hackery. Certainly possible, but not as easy.

Actually, there is a library from Roberto di Cosmo called Parmap that does 
a simple but reasonable job.  For Coccinelle there are two problems:

1. The Coccinelle build system is too complex or me to be able to figure 
out how to include Parmap.  This probably just requires a little time and 
patience to resolve.

2. Coccinelle provides initialize and finalize rules.  These are normally 
used to collect information, eg in a hash table or a global list.  If one 
treats eg a set of files in parallel, then one would have to specify how 
to join the information collected by the separate initialize and finalize 
instances, or somehow implement shared memory in C and use some for of 
synchronization.  This seems all too complicated for Coccinelle.

Point 2 means that parallelism is likely to be provided inside Coccinelle 
only for semantic patches that don't have initialize and finalize rules.  
If the semantic patch has initialize and finalize rules, the user should 
have to explicitly device whether they want to run Coccinelle single 
threaded or run it in separate files in parallel and combine the results 
in the end in some other way.

Another alternative would be to introduce parallelism within the treatment 
of a single file, eg running a matching rule on each function in parallel.  
In preliminary experiments, this didn't seem cost effective.  There is a 
lot of context information that has to be transmitted to the child 
processes, and anyway the treatment of most functions is very fast, 
because there is nothing to do.

julia
