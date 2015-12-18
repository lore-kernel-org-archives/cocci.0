From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 18 Dec 2015 09:00:36 +0100
Subject: [Cocci] Coccinelle for other programming languages
In-Reply-To: <alpine.DEB.2.10.1512171825240.10291@hadrien>
References: <B517F47C2F6D914AA8121201F9EBEE6701C7CF57C22C@Mail1.FCMD.local>
 <alpine.DEB.2.10.1512171825240.10291@hadrien>
Message-ID: <5673BD24.5000900@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I?m curious whether you can comment on any other tools for other programming languages.

How do you think about to take another look at issues like the following?


> Coccinelle doesn't support any languages other than C, and a small amount of C++.

Support C++ codebases
https://github.com/coccinelle/coccinelle/issues/1

How many design elements can be shared for programming languages
which have got similar properties?
https://en.wikipedia.org/wiki/Procedural_programming


> For C++, it parses the C-like parts of the code, and ignores the rest.

Exclusion of unsupported source code parts
https://github.com/coccinelle/coccinelle/issues/20


> It could be conceptually possible to design a version of Coccinelle
> for other languages, but it would require a lot of development work,
> so funding would be required.

Class libraries for software components
https://github.com/coccinelle/coccinelle/issues/22

Regards,
Markus
