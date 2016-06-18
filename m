From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 18 Jun 2016 12:37:09 +0200 (CEST)
Subject: [Cocci] [PATCH v2 4/8] scripts: add glimpse.sh for indexing the
	kernel
In-Reply-To: <20160618012243.GD11948@wotan.suse.de>
References: <1466116292-21843-1-git-send-email-mcgrof@kernel.org>
 <1466116292-21843-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1606171129200.3164@hadrien>
 <20160617151052.GN11948@wotan.suse.de>
 <alpine.DEB.2.10.1606171732480.3164@hadrien>
 <20160618012243.GD11948@wotan.suse.de>
Message-ID: <alpine.DEB.2.02.1606181230460.2079@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Overall, idutils seems to be a good choice.  As compared to a grep based 
solution, it knows what is code, so it doesn't report on files where the 
words of interest only occur in comments.  As compared to glimpse, it 
knows that foo_bar is a single word.  Indexing is faster than with 
glimpse, and looking things up in the index is also slightly faster, even 
though Coccinelle needs to make multiple calls because it doesn't support 
complex formulas.  It does support regexps, which could perhaps be even 
faster, but since the running time currently is mostly under 1 second and 
often under .1 seconds, it probably doesn't matter.

julia
