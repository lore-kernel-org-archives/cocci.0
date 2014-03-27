From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 27 Mar 2014 19:43:18 +0100 (CET)
Subject: [Cocci] How to exclude volatile data accesses in expressions
 with SmPL?
In-Reply-To: <5334705A.9050303@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <53342A9C.9070406@users.sourceforge.net>
 <alpine.DEB.2.10.1403271907390.2088@hadrien>
 <5334705A.9050303@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1403271942390.2088@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 27 Mar 2014, SF Markus Elfring wrote:

> > I don't know if this would find much.  Intuitively, one might expect such
> > problems to be detected easily by testing or developers to know better in
> > thw first place, but who knows.
>
> I see the software development challenge in the analysis of the
> expression which is used in a condition check. Such an expression could
> be constructed out of several elements.
> I am still unsure on how a data type property like "volatile" can be
> safely determined by the semantic patch language for each used element.
> I would be able to specify a filter for a single element as you suggest.
> But is the combination of some elements more interesting for the general
> use case?

Coccinelle makes an effort to infer types.  YOu may need to use eg
--recursive-includes and --relax-include-path to get the most possible
type information.

julia
