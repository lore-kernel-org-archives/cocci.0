From: mmarek@suse.cz (Michal Marek)
Date: Thu, 15 Aug 2013 17:25:35 +0200
Subject: [Cocci] [PATCH] scripts/coccinelle/misc/warn.cocci: use WARN
In-Reply-To: <1376313683-32276-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1376313683-32276-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <520CF2EF.8080000@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 12.8.2013 15:21, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Use WARN(1,...) rather than printk followed by WARN(1).
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  scripts/coccinelle/misc/warn.cocci |  109 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)

Hi Julia,

this has been in mainline since v3.8-rc1 as commit ad99ac2.

Michal
