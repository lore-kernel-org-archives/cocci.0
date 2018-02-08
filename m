From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 8 Feb 2018 16:53:50 +0300
Subject: [Cocci] [PATCH] scripts/coccinelle/misc/shift.cocci: detect <
 or > that should be a shift
In-Reply-To: <1518094434-12852-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1518094434-12852-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20180208135350.e4yljburdpq7f5ny@mwanda>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Feb 08, 2018 at 01:53:54PM +0100, Julia Lawall wrote:
> This checks for a comparison using < or > between two constants,
> considering both explicit constants (1, 2, etc) and macros defined
> with #define.  False positives are possible in the latter case, when
> a macro may have multiple possible definitions and it is indeed
> necessary to check the value.  There are currently two such false
> positives, in drivers/net/ethernet/chelsio/cxgb3/sge.c:
> 
>        q->fl[0].use_pages = FL0_PG_CHUNK_SIZE > 0;
>        q->fl[1].use_pages = FL1_PG_CHUNK_SIZE > 0;
> 

We could eliminate both these false postives by ignoring >> vs >.  Did
searching for > actually find any bugs?  I think you were right that
right shifting a constant is way less common than left shifting and I
have some smatch scripts where I ignore right shifting bugs.

On the other hand, two false positives are not a big deal.

regards,
dan carpenter
