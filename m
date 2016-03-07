From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 7 Mar 2016 23:20:23 +0100
Subject: [Cocci] Parsing C source files by Coccinelle
In-Reply-To: <alpine.DEB.2.10.1603080655550.2647@hadrien>
References: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
 <56D99C75.7080100@users.sourceforge.net>
 <CAO=9Y+2Qm+A9a91zGrYNJavOXcWFR2hj5Xx+=FPG1p02KdC7Ew@mail.gmail.com>
 <56DDCAD3.2080309@users.sourceforge.net>
 <alpine.DEB.2.10.1603080655550.2647@hadrien>
Message-ID: <56DDFEA7.1080407@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> The software library "http://cristal.inria.fr/~fpottier/menhir/"
>> is involved to some degree.
> 
> None whatsoever, actually.

An option like "--enable-menhirLib" is provided under the configuration category
"Optional Features", isn't it?



> A parser is implemented using ocamlyacc, combined with some hauristics
> that reorganize the input tokens a little bit.  The approach is described in the following paper:
> 
> Yoann Padioleau:
> Parsing C/C++ Code without Pre-processing. CC 2009: 109-125

How much did the software design and corresponding implementation evolve further
since the description of this approach?

Regards,
Markus
