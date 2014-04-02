From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 2 Apr 2014 09:43:02 +0200 (CEST)
Subject: [Cocci] Clarification for source code style reformatting
In-Reply-To: <533BBA12.1040105@users.sourceforge.net>
References: <1396374174.21529.93.camel@joe-AO722>
 <533BBA12.1040105@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1404020940280.2080@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 2 Apr 2014, SF Markus Elfring wrote:

> > The output is apparently correct and compilable.
> > It is just not kernel style.  I'm not sure there
> > is a defect really, just wanted to bring it up.
> >
> > Maybe the first transform could be better written.
>
> It seems that the shown differences in source code formatting come from your
> first semantic patch rule.
> Does your update suggestion fit to implementations of functions which had a
> non-void return type before?

The transformation makes no sense for a non-void return type.

The intent of Coccinelle is that the output should follow the Linux coding
guidelines.  The pretty printing, however, is fairly fragile and it looks
like this case has slightly degraded in some way, although the previous
generated code was not ideal either, due to the introduced newline.

julia
