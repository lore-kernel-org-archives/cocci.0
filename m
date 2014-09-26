From: mmarek@suse.cz (Michal Marek)
Date: Fri, 26 Sep 2014 13:43:10 +0200
Subject: [Cocci] [PATCH v2] coccinelle: misc: semantic patch to delete
	overly	complex return code processing
In-Reply-To: <1408772085-28818-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1408772085-28818-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20140926114309.GA31096@pobox.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Aug 23, 2014 at 07:34:45AM +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> This semantic patch simplifies cases where the effect of the processing of
> a function call's return code is just to return the result of the function
> directly.  It may also delete a local return flag variable, if this is no
> longer used.
> 
> This was proposed by Uwe Kleine-K?nig.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied to kbuild.git#misc, thanks.

Michal
