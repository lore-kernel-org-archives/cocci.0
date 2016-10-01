From: mmarek@suse.com (Michal Marek)
Date: Sat, 1 Oct 2016 23:04:07 +0200
Subject: [Cocci] [PATCH] Coccinelle: pm_runtime: ensure relevance of
 pm_runtime reports
In-Reply-To: <1474532935-22506-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1474532935-22506-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <57F024C7.7050503@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 22.9.2016 v 10:28 Julia Lawall napsal(a):
> pm_runtime.cocci starts with one rule that searches for a variety of
> functions calls, followed by various rules that report errors.  Previously,
> the only connection between the first rule and the rest was to check that
> the first rule had matched somewhere.  Change the rules to propagate a
> position from the first rule to the others, to make sure that the sites
> reported on are the same as the sites that were identified as having the
> relevant functions.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied to kbuild.git#misc.

Thanks,
Michal
