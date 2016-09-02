From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 2 Sep 2016 11:11:12 +0200
Subject: [Cocci] Detecting undefined behavior with Coccinelle
In-Reply-To: <CANO7a6yAgHjcJc2R2fNyn8Pgto=qs-5+kUTZ2Etan0ODhqLSrQ@mail.gmail.com>
References: <CANO7a6yAgHjcJc2R2fNyn8Pgto=qs-5+kUTZ2Etan0ODhqLSrQ@mail.gmail.com>
Message-ID: <8cbd73d2-65c1-7b80-bee1-e84e0cb04462@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Is it possible to detect such code patterns (multiplication operation
> followed by division to check for overflow) which invoke undefined
> behavior using Coccinelle?

I imagine that it is generally possible to find some update candidates
for such an use case also by means of the semantic patch language.
https://www.securecoding.cert.org/confluence/display/c/CC.+Undefined+Behavior

* How many software development efforts would you like to invest?

* Which search patterns do you find worthwhile here?

* Can it be that data flow analysis will be needed to check appropriate
  usage of the involved variables in a safer way?

Regards,
Markus
