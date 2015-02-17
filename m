From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 17 Feb 2015 21:31:39 +0100 (CET)
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <cce01af047524475b08dcc21781ce23f@BL2FFO11FD010.protection.gbl>
References: <db4839c19266450b88ea802a7c5ab597@BL2FFO11FD013.protection.gbl>
 <alpine.DEB.2.02.1502151036100.2033@localhost6.localdomain6>
 <4f675e42e0b446d8829a42c5cc9a8dfd@BL2FFO11FD036.protection.gbl>
 <alpine.DEB.2.02.1502152207560.2278@localhost6.localdomain6>
 <88f4915b894e471aa3e551a6287e5d17@BY2FFO11FD031.protection.gbl>
 <alpine.DEB.2.02.1502152238270.2278@localhost6.localdomain6>
 <d20b2eea04ee429e9daa382827d052f8@BY2FFO11FD001.protection.gbl>
 <alpine.DEB.2.02.1502152254560.2278@localhost6.localdomain6>
 <fa1325f6cb734f9cb7b8dfc39054bdf8@BN1BFFO11FD021.protection.gbl>
 <alpine.DEB.2.02.1502170754400.2079@localhost6.localdomain6>
 <cce01af047524475b08dcc21781ce23f@BL2FFO11FD010.protection.gbl>
Message-ID: <alpine.DEB.2.02.1502172131100.2306@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 17 Feb 2015, S?ren Brinkmann wrote:

> On Tue, 2015-02-17 at 07:56AM +0100, Julia Lawall wrote:
> > Another patch is below.  With this the code parses, and the transformation 
> > can be made.  However, it considers this to be a duplicate const 
> > annotation, so I'm not sure that the const is being associated in the 
> > right way by the parser.
> 
> I applied the patch. I do see the mentioned warning now:
>   Warning: PARSING: duplicate 'const'; value = [1]
> 
> The replacement still doesn't happen though. I'm not sure whether I
> need another rule to catch these declarations. But I think I will
> just make people fix their code. I think having 'const' appear twice
> is not right, despite it being parseable.

Could you send a complete example?  It worked in the example I tried.

julia
