From: mmarek@suse.com (Michal Marek)
Date: Sat, 1 Oct 2016 23:03:56 +0200
Subject: [Cocci] [PATCH] Coccinelle: limit memdup_user transformation to
 GFP_KERNEL case
In-Reply-To: <1474472919-12867-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1474472919-12867-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <57F024BC.30606@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 21.9.2016 v 17:48 Julia Lawall napsal(a):
> Memdup_user encapsulates a memory allocation with the flag GFP_KERNEL, so
> only allow this flag in the original code.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied to kbuild.git#misc.

Thanks,
Michal
