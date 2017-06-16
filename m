From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 16 Jun 2017 16:03:31 +0200
Subject: [Cocci] Replacing suffix rules in make scripts?
In-Reply-To: <alpine.DEB.2.20.1706161414440.3591@hadrien>
References: <020f8c95-fcaa-d47e-410b-7fb633fefa09@users.sourceforge.net>
 <9c2abe52-5ef9-62e0-26ab-f4fc69513257@users.sourceforge.net>
 <alpine.DEB.2.20.1706142255480.3610@hadrien>
 <47632935-6b4f-aeec-2ced-11f5d2f8609b@users.sourceforge.net>
 <alpine.DEB.2.20.1706152233080.3015@hadrien>
 <75d88a53-ace7-3bea-a3b2-bbc100091e78@users.sourceforge.net>
 <alpine.DEB.2.20.1706160802420.3013@hadrien>
 <8acbcd33-5eb7-08d3-c841-734d0359f87b@users.sourceforge.net>
 <alpine.DEB.2.20.1706160829130.3459@hadrien>
 <0e92a764-c68e-c279-4d33-228690b47172@users.sourceforge.net>
 <alpine.DEB.2.20.1706160907590.3049@hadrien>
 <1a14a623-cb5d-b8ab-4635-2dbe2082318c@users.sourceforge.net>
 <834eb5af-9423-9138-1c56-68d5dc86bdf0@users.sourceforge.net>
 <alpine.DEB.2.20.1706161149040.3029@hadrien>
 <2718dfcc-924c-8685-9a70-0c776e1d012f@users.sourceforge.net>
 <alpine.DEB.2.20.1706161414440.3591@hadrien>
Message-ID: <6b124d83-4abe-68e9-7dbc-4c1b994c6969@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Can you get the impression from the mentioned error message examples
>> that the desired software build prerequisites failed anyhow?
> 
> Something fails in your situation, but without knowing the arguments to
> the compiler, I don't know what.

You could know also from the reduced information.


Is it really easier for you to see the following data again?

elfring at Sonne:~/Projekte/Coccinelle/20160205/parsing_c> LANG=C make V=1
/usr/bin/ocamlc.opt -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I  ../parsing_cocci  -c includes.mli
File "includes.mli", line 38, characters 46-60:
Error: Unbound module Ast_c
make: *** [/home/elfring/Projekte/Coccinelle/20160205/common_rules.make:6: includes.cmi] Error 2


Regards,
Markus
