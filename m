From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 14 Oct 2016 11:04:27 +0200 (CEST)
Subject: [Cocci] Replacing calls of general functions by more specific
 ones with SmPL
In-Reply-To: <2d2a0414-0e23-790b-e99c-0220ffda2b35@users.sourceforge.net>
References: <8c2c37de-baee-8282-b5cc-ad6eea3bb66f@users.sourceforge.net>
 <alpine.DEB.2.10.1610141019550.3002@hadrien>
 <2d2a0414-0e23-790b-e99c-0220ffda2b35@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1610141101550.3272@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > coccinelle/demos/first.cocci may be helpful.
>
> I have got the impression that this small SmPL script demonstrates the usage
> of the mentioned function from your software library only for a simple position variable.
> I do not see the way so far how desired data could be extracted from a function
> (or expression?) parameter. Would you like to make the introspection options a bit
> clearer for the SmPL interface?

You can inherit and test properties of anything you like in python or
ocaml code.  If you inherit some kind of metavariable other than a
position variable, the term will be represented as a string.  But that
should be fine for detecting eg if a string has only one character.  If it
has multiple characters, you can do the include match false call, so that
in the last rule when yu inherit again the metavariable containing th
string, it won't be seen.

julia
