From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 15 Jun 2017 22:33:37 +0200 (CEST)
Subject: [Cocci] Replacing suffix rules in make scripts?
In-Reply-To: <47632935-6b4f-aeec-2ced-11f5d2f8609b@users.sourceforge.net>
References: <020f8c95-fcaa-d47e-410b-7fb633fefa09@users.sourceforge.net>
 <9c2abe52-5ef9-62e0-26ab-f4fc69513257@users.sourceforge.net>
 <alpine.DEB.2.20.1706142255480.3610@hadrien>
 <47632935-6b4f-aeec-2ced-11f5d2f8609b@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1706152233080.3015@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 15 Jun 2017, SF Markus Elfring wrote:

> > If you have changed things, then perhaps you have caused the problem?
>
> I have found an approach for the adjustment of affected build scripts
> where I can improve the involved dependency specifications in a few
> subdirectories on my own to some degree.
> But I guess that a directory like ?parsing_cocci? provides bigger development
> challenges to make the dependencies safer there.
> I am curious on how a dependency for a software interface like ?Visitor_ast0_types?
> should be expressed for so many source files in a consistent way.

What problem are you trying to solve?  Why do the dependency
specifications need improving?

julia
