From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 15 Oct 2016 09:19:43 +0200
Subject: [Cocci] Replacing calls of general functions by more specific
 ones with SmPL
In-Reply-To: <alpine.DEB.2.10.1610141019550.3002@hadrien>
References: <8c2c37de-baee-8282-b5cc-ad6eea3bb66f@users.sourceforge.net>
 <alpine.DEB.2.10.1610141019550.3002@hadrien>
Message-ID: <db49dd34-98f8-c9ff-c05b-015d16d71e68@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The simplest would be to use python or ocaml code to make the checks that
> are needed.  You can use cocci.include_match(False) in python or
> Coccilib.include_match false in ocaml when your test detects that
> something is not suitable.

Will it occasionally matter then to distinguish better if a specific source code
fragment or a complete source file should be excluded from an analysis run
on demand?

Regards,
Markus
