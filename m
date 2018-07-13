From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 13 Jul 2018 06:50:13 -0400 (EDT)
Subject: [Cocci] [PATCH 01/18] coccinelle: change strncpy+truncation to
 strlcpy
In-Reply-To: <20180713102103.GA12972@himanshu-Vostro-3559>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <20180713074455.GA6859@himanshu-Vostro-3559> <20180713080023.GB9638@nautica>
 <20180713091412.GA11250@himanshu-Vostro-3559>
 <alpine.DEB.2.20.1807130540270.3044@hadrien>
 <20180713102103.GA12972@himanshu-Vostro-3559>
Message-ID: <alpine.DEB.2.20.1807130647460.3063@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

For the file drivers/net/wireless/ti/wl1251/acx.c, the following keeps the
comment before the buf update and moves the strlcpy call below it.  It
does however drop the comment just before the original call to strncpy.

julia


@r@
expression dest, src;
expression f;
@@

- strncpy(dest,src,f);
  dest[f - 1] = '\0'
+ + strlcpy(dest,src,f)
  ;

@@
expression r.dest, r.src;
expression r.f;
@@

- dest[f - 1] = '\0' + strlcpy(dest,src,f);
+ strlcpy(dest,src,f);
