From: mmarek@suse.cz (Michal Marek)
Date: Sun, 9 Dec 2012 16:04:30 +0100
Subject: [Cocci] [PATCH] scripts/coccinelle/misc/warn.cocci: use WARN
In-Reply-To: <1351972929-7448-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1351972929-7448-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20121209150429.GA29236@pobox.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Nov 03, 2012 at 09:02:09PM +0100, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Use WARN(1,...) rather than printk followed by WARN(1).
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  scripts/coccinelle/misc/warn.cocci |  109 +++++++++++++++++++++++++++++++++++++

Applied to kbuild.git#misc, thanks.

Michal
