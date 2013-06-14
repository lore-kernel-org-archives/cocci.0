From: mmarek@suse.cz (Michal Marek)
Date: Fri, 14 Jun 2013 15:32:57 +0200
Subject: [Cocci] [PATCH 1/2] Coccinelle: Make 'report' the default mode
In-Reply-To: <1370554793-9152-2-git-send-email-nicolas.palix@imag.fr>
 <1370554793-9152-1-git-send-email-nicolas.palix@imag.fr>
Message-ID: <20130614133256.GA5402@sepie.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Jun 06, 2013 at 11:39:52PM +0200, Nicolas Palix wrote:
> It appears that the 'report' mode is the one always
> provided by the semantic patches included in the kernel.
> It is thus more natural to select it by default.
> 
> The 'chain' mode is however kept and the 'patch' mode
> is still the first tried in that case.
> 
> Signed-off-by: Nicolas Palix <nicolas.palix@imag.fr>

On Thu, Jun 06, 2013 at 11:39:53PM +0200, Nicolas Palix wrote:
> Add Michal Marek and the misc branch of the kbuild tree
> in the Coccinelle section of MAINTAINERS.
> 
> Signed-off-by: Nicolas Palix <nicolas.palix@imag.fr>

I applied both patches to kbuild.git#misc.

Thanks,
Michal
