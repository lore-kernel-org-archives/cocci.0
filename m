From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 8 Nov 2012 08:21:09 +0100 (CET)
Subject: [Cocci] [Review needed] Ensure that calls to d_find_alias() are
 followed by dput().
In-Reply-To: <509B0B81.50304@gmail.com>
References: <509B0B81.50304@gmail.com>
Message-ID: <alpine.DEB.2.02.1211080820540.1945@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

How many cases do you find?

julia

On Thu, 8 Nov 2012, Cyril Roelandt wrote:

> Hello,
>
> After seeing this patch 
> http://permalink.gmane.org/gmane.linux.kernel.commits.head/348204 I tried to 
> write a semantic patch that ensures that a call to d_find_alias() is followed 
> by a call to dput().
>
> The attached patch seems to do that. I wrote it by copying the example found 
> in the "Reference counter: the of_xxx API" paragraph of the grammar. I 
> haven't played with Coccinelle in a while though, and I can't remember 
> exactly the semantics of the "exists" keyword and of the "<... ...>" and 
> "<+... ...+>". Could you enlighten me ?
>
> If the patch looks good to you, I'll send it to kernel-janitors (unless there 
> is a more approriate list for semantic patches) along with a few patches.
>
>
> WBR,
> Cyril Roelandt.
>
