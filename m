From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 30 Apr 2015 17:35:30 +0200 (CEST)
Subject: [Cocci] Fiddling with whitespace in SmPL
In-Reply-To: <55424B51.9020404@users.sourceforge.net>
References: <44BEB158-144E-4ADA-9B1E-9AC634906DE0@gmail.com>
 <alpine.DEB.2.02.1504292115570.2042@localhost6.localdomain6>
 <554232B2.10107@redhat.com> <alpine.DEB.2.10.1504301549510.2415@hadrien>
 <55424B51.9020404@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1504301734590.2415@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 30 Apr 2015, SF Markus Elfring wrote:

> > As a side note, the previous release contained improved regression testing
> > for whitespace problems, so I hope that in the future the handling of
> > whitespace will only improve...
>
> Will corresponding software development challenges evolve also around a
> feature request like "Make change influence configurable for coding
> style rules"?
> https://github.com/coccinelle/coccinelle/issues/37

Not likely soon.  You can use --smpl-spacing to control the spacing of
generated code within a line.

julia
