From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 8 Oct 2014 13:51:22 +0200 (CEST)
Subject: [Cocci] Searching for pass-through functions
In-Reply-To: <543522B0.9020700@users.sourceforge.net>
References: <54303340.3090901@users.sourceforge.net>
 <alpine.DEB.2.02.1410042116320.2079@localhost6.localdomain6>
 <54305719.1050304@users.sourceforge.net>
 <alpine.DEB.2.02.1410042331240.2079@localhost6.localdomain6>
 <54312F70.3080809@users.sourceforge.net>
 <alpine.DEB.2.02.1410051347570.2229@localhost6.localdomain6>
 <54313662.8000402@users.sourceforge.net>
 <alpine.DEB.2.02.1410051729480.2022@localhost6.localdomain6>
 <543522B0.9020700@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1410081351060.2441@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 8 Oct 2014, SF Markus Elfring wrote:

> > For example are you only interested in pointers?
>
> I get the impression from the source files within the software repository for
> the operating system "MINIX 3.3.0" that pointers are specified for input
> parameters (which will be also forwarded as return values) at 177 source code
> places while non-pointer data types are used 301 times for such a specific
> parameter in corresponding function signatures.
> Are such facts worth for further considerations?

I don't know.  It depends on what you specifically want to do with the
information.

julia
