From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 10 Jan 2017 19:28:39 +0100 (CET)
Subject: [Cocci] [RFC] coccicheck: add a test for repeat memory fetches
In-Reply-To: <20170109231323.GA89642@beast>
References: <20170109231323.GA89642@beast>
Message-ID: <alpine.DEB.2.20.1701101927070.1981@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2159
> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2257
> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2302
> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2342
> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2365
> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2406
> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2439
> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2491

Do you want the above results?  They have the form:

if (copy_from_user(&t, useraddr, sizeof(t)))

My reasoning was that there could be no problem here, because the size is
the size of the destination structure.  It doesn't depend on user level data.

julia
