From: mmarek@suse.cz (Michal Marek)
Date: Fri, 08 Nov 2013 14:52:40 +0100
Subject: [Cocci] [PATCHv2] coccinelle: Add a script to find unnecessary
 ifs with no body
In-Reply-To: <alpine.DEB.2.02.1311021748590.2261@hadrien>
References: <20131102143236.GA18084@leaf>
 <alpine.DEB.2.02.1311021550330.2261@hadrien> <20131102151500.GW15704@leaf>
 <alpine.DEB.2.02.1311021748590.2261@hadrien>
Message-ID: <527CECA8.5030408@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 2.11.2013 17:49, Julia Lawall wrote:
>> + at r depends on report || context@
>> +expression E;
>> +position p;
>> +@@
>> +if at p (E) {}
> 
> There should be a * in front of the if, to support context mode.

Josh, will you send a v3 with the above fix?

Thanks,
Michal
