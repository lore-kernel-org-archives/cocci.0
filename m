From: peff@peff.net (Jeff King)
Date: Sat, 25 Aug 2018 04:22:51 -0400
Subject: [Cocci] Excluding a function from Coccinelle transformation
In-Reply-To: <20d4a3cf-d7b6-81e6-25b0-94535795242b@users.sourceforge.net>
References: <20180824205349.GA31853@sigill.intra.peff.net>
 <20d4a3cf-d7b6-81e6-25b0-94535795242b@users.sourceforge.net>
Message-ID: <20180825082251.GA1672@sigill.intra.peff.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Aug 25, 2018 at 10:08:30AM +0200, SF Markus Elfring wrote:

> >> However, this can all be very expensive, because you are matching paths
> >> through the function definition which you don't really care about.
> >> All you care about here is the name.  So another approach is
> >
> > Yeah, it is. Using the pre-1.0.7 version, the original patch runs in
> > ~1.3 minutes on my machine. With "<... P ...>" it's almost 4 minutes.
> > Your python suggestion runs in about 1.5 minutes.
> >
> > Curiously, 1.0.4 runs the original patch in only 24 seconds, and the
> > angle-bracket one takes 52 seconds. I'm not sure if something changed in
> > coccinelle, or if my build is simply less optimized (my 1.0.4 is from
> > the Debian package, and I'm building 1.0.7 from source; ?
> 
> I guess that such run time comparisons are interesting for further software
> development considerations.
> 
> * How often would you run discussed SmPL scripts?

We run them as part of every automated CI build, and some people run
them manually periodically (I'd guess once every few days or so).

I don't think speed is critical for our use case. I mostly wanted to see
if the angle-bracket approach was intolerably slow (it's not, which
makes it an acceptable tradeoff against the need to have spatch built
with python support). And I found the speed difference between the two
versions mostly a curiosity.

-Peff
