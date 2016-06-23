From: afd@ti.com (Andrew F. Davis)
Date: Thu, 23 Jun 2016 14:22:13 -0500
Subject: [Cocci] [PATCH] Coccinelle: Add misc/boolconv.cocci
In-Reply-To: <1466709177.1847.19.camel@perches.com>
References: <20160623185352.25818-1-afd@ti.com>
 <1466709177.1847.19.camel@perches.com>
Message-ID: <576C36E5.9030909@ti.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 06/23/2016 02:12 PM, Joe Perches wrote:
> On Thu, 2016-06-23 at 13:53 -0500, Andrew F. Davis wrote:
>> Add a script to check for unneeded conversions to bool.
> 
> this could also be extended for bool functions that:
> 
> 	return !!expression;
> and
> 	return expression != 0;
> 

Agreed, it's in the works, I was going to post this current set with
some patches to the kernel that is detects, then add additional checks
and their kernel fixes incrementally.

For the second suggestion I think we could have additions to
boolinit.cocci that include the results of comparison/logical operations.

Thanks,
Andrew
