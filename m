From: mmarek@suse.cz (Michal Marek)
Date: Wed, 15 Apr 2015 14:22:27 +0200
Subject: [Cocci] [PATCH V2 linux-next]
 scripts/coccinelle/misc/bugon.cocci: update bug_on conversion warning
In-Reply-To: <1428613084-2861-1-git-send-email-fabf@skynet.be>
References: <1428613084-2861-1-git-send-email-fabf@skynet.be>
Message-ID: <552E5803.6050902@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 2015-04-09 22:58, Fabian Frederick wrote:
> if()/BUG conversion to BUG_ON must be avoided when there's side effect
> in condition. The reason being BUG_ON won't execute the condition when CONFIG_BUG
> is not defined.
> 
> Inspired-by: J. Bruce Fields <bfields@fieldses.org>
> Suggested-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Acked-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
> V2: s/condition/the condition/

Applied to kbuild.git#misc.

Michal
