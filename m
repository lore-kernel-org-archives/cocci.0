From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 17 Jul 2013 11:01:10 +0200 (CEST)
Subject: [Cocci] gboolean -> bool conversion
In-Reply-To: <51E65A19.6010903@monom.org>
References: <51DE6A05.9050008@monom.org>
 <alpine.DEB.2.02.1307111026390.2253@hadrien> <51DE75BF.3060207@monom.org>
 <51DE81CC.3010805@monom.org> <alpine.DEB.2.02.1307111221320.2253@hadrien>
 <51DE944F.1000903@monom.org> <alpine.DEB.2.02.1307111417120.2253@hadrien>
 <51DEA75C.10309@monom.org> <alpine.DEB.2.02.1307111451080.2253@hadrien>
 <51DFA84A.4050805@monom.org>
 <alpine.DEB.2.02.1307120858060.2013@localhost6.localdomain6>
 <51E556E8.2040701@monom.org> <alpine.DEB.2.02.1307161818580.2264@hadrien>
 <51E65A19.6010903@monom.org>
Message-ID: <alpine.DEB.2.02.1307171100000.2247@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I am still struggling with creating a rule for a prototype. Rereading examples
> and documentation.
>
> So I am only allowed to write a prototype (funproto, right?) in the
> declaration section (common_decl)? How do I write the rule?
>
> (I am really bad not getting this done by myself.)

Could you send your attempt?  It should be possible to write a function
prototype pattern just like any other pattern, but it is true that I
haven't done that very much, so it might be deficient in some way.

julia
