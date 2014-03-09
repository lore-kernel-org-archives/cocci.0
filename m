From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 9 Mar 2014 08:13:22 +0100 (CET)
Subject: [Cocci] Determination of the number for named function
 parameters
In-Reply-To: <531C11E1.5090004@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <531B0D52.5070008@users.sourceforge.net>
 <alpine.DEB.2.10.1403081514140.2156@hadrien>
 <531B32F4.9080004@users.sourceforge.net>
 <alpine.DEB.2.02.1403082257440.2126@localhost6.localdomain6>
 <531C11E1.5090004@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1403090808580.2030@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 9 Mar 2014, SF Markus Elfring wrote:

> >> I find the use of the element "n" (the name in square brackets) not obvious from
> >> the Coccinelle manual so far.
> > 
> > It is the number of elements that have been matched.
> 
> A part of my difficulty with interpretation of the grammar for the semantic
> patch language came from this notation.
> 
> "metadecl ::= ...
>             | parameter [list] ids ;
>             | parameter list [ id ] ids ;
> ..."
> 
> 
> Do square brackets indicate in one line that an information is optional while in
> the other line they should be used as literals?

Yes.  The spaces around the [ ] means that they are tokens.

julia
