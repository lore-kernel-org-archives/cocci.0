From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 26 Dec 2015 21:24:48 +0100 (CET)
Subject: [Cocci] [PATCH] coccinelle: api: check for propagation of error
 from platform_get_irq
In-Reply-To: <alpine.DEB.2.02.1512262107340.2070@localhost6.localdomain6>
References: <1451157891-24881-1-git-send-email-Julia.Lawall@lip6.fr>
 <567EF188.7020203@cogentembedded.com>
 <alpine.DEB.2.02.1512262107340.2070@localhost6.localdomain6>
Message-ID: <alpine.DEB.2.02.1512262123500.2070@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The conclusion seems to be that it is useful to override the value, so we 
can just drop this semantic patch.

julia
