From: peff@peff.net (Jeff King)
Date: Sun, 26 Aug 2018 02:36:49 -0400
Subject: [Cocci] Excluding a function from Coccinelle transformation
In-Reply-To: <20408ad4-672d-0b59-7f18-0c28bcf86adc@users.sourceforge.net>
References: <20180824205349.GA31853@sigill.intra.peff.net>
 <20d4a3cf-d7b6-81e6-25b0-94535795242b@users.sourceforge.net>
 <20180825082251.GA1672@sigill.intra.peff.net>
 <20408ad4-672d-0b59-7f18-0c28bcf86adc@users.sourceforge.net>
Message-ID: <20180826063649.GA7560@sigill.intra.peff.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Aug 25, 2018 at 12:23:11PM +0200, SF Markus Elfring wrote:

> > I don't think speed is critical for our use case. I mostly wanted to see
> > if the angle-bracket approach was intolerably slow (it's not,
> > which makes it an acceptable tradeoff against the need to have spatch
> > built with python support). And I found the speed difference between
> > the two versions mostly a curiosity.
> 
> I am curious if your software behaviour expectations will vary any more.
> Will the mentioned run time differences accumulate to more meaningful
> numbers over time?

Maybe. My plan is to cross that bridge when we come to it.

> Would you dare to take the application of the SmPL construct ?<+... ? ...+>?
> into account?
> http://coccinelle.lip6.fr/docs/main_grammar004.html

I don't know what you mean by "dare". Are you suggesting that the "<+"
form might solve my problem better?

-Peff
