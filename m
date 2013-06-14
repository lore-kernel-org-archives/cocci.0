From: mmarek@suse.cz (Michal Marek)
Date: Fri, 14 Jun 2013 15:34:01 +0200
Subject: [Cocci] [PATCH] scripts/coccinelle: check for field address
 argument to kfree
In-Reply-To: <1370708502-21907-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1370708502-21907-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20130614133401.GB5402@sepie.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Jun 08, 2013 at 06:21:42PM +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> The argument to kfree should not be the address of a structure field.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied to kbuild.git#misc.

Thanks,
Michal
