From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 15 Jun 2017 20:13:36 +0200
Subject: [Cocci] Replacing suffix rules in make scripts?
In-Reply-To: <alpine.DEB.2.20.1706142255480.3610@hadrien>
References: <020f8c95-fcaa-d47e-410b-7fb633fefa09@users.sourceforge.net>
 <9c2abe52-5ef9-62e0-26ab-f4fc69513257@users.sourceforge.net>
 <alpine.DEB.2.20.1706142255480.3610@hadrien>
Message-ID: <47632935-6b4f-aeec-2ced-11f5d2f8609b@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> If you have changed things, then perhaps you have caused the problem?

I have found an approach for the adjustment of affected build scripts
where I can improve the involved dependency specifications in a few
subdirectories on my own to some degree.
But I guess that a directory like ?parsing_cocci? provides bigger development
challenges to make the dependencies safer there.
I am curious on how a dependency for a software interface like ?Visitor_ast0_types?
should be expressed for so many source files in a consistent way.

Regards,
Markus
