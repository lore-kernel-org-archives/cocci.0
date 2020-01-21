Return-Path: <SRS0=kxF3=3K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111C3C33CAA
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 06:32:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA4422522
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 06:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJYg5gxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA4422522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00L6VoM9027045;
	Tue, 21 Jan 2020 07:31:50 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1F65F77E1;
	Tue, 21 Jan 2020 07:31:50 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7090777DB
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 07:31:48 +0100 (CET)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00L6ViHF002787
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 07:31:45 +0100 (CET)
Received: by mail-pj1-x1042.google.com with SMTP id e11so970766pjt.4
 for <cocci@systeme.lip6.fr>; Mon, 20 Jan 2020 22:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=YjawRMKdm8OfiarQVvPGkdWjjfDbFxllxQ4uPbAAw0o=;
 b=RJYg5gxkOD7PcTAIXBB1O5kKjm8P+oWyCnv18jrp1Q4bAsOdUp0LCthEigkRBXpUaW
 YTwoTYAyAbDVsh3U84FVvTJq7tFndPKtGHSQRXsZHgv2J0xO6P0dVmB1xEfWVatxtk08
 CmhYvmn2//F7DF61drzHjKOaLCOU70sUf+M2UdqrSOANuAA49QkOV0umDv4unp48aUNF
 lFvSQvbQ8KyNT1woyQGJa+bXiZKo5a1Rvfjw1Z58U6eN9gdH4nKewdKn7E0J2lRuWNbV
 7aU6ob+pnXdnuPdErP5bgCq9w7sKU+9s5BFvLh7GhGS+3ZPrrGWdfD5hLrd/zJj5Mw+1
 R4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=YjawRMKdm8OfiarQVvPGkdWjjfDbFxllxQ4uPbAAw0o=;
 b=D5I3tHYPsv682JIFoUK2GT58KrWeNFzIluxlWFzXdnYnyv1FXAh8NySunkQyFEQUTx
 emgOj50OoGsokKPzq8p3y8EInebp4z/7TA4I5RUaPNF5V7xIvRBiF/nP1S9FPq5OiYRQ
 PCQFngrff6B6w9/VcRvRpjCtrE/c+huon11LM3p4zftB42x+n7iB3+R+OokqQJqZSoWB
 ufT8gO0z18KbDV2MkWL2ehU8lHXSryicDoZbA9LkKVINhJsnr+VjvUvBv+o3xXwPvAqi
 bQ8GtZM5Hq98/dkbCfrjtvg4wzCba/umqE4qpEs1uQojaDaV2aXH1BsD1KkBMyZgFY/9
 g26g==
X-Gm-Message-State: APjAAAWyyz+xv11PLBnv0wOSW8anK+w9oSCjSSrvrcPUz0Kl7ZwcHX32
 YRDDjvLnkwZK0Q0/pA1zQRw=
X-Google-Smtp-Source: APXvYqxj3jLqJGOXwK5f13cfDJfMCBTA1b6yZVsHZxkPWKMwZ501YHWEtBynQ7OvlgBjfEDPojBAJw==
X-Received: by 2002:a17:902:462:: with SMTP id
 89mr3894995ple.270.1579588304180; 
 Mon, 20 Jan 2020 22:31:44 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:167e:da7:fcf8:ab67:c0bb:e29])
 by smtp.gmail.com with ESMTPSA id
 y197sm42404359pfc.79.2020.01.20.22.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 22:31:43 -0800 (PST)
Message-ID: <14a0f459a636673eeaf968b90cc0e85c0717f15f.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Tue, 21 Jan 2020 12:01:40 +0530
In-Reply-To: <alpine.DEB.2.21.2001210622150.2301@hadrien>
References: <20200119134812.32748-1-jaskaransingh7654321@gmail.com>
 <alpine.DEB.2.21.2001210622150.2301@hadrien>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 21 Jan 2020 07:31:50 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 21 Jan 2020 07:31:45 +0100 (CET)
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

On Tue, 2020-01-21 at 06:23 +0000, Julia Lawall wrote:
> 
> On Sun, 19 Jan 2020, Jaskaran Singh wrote:
> 
> > bool is widely used in the Linux kernel. Certain cases of
> > parsing_hacks.ml would mislabel bool.
> > 
> > Add bool to the list of known typedefs.
> 
> As far as I can see, this function is only used for avoiding to print
> some
> warning messages.  So I'm not sure why it would have any impact on
> the
> parsing at all?
> 

Sorry, It should've been clear in the patch.

This patch will only make any difference if it's applied on top of 
https://www.mail-archive.com/cocci@systeme.lip6.fr/msg06706.html

Cheers,
Jaskaran.

> julia
> 
> > Stats of --parse-c on Linux v5.5-rc4 are as follows:
> > 
> > Before:
> > 
> >   nb good = 18956150,  nb passed = 134062 =========> 0.70% passed
> > 
> > After:
> > 
> >   nb good = 18956150,  nb passed = 134073 =========> 0.70% passed
> > 
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
