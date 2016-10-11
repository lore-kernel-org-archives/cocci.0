From: mmarek@suse.com (Michal Marek)
Date: Tue, 11 Oct 2016 09:58:51 +0200
Subject: [Cocci] [PATCH] Coccinelle: flag conditions with no effect
In-Reply-To: <1475941905-8835-1-git-send-email-hofrat@osadl.org>
References: <1475941905-8835-1-git-send-email-hofrat@osadl.org>
Message-ID: <20161011075851.GB16035@sepie.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Oct 08, 2016 at 05:51:45PM +0200, Nicholas Mc Guire wrote:
> Report code constructs where the if and else branch are functionally
> identical. In cases where this is intended it really should be 
> documented - most reported cases probably are bugs.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Applied to kbuild.git#misc.

Thanks,
Michal
