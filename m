From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 05 Oct 2014 13:45:52 +0200
Subject: [Cocci] Searching for pass-through functions
In-Reply-To: <alpine.DEB.2.02.1410042331240.2079@localhost6.localdomain6>
References: <54303340.3090901@users.sourceforge.net>
 <alpine.DEB.2.02.1410042116320.2079@localhost6.localdomain6>
 <54305719.1050304@users.sourceforge.net>
 <alpine.DEB.2.02.1410042331240.2079@localhost6.localdomain6>
Message-ID: <54312F70.3080809@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The rule is_pass_through asks it to analyze every input of every function.  
> Perhaps it is not surprising that it takes some time.

I tried out another command variant again.

elfring at Sonne:~/Projekte/Coccinelle/lokal/demos/pass-through> date && spatch.opt
--timeout 30 --include-headers-for-types -I /usr/src/linux-stable/include
-sp_file list_pass-through_functions.cocci -dir /usr/src/linux-stable >
list_pass-through_functions-Linux-3_16_3-B.txt 2>
list_pass-through_functions-Linux-3_16_3-B-errors.txt && date
So 5. Okt 09:47:03 CEST 2014
So 5. Okt 10:15:39 CEST 2014


Now it seems that 2924 pass-through functions were found by this source code
analysis approach at least.

Excerpt from log file:
?
HANDLING: /usr/src/linux-stable/drivers/media/pci/ttpci/av7110_ipack.c
EXN:Common.Timeout
?
HANDLING: /usr/src/linux-stable/drivers/net/fddi/skfp/ess.c
EXN:Common.Timeout
?
HANDLING: /usr/src/linux-stable/crypto/fcrypt.c
EXN:Failure("lexing: empty token")
?
HANDLING: /usr/src/linux-stable/kernel/debug/kdb/kdb_io.c
EXN:Common.Timeout
?
HANDLING: /usr/src/linux-stable/net/ipv6/ndisc.c
EXN:Failure("is_pass_through: node 121: return ...[1,2,47] in
ndisc_parse_options reachable by inconsistent control-flow paths")
?


Would you like to look at these source files in more detail?

Regards,
Markus
