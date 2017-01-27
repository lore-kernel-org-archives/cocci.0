From: johannes@sipsolutions.net (Johannes Berg)
Date: Fri, 27 Jan 2017 17:13:04 +0100
Subject: [Cocci] modifying initializers with spatch?
In-Reply-To: <alpine.DEB.2.20.1701271408210.3117@hadrien>
References: <1485433691.14760.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261415040.3109@hadrien>
 <1485437521.14760.5.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261518560.3109@hadrien>
 <1485440882.14760.8.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261644140.3109@hadrien>
 <1485445951.14760.16.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701270807230.1935@hadrien>
 <1485507305.5851.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701271408210.3117@hadrien>
Message-ID: <1485533584.14579.1.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2017-01-27 at 14:11 +0100, Julia Lawall wrote:

> > Out of curiosity: will it require some form of "..." to match
> > something inside now?
> 
> No.

Ok.

> It considers that the rule writer has no knowledge or control of the
> field names that are provided or the order in which they appear, so
> you can specify any subset of them.??You only need ... when you want
> to add a new one at the beginning or at the end of the
> structure.??The ... lets you specify beginning or end.

Interesting. I thought I needed the ... at the end, but that may have
been a case of "let's see if I need both - doesn't work - remove one -
ok works now" :)

> I want to allow you to remove the {} only when all of the field
> initializations are also removed.??Some work though is required.

That'd make sense.

I'm very grateful for this. I'm dealing with an awful compiler that
emits stupid code for C99 initializers, so I'm thinking of using what
we were discussing here to remove them all at build time. I'm going to
be travelling (again) next week, but will give it a try later.

Thanks a lot!

johannes
