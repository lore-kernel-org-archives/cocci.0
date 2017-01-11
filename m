From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 11 Jan 2017 07:12:53 +0100 (CET)
Subject: [Cocci] [PATCH] coccicheck: add a test for repeat copy_from_user
In-Reply-To: <76D088EA-3C7E-4766-A237-3FA1F0767C1A@gmail.com>
References: <20160426222442.GA8104@www.outflux.net>
 <alpine.DEB.2.20.1612271916250.2001@hadrien>
 <d0289ec5-3ce2-f119-6876-e19dc1a5ccde@oracle.com>
 <05AE3A59-EF48-4FFF-A028-0204B2E56DEB@gmail.com>
 <4ba1f717-9ad8-687b-e31c-64e5f2ffcab1@oracle.com>
 <19545870-5238-4BEB-AF1E-741BA97A6AA2@gmail.com>
 <152a02a9-3a82-af69-0eac-8014494e76ec@oracle.com>
 <76D088EA-3C7E-4766-A237-3FA1F0767C1A@gmail.com>
Message-ID: <alpine.DEB.2.20.1701110708030.2396@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I looked at the get_user part of the original script.  It looks like most
of the complexity is to deal with the possibility of the src location
being expressed in two different ways between the two calls.  Even if this
happens in practice only for get_user, it would seem that it could happen
for copy_from_user as well.  So I think we could just throw both get_user
and copy_from_user into the same rule?

I'm also not sure to understand why there are cases for things like

get_user(exp1, src->f1)
...
get_user(exp2,src)

Can this happen?  The types seem wrong.

Likewise, I see the need to take into account a second argument of src++,
but not the need to take into account a second argument of src+4.  Either
there is src+4 in both calls or the addresses involved are just different.

Perhaps I'm missing something, though.

julia
