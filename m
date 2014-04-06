From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 6 Apr 2014 12:57:51 +0200 (CEST)
Subject: [Cocci] spatch issue with C struct initialization
In-Reply-To: <1396770309.2151.4.camel@localhost.localdomain>
References: <1396513844.24348.13.camel@localhost.localdomain>
 <alpine.DEB.2.10.1404031216060.2090@hadrien>
 <1396531867.24348.27.camel@localhost.localdomain>
 <alpine.DEB.2.10.1404031618260.2090@hadrien>
 <1396535383.24348.38.camel@localhost.localdomain>
 <alpine.DEB.2.10.1404041317240.2088@hadrien> <53401ACD.8010004@redhat.com>
 <alpine.DEB.2.02.1404051717280.2029@localhost6.localdomain6>
 <1396770309.2151.4.camel@localhost.localdomain>
Message-ID: <alpine.DEB.2.10.1404061255350.2112@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Not being an expert on grammar, there is a chance this will work ?
>
>  initializer
>     : assignment_expression
>        | '{' initializer_list '}'
>        | '{' initializer_list ',' '}'
>        | ( type-name ) { initializer-list }
>        | ( type-name ) { initializer-list , }
>
> If you can point me to the code dealing with it, I can try to play with
> it a little bit.

I think I already tried the same thing.  The problem is that ( type-name )
is already buried deep within assignment_expression, for an ordinary cast,
so the parser doesn't know which rule to choose.

julia
