From: mmarek@suse.cz (Michal Marek)
Date: Fri, 22 Feb 2013 11:25:04 +0100
Subject: [Cocci] [PATCH V2]
	scripts/coccinelle/misc/memcpy-assign.cocci:	Replace memcpy
	with struct assignment
In-Reply-To: <1358978790-2990-1-git-send-email-peter.senna@gmail.com>
References: <1358978790-2990-1-git-send-email-peter.senna@gmail.com>
Message-ID: <20130222102503.GD12402@pobox.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jan 23, 2013 at 08:06:30PM -0200, Peter Senna Tschudin wrote:
> There are error-prone memcpy() that can be replaced by struct
> assignment that are type-safe and much easier to read. This semantic
> patch looks for memcpy() that can be replaced by struct assignment.
> 
> Inspired by patches sent by Ezequiel Garcia <elezegarcia@gmail.com>
> 
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
> ---
> Changes from V1:
>  Updated commit message
>  Changed Confidence comment to High on the semantic patch

Applied to kbuild.git#misc, thanks.

Michal
