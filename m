From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 2 Apr 2014 10:33:13 +0200 (CEST)
Subject: [Cocci] Clarification for source code style reformatting
In-Reply-To: <533BC1FE.9040206@users.sourceforge.net>
References: <1396374174.21529.93.camel@joe-AO722>
 <533BBA12.1040105@users.sourceforge.net>
 <alpine.DEB.2.10.1404020940280.2080@hadrien>
 <533BC1FE.9040206@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1404021031560.2080@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 2 Apr 2014, SF Markus Elfring wrote:

> > The intent of Coccinelle is that the output should follow the Linux coding guidelines.
>
> I would find it also useful to support other source code format styles.
> How do you think about corresponding configuration options for the
> pretty-printing functionality?

Sorry, I forgot to add that there is an option --smpl-spacing where the
result follows the format found in the semantic patch.

julia
