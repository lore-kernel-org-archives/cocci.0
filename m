From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 05 Oct 2014 14:15:30 +0200
Subject: [Cocci] Searching for pass-through functions
In-Reply-To: <alpine.DEB.2.02.1410051347570.2229@localhost6.localdomain6>
References: <54303340.3090901@users.sourceforge.net>
 <alpine.DEB.2.02.1410042116320.2079@localhost6.localdomain6>
 <54305719.1050304@users.sourceforge.net>
 <alpine.DEB.2.02.1410042331240.2079@localhost6.localdomain6>
 <54312F70.3080809@users.sourceforge.net>
 <alpine.DEB.2.02.1410051347570.2229@localhost6.localdomain6>
Message-ID: <54313662.8000402@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> You can use --show-trying to find on what function it gets stuck.

1. /usr/src/linux-stable/drivers/media/pci/ttpci/av7110_ipack.c
?
     trying function: av7110_ipack_instant_repack
timeout (we abort)
?

2. /usr/src/linux-stable/drivers/net/fddi/skfp/ess.c
?
     trying function: ess_raf_received_pack
timeout (we abort)
?


3. /usr/src/linux-stable/crypto/fcrypt.c
?
     trying function: kdb_read
timeout (we abort)
?

4. /usr/src/linux-stable/crypto/fcrypt.c
?
exn while in timeout_function
Fatal error: exception Failure("lexing: empty token")

5. /usr/src/linux-stable/net/ipv6/ndisc.c
?
     trying function: ndisc_parse_options
exn while in timeout_function
Fatal error: exception Failure("is_pass_through: node 121: return ...[1,2,47] in
ndisc_parse_options reachable by inconsistent control-flow paths")


Should we reconsider more implementation details here?

Regards,
Markus
