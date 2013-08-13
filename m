From: mmarek@suse.cz (Michal Marek)
Date: Tue, 13 Aug 2013 22:45:02 +0200
Subject: [Cocci] [PATCH v3] coccinelle: replace 0/1 with false/true in
 functions returning bool
In-Reply-To: <1376255112-22787-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1376071193-21146-1-git-send-email-linux@rasmusvillemoes.dk>
 <1376255112-22787-1-git-send-email-linux@rasmusvillemoes.dk>
Message-ID: <520A9ACE.7080809@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 11.8.2013 23:05, Rasmus Villemoes napsal(a):
> This semantic patch replaces "return {0,1};" with "return
> {false,true};" in functions returning bool.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> v2: Simplified script, and eliminate whitespace mangling at the same
> time. Thanks to Julia Lawall.
> 
> v3: Further improvements from Julia. In particular, it now also does
> header files.

Applied to kbuild.git#misc.

Michal
