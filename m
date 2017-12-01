From: johannes@sipsolutions.net (Johannes Berg)
Date: Fri, 01 Dec 2017 19:02:58 +0100
Subject: [Cocci] Parse error with genl-const.cocci
In-Reply-To: <5c6cb44c-9e19-8cf2-8946-a9c0e08c3974@gmail.com>
 (sfid-20171201_185732_488308_017133DA)
References: <925f98d2-047f-785f-4162-21b53a77cd62@gmail.com>
 <1512116859.25588.4.camel@sipsolutions.net>
 <5c6cb44c-9e19-8cf2-8946-a9c0e08c3974@gmail.com>
 (sfid-20171201_185732_488308_017133DA)
Message-ID: <1512151378.25588.20.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2017-12-01 at 09:57 -0800, Remington Furman wrote:
> 
> Ok, I've rebuilt with 1.0.4, and it applied genl-const.cocci just
> fine.  But, later on my CPU was held at 100% for 29 minutes:

Yeah, known issue. Give it more time - that particular patch is
*really* slow. Yes, more than 29 minutes, on my system as well.

What I can recommend is that you remove things from copy-list that you
don't care about, e.g. bluetooth drivers if you don't need them,
certain wifi drivers you don't need, etc. (before running gentree.py)

johannes
