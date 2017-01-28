From: johannes@sipsolutions.net (Johannes Berg)
Date: Sat, 28 Jan 2017 10:16:00 +0100
Subject: [Cocci] position confusion?
In-Reply-To: <034eff0a-e9df-bf26-f9ac-5cb3cae7ae1b@oracle.com>
References: <1485558606.14579.15.camel@sipsolutions.net>
 <9d692cfd-f6a0-fef4-bcbb-84564e60beb5@oracle.com>
 <1485591488.4812.2.camel@sipsolutions.net>
 <034eff0a-e9df-bf26-f9ac-5cb3cae7ae1b@oracle.com>
Message-ID: <1485594960.4812.4.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

But assume I wanted to have p and q in different
> > positions, or whatever. Note that I didn't even *use* @p in the
> > rule,
> Got your point now. Just tried to solve the parsing error in the?
> previous mail. :)

:)
Although, had I known the "!= {a.p, b.p}" thing you pointed out to me,
then I never would've run into this parsing problem to start with :)
Thanks!

johannes
