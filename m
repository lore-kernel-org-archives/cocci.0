From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 4 Jul 2015 10:16:39 +0200 (CEST)
Subject: [Cocci] Various minor parsing bugs
In-Reply-To: <1435997618.363960.314982145.35E4A6A9@webmail.messagingengine.com>
References: <1434594839.2823366.298546905.56C27EC5@webmail.messagingengine.com>
 <alpine.DEB.2.10.1506231430140.2554@hadrien>
 <1435098813.2577840.305986601.7F5C26BA@webmail.messagingengine.com>
 <alpine.DEB.2.10.1506240934280.2553@hadrien>
 <1435201805.2992101.307114657.0D123073@webmail.messagingengine.com>
 <CAGbDTvr6DpQzjYktmTjBTYWGZYxNPBWtuW1qf5nFjCBzKxQ6Cw@mail.gmail.com>
 <1435997618.363960.314982145.35E4A6A9@webmail.messagingengine.com>
Message-ID: <alpine.DEB.2.02.1507041016040.2057@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I had seen --(un)defined in the "spatch --help" output, but without any
> description:
> 
>   --defined
>   --undefined
> 
> Julia, may I suggest the following text for these?
> 
>   --defined      <symbol> treat cpp symbol as defined in #ifdef
>   --undefined    <symbol> treat cpp symbol as undefined in #ifdef
> 
> If this minimal documentation had been in place, I might have been able
> to discover this functionality on my own.

Sure.  I'll update the help text.  Thanks for the suggestion.

julia
