From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 2 Apr 2014 10:35:14 +0200 (CEST)
Subject: [Cocci] "trivial" linux code style reformatting
In-Reply-To: <533BCAAA.1050202@users.sourceforge.net>
References: <1396374174.21529.93.camel@joe-AO722>
 <CA+MoWDr-vry3W3T-duYPYr=H4b3OE0YshuDN9caH56o+WE4CQA@mail.gmail.com>
 <1396393876.21529.99.camel@joe-AO722>
 <alpine.DEB.2.02.1404020749280.2007@localhost6.localdomain6>
 <533BCAAA.1050202@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1404021033420.2080@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 2 Apr 2014, SF Markus Elfring wrote:

> > Indeed, it works mostly better, because Coccinelle takes charge
> > of the interaction between the ) and the {, but if ther is some
> > specific spacing in E, that will be lost.
>
> Would you like to clarify this implementation detail a bit more?
> Are there any chances that this software will become able to restore a preferred
> source code layout from the matched expressions?

No, a metavariable contains no information about its format, so that it
can match with other metavariables, and when it is printed, Coccinelle
follows whatever strategy it follows, which is intended to follow the
conventions of Linux, but is not always successful.  There are tools such
as indent that reformat software as a whole using various conventions.

julia
