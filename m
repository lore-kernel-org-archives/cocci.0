Return-Path: <SRS0=PsQ7=3C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B012DC33CAE
	for <cocci@archiver.kernel.org>; Mon, 13 Jan 2020 22:47:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0C5206DA
	for <cocci@archiver.kernel.org>; Mon, 13 Jan 2020 22:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1ngXV58L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0C5206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00DMl2CW007783;
	Mon, 13 Jan 2020 23:47:02 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1C3C577E3;
	Mon, 13 Jan 2020 23:47:02 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4A1A4771F
 for <cocci@systeme.lip6.fr>; Mon, 13 Jan 2020 23:47:00 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00DMkxlE000093
 for <cocci@systeme.lip6.fr>; Mon, 13 Jan 2020 23:46:59 +0100 (CET)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D4B57206DA
 for <cocci@systeme.lip6.fr>; Mon, 13 Jan 2020 22:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578955619;
 bh=b8smSXWejPE3pZoHqMFoceFQLiDj5dEBKW+kBVEDuZI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=1ngXV58LB8egZCtAQ8orzFndfR6IJ3pcthAzHpG/uSuUJ0wowPkY/yDFQUC7eM0/L
 wt/4tSc1HV7g2Zn6EqndI65JPiX0M7Wxo5vmEw6jejfYpbWbAuqcr05l3TLAa1r16Y
 EfmUuD4m0gtyhFkJLgZCIpHh3REkG6DmjN/Sq5iY=
Received: by mail-qt1-f170.google.com with SMTP id e5so10677627qtm.6
 for <cocci@systeme.lip6.fr>; Mon, 13 Jan 2020 14:46:58 -0800 (PST)
X-Gm-Message-State: APjAAAUxQHGZOSFsDv/W8Q3Nf0FP3R3IA8DKZfTDbhMCYCeVFaCty0+5
 Gt25ez4/MGwvTRtKI+tNbckuTsgx6T9f2IThey4=
X-Google-Smtp-Source: APXvYqwO9qUto+NEIwMKc3BD92UTYh+e6uE3LtR9pGO67Oqsc+etyBT9TdbiNzyTiwYyWBDHR2OWOGxJ16U0/NGmeZo=
X-Received: by 2002:ac8:45c7:: with SMTP id e7mr856938qto.334.1578955618055;
 Mon, 13 Jan 2020 14:46:58 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXU4vhqzot5EEMZ_9jAdp-Be0TTyDS-uXJVPrGs2k=c7nA@mail.gmail.com>
 <alpine.DEB.2.21.2001132332060.2574@hadrien>
In-Reply-To: <alpine.DEB.2.21.2001132332060.2574@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Mon, 13 Jan 2020 16:46:21 -0600
X-Gmail-Original-Message-ID: <CAOZdJXWwKUPf_4oGk4G2j438n47fntf7J0AEJd7nFbg6+pR6Qw@mail.gmail.com>
Message-ID: <CAOZdJXWwKUPf_4oGk4G2j438n47fntf7J0AEJd7nFbg6+pR6Qw@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 13 Jan 2020 23:47:02 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 13 Jan 2020 23:46:59 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>, Timur Tabi <timur@kernel.org>
Subject: Re: [Cocci] Concatenating parameters into a string
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

On Mon, Jan 13, 2020 at 4:33 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> Sorry, I don't follow what you are trying to do here.  Could you send an
> example of the desired before after C code?  I see what you have above,
> but I don't see the connection to the rule you have tried to write.
>
> I have the feeling that you will want to use some python code to do
> something with the ##s, but I'm not sure.

I'm hoping to avoid Python.

I'm basically trying to recreate the ## feature of C macros.  For
example, given:

#define MACRO(a, b)   a##b

I'm looking for a cocci script that replaces

   x = 1 << MACRO(HELLO, _THERE);

with

  x = 1 << HELLO_THERE;
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
