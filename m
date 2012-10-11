From: mmarek@suse.cz (Michal Marek)
Date: Thu, 11 Oct 2012 14:51:40 +0200
Subject: [Cocci] Re: [PATCH] scripts/coccinelle/tests/odd_ptr_err.cocci:
 semantic patch for IS_ERR/PTR_ERR inconsistency
In-Reply-To: <1345927365-26814-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1345927365-26814-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20121011125140.GA16465@sepie.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Aug 25, 2012 at 10:42:45PM +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  scripts/coccinelle/tests/odd_ptr_err.cocci |   65 +++++++++++++++++++++++++++++

Looks like I missed this one. I applied it to kbuild.git#misc now.

thanks,
Michal
_______________________________________________
Cocci mailing list
Cocci at diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
