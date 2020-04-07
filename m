Return-Path: <SRS0=i6Iw=5X=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B65C2BA1A
	for <cocci@archiver.kernel.org>; Tue,  7 Apr 2020 17:22:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6419D206C0
	for <cocci@archiver.kernel.org>; Tue,  7 Apr 2020 17:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UpqStN6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6419D206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 037HMcmC007721;
	Tue, 7 Apr 2020 19:22:38 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 890CC782B;
	Tue,  7 Apr 2020 19:22:38 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 50F367815
 for <cocci@systeme.lip6.fr>; Tue,  7 Apr 2020 17:50:20 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 037FoJxM004259
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 7 Apr 2020 17:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1586274608;
 bh=BZI6U+33BCxOnCVdE28ab0//2fZpUYxRTZDmA4+ws5g=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UpqStN6aLNBRWEpwqx88cN0FCsrqwqi0Oiw0dleghRLlIfGQwmfitkvVMSsigu1S+
 kFU2/kmfQ2uyGSwjYrhcoQDXdmX83YwIYKTbhVgFdfWNO0EnKo+H4woEARhzWzfU+Z
 v4os6Ofs+mJUnp8/2/Pw9DBfnzQ5e1iK99zUwUuo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from lenovo-laptop ([82.19.195.159]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS54-1itdXO0tFi-00kt6E; Tue, 07
 Apr 2020 17:50:08 +0200
Date: Tue, 7 Apr 2020 16:50:05 +0100
From: Alex Dewar <alex.dewar@gmx.co.uk>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <20200407155005.rdyiu7xqss57rzhq@lenovo-laptop>
References: <20200403173011.65511-1-alex.dewar@gmx.co.uk>
 <alpine.DEB.2.21.2004062115000.10239@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004062115000.10239@hadrien>
X-Provags-ID: V03:K1:3+/uYKcyqckCD21z5Oc92ud+jA0kA+TrKGQMzrR1eI7TLUaCYYA
 a7C1GCnuuU6+6Zqbu5xXJMNgU5wz4nW5X9OCgSCxt0Xs0S+CxLUghMWapkau4+FswwcbJ5C
 2MrWCZyxW+fpYQEy9l/H9+X54ehU9CxG3OjiJbQI8mKoMqVTVMcpZ8ftpyNzywyjiSrUyTD
 lMeVN5SdL57AXev69FA0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I4ElZ7o+piY=:PCIQOsUg9Jbxqznmt7mwxt
 +y8wZWkXIgHmHGg9aWshaEsrSyjTLCf+ssCrqG3C3alMVCsSO+SNrH7jzivlborXIA5r+zQTl
 OCvXK+ZO0G6wKiehVVHK97PGLFtx4uEPUVg2ePyBEekxJAHucyaTRfgdwogLLMvyRbeRphMwG
 HxiYv4sqMlXXTnW97aLwZR8cE0Bat0Knm7hJXoskqhFELyCtYTJyUO0MQDT3PfvP31pLT+cyI
 VYZmB9XCUTaKtDpq8Ln+iQa5/QIqhLI0BH6XVua1z4TTC84uR9Aiexz22OYUxSxrSA/mRI8gi
 8WsrdCMElSZZlT0GGldrjcXlBGfroqbB8XAPcbKIAssig64CZlseJ6pCZeLWT98AipYgIhk3/
 X59jvXPzKIjg0d7qmAd7OJfQUSCG8zWZjO5omIg7NOsZjm2k91ohTNHHyPDHs5QeCBcIh28X2
 U/PsYLsxTZHO5FsexY0VOpRc1WsA5zMEOFspryedKHMnqZA0Ur085SW5vL5ojYAtmg7nk1V09
 G9bNYYHoW9J5F+5d6sl1x50Nk4eMFnKch3jSypNrdMUsMpo6rLRAVjl1ebaWPfrUtD8VhTODo
 xhPunwOESSqn+LYUPzrdPxKTaNYkjgfBwaUGrcSryLd7X1oBjpKbp5s/guQoiaQYs2CCcpkR9
 yzEnu5MjAxvrxAGhZ/ApSiu20i0UnhivwalRqI77WWOZM0q9rWcBDDZ+26ola10A0Cd7i55Fg
 cexHNv94w0th7Va26mXq2yCV9vsLIgSHP5fhdXmp8nG/GBeYXgPrZLiNuawK/0USfvCM0SQ6W
 t0qt5dOmY1X+r34ZkOgxShTkSiLbrO5luh/RT9cfliFRwchSpxHWJnLACud4a4bKs++AwPu+s
 8QpbhpF7DSzKfu52nOPB7b/SgKFXiMI2TEoEgM8d++/XeJQ+H1hiASns9Aus/hXu/CBulVew+
 Glg//8y9N3JKKQNIND41iSCncjwTrV+++IFU33k3ErASPlo17VkAX0Xsn3kmBOAm9XaklDbCq
 E8DVbBeyy4cE58uwgyvUlEd9V3TjQXrPQha4vh49z512Pw3zYrVhVyp+OzmZUlr6GkIdv1asw
 uqddE3uxyZGOQGFgTgBcbE3sZPyObcjq1fJjqIpGfhMjVlGVuz/UOqU90deY09cbdSR3Df2f5
 isWIml7zPwIJltIxEC35ftebcmtafSZitf1JFdvdwqU54BsXZoBjuqPLlEYZelQasa7U6u8jh
 MNYYbaMeYQ9CDYf+B
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 07 Apr 2020 19:22:38 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 07 Apr 2020 17:50:19 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 07 Apr 2020 19:22:36 +0200
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, cocci@systeme.lip6.fr,
        Allison Randal <allison@lohutok.net>
Subject: Re: [Cocci] [PATCH] Coccinelle: zalloc_simple: Fix patch mode for
 dma_alloc_coherent()
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

On Mon, Apr 06, 2020 at 09:15:29PM +0200, Julia Lawall wrote:
>
>
> On Fri, 3 Apr 2020, Alex Dewar wrote:
>
> > Commit dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()"), in
> > removing dma_zalloc_coherent() treewide, inadvertently removed the patch
> > rule for dma_alloc_coherent(), leaving Coccinelle unable to auto-generate
> > patches for this case. Fix this.
> >
> > Fixes: dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()")
> > CC: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>
> > ---
> >  scripts/coccinelle/api/alloc/zalloc-simple.cocci | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> > index 26cda3f48f01..c53aab7fe096 100644
> > --- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> > +++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> > @@ -70,6 +70,15 @@ statement S;
> >  - x = (T)vmalloc(E1);
> >  + x = (T)vzalloc(E1);
> >  |
> > +- x = dma_alloc_coherent(E2,E1,E3,E4);
> > ++ x = dma_alloc_coherent(E2,E1,E3,E4);
>
> Hi,
>
> I don't understand the above case.  The before and after code seem to be
> the same?
>
> julia

Hi,

I just wanted to flag up unnecessary calls to memset() after
dma_alloc_coherent() and I wasn't sure how to best express that, though
I'm sure there's a much cleaner way. At the moment the cocci file only
gives warnings for this case, but it would be nice to be able to
autogenerate patches too.

Best,
Alex

>
>
> > +|
> > +- x = (T *)dma_alloc_coherent(E2,E1,E3,E4);
> > ++ x = dma_alloc_coherent(E2,E1,E3,E4);
> > +|
> > +- x = (T)dma_alloc_coherent(E2,E1,E3,E4);
> > ++ x = (T)dma_alloc_coherent(E2,E1,E3,E4);
> > +|
> >  - x = kmalloc_node(E1,E2,E3);
> >  + x = kzalloc_node(E1,E2,E3);
> >  |
> > --
> > 2.26.0
> >
> >
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
