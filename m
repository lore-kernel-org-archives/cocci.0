From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 24 Aug 2017 13:10:27 +0200
Subject: [Cocci] parsing of C code
In-Reply-To: <alpine.DEB.2.20.1708241219540.3187@hadrien>
References: <alpine.DEB.2.20.1708231104310.3150@hadrien>
 <8fcfa4a0-678a-f8f3-003a-9c953ba36c11@users.sourceforge.net>
 <alpine.DEB.2.20.1708241219540.3187@hadrien>
Message-ID: <e113478d-2cf4-ed9a-a168-35f7209b49c0@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Parsing of foo fails due to the attribute __xxx(yyy) that Coccinelle is
> not able to cope with.

Why does the parsing software struggle with such input data so far?


> Coccinele hopes that expanding macros will solve the problem.

Why do you need to ?hope? something if the software could be designed
in the way to take also special care with these source code places?

Do you eventually stumble on target conflicts because of language processing
difficulties which could be explained from the Chomsky?Sch?tzenberger hierarchy?

Regards,
Markus
