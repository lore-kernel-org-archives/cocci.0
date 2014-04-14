From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 14 Apr 2014 15:27:55 +0200 (CEST)
Subject: [Cocci] Road map after Coccinelle 1.0.0-rc21?
In-Reply-To: <534BDDD6.9070407@users.sourceforge.net>
References: <alpine.DEB.2.10.1404141356250.2601@hadrien>
 <534BDDD6.9070407@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1404141525370.2572@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 14 Apr 2014, SF Markus Elfring wrote:

> Am 14.04.2014 14:05, schrieb Julia Lawall:
> > Version 1.0.0-rc21 has been released.
>
> Which release will contain improvements for open issues which we discussed for
> the software "Coccinelle 1.0.0-rc20"?

You had a problem with including some ocaml libraries, which will be
worked on at some point in the near future.

You had a problem with temporary file names, which is addressed (cf
changes.html).

Someone else had a problem with constructors, which will also be addressed
shortly.

I don't think anything else was discussed which was within the current
goals and resources for the development of Coccinelle.

julia
