From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 5 Oct 2014 17:33:34 +0200 (CEST)
Subject: [Cocci] Searching for pass-through functions
In-Reply-To: <54313662.8000402@users.sourceforge.net>
References: <54303340.3090901@users.sourceforge.net>
 <alpine.DEB.2.02.1410042116320.2079@localhost6.localdomain6>
 <54305719.1050304@users.sourceforge.net>
 <alpine.DEB.2.02.1410042331240.2079@localhost6.localdomain6>
 <54312F70.3080809@users.sourceforge.net>
 <alpine.DEB.2.02.1410051347570.2229@localhost6.localdomain6>
 <54313662.8000402@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1410051729480.2022@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I'm not sure what is the goal of your semantic patch.  For example are you 
only interested in pointers?  If so, it could be helpful to specify it in 
your semantic patch.  The first two I cases I looked at return int.

Another thing that could be helpful is to check if there exists the 
pattern you are looking for, before checking whether it is found on all 
execution paths.  You can use the same rule you have, but with exists in 
the header, and then have a second rule that checks all paths and depends 
on the first one.

Also, since you just want to find returns, but don't care about what 
happens in between, you can use arguments like --no-loops and --no-gotos.

julia

On Sun, 5 Oct 2014, SF Markus Elfring wrote:

> > You can use --show-trying to find on what function it gets stuck.
> 
> 1. /usr/src/linux-stable/drivers/media/pci/ttpci/av7110_ipack.c
> ?
>      trying function: av7110_ipack_instant_repack
> timeout (we abort)
> ?
> 
> 2. /usr/src/linux-stable/drivers/net/fddi/skfp/ess.c
> ?
>      trying function: ess_raf_received_pack
> timeout (we abort)
> ?
> 
> 
> 3. /usr/src/linux-stable/crypto/fcrypt.c
> ?
>      trying function: kdb_read
> timeout (we abort)
> ?
> 
> 4. /usr/src/linux-stable/crypto/fcrypt.c
> ?
> exn while in timeout_function
> Fatal error: exception Failure("lexing: empty token")
> 
> 5. /usr/src/linux-stable/net/ipv6/ndisc.c
> ?
>      trying function: ndisc_parse_options
> exn while in timeout_function
> Fatal error: exception Failure("is_pass_through: node 121: return ...[1,2,47] in
> ndisc_parse_options reachable by inconsistent control-flow paths")
> 
> 
> Should we reconsider more implementation details here?
> 
> Regards,
> Markus
> 
