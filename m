From: jesse.brandeburg@intel.com (Jesse Brandeburg)
Date: Mon, 4 Dec 2017 10:05:46 -0800
Subject: [Cocci] BUG: possible parsing issue
In-Reply-To: <alpine.DEB.2.20.1712020913040.2168@hadrien>
References: <253CF818969A9240AB2054BF91F2C2BC74A93A70@ORSMSX114.amr.corp.intel.com>
 <alpine.DEB.2.20.1712020913040.2168@hadrien>
Message-ID: <20171204100546.000045ab@intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 2 Dec 2017 09:14:23 +0100
Julia Lawall <julia.lawall@lip6.fr> wrote:

> > - LIST_FOR_EACH_ENTRY(c,f,g,member) S
> > + hlist_for_each_entry(c,f,member) S  
> 
> Actually, the problem is that you have removed S and dded it back.
> Then you are relying on Coccinelle to do the pretty printing, and all
> comments will be dropped.  Just rewrite your rule as follows, and
> everything will be fine:
> 
>  - LIST_FOR_EACH_ENTRY(c,f,g,member)
>  + hlist_for_each_entry(c,f,member)
>    S

Wow, thanks for that, it now works. The discussion following this post
was also very educational.  Thanks!
