From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Sep 2016 19:46:30 +0200
Subject: [Cocci] Detecting undefined behavior with Coccinelle
In-Reply-To: <alpine.DEB.2.10.1609021106100.3052@hadrien>
References: <CANO7a6yAgHjcJc2R2fNyn8Pgto=qs-5+kUTZ2Etan0ODhqLSrQ@mail.gmail.com>
 <alpine.DEB.2.10.1609020833410.3103@hadrien>
 <CANO7a6xaN2P9a+3kprsP-o1rh0sgwiEcuHuP3ZH6cKNvP1jF9w@mail.gmail.com>
 <alpine.DEB.2.10.1609021106100.3052@hadrien>
Message-ID: <bbd0da43-af3d-8f59-53cf-711c6b71f723@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> You may however have some typedefs for signed types, such as s32, etc.

How many data type definitions should be usually considered here?


> If you need multiple types, you can put them in {}.

How do you think about to give this construct a more succinct name
(than "curly brackets") for the semantic patch language?

Can it become easier to recognise corresponding descriptions for the
handling of "ctypes" in the available SmPL documentation?

Regards,
Markus
