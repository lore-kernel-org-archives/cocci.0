From: wpengfeinudt@gmail.com (Pengfei Wang)
Date: Wed, 11 Jan 2017 21:44:00 +0800
Subject: [Cocci] [PATCH] coccicheck: add a test for repeat copy_from_user
In-Reply-To: <alpine.DEB.2.20.1701110708030.2396@hadrien>
References: <20160426222442.GA8104@www.outflux.net>
 <alpine.DEB.2.20.1612271916250.2001@hadrien>
 <d0289ec5-3ce2-f119-6876-e19dc1a5ccde@oracle.com>
 <05AE3A59-EF48-4FFF-A028-0204B2E56DEB@gmail.com>
 <4ba1f717-9ad8-687b-e31c-64e5f2ffcab1@oracle.com>
 <19545870-5238-4BEB-AF1E-741BA97A6AA2@gmail.com>
 <152a02a9-3a82-af69-0eac-8014494e76ec@oracle.com>
 <76D088EA-3C7E-4766-A237-3FA1F0767C1A@gmail.com>
 <alpine.DEB.2.20.1701110708030.2396@hadrien>
Message-ID: <09D4B047-4E54-4A3B-9EDB-B1F5E87A660B@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> ? 2017?1?11????2:12?Julia Lawall <julia.lawall@lip6.fr> ???
> 
> I looked at the get_user part of the original script.  It looks like most
> of the complexity is to deal with the possibility of the src location
> being expressed in two different ways between the two calls.  

Yes, in addition to pointer alias and the ?field-whole? double-fetch type 
as we mentioned previously, we also need to take into consideration of 
the explicit data type conversion of the src pointer, such as:
get_user(dst, src)
?
get_user(dst, (int*)src)

Also the embedded computation at the argument position, such as 
get_user(dst, ++src) , get_user(dst, align(src)), or get_user(dst, src[i]),
which could cause false positives. Loops also cause false positives.


> Even if this
> happens in practice only for get_user, it would seem that it could happen
> for copy_from_user as well.  So I think we could just throw both get_user
> and copy_from_user into the same rule?
> 
Agreed.

> I'm also not sure to understand why there are cases for things like
> 
> get_user(exp1, src->f1)
> ...
> get_user(exp2,src)
> 
> Can this happen?  The types seem wrong.
I think it is unreasonable. It doesn?t work in practice. It exists in my script 
because I combined different situations with disjunction but forgot to remove 
the infeasible ones. Please remove it. A practical one should be:
get_user(exp1, src->f1)
?
copy_from_user(exp2, src ,size)

> Likewise, I see the need to take into account a second argument of src++,
> but not the need to take into account a second argument of src+4.  Either
> there is src+4 in both calls or the addresses involved are just different.

src++ or src+4 are used when handling long messages byte by byte or word 
by word by means of a loop. I paid attention to these because they cause 
false positives as src pointers have changed for the double fetches. I remember 
both of these two situations when examining the source code but I cannot 
guarantee the src+4 situation exists as I don?t have an example in hand now. I suggest 
we focus on the src++ for now. If src+4 cause any false positives, we?ll add it, too.

Regards
Pengfei

> 
> Perhaps I'm missing something, though.
> 
> julia
> 
