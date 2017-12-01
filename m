From: johannes@sipsolutions.net (Johannes Berg)
Date: Fri, 01 Dec 2017 20:39:23 +0100
Subject: [Cocci] Parse error with genl-const.cocci
In-Reply-To: <alpine.DEB.2.20.1712011954500.2825@hadrien>
References: <925f98d2-047f-785f-4162-21b53a77cd62@gmail.com>
 <1512116859.25588.4.camel@sipsolutions.net>
 <5c6cb44c-9e19-8cf2-8946-a9c0e08c3974@gmail.com>
 (sfid-20171201_185732_488308_017133DA)
 <1512151378.25588.20.camel@sipsolutions.net>
 <alpine.DEB.2.20.1712011954500.2825@hadrien>
Message-ID: <1512157163.25588.22.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2017-12-01 at 19:57 +0100, Julia Lawall wrote:

> You can also set a timeout, for example --timeout 120 (120 seconds).  It
> will report on the files that timed out and you can check on them
> manually.  Some other useful options are:

Right, but the result won't compile if you do that and it doesn't
modify some files :-)

> --profile: see how long it spends in each rule or various parts of the
> OCaml code
> 
> --show-trying: see what function it is working on
> 
> --debug see what rule and with what inputs it is working on

I guess I should play with these and figure out why this particular
spatch is so slow, thanks for the pointers!

johannes
