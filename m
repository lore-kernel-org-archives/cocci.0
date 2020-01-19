Return-Path: <SRS0=ajuV=3I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CADC33CB1
	for <cocci@archiver.kernel.org>; Sun, 19 Jan 2020 13:26:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C112053B
	for <cocci@archiver.kernel.org>; Sun, 19 Jan 2020 13:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uteKj36B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C112053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00JDQ5Et028405;
	Sun, 19 Jan 2020 14:26:05 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1C84F7722;
	Sun, 19 Jan 2020 14:26:05 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6030037BC
 for <cocci@systeme.lip6.fr>; Sun, 19 Jan 2020 14:26:03 +0100 (CET)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00JDQ125025432
 for <cocci@systeme.lip6.fr>; Sun, 19 Jan 2020 14:26:01 +0100 (CET)
Received: by mail-pj1-x1041.google.com with SMTP id n59so5734827pjb.1
 for <cocci@systeme.lip6.fr>; Sun, 19 Jan 2020 05:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=zI3kjX1k6NMqo4vsGAxKFKnraw2ThO2LmRiTBf9NOV4=;
 b=uteKj36B/wvpW3vJMXwtQCSCKw7svyHtzR86lyBjcGJcOMTi1J9cnT/wepBLgtxWAC
 YnHvXfCmy98UstvNH89kQT8cin0MOWAZ1Okj+OdgVr+uRnbI3uCHsUj+bfNexzSAUAs7
 Esl7D4Smv23he43d2ExinX2g6TuandaN+wK+aqYoA1dEfi1DfxaI1C9jAoNZa6l+Vez4
 wAImBfeMHHbwXjwFLsU9q5lBcqj+TclyHI///+iVMzj8BhWi4taffb22/Hu6m2EWWmMi
 ICdjIdZESWypSzOKYgxA8W/lzuH8B97vLw2MXrT9nmohDDLmgoHQkfCH8kTLuxzgWnGy
 c1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=zI3kjX1k6NMqo4vsGAxKFKnraw2ThO2LmRiTBf9NOV4=;
 b=Jyh7QlinTwfiiW+rbyJ1qldKmgqyS4FHP1mMPH5QF9SmCT0zZb/+Ln+QzFV6LcZZM7
 ZfmKIKzY8bxhODxypV9w/DoiFapg0l9NGvKw5CmgefV0VxExz7NF0Lp6+5UG55/c+Pjo
 XizdvA6g/woW12/zhO3v0vUarwM3ReoIW2/Z24aAUgxgpiD0vUIi2So4x4CwvhYW5M58
 ub+Iq70TiDyfqfg6Zh32cShJruV4tLvcfHzBLugksmKGB+zpbGqzbhlH7B20CcVNlmIX
 JuY5PxmSdANuCJITNZk0smnZhOhwyS8gU8+yYkXBUgYRaVyKFhPIc0B7bR30XRnyzZdW
 8jHw==
X-Gm-Message-State: APjAAAXSUPWKLlfTkSybtxikTX6duSNwaDGV/ZjODgQZ21JQoo8vDD4W
 luC2t2JJXseyQTitHmD5HaI=
X-Google-Smtp-Source: APXvYqzQBUzE2Xn0oX61BPD0wMMRqyJbDN05k7L9ahr2qbITKAZzYW29QMmwwnn5PuREiwHKauAzPw==
X-Received: by 2002:a17:902:8ec6:: with SMTP id
 x6mr9730880plo.179.1579440361034; 
 Sun, 19 Jan 2020 05:26:01 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:167e:6ff0:778b:ad50:8d0:2129])
 by smtp.gmail.com with ESMTPSA id 12sm36340364pfn.177.2020.01.19.05.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jan 2020 05:26:00 -0800 (PST)
Message-ID: <23d1fda6d94c1c09792d0e7dce58b213ef66fd7e.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
Date: Sun, 19 Jan 2020 18:55:49 +0530
In-Reply-To: <20200119131846.23302-1-jaskaransingh7654321@gmail.com>
References: <20200119131846.23302-1-jaskaransingh7654321@gmail.com>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 19 Jan 2020 14:26:05 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 19 Jan 2020 14:26:02 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: "linux-kernel-mentees-request@lists.linuxfoundation.org"
 <linux-kernel-mentees-request@lists.linuxfoundation.org>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH] parsing_c: Handle case of macro before typedef
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

On Sun, 2020-01-19 at 18:48 +0530, Jaskaran Singh wrote:
> For the following case:
> 
> <macro> <typedef> <identifier>
> 
> A case in parsing_hacks.ml sometimes mislabels <macro> as a
> typedef ident.
> 
> If <typedef> is a known typedef (such as u8 or *_t), then label
> <macro> as a CppMacro. Subsequent cases will then label <typedef>
> correctly.
> 
> Following is a diff of --parse-c on the Linux Kernel v5.5-rc4:
> Before
> ---
> After
> 
> nb good = 18956150,  nb passed = 134061 =========> 0.70% passed
> ---
> nb good = 18956150,  nb passed = 134062 =========> 0.70% passed
> 
> Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>


Whoops, ignore this. The commit message comes out badly.

Thanks,
Jaskaran.

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
