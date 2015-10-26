From: mmarek@suse.com (Michal Marek)
Date: Mon, 26 Oct 2015 22:41:40 +0100
Subject: [Cocci] [PATCH 2/2 v2] coccinelle: ifnullfree: handle various
 destroy functions
In-Reply-To: <1445894906-28137-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1445894906-28137-2-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <562E9E14.4000901@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 26.10.2015 v 22:28 Julia Lawall napsal(a):
> Extend ifnullfree to the various destroy functions that were recently
> extended to tolerate NULL arguments.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied both to kbuild.git#misc, thanks.

Michal
