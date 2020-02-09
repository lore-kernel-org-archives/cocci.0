Return-Path: <SRS0=c99d=35=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22D6C2BA83
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 17:32:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EED120714
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 17:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEqTCp/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EED120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 019HWaWU016809;
	Sun, 9 Feb 2020 18:32:36 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C508A772F;
	Sun,  9 Feb 2020 18:32:36 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C532D7718
 for <cocci@systeme.lip6.fr>; Sun,  9 Feb 2020 18:32:35 +0100 (CET)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 019HWYhK019868
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 9 Feb 2020 18:32:35 +0100 (CET)
Received: by mail-pj1-x1044.google.com with SMTP id fa20so3139269pjb.1
 for <cocci@systeme.lip6.fr>; Sun, 09 Feb 2020 09:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=muhOcDUhhtnzARl4eJAvkNMAOOJ2WwTjwza3/x00Fkk=;
 b=oEqTCp/g/OQIlRmBXusWmJecD/S413NQ5zaNsXivUdkDqWHkr+UExoBupjpeSCN5Tj
 47fCXdNfRlJS+vkHt6FFSlN1ne28ir+D4Ywx/vxCeNZWz5F77YktPKM9PoC23jwj6/aI
 dVUaCdT59uyRo3Bu1rOVDCnPc7l0AgrXFPIiuLzaCSnBPMT/S8wDunHKtftqeunx3QRn
 tPYKr4DTjAXOHLfLLBIh7i8RFkjTxQawpBbXWYWKO4VgDK1Ngb12D/l6Q0YNifEQ4oYR
 whM6Loaf6jjw1kYO3EooPMlEe/3aUsSUIc2eLFFXrRoXnZ4xRNRpNMUUw+dGk3K72znW
 bVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=muhOcDUhhtnzARl4eJAvkNMAOOJ2WwTjwza3/x00Fkk=;
 b=XB+MLrNyNwqiCvPSst0YnP+Eww36daelCRbbbVAd2S4pu8g0x/B/67JHD7Hw28jN/u
 aJRD38z6sPx7KSV+Bd0esd9jjmDOjYvgf7T3jyMN9JUUswZU2PZs+AjPT+WJDoVeviqz
 48FmBBahdoncPBYZNEM/Z5Z+J+/SP4pINSXVARWW/hysbFr61SiZR8UjOqxhDuSAfRyp
 Y+evR39OHiL0lxyyRm2LYklQ/E82J9PjIub4GJ39M9T8NJID1gQ5ptKCwU+oyslaeGlp
 iKQb8CsSmFWsXOaZgEQgl6Nl/nHDrUZp0/ZbMMMh2OBsjGVWTtuZXHvsE1LVJauM8dOd
 Q7tA==
X-Gm-Message-State: APjAAAUEQGnA9v5w/Dz5ihHvnb1mdkh2XCM7QFsYzhGEjVVhJRRTasRl
 t8vnl0CY7OuBajhPMJrpkYg=
X-Google-Smtp-Source: APXvYqxUr+G8d913mnxkwX+GpkXa0MPq7T3JGKVu0EC76j5pA/aRcqWxrIqXKBQrVX+QOdNwEIxcQg==
X-Received: by 2002:a17:902:d705:: with SMTP id
 w5mr9148165ply.68.1581269553308; 
 Sun, 09 Feb 2020 09:32:33 -0800 (PST)
Received: from localhost.localdomain ([2405:204:22ac:7250:d1c8:6411:2f12:731d])
 by smtp.gmail.com with ESMTPSA id 64sm9674169pfd.48.2020.02.09.09.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2020 09:32:32 -0800 (PST)
Message-ID: <beb17020cc87be2d0e63edc0a897a4c0c2975b27.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Sun, 09 Feb 2020 23:02:25 +0530
In-Reply-To: <alpine.DEB.2.21.2002091747430.3430@hadrien>
References: <20200209153452.11837-1-jaskaransingh7654321@gmail.com>
 <20200209153452.11837-4-jaskaransingh7654321@gmail.com>
 <alpine.DEB.2.21.2002091747430.3430@hadrien>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 09 Feb 2020 18:32:37 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 09 Feb 2020 18:32:35 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v4 3/3] tests: Add test case to match const
 pointer variants
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

On Sun, 2020-02-09 at 17:48 +0100, Julia Lawall wrote:
> On Sun, 9 Feb 2020, Jaskaran Singh wrote:
> 
> > Pointer to const pointer and its variants would not match
> > previously.
> > Add a test case for matching these types.
> > 
> > Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> > ---
> >  tests/constptr.c     |  7 +++++++
> >  tests/constptr.cocci | 19 +++++++++++++++++++
> >  tests/constptr.res   |  7 +++++++
> >  3 files changed, 33 insertions(+)
> >  create mode 100644 tests/constptr.c
> >  create mode 100644 tests/constptr.cocci
> >  create mode 100644 tests/constptr.res
> > 
> > diff --git a/tests/constptr.c b/tests/constptr.c
> > new file mode 100644
> > index 00000000..13fe064c
> > --- /dev/null
> > +++ b/tests/constptr.c
> > @@ -0,0 +1,7 @@
> > +int main()
> > +{
> > +	const char * const * id;
> > +	const char * * const * id;
> > +	const char * const * * id;
> > +	const char * const id;
> 
> As far as I can see in the Linux kernel, there is no space between
> two *s,
> and there is no space before an identifier.
> 

Well, the test isn't replacing the type here. It's just replacing the
ident as per the matches. So I guess the spaces are preserved as in the
C file.
When replacing the type like say
-t x;
+t y;
Spaces are not added between the stars or the ident.

Sorry if I'm missing something. Do you mean that the C file/res file
should conform to the Linux style?

Cheers,
Jaskaran.

> julia
> 
> > +}
> > diff --git a/tests/constptr.cocci b/tests/constptr.cocci
> > new file mode 100644
> > index 00000000..29f0aa96
> > --- /dev/null
> > +++ b/tests/constptr.cocci
> > @@ -0,0 +1,19 @@
> > +@ r0 @
> > +identifier id;
> > +@@
> > +const char * const *
> > +- id
> > ++ id1
> > +;
> > +const char * * const *
> > +- id
> > ++ id2
> > +;
> > +const char * const * *
> > +- id
> > ++ id3
> > +;
> > +const char * const
> > +- id
> > ++ id4
> > +;
> > diff --git a/tests/constptr.res b/tests/constptr.res
> > new file mode 100644
> > index 00000000..0af4de9a
> > --- /dev/null
> > +++ b/tests/constptr.res
> > @@ -0,0 +1,7 @@
> > +int main()
> > +{
> > +	const char * const * id1;
> > +	const char * * const * id2;
> > +	const char * const * * id3;
> > +	const char * const id4;
> > +}
> > --
> > 2.21.1
> > 
> > 

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
