Return-Path: <SRS0=Y/+4=CA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1786C433DF
	for <cocci@archiver.kernel.org>; Sat, 22 Aug 2020 07:08:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 627E120724
	for <cocci@archiver.kernel.org>; Sat, 22 Aug 2020 07:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vt-edu.20150623.gappssmtp.com header.i=@vt-edu.20150623.gappssmtp.com header.b="ZLiF4nKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627E120724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07M785SA003238;
	Sat, 22 Aug 2020 09:08:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 386B6758C;
	Sat, 22 Aug 2020 09:08:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 64EB33F6C
 for <cocci@systeme.lip6.fr>; Sat, 22 Aug 2020 05:35:43 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:72c])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07M3Zfn5027752
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 22 Aug 2020 05:35:42 +0200 (CEST)
Received: by mail-qk1-x72c.google.com with SMTP id x69so3160520qkb.1
 for <cocci@systeme.lip6.fr>; Fri, 21 Aug 2020 20:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vt-edu.20150623.gappssmtp.com; s=20150623;
 h=sender:from:to:cc:subject:in-reply-to:references:mime-version
 :content-transfer-encoding:date:message-id;
 bh=KG6D35LrETrIbEfRR6i8e5kjQoSsAlfAd76Negglopk=;
 b=ZLiF4nKTa6K1HQaBpXgSIFMMvGzHJi8jg30bu8smasWga6F6Z6Dp/z48oYS+prRwEL
 j91ry5qS9XZJsCmKuR0SiRVobdT73zx55YSa01bGbr35MgE40OO0yjBa4C0nVAUpIqCa
 dCzOwPEUo6ug+qKL++tJRdAfIf0ARwvMUC9aF+LVLfYQsOJGF4OwXNu+UY20YhvfHndb
 POpJoYvGm2z1DGNwoSYJe1XWaDa1zTonVDmD+/T9dH1NlLgIUCRKkivCaUGd3qmnyn1H
 KNKTsIHJ9OR+ijbYH+Oxw37DIcwj+Ro6f/A+TZysAycsp51Sp+/rKKFiwI+scuouCpSQ
 J0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
 :mime-version:content-transfer-encoding:date:message-id;
 bh=KG6D35LrETrIbEfRR6i8e5kjQoSsAlfAd76Negglopk=;
 b=Zuszf2R0CUdiC1rf69Qoxh2LT8v0TAUNorNRaOnGJZrWj2f+RNUUztN6oMx3AEx/AA
 knZ5z4u3jU5lSDUInQgt/tbjmSbCyXB1eTEe3kjwKWkp3FVx8535pncG0QU/QytcKssL
 UY0dOLh6LK1LuuwL2Y73eFsPRukJ78k0ScfPZ4D6dqWE6lKvde89sdAJiMOsHBmM5uD0
 Nzh44gH7VEvOJnLtHrXBWyFf2BvYhcVRcgRYAzIECzCLFDXkgK6kr0PNQzLANil770M3
 7IFhE9SxTe54eJWkjAMeIbLiSGGYmLhi8OjRgO8aN7dBOrJAjlqRbMbsNCtA7qnTBweD
 c1Bw==
X-Gm-Message-State: AOAM533RNB+18VBLwzOxaYqiy0GzANomZ/BTBnbzdnQlX6k7Gb9XPqjO
 JSelwI57enjUJvqfLrQUeIuVIQ==
X-Google-Smtp-Source: ABdhPJyXiMG8R/vxxpTmr6jwH49uQw4sDsejPXcgr60otWQbrUaOArpxK+wbVrBg76CIxpKdyIKIUA==
X-Received: by 2002:a05:620a:128e:: with SMTP id
 w14mr5216948qki.97.1598067341235; 
 Fri, 21 Aug 2020 20:35:41 -0700 (PDT)
Received: from turing-police ([2601:5c0:c000:a8c1::359])
 by smtp.gmail.com with ESMTPSA id w44sm4481201qtj.86.2020.08.21.20.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 20:35:39 -0700 (PDT)
From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks"
 <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To: Joe Perches <joe@perches.com>
