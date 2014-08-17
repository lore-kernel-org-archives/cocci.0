From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 17 Aug 2014 18:09:47 +0200
Subject: [Cocci] cocci: char* indexing style for linux
In-Reply-To: <1408280475.17489.4.camel@joe-AO725>
References: <1408219616.2683.101.camel@joe-AO725>
 <1408222763.2683.107.camel@joe-AO725>
 <alpine.DEB.2.10.1408170510420.2599@hadrien>
 <1408280475.17489.4.camel@joe-AO725>
Message-ID: <53F0D3CB.4000803@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> I would prefer to be able to convert
> 	*(skb->data + frame_size / 2 + 10)
> not to
> 	(skb->data + frame_size / 2)[10]
> but to
> 	skb->data[frame_size / 2 + 10]
>
> but I don't know how.

How do you think about a bit more fine-tuning for the desired semantic
patch?

Can it be that the pattern "*(foo + e)" is too generic for any source
code place?
Would you like to try out the specification of a few more elements
instead of a single expression here?

Regards,
Markus
