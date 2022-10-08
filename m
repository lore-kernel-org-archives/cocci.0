Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B60C433F5
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 15:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=y482c9KYKPLEs+Kl13ykbudpYNohmEbf6xP4dg/Q9jo=;
  b=jrM+gOe4KLAdLV0CbOWcMiq5WCT3K51A3q/1KkgopxdKfwaRWRhCb48X
   7lvnM7o+iW5GHM6IfN23Iytbmkq+VCz4nh5jAZvgk7R2uwu3Az73S86oI
   GBEa6PIdNnkJ9ybIiBAdT/6jS7jauitheNDCoE7rTHjeoXYUYYWaFzcJ4
   w=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="56680562"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 17:11:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5AFCBE02A3; Sun,  9 Oct 2022 17:11:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 11010E0121
	for <cocci@sympa.inria.fr>; Sat,  8 Oct 2022 05:09:46 +0200 (CEST)
IronPort-SDR: 6340e9f9_MhP3/FqIzIev+RLmQacP3yKocCQA9WxhKv49eORCw6UvriJ
 g6gzc1SmusuUopKlW2kHBEV1eh5m90ZhHKI0bhg==
X-IPAS-Result: =?us-ascii?q?A0AJAwCY6EBjf7bWVdFagQmBT4IkgQFWLgRQjUyaBIsrg?=
 =?us-ascii?q?XwLAQMBCwEBNwsEAQGBU4MyhHYCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBARgJGQcODgUkhWgNgjUpAYNmFigGAQE3AYEUAQUBN?=
 =?us-ascii?q?SKCXIMgAxCeJYEEQoswgTSBAYIIAQEGgUABhE2BXAMGCQEIgSuLT4NlgSEcg?=
 =?us-ascii?q?UlEgRWGM4JGg0KCLpo9OANEHUEDC0I1GAMUAwUhBwMZDyMNDQQdDAMDBSUDA?=
 =?us-ascii?q?gIbBwICAwIGEwUCAk00CAQIBCskDwUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVA?=
 =?us-ascii?q?hAIAggmFwcTMxkBBVkOCSEcKA0FBhMDIG8FQg8oL2krHRsHgQwqKBUDBAQDA?=
 =?us-ascii?q?gYTAyICDSkxFAQpEw8tBylxCQIDImsDAwQoLAMJIR8HKCQ8B1g6BQMCECI9B?=
 =?us-ascii?q?gMJAwIiWIEpJgUDDRkmCAU3GwQIPAIFBlMTAgoSAxIPLUoPSkA9mg6BC4EJg?=
 =?us-ascii?q?TkXgWejdJ5og2iBSQyJaJUwEZZXkh6XEI1AmgYCCgcGECOBPjqBWzMaCCgIg?=
 =?us-ascii?q?yISATsDGQ+XJoVqITQCOQIGCwEBAwmLGAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Tw7KMqzUWVcr06+sm2zkKrPwHb1zdoMgy1knxilNoNJuA6ilfu
 SV7Y8mPH7P+U4ssRQb8+xoV5PwIk80maQFg7X5Xo3SJTUO2lHYSr2KhLGKq1aBJ8SXzI9gPM
 xbAs9D4bPLfD1HZAXBjDVQ0exM/DBKys+VbC7loUtQcQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,168,1661810400"; 
   d="scan'208";a="25822562"
X-MGA-submission: =?us-ascii?q?MDGoGTCZS+KePPFsnUn3E3sLdXPbaKYj4DmbeP?=
 =?us-ascii?q?g1d5WW1Wv9e50KaJFFFeKmhMqNWUcrTPn9YsOgNrHd7J7y7kGgO+00Qt?=
 =?us-ascii?q?4B9yL6H6HVpvMbGz4rQo1uFKgV+lYD4x9eR1GOPydNKL32mjln15hQwK?=
 =?us-ascii?q?wsvSbwCe9Cd2PM5079imoFkw=3D=3D?=
