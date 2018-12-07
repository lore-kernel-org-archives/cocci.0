Return-Path: <SRS0=vlGS=OQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED82C07E85
	for <cocci@archiver.kernel.org>; Fri,  7 Dec 2018 17:52:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767D220838
	for <cocci@archiver.kernel.org>; Fri,  7 Dec 2018 17:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFw3STx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767D220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB7HqRex004876
          ; Fri, 7 Dec 2018 18:52:27 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E283876D6;
	Fri,  7 Dec 2018 18:52:26 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 305B076D4
 for <cocci@systeme.lip6.fr>; Fri,  7 Dec 2018 18:52:25 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB7HqOl2021628
 for <cocci@systeme.lip6.fr>; Fri, 7 Dec 2018 18:52:24 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A45E220882
 for <cocci@systeme.lip6.fr>; Fri,  7 Dec 2018 17:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544205143;
 bh=mNq4EDVtOfgRyUgD4uNiYC5TA/z+mXa3UXw+EmfxFYc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=mFw3STx7r6f1goqHJX37j0ZFNUTriVoM6X9bKZbELjIMTluJWDZIbi4mN93/e/sMA
 SbMGZbzKhfvy0fVKonmEeEX03Ak0jeJdJAqNZ76EJ4032ADhChZ08FcOLHDRSyoxNk
 tJWcARwS8Sno55Q/kW0CHXVXy9O3T5eb5Sb+3x8o=
Received: by mail-ot1-f53.google.com with SMTP id 40so4576623oth.4
 for <cocci@systeme.lip6.fr>; Fri, 07 Dec 2018 09:52:23 -0800 (PST)
X-Gm-Message-State: AA+aEWYpZcbppmZjMj1Hk+sBRdFJjbmzYlOovvx0xZTbFpBsV0bIJda5
 qgcJfmVT6g9ySQHD4MP3ojm1jmtFkHw4i8WJmak=
X-Google-Smtp-Source: AFSGD/WOuiLJCRLTVYLvr4NtOdOcqWYgY/U3zDBktqZOKquBpu4dxBL/Z+QYtG+GyZ/Q+xu7lI9kSQGt73iLpDGIGCo=
X-Received: by 2002:a9d:6c11:: with SMTP id f17mr1961641otq.38.1544205142997; 
 Fri, 07 Dec 2018 09:52:22 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXW9XmFAPbhiSsejhFZ+9me=kHc25A-Qk0e=CrCnkkFuhw@mail.gmail.com>
 <alpine.DEB.2.20.1812071837160.20798@hadrien>
In-Reply-To: <alpine.DEB.2.20.1812071837160.20798@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Fri, 7 Dec 2018 11:51:46 -0600
X-Gmail-Original-Message-ID: <CAOZdJXX-_cVVTdvird2amhKRD-ywDgCxJopwof4ZovjU2zS-Yw@mail.gmail.com>
Message-ID: <CAOZdJXX-_cVVTdvird2amhKRD-ywDgCxJopwof4ZovjU2zS-Yw@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Dec 2018 18:52:27 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 07 Dec 2018 18:52:24 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>, Timur Tabi <timur@kernel.org>
Subject: Re: [Cocci] Fatal error: exception File
 "engine/ctlcocci_integration.ml", line 361,
 characters 4-10: Assertion failed
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

On Fri, Dec 7, 2018 at 11:42 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
> Do you know which function in your C code causes the problem?  Does that
> function have some dead code?  You can try
>
> spatch --control-flow file.c

That revealed the line number of the problem.  It's a goto tag in a macro:

#define xxx(type, member) \
...
member##_done:                                                               \
...

I can work around this by temporarily commenting-out that line, since
my script doesn't care about its contents.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
