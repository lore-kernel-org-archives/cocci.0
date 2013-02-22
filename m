From: mmarek@suse.cz (Michal Marek)
Date: Fri, 22 Feb 2013 11:44:31 +0100
Subject: [Cocci] [PATCH] scripts/coccinelle: find constant additions
	that could	be bit ors
In-Reply-To: <1359821995-27910-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1359821995-27910-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20130222104431.GF12402@pobox.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Feb 02, 2013 at 05:19:55PM +0100, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Semantic patch (http://coccinelle.lip6.fr/) to check for constants that are
> added but are used elsewhere as bitmasks.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied to kbuild.git#misc.

Michal
