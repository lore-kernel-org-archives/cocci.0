From: mmarek@suse.cz (Michal Marek)
Date: Mon, 08 Apr 2013 15:52:42 +0200
Subject: [Cocci] [PATCH 1/4] Coccinelle: Restore coccicheck verbosity in
 ONLINE mode (C=1 or C=2)
In-Reply-To: <1362260188-14138-1-git-send-email-nicolas.palix@imag.fr>
References: <1362260188-14138-1-git-send-email-nicolas.palix@imag.fr>
Message-ID: <5162CBAA.5020506@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 2.3.2013 22:36, Nicolas Palix wrote:
> A recent patch have introduce the VERBOSE variable and comments
> now depend on it. However, the message printed for each cocci file
> such not be printed when the ONLINE mode is active, whatever is
> the value of VERBOSE.
> 
> Signed-off-by: Nicolas Palix <nicolas.palix@imag.fr>
> ---
>  scripts/coccicheck |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I applied these four to kbuild.git#misc.

Michal
