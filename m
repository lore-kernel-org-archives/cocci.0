From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 14 Oct 2016 11:36:48 +0200
Subject: [Cocci] Replacing calls of general functions by more specific
 ones with SmPL
In-Reply-To: <alpine.DEB.2.10.1610141101550.3272@hadrien>
References: <8c2c37de-baee-8282-b5cc-ad6eea3bb66f@users.sourceforge.net>
 <alpine.DEB.2.10.1610141019550.3002@hadrien>
 <2d2a0414-0e23-790b-e99c-0220ffda2b35@users.sourceforge.net>
 <alpine.DEB.2.10.1610141101550.3272@hadrien>
Message-ID: <11ec513e-cc4d-4748-4fb0-e44088a5f223@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> You can inherit and test properties of anything you like in python or
> ocaml code.  If you inherit some kind of metavariable other than a
> position variable, the term will be represented as a string.  But that
> should be fine for detecting eg if a string has only one character.

Your explanation sounds promising.


> If it has multiple characters, you can do the include match false call, so that
> in the last rule when yu inherit again the metavariable containing th
> string, it won't be seen.

I see another software development challenge then.

* I imagine that this "false call" will work for the exclusion of unwanted source
  code fragments.

* But I will also need a way to construct a source code change ("plus code" in
  the semantic patch) with OCaml or Python scripting, won't I?

Regards,
Markus
