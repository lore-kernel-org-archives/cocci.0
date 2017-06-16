From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 16 Jun 2017 11:43:30 +0200
Subject: [Cocci] Replacing suffix rules in make scripts?
In-Reply-To: <1a14a623-cb5d-b8ab-4635-2dbe2082318c@users.sourceforge.net>
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
Message-ID: <834eb5af-9423-9138-1c56-68d5dc86bdf0@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The command ?ocamldep *.mli *.ml > .depend? was performed for
> relevant subdirectories.
> Unfortunately, this approach seems to be insufficient for the desired
> safe integration of dependency information so far.

How do you think about to work any more with dedicated files
for each source file by pattern rules like it is described in the manual
section ?Generating prerequisites automatically??
https://www.gnu.org/software/make/manual/html_node/Automatic-Prerequisites.html

Would it make sense to split the data from the command ?ocamldep? into
smaller units?


Do I stumble on unexpected software behaviour by the tool ?GNU Make 4.2.1-1.7?
on my openSUSE Tumbleweed system?

Regards,
Markus
