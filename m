Return-Path: <SRS0=kxF3=3K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A91C33CAA
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 06:28:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E966222522
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 06:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaMItUg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E966222522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00L6S5YB024482;
	Tue, 21 Jan 2020 07:28:05 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6EB1377E1;
	Tue, 21 Jan 2020 07:28:05 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 30AB077DB
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 07:28:04 +0100 (CET)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00L6S3qb016006
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 07:28:03 +0100 (CET)
Received: by mail-pj1-x1044.google.com with SMTP id d15so866119pjw.1
 for <cocci@systeme.lip6.fr>; Mon, 20 Jan 2020 22:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=p5yJ8Z8XAUEesX2qNHrk5cjCYwtFfYQhAcgOhIYm1/k=;
 b=kaMItUg1jSXqkWXE9RYXG6GdZQyT6NTlBish9gNPhKcYj5apQnRU92WloscPYSDbI5
 rB8WDSCAtvGMMsq84BI2LXNL+bzkhyrKXlt7inNPl5rsS208jX3UFjU34P50trOSFhfD
 ddng7jLawCEi4cZr8s9OSfVxI0iDflag1xwN/vsHVWTLj9Ic40uXRDItMCN9LliPynj/
 Gt89uy8QtE9pWP2fyYhcMaGzW2ciOJGkxWfnQkPvdnTc8RLlgnI8Txjdr2ngOB5eG2hq
 C2W9Gg12Be7wTnl32PPir9STGYVAlxCwnwk1PCQb9AjmRTHz6yQ45w9H2Hu6+EOUTfz+
 4pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=p5yJ8Z8XAUEesX2qNHrk5cjCYwtFfYQhAcgOhIYm1/k=;
 b=TllhdhcRVX/MhYGubSu64dTPAFhGcK+UqtWpNZxV9fZ6CcTFwScCxBTb5kXQPH0EAY
 Mrh37iCxl+wO4RRaOFonjuDNz1hwToGrn94E7b4pU5kyYoxg3+oyzHtd49jMQLHiAqGc
 Pk0OQw8LNI204hQ4dxF2q67FSlPuwuC6aAg0u/J52cTK5AuvCrIFUol53Ug1lY5X8Rar
 A5y5paRXbffsSMfVNalL+Inchn7wuqWgHaNKHNoypLpAvEeydb89F/kI8mZiFv7O4Dwy
 pBrOpSEnQgLkZv0s8dVbhYEqSPNgUCXbhxz2H7FHaS02XQT89DIsS7RdhobGLYAX4ain
 XqRQ==
X-Gm-Message-State: APjAAAXqVa3bxdGVnexJrXJMBxz2+ikXwHdQYGlyfDuxjXmVYgQH0ddh
 yRhX5hvkEAYbTuDDrLXoouI=
X-Google-Smtp-Source: APXvYqxUo2eZAP7BfSuJrH/h2gf4KGmT5THy6BzIwYWwUXRzTlc3mKlC5lkS7j28g6NAEW4nwZ1JMQ==
X-Received: by 2002:a17:90b:4398:: with SMTP id
 in24mr3573540pjb.29.1579588082547; 
 Mon, 20 Jan 2020 22:28:02 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:167e:da7:fcf8:ab67:c0bb:e29])
 by smtp.gmail.com with ESMTPSA id
 c17sm40774161pfi.104.2020.01.20.22.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 22:28:02 -0800 (PST)
Message-ID: <7fc95d036dbda26e6540839ef25c5c09c21ca747.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Tue, 21 Jan 2020 11:57:58 +0530
In-Reply-To: <alpine.DEB.2.21.2001210619100.2301@hadrien>
References: <20200119134812.32748-1-jaskaransingh7654321@gmail.com>
 <alpine.DEB.2.21.2001210619100.2301@hadrien>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 21 Jan 2020 07:28:05 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 21 Jan 2020 07:28:03 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH] parsing_hacks: Add bool to list of known
	typedefs
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

On Tue, 2020-01-21 at 06:20 +0000, Julia Lawall wrote:
> 
> On Sun, 19 Jan 2020, Jaskaran Singh wrote:
> 
> > bool is widely used in the Linux kernel. Certain cases of
> > parsing_hacks.ml would mislabel bool.
> > 
> > Add bool to the list of known typedefs.
> > 
> > Stats of --parse-c on Linux v5.5-rc4 are as follows:
> > 
> > Before:
> > 
> >   nb good = 18956150,  nb passed = 134062 =========> 0.70% passed
> > 
> > After:
> > 
> >   nb good = 18956150,  nb passed = 134073 =========> 0.70% passed
> 
> Why did nb passed increase?  These are tokens that will not be able
> to be
> transformed by a semantic patch.
> 

I suspect it's instances of nokprobe_inline in
linux/kernel/trace/trace_kprobe.c. They're marked as CppMacro.

Here's results from my diff:

20402,20406c20288,20294
< passed:bool 
< passed:bool 
< passed:bool 
< passed:bool 
< passed:bool 
---
> passed:nokprobe_inline 
> passed:nokprobe_inline 
> passed:nokprobe_inline 
> passed:nokprobe_inline 
> passed:nokprobe_inline 
> passed:nokprobe_inline 
> passed:nokprobe_inline 
20407a20296,20297
> passed:nokprobe_inline 
> passed:nokprobe_inline 
20408a20299,20300
> passed:nokprobe_inline 
> passed:nokprobe_inline 
20409a20302,20303
> passed:nokprobe_inline 
> passed:nokprobe_inline 
20410a20305,20306
> passed:nokprobe_inline 
> passed:nokprobe_inline 

Cheers,
Jaskaran.

> julia
> 
> > Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> > ---
> > The above diff has been obtained after applying
> > https://www.mail-archive.com/cocci@systeme.lip6.fr/msg06706.html
> > 
> >  parsing_c/parsing_hacks.ml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/parsing_c/parsing_hacks.ml
> > b/parsing_c/parsing_hacks.ml
> > index 685a4908..5e3301a0 100644
> > --- a/parsing_c/parsing_hacks.ml
> > +++ b/parsing_c/parsing_hacks.ml
> > @@ -61,7 +61,7 @@ let is_known_typdef =
> >        | "u_char"   | "u_short"  | "u_int"  | "u_long"
> >        | "u8" | "u16" | "u32" | "u64"
> >        | "s8"  | "s16" | "s32" | "s64"
> > -      | "__u8" | "__u16" | "__u32"  | "__u64"
> > +      | "__u8" | "__u16" | "__u32"  | "__u64" | "bool"
> >          -> true
> > 
> >        | "acpi_handle"
> > --
> > 2.21.1
> > 
> > 

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
