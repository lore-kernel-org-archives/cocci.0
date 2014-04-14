From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 14 Apr 2014 16:35:30 +0200 (CEST)
Subject: [Cocci] Road map after Coccinelle 1.0.0-rc21?
In-Reply-To: <534BF121.40607@users.sourceforge.net>
References: <alpine.DEB.2.10.1404141356250.2601@hadrien>
 <534BDDD6.9070407@users.sourceforge.net>
 <alpine.DEB.2.10.1404141525370.2572@hadrien>
 <534BE66B.8060907@users.sourceforge.net>
 <alpine.DEB.2.10.1404141622020.2591@hadrien>
 <534BF121.40607@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1404141634180.2591@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 14 Apr 2014, SF Markus Elfring wrote:

> > Nothing is planned for the handling of regular expressions.
>
> How does this feedback fit to your response for a "regexp problem" on March 7th?

OK, I will look into the abstract value problem as well.

There was some proble about really huge regular expressions, which I think
must be a library problem, not a Coccinelle problem, so I don't plan to do
anything about it.

julia
