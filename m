From: mmarek@suse.com (Michal Marek)
Date: Thu, 18 Feb 2016 22:10:54 +0100
Subject: [Cocci] [PATCH] coccinelle: bugon: reduce rule applicability
In-Reply-To: <1454522746-396-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1454522746-396-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <56C6335E.2010006@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 3.2.2016 v 19:05 Julia Lawall napsal(a):
> Rule r is only use in org or report mode, so only execute it in those
> cases.

I applied this and the previous three patches to kbuild.git#misc.

Thanks,
Michal
