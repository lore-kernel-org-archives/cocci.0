From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 26 Oct 2015 22:36:02 +0100 (CET)
Subject: [Cocci] [PATCH 1/2] coccinelle: ifnullfree: improve and extend
 ifnullfree
In-Reply-To: <562E9BE3.5080004@suse.com>
References: <1445102605-22408-1-git-send-email-Julia.Lawall@lip6.fr>
 <56236C9A.8060906@users.sourceforge.net> <562E9BE3.5080004@suse.com>
Message-ID: <alpine.DEB.2.02.1510262235490.2079@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 26 Oct 2015, Michal Marek wrote:

> Dne 18.10.2015 v 11:55 SF Markus Elfring napsal(a):
> >> Remove removal and re-addition of freeing functions.
> > 
> > I find such a wording confusing for a commit message.
> 
> It is also a bit confusing to use the same subject for two patches in a
> series. How about
> 
> [PATCH 1/2] coccinelle: ifnullfree: Adjust tests to compare against NULL
> [PATCH 2/2] coccinelle: ifnullfree: handle various destroy functions

Sorry.  I'll send them again.

julia

> 
> ?
> 
> Michal
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
