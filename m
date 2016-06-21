From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 22 Jun 2016 01:43:41 +0200
Subject: [Cocci] [PATCH v3 5/8] scripts: add Linux .cocciconfig for
	coccinelle
In-Reply-To: <alpine.DEB.2.02.1606212227200.2040@localhost6.localdomain6>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
 <1466536893-23355-6-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606212227200.2040@localhost6.localdomain6>
Message-ID: <20160621234341.GK25646@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jun 21, 2016 at 10:29:53PM +0200, Julia Lawall wrote:
[...]

> mkid -i C --output .id-utils.index
> 
> [...] Coccinelle searches for the index in the directory 
> on which it is working

Can you clarify if this is $PWD from which we spawn spatch or
the --dir, or the current directory that spatch is working on
at the moment.

  Luis
