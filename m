From: joe@perches.com (Joe Perches)
Date: Thu, 23 Jun 2016 12:12:57 -0700
Subject: [Cocci] [PATCH] Coccinelle: Add misc/boolconv.cocci
In-Reply-To: <20160623185352.25818-1-afd@ti.com>
References: <20160623185352.25818-1-afd@ti.com>
Message-ID: <1466709177.1847.19.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2016-06-23 at 13:53 -0500, Andrew F. Davis wrote:
> Add a script to check for unneeded conversions to bool.

this could also be extended for bool functions that:

	return !!expression;
and
	return expression != 0;
