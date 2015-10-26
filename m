From: mmarek@suse.com (Michal Marek)
Date: Mon, 26 Oct 2015 22:39:50 +0100
Subject: [Cocci] [PATCH] cocinelle: iterators: semantic patch to delete
 unneeded of_node_put
In-Reply-To: <1445544719-11953-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1445544719-11953-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <562E9DA6.1040702@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 22.10.2015 v 22:11 Julia Lawall napsal(a):
> Device node iterators perform an of_node_put on each iteration, so putting
> an of_node_put before a continue results in a double put.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied to kbuild.git#misc, thanks.

Michal
