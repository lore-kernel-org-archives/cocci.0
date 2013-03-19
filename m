From: eric@regit.org (Eric Leblond)
Date: Tue, 19 Mar 2013 17:16:17 +0100
Subject: [Cocci] Have coccinelle follow typedef ?
Message-ID: <1363709777.30419.20.camel@tiger2>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I've got the following construction in a code:
 typedef struct Packet_ {
	struct Flow_ * flow;
 } Packet;
and in an other include file:
 typedef struct Flow_ {
	...	
 } Flow;

My problem here is that if p is a Packet then p->flow is a Flow at least
from a developer point of view. But coccinelle is not detecting the
match "Flow f" do not match on a "p->flow".

I've thought about adding a new isomorphism to solve this but I don't
like the idea...

How could I fix this issue ? 

BR,
-- 
Eric Leblond <eric@regit.org>
Blog: https://home.regit.org/
