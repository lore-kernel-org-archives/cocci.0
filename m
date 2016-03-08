From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 8 Mar 2016 10:01:49 +0100
Subject: [Cocci] Parsing C source files by Coccinelle
In-Reply-To: <alpine.DEB.2.10.1603080728340.2647@hadrien>
References: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
 <56D99C75.7080100@users.sourceforge.net>
 <CAO=9Y+2Qm+A9a91zGrYNJavOXcWFR2hj5Xx+=FPG1p02KdC7Ew@mail.gmail.com>
 <56DDCAD3.2080309@users.sourceforge.net>
 <alpine.DEB.2.10.1603080655550.2647@hadrien>
 <56DDFEA7.1080407@users.sourceforge.net>
 <alpine.DEB.2.10.1603080728340.2647@hadrien>
Message-ID: <56DE94FD.3030707@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> An option like "--enable-menhirLib" is provided under the configuration category
>> "Optional Features", isn't it?
> 
> This is for the parsing of the semantic patch.

Does this information mean that the software library "Menhir" is not so optional at the moment?


> Not the parsing of the C code.

Is the tool "ocamlyacc" sufficient for this data processing so far?


>>> Yoann Padioleau:
>>> Parsing C/C++ Code without Pre-processing. CC 2009: 109-125
>>
>> How much did the software design and corresponding implementation evolve further
>> since the description of this approach?
> 
> Not at all.

I have got an other impression through the years.

Your software supports source code transformations also without including header files
and other pre-processing stuff.

Example:
The option "--include-headers-for-types" was added by the release "Coccinelle 1.0.0-rc22".

A developer should decide whether header information is needed for a script in the semantic
patch language or not.


Would you like to increase the usage of "Menhir" as a LR(1) parser generator for the OCaml
programming language.

Regards,
Markus
