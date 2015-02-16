From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 16 Feb 2015 10:10:12 +0100 (CET)
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <fa1325f6cb734f9cb7b8dfc39054bdf8@BN1BFFO11FD021.protection.gbl>
References: <2bb2afa2a75f464b900af8506ddc84dd@BN1BFFO11FD029.protection.gbl>
 <alpine.DEB.2.10.1502141955040.6185@hadrien>
 <db4839c19266450b88ea802a7c5ab597@BL2FFO11FD013.protection.gbl>
 <alpine.DEB.2.02.1502151036100.2033@localhost6.localdomain6>
 <4f675e42e0b446d8829a42c5cc9a8dfd@BL2FFO11FD036.protection.gbl>
 <alpine.DEB.2.02.1502152207560.2278@localhost6.localdomain6>
 <88f4915b894e471aa3e551a6287e5d17@BY2FFO11FD031.protection.gbl>
 <alpine.DEB.2.02.1502152238270.2278@localhost6.localdomain6>
 <d20b2eea04ee429e9daa382827d052f8@BY2FFO11FD001.protection.gbl>
 <alpine.DEB.2.02.1502152254560.2278@localhost6.localdomain6>
 <fa1325f6cb734f9cb7b8dfc39054bdf8@BN1BFFO11FD021.protection.gbl>
Message-ID: <alpine.DEB.2.10.1502161009420.2609@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> With your help I did some more adjustments and my semantic patch replaces
> all the typedefed structs correctly, with a single exception. The sources
> contain one line like this:
>   static const foo_t const foo_arry[] = {

Could you check if things work when the [] is not empty?

julia

>   	...
>   };
> Similar as before, foo_t should be replaced with 'struct foo_t',
> but it's not.
>
> Again, some complex const usage, though this time I'm almost certain that
> the second const is meaningless. gcc consumes it, though, so does
> 'spatch --parse-c'.
>
> 	Soren
>