Received: from mail-pl1-f182.google.com ([209.85.214.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 05:09:45 +0200
Received: by mail-pl1-f182.google.com with SMTP id z20so6066546plb.10
        for <cocci@inria.fr>; Fri, 07 Oct 2022 20:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y482c9KYKPLEs+Kl13ykbudpYNohmEbf6xP4dg/Q9jo=;
        b=ECqnsNIDHUx1PQOtboPEAwQ+bRUb2lh5Bi9j1c4U5w8hVaVB3MiPlYyyAGP29JVq/j
         N+LybVqF3zMceMuLeL1uzuonK1U2EmgYnQe8ud42otwJMDH6jl8QQu4TIpPCvznqEKUC
         9bDM08pz2T/5kk9a0G17GrZaKPICKvrCePZ/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y482c9KYKPLEs+Kl13ykbudpYNohmEbf6xP4dg/Q9jo=;
        b=sD/2vy9pO030Ei3m2MUPpcZf125LMQfy2P79rxBUZQfQZCmUH7PaeTssnTE7cJvIHH
         pQopI9KLU2ru5q4bSxSK2Z/PyVenqDKmj0e7jh5nZ/28QRaiWi8lHRJW6COtL86k984p
         fOoyAO9nODqZl/8r6w/mRjxt2/TR51xvim6BLApTgsYj7ZldieR5MjFjzurSoIrY4GUZ
         fy0kAw86b2DcrrG9J/ucdOfnnSL9oNQfUbc9N9M0SGQhb8S12MPtYIS3plPR6lha27GX
         uiesvUI4kxPm9+I7Xlnj4L/UrwJsO4lcxGFkSCbvebk+p0NKPgH6FITD7H+uvGQG023s
         UaVw==
X-Gm-Message-State: ACrzQf0bMdl01EZpHTklS/rjsx9hw25R6/DNfMJ/dY7AslIBrhWjxSqo
	Hgzr3OYrkcE0cPJBTQko2XgDIUCUs2cKnw==
X-Google-Smtp-Source: AMsMyM7iH6UpmaIVVpHRfyhpNEXyU5GrjQT2znaEAWVv8tFWRTOWnKBCmXmvyiNcjL1Ugqwj81za7Q==
X-Received: by 2002:a17:90b:4d88:b0:20a:ad78:781d with SMTP id oj8-20020a17090b4d8800b0020aad78781dmr8493755pjb.95.1665198582403;
        Fri, 07 Oct 2022 20:09:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h12-20020a63df4c000000b00459a36795cbsm2379107pgj.42.2022.10.07.20.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 20:09:41 -0700 (PDT)
Date: Fri, 7 Oct 2022 20:09:40 -0700
From: Kees Cook <keescook@chromium.org>
To: cocci@inria.fr
Cc: Julia Lawall <julia.lawall@inria.fr>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Message-ID: <202210071600.078A2101@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] how to check a for "don't care" state of a variable?
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 623
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/202210071600.078A2101%40keescook>
Message-ID: <20221008030940.2HhllfgyLDfrTnU9FXA3o0RVKTTJwIYaIDYHj5k85ZM@z>

Hi!

I was looking at doing some conversions for this[1], and I wasn't sure
how to check for removing a variable assignment if there was either no
more uses or the next use was an assignment itself.

i.e.:

	var = 1;
	other = func(var);

turns into:

	other = func(1);

but this would not:

	var = 1;
	other = func(var);
	report(var);

without getting confused by:

	var = 1;
	other = func(var);
	var = 5;



@multi_line@
identifier randfunc =~ "get_random_int|prandom_u32|get_random_u32";
identifier RAND;
expression E;
type TYPE;
@@

(
-       RAND = randfunc();
        ... when != RAND
-       RAND %= (E);
+       RAND = prandom_u32_max(E);
|
-       RAND = randfunc();
        ... when != RAND
-       ((TYPE)RAND % (E))
+       prandom_u32_max(E)
// This is wrong: we need to check that RAND is either assigned or never
// accessed again
)


I thought I could do this:

	... when != RAND
	<... RAND = EXP; ...>

But this appears to be invalid syntax...

-Kees

[1] https://lore.kernel.org/lkml/202210071241.445289C5@keescook/

-- 
Kees Cook