In-Reply-To: <744af177c09f8ce22c99d6e1df458bced558518b.camel@perches.com>
References: <20200818184107.f8af232fb58b17160c570874@linux-foundation.org>
 <3bf27caf462007dfa75647b040ab3191374a59de.camel@perches.com>
 <b0fd63e4b379eda69ee85ab098353582b8c054bb.camel@perches.com>
 <alpine.DEB.2.22.394.2008201021400.2524@hadrien>
 <a5713d8597065ef986f780499428fcc4cd31c003.camel@perches.com>
 <alpine.DEB.2.22.394.2008201856110.2524@hadrien>
 <744af177c09f8ce22c99d6e1df458bced558518b.camel@perches.com>
Mime-Version: 1.0
Date: Fri, 21 Aug 2020 23:35:38 -0400
Message-ID: <162653.1598067338@turing-police>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 22 Aug 2020 09:08:05 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 22 Aug 2020 05:35:42 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Sat, 22 Aug 2020 09:08:03 +0200
Cc: Giuseppe Scrivano <gscrivan@redhat.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolons (was Re:
	[PATCH] checkpatch: Add test for comma use that should be semicolon)
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
Content-Type: multipart/mixed; boundary="===============0276947390=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0276947390==
Content-Type: multipart/signed; boundary="==_Exmh_1598067338_2109P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1598067338_2109P
Content-Type: text/plain; charset=us-ascii

On Fri, 21 Aug 2020 18:08:08 -0700, Joe Perches said:
> (forwarding on to kernel-janitors/mentees and kernelnewbies)
>
> Just fyi for anyone that cares:
>
> A janitorial task for someone might be to use Julia's coccinelle
> script below to convert the existing instances of commas that
> separate statements into semicolons.

Note that you need to *really* check for possible changes in semantics.
It's *usually* OK to do that, but sometimes it's not...

for (i=0; i++, last++; !last) {

changing that comma to a ; will break the compile.  In other cases, it can
introduce subtle bugs.

> > I do appreciate that coccinelle adds braces for multiple
> > expression comma use after an if.
> >
> > i.e.:
> > 	if (foo)
> > 		a = 1, b = 2;
> > becomes
> > 	if (foo) {
> > 		a = 1; b = 2;
> > 	}

Yeah.  Like there, if you forget to add the {}.

--==_Exmh_1598067338_2109P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBX0CSigdmEQWDXROgAQKNCQ/8DDgTmFpZiCAqadYFLPHzj4cazPnhAUXW
F7pYc//dQ403pifqc84z6kGRQsocCpaXTMRzYfSe/EMYP/oCLxYr+qvbG2UJg1qs
ltyI+7Z3UY0lz/OxBmzwm+/QmCc5YHpEZ+eK4zmQwgP4KfgjD8BDrraWqAueAHi2
mOBcWxQ2/KcYwN4dvDJ3ESRJyiws6KOfCe4a216h1mpc+u94zgmRUkUXBxVNZQB+
Ew3a+GI5cLTAXt9JbSrakXqoj/sH9+GqJnJ1T0flu/mBhs5gRRXDmcfoEDgxUeJQ
T+5Yunwj00vqcCql+G6jOaLvBcPnxI2xx7UaOIzl3JO+4wQZOjj6JC3EJjpLYtLL
RZGwHt/35XSJV6Tci/tAE/5H7twYwhig68ChnuGAOgxm2yg1sUxpKdgl/K6u+qOs
xIzp1f66xWljUPSx7xJxxc1445gd1I6udjeY8tUP2wVLlUseD4L2JwJInRvfufy5
7dN3nTy4e1s3Vu5P6CK4PntJagNPNm83EQtBk9a0A3skoPZyADW1UUCPRhIdy/te
Z1IC/I3rGRw6lVzVZR8tXox70QhVBRHLL99Zxv4w5DedB0dDNsu7//pE3YSQrRW+
t2vRvfBi0Nz6MZVxMMV/uMHa4sqJjqt9T4JD3uijdvQFkMxtm5o6cSXWuAobIU/T
w6QQ1Tjr1Z4=
=9BEy
-----END PGP SIGNATURE-----

--==_Exmh_1598067338_2109P--

--===============0276947390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0276947390==--
