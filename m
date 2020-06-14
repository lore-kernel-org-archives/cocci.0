Return-Path: <SRS0=yQoC=73=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBEAC433DF
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 08:41:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698B620714
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 08:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JqhBI3Po"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698B620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05E8fQ16008321;
	Sun, 14 Jun 2020 10:41:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 828997828;
	Sun, 14 Jun 2020 10:41:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A3C4844A7
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 10:32:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05E8WnuF019538
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 10:32:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1592123567;
 bh=LOOr61he59OlknC29uNscWYrc+BGSU0yyhwDAC9Er3g=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=JqhBI3PoOxUvLjBdCtW9mPCU0GE5uJURlZZ3vJF25x+ScJaWnfTt9rkcYIuhiTRgn
 /MQII55WmAmEuGJ5OA9+kamwGY/I7FwY9dNUKpkzDo40SACo/PebJo1yVQ3dCpNFbC
 MoRLWAieAu6cAmwMogRYgflWphmfO3RwT+OgZ4XY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.221.151.23]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bfw-1iqdFI3gcw-0184ka; Sun, 14
 Jun 2020 10:32:46 +0200
Message-ID: <1592123565.2129.21.camel@gmx.de>
From: Mike Galbraith <efault@gmx.de>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Sun, 14 Jun 2020 10:32:45 +0200
In-Reply-To: <1592122310.2129.14.camel@gmail.com>
References: <b14e6d1d-afa0-5c28-547a-9bb1a987f6fd@infradead.org>
 <1592115803.27290.33.camel@gmail.com>
 <alpine.DEB.2.22.394.2006140940000.2849@hadrien>
 <1592121432.2129.9.camel@gmail.com> <1592121650.2129.11.camel@gmail.com>
 <1592122310.2129.14.camel@gmail.com>
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
X-Provags-ID: V03:K1:COkShJHs0QeZdJW+kIQFBq7Yb8+3TAqUXROrJW0pFjaSM8Wb2Dc
 9bfsZ7dh/ZxweELgb2eUfOfwnt+m6al2B14s3gm0aDsVqcE9Z8ns6XHlhO1fMMpasX7sG42
 eCHaWamN4B8ipg+8XirfLzpNwfWeJi+jD/g3uTOSftAvxCsNl3NiQiwe/ithUbVPGmU+JL+
 rrffd+jZIPrdTKpKZnb7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/yRnXQ4I/tg=:wQNHGkTyyhQgte2wiYhq9L
 jdEGkAHzCDIENWE0VQol0z/i7wNgapA/FPd7aK7qwuW8XQx/tC9f5+v2HbpfoUcgbDbNdAEg/
 OBmS+MB9VRCDdvVOFgz2k0AC38I8rBEq/jmWRWSnqeNYVKz6F6GH1W6fObr7CIGlL4F35FhMo
 qMdfzeoknsonww3socLHE6dzLlR1I3pxMf9Ip3j3Yt0FJQNp6FQxHxS9+lfuhIsrZewKi2YYT
 lKXMRSTgmnoHCU7LXfrzaRUcDoehyc3NxB725lZ0ee49FbEk7MMhMf/mUBwZDvqmoIWpAqPYT
 pvfgZQrm1nxHro2NgjplOcKXK1xcaIrAlpiXjeTC+UUXHFwNgfTITFC3U814TLO2CnuRjYbEP
 1jC9DYN3Whwt9TVFAqQZMMk8W6E4CjRO1RzLdNLDX8nVyj5muU8yJV+WA7Ayo0ZMjboNFUVOy
 apxBbViM+DX708DdSSXF4JcsNfUgtbtfisAPzknzv4idZZX/OEUJMmdgdz60K2Nx28uKunsZJ
 5eXDLOpezb5lPu3e38oD3wuLX1PTyJ7SKd1GYlSslWJ5i7JAwaR/kA2O6QaXxYFuoe6dfCRla
 w0AqoIcSzOTCbLKbBLoYYUql+xVufdkwL1mOc0dubRc+0dKoUIZZTEtqJ1I9IBWcfk1dt0FxL
 QA5XtxeS6LwK1z1zZsq7i05ByWcCHqEFmcQzuSwLTc5N/K7wFNH+QYOEjxwAIFX2moUf40uZx
 aMfQUOUh+YTtuhcLRufHsaSqbr8BBDbk7Azx80ozn7RbOuN3Z+CeFbqUACRuUBTs2Z2QTTSv4
 RfHcFOwK1XJquDyYPqaD9noXIeFjfbGUt5yrTtDdD3a6xCGqmD7oB/psplU5kL1mJl/Xbts4a
 cDQf2RO0bROaOQqQQAT2X31FPwLX9GKsB2AkzdxP0jfXWk/Lsk0St/TdhbU1uaQHciVucQ42D
 wDWrm1E+NUlWp6Gg6ghbEcq4vi2XRDuf9qMLuowFJ6FKtrCIpMXttUUdRNrOt18l+YFQj75Bw
 9qa9iyQQpG/VO/NNLfxYBsU+hJ91ObPBSliiP/my1L2ClnXrEtwZq9ewebbtM72D5j0wHqz0m
 aODeEtkO8sim/27Jaz7Ln6rMhB/r1JzfNBrFIW0nzhgxjDEe5WDk4F/I7fCJw6Czrz2nMtTF8
 ssAbUwY3Iof1XKecOYqkSKSM3yQ8AZRQZchxcnzKWX4ns1f1lZAEXTY2ioEQacjSZ1QJ1jRUO
 FNrOEZ3+v/Mr0H84j
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 14 Jun 2020 10:41:28 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 14 Jun 2020 10:32:49 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 14 Jun 2020 10:41:23 +0200
Cc: Randy Dunlap <rdunlap@infradead.org>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] coccinelle issues
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


Aha, trying a fresh build/install of 1.0.7 reproduced Randy's problem..

/usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/api/alloc/alloc_cast.cocci --no-includes --include-headers --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 8 --chunksize 1
Python error: No module named coccilib.elems

..and creating /usr/local/coccinelle/lib -> /usr/local/coccinelle/lib64
fixed it up for me.

Note: I configured --prefix=/usr/local/coccinelle to keep things
contained, and added a couple symlinks in /usr/local/bin for the
binaries.

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
