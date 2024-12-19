Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE1FE77184
	for <cocci@archiver.kernel.org>; Thu, 19 Dec 2024 18:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+za3kcxO3UpzOcVt5ITsXgP9EC0iHPI46MmKxVKQXSA=;
  b=SKd2k+18uNzNgnyPk3fYEFwToO4UorIiMP75p/aUfBJwvcg+rFP2wGz1
   li7J3NxWrmKco9ezt94XmTgoAW3if+csYk4iswfrA79zuYfhER1zSRm9/
   hd/YNF2K4u0tOdLTgZVPWm6dkmvUX/cMrkeP4s9SPxLbq2VggcWkhmLD4
   c=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.12,248,1728943200"; 
   d="scan'208,217";a="200140315"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Dec 2024 19:55:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 30E56E0137; Thu, 19 Dec 2024 19:55:43 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D0A0EE0077
	for <cocci@sympa.inria.fr>; Thu, 19 Dec 2024 19:55:41 +0100 (CET)
IronPort-SDR: 67646c2d_I5+feBqnzSz5EmIdCJxPs1eEF8qO38ia7sT6VDKHHhq513Q
 QN5wz9fudnSLYRcjq6siKk8KqIOiym9BNRzg7Nw==
X-IPAS-Result: =?us-ascii?q?A0F/AgAoa2RngbHQVdFaglyBclKBVzMEU4RWj02BdDCEO?=
 =?us-ascii?q?4c7i0yGVoFAPg8BAwELAQFCAgQBAQMEOIRIAoptAh4HAQQwCQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBIhkHDjuFew2CYgGBJGECBQM7A?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQIsXwEBAQMSE?=
 =?us-ascii?q?QQZARsdAQMMBgMCCw0qAgIiEQEFARwGFQEBHoJfgjABAzEDAZZZj0CBBUKLP?=
 =?us-ascii?q?n8WBQIWgQGCDQbaXAoZKA1sA4FhAgcJAQqBNIR0KU4OgjgdASqBMgKICnonD?=
 =?us-ascii?q?4FVRIEVJ4EUgW8+iB6CaQSCOUyCGy4Cg0mHMoM4g1OFVYoeCAcfEgkJEwYKA?=
 =?us-ascii?q?ksFEBIDBAMEBAECCwkKCQMDAg4CCAMCCAYfAT8SBBMKDQsHBR8KBwwRCigDI?=
 =?us-ascii?q?gQOERwPA1wFNAELAwcCCAICBgMCAgQUBgMFCAMCBQUNAgIKAgQDFQQEDwEBA?=
 =?us-ascii?q?h4CBgECEAEHAgIBFAIKAwIFBgcCHAICAwMEBAMBBQMSAwsBBQYFAQEEDgECA?=
 =?us-ascii?q?QIBAQIDAw4CAgMDAgIBCQICAQECDQgBBAMBBwIFAwUDCgEBAQIBBAkEDQYDB?=
 =?us-ascii?q?QMDBwMEAgMCBgIEBAEEAgIDAwIDAQMDAgECAwkCAQ8PCQ8CAgMEAgYCAgEEJ?=
 =?us-ascii?q?gIBFQUCAwQCAgcCAgMBAgECAgIEAgQCAgYDCQgBAgIHAQICAgMVAgUBBAkDA?=
 =?us-ascii?q?wUSDCADAgICAgMHCgMFAgEBAgQDAwMDDA0HAgMBAgEDBQMBAgECCQMGAgIDA?=
 =?us-ascii?q?wUSGQUDAg8DAgEFBAIIEgsHAQEPFAUECQUVAwYCAwMWCwQFAwMDAQwFDA4CA?=
 =?us-ascii?q?gsDFwUBAQcBAw0IAwQEAgMDCQIBEAEDBAIJAgQBAgoCAgICAgQBAQUEAgQDA?=
 =?us-ascii?q?gUCAgEIBAMDAw0EAwgIAwUDDBICAgIJAgMBAgMDAwQNCBYNAwINGAoVEwcHA?=
 =?us-ascii?q?wMECwIJAwQNAgQCAgEGAwYKBgcEBQYBAhgCAgYMBAMDCAMCAwICAQICAgERA?=
 =?us-ascii?q?gIJCA0FCQUGAgIVAwIDCAEJAw8DAhQBBgIIAwcBAQQCAgoRCgEBAgIBBigDA?=
 =?us-ascii?q?QECFBMHAwgCAgICBhYMAQUHAwcPBQUEAgIWAwMSBAQQAgIDAwIBARQGFQEFA?=
 =?us-ascii?q?gMGCwEGAQIFBAIDBAISAhIDBAMKAg8DBgMEBgMBAgwQAgQCCQoBBQQDBwUCH?=
 =?us-ascii?q?wMDAgIFCwIIAgIFAgUHAwkLBgECBQMECQIUAhACAgICCBcCAgIFHgMmAgQDA?=
 =?us-ascii?q?wMDCwECAg4JAwQ8BhMEAgMDAg4BAgILAQICBAIDAQQHCQMDCQoHAQoNBwICC?=
 =?us-ascii?q?ggJEAECAg8HAwICAgIGBw4DAhMPBQYGAgoHDQoDAgECAhMCAwkGAwUNAwcEC?=
 =?us-ascii?q?g8CFQIWBQMgAggJCwIHDgUCBRIDDgUDAgISBAIDBgUDAQcBFwMHCAICDAICA?=
 =?us-ascii?q?gIFAgUCBRgRAQ0EAwMDAggBBBUGAwkIKggEAwsGHQICAwIEBQEBEwEBAQUBC?=
 =?us-ascii?q?QIDAgMECAMDAwMCAwQMCwIBBwgDAwYLCAkGAwIHCBkDBQQDBwULIQIGAwIEB?=
 =?us-ascii?q?QQBBQIVDQIDGQIGAwYUCwwCBg4ICQMHAQEBAgICCAEFBRICAwQCBQQEAQEIA?=
 =?us-ascii?q?wMEBgIBAwICAgEEAgoBAQECCgIICgEJFAQDCAMDAwMDBQEBAgIKBBMFBQIBB?=
 =?us-ascii?q?Q4NHQIJAyMPAgELCQgTPQwHMgQ2AQkLFAcGJYEAm0cBChCBMIRjExSBOIFXn?=
 =?us-ascii?q?gWSd5RdNAeEHYFdBgyfXAYPBC+XQ5MOiCmQUoErp1UCCgcGESMSgTI6gVwzG?=
 =?us-ascii?q?iOBAYI2TwMZD44tFoNYvzhCNTwCBwEKAQEDCYVpiUwtBYFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:XAC8XqmGk7wZSWF/jy9OX4O4ChfpDfL83DAbv31ZSRFFG/FwWf
 re58jzpiWE9Qr5OUtQ++xoXZPrfZqyz+8Q3WB8B8bfYOCighrWEGgA1/qE/9SDIVyaygc178
 4JGNkcNDSzNykBsS+T2mmF+r0bsaC6Gc6T9J/jJjtWPGdXQpAlwQM8JAjzKCJLrcp9aabR1q
 Dw2iOKnVSdkL0sD/iGOg==
X-Talos-CUID: 9a23:ocb0MGEljbaJvJwKqmJn0UspOutmeUGG7y3QDkS2LG1RcL+KHAo=
X-Talos-MUID: 9a23:+G5a/AT9hGh9gKgpRXTUgmAyN/5K4Z2RVmwPl5YMi9uUNh5/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,248,1728943200"; 
   d="scan'208,217";a="200140306"
X-MGA-submission: =?us-ascii?q?MDEgDOMJGdrtZXJw1j9Jievbr9LsH9fzibfL7y?=
 =?us-ascii?q?E4ABLF7wQw+0Ok9WgyTH5xy14DCsgT4bKHblAkb0mxOeIRt+svlaDNs+?=
 =?us-ascii?q?eGPgs/zzMbyfZAhcVogl/FN+xk8JPO90pMZU6PZ2ChwueQlWQmwnJiBr?=
 =?us-ascii?q?EYEWzjp3i2WrtLnJJLcngFPg=3D=3D?=
Received: from mail-lj1-f177.google.com ([209.85.208.177])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 19:55:41 +0100
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30167f4c1deso11100191fa.1;
        Thu, 19 Dec 2024 10:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734634540; x=1735239340; darn=inria.fr;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+za3kcxO3UpzOcVt5ITsXgP9EC0iHPI46MmKxVKQXSA=;
        b=EM3UKuGqcrToJyZRczdzhBfpRsHkweSteQ6ZeoKKuaBwXm10EvCiii6gY3n13hzWLv
         DjfLnZc3mhoavO6MNimgxdm8K3uZzp0j2TqoqEE5giFlLQrY4qSDTzUTn3Jgh3XA6zTG
         n4Jtr6Tdypfq6Q3EbW2J+XANP9CdWuK7O/2AcdtFcEbJ8Q3ZDUkqT9KGBpvNTzFSqI2D
         0vMQqq7mF0rFspxhYplb4++kyROdsYGYZFHBTHc3ZZV3BtaOlrqT/k/4isnHOPhPUJSx
         +4075B4k73EYu28Kldw/ZWs04GXa9RHpkHvJB7aeUK0N4nM6o3jETCb9Rox9PhTaFq2L
         s/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734634540; x=1735239340;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+za3kcxO3UpzOcVt5ITsXgP9EC0iHPI46MmKxVKQXSA=;
        b=JYXLXZnceg0u17pzhec11GhDNLSkgTYm/QL3W67fOs8Qq4Flzr1JXerdy7KQ5lrppD
         pkXAZeydOxYqiyTpoKWei2ORb6Y/RYsbYIShXVGCOr54Sds7otrOKawW3MR4LGu93evv
         yVwLoJinYZnbmXWY5J0k3xo2q9aYz53OBVrP89Sfv6K1hSkNzrloK5dXt//psQb/deFa
         9C32sOmZMyNoOf2DpQ6cTQjSb+F5U+kHjpe+h6XYdgn07yhGG/kINZcQWtC2sieJsI6k
         OCqWCTQn+9PoSgJJqLg4XRxSrPuS0ztayR9z6+SQNsD5SPFH4DCVxACwXttKISGJgH5E
         KQKA==
X-Gm-Message-State: AOJu0YzVI7dQp1PVEUL13o1tWUzGD6VPuFuwmYC0f/Py6/nZOkeXp/Xl
	CCNRRgEMLRflqNKbEk+kiqvKSn3PkC7e8Z2QuVo/iTuX/lPERlQ5FPEqeA==
X-Gm-Gg: ASbGncudVUtU0KOr9Xuzul3kE1axpnVWhMNz/4iePY6u0odHHTIWVI680oRxF6lBlkx
	8iPVQtfTVN4GKPalwojN28GQXxtH31mGZ0VMLljt2N30QaXjOYdnnjMDKBjT63ARmZ/drD9ZuAm
	l3lRF7wrmwl8Ae0Wr+28LWEXlfx1iYBX+2+6kKGEOBYcXEZ4J1kMDDJyQYwQYr3Y2UJHEyneFAH
	5TG1c5FCKHUiWro/WQi9jNMP1p+o4d4MIiCVl+usMSR+DQyErU4BzeRObVXiyobG2t6oQGXxZO0
	OT7gcgDcbiSscfW1cjbI0iTz4EuAiWVP
X-Google-Smtp-Source: AGHT+IECnX7vvorLFMLi1axwUT/7gyqB0F4dowfjrCKB3jkWPxtEUYf20jJKlUZRWXh+lfawphKU0g==
X-Received: by 2002:a05:651c:1505:b0:302:1861:6de7 with SMTP id 38308e7fff4ca-304685bbb4bmr517191fa.24.1734634539204;
        Thu, 19 Dec 2024 10:55:39 -0800 (PST)
Received: from ?IPV6:2a02:aa1:114d:98dc:7488:2975:59bc:6311? ([2a02:aa1:114d:98dc:7488:2975:59bc:6311])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6c5a0sm2981891fa.22.2024.12.19.10.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 10:55:37 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------Uw06x4RzB3p7XwTcYwSY4UO6"
Message-ID: <a1e9628f-4d97-4fe3-99d0-585a0196d988@gmail.com>
Date: Thu, 19 Dec 2024 19:55:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <f0764391-b0d3-48fa-8a54-6edddf8d2c8d@gmail.com>
 <da51b2de-12cd-4aad-d989-79e925ead01f@inria.fr>
Content-Language: en-US
From: Mats Kindahl <mats.kindahl@gmail.com>
In-Reply-To: <da51b2de-12cd-4aad-d989-79e925ead01f@inria.fr>
Subject: Re: [cocci] Depends on with negative matches
Reply-To: Mats Kindahl <mats.kindahl@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2188
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/a1e9628f-4d97-4fe3-99d0-585a0196d988%40gmail.com>

This is a multi-part message in MIME format.
--------------Uw06x4RzB3p7XwTcYwSY4UO6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you Julia,

It worked for the example I gave, but the "real" code has validation 
functions rather than comparisons with NULL, and when I tested with 
that, it did not work. Here is a modified version of the code closer to 
what have:

    #include <stdbool.h>
    #include <stdio.h>
    #include <stdlib.h>

    extern bool PointerIsValid(const void *pointer);

    struct something {
       const char *here;
       int ok;
    };

    /* This should match */
    void func_1() {
       struct something *foo;
       foo = malloc(sizeof(struct something));
       if (!PointerIsValid(foo)) {
         printf("Error %s", foo->here);
         return;
       }
       foo->ok = 1;
    }

    /* This should NOT match */
    struct something *func_2() {
       struct something *foo;
       foo = malloc(sizeof(struct something));
       if (PointerIsValid(foo)) {
         foo->ok = 1;
         return foo;
       }
       printf("Error %s", foo->here);
       return NULL;
    }

    /* This should NOT match */
    struct something *func_3() {
       struct something *foo;
       foo = malloc(sizeof(struct something));
       if (!PointerIsValid(foo)) {
         printf("Error %s", foo->here);
         return NULL;
       }
       foo->ok = 1;
       return foo;
    }

    /* This should match */
    void func_4(struct something *foo) {
       if (!PointerIsValid(foo))
         foo = malloc(sizeof(struct something));
       foo->ok = 1;
       printf("Error %s", foo->here);
    }

    /* This should NOT match */
    void func_5(struct something *foo) {
       if (!PointerIsValid(foo))
         foo = malloc(sizeof(struct something));
       foo->ok = 1;
       printf("Error %s", foo->here);
       free(foo);
    }

    /* This should NOT match */
    struct something *func_6(struct something *foo) {
       if (!PointerIsValid(foo))
         foo = malloc(sizeof(struct something));
       foo->ok = 1;
       printf("Error %s", foo->here);
       return foo;
    }

Here is the new version of the semantic patch:

    // Capture any malloc() to a local variable
    @r@
    local idexpression var;
    position p;
    @@
       var@p = malloc(...)

    @@
    local idexpression r.var;
    position r.p;
    @@
    * var@p = malloc(...);
       ... when != false !PointerIsValid(var)
           when != true PointerIsValid(var)
           when != free(var)
           when != return (var);

And here is the result.

    mats@abzu:~/lang/cocci/tests$ spatch --sp-file missing_free.cocci
    code/malloc-example.c
    init_defs_builtins: /usr/lib/coccinelle/standard.h
    HANDLING: code/malloc-example.c
    diff =
    --- code/malloc-example.c
    +++ /tmp/cocci-output-177912-b5da93-malloc-example.c
    @@ -12,7 +12,6 @@ struct something {
    /* This should match */
    void func_1() {
       struct something *foo;
    -  foo = malloc(sizeof(struct something));
       if (!PointerIsValid(foo)) {
         printf("Error %s", foo->here);
         return;
    @@ -23,7 +22,6 @@ void func_1() {
    /* This should NOT match */
    struct something *func_2() {
       struct something *foo;
    -  foo = malloc(sizeof(struct something));
       if (PointerIsValid(foo)) {
         foo->ok = 1;
         return foo;
    @@ -35,7 +33,6 @@ struct something *func_2() {
    /* This should NOT match */
    struct something *func_3() {
       struct something *foo;
    -  foo = malloc(sizeof(struct something));
       if (!PointerIsValid(foo)) {
         printf("Error %s", foo->here);
         return NULL;
    @@ -47,7 +44,6 @@ struct something *func_3() {
    /* This should match */
    void func_4(struct something *foo) {
       if (!PointerIsValid(foo))
    -    foo = malloc(sizeof(struct something));
       foo->ok = 1;
       printf("Error %s", foo->here);
    }

I was assuming that you could pass in any expression in the "when != 
true expr", since that is what the grammar says. Was that wrong or did I 
make a mistake?

Best wishes,
Mats Kindahl

On 2024-12-19 08:53, Julia Lawall wrote:
> Thanks for the many test cases.
>
> You can try this:
>
> @r@
> local idexpression var;
> position p;
> @@
> var@p = malloc(...)
>
> @@
> local idexpression r.var;
> position r.p;
> @@
>
> *var@p = malloc(...)
> ... when != true var == NULL
>      when != false var != NULL
>      when != free(var)
>      when != return (var);
>
> You may want to add some more when clauses like when != e->f = var
>
> julia
--------------Uw06x4RzB3p7XwTcYwSY4UO6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Thank you Julia,</p>
    <p>It worked for the example I gave, but the "real" code has
      validation functions rather than comparisons with NULL, and when I
      tested with that, it did not work. Here is a modified version of
      the code closer to what have:</p>
    <blockquote>
      <p><font face="monospace">#include &lt;stdbool.h&gt;<br>
          #include &lt;stdio.h&gt;<br>
          #include &lt;stdlib.h&gt;<br>
          <br>
          extern bool PointerIsValid(const void *pointer);<br>
          <br>
          struct something {<br>
            const char *here;<br>
            int ok;<br>
          };<br>
          <br>
          /* This should match */<br>
          void func_1() {<br>
            struct something *foo;<br>
            foo = malloc(sizeof(struct something));<br>
            if (!PointerIsValid(foo)) {<br>
              printf("Error %s", foo-&gt;here);<br>
              return;<br>
            }<br>
            foo-&gt;ok = 1;<br>
          }<br>
          <br>
          /* This should NOT match */<br>
          struct something *func_2() {<br>
            struct something *foo;<br>
            foo = malloc(sizeof(struct something));<br>
            if (PointerIsValid(foo)) {<br>
              foo-&gt;ok = 1;<br>
              return foo;<br>
            }<br>
            printf("Error %s", foo-&gt;here);<br>
            return NULL;<br>
          }<br>
          <br>
          /* This should NOT match */<br>
          struct something *func_3() {<br>
            struct something *foo;<br>
            foo = malloc(sizeof(struct something));<br>
            if (!PointerIsValid(foo)) {<br>
              printf("Error %s", foo-&gt;here);<br>
              return NULL;<br>
            }<br>
            foo-&gt;ok = 1;<br>
            return foo;<br>
          }<br>
          <br>
          /* This should match */<br>
          void func_4(struct something *foo) {<br>
            if (!PointerIsValid(foo))<br>
              foo = malloc(sizeof(struct something));<br>
            foo-&gt;ok = 1;<br>
            printf("Error %s", foo-&gt;here);<br>
          }<br>
          <br>
          /* This should NOT match */<br>
          void func_5(struct something *foo) {<br>
            if (!PointerIsValid(foo))<br>
              foo = malloc(sizeof(struct something));<br>
            foo-&gt;ok = 1;<br>
            printf("Error %s", foo-&gt;here);<br>
            free(foo);<br>
          }<br>
          <br>
          /* This should NOT match */<br>
          struct something *func_6(struct something *foo) {<br>
            if (!PointerIsValid(foo))<br>
              foo = malloc(sizeof(struct something));<br>
            foo-&gt;ok = 1;<br>
            printf("Error %s", foo-&gt;here);<br>
            return foo;<br>
          }<br>
        </font></p>
    </blockquote>
    <p>Here is the new version of the semantic patch:</p>
    <blockquote>
      <p><font face="monospace">// Capture any malloc() to a local
          variable<br>
          @r@<br>
          local idexpression var;<br>
          position p;<br>
          @@<br>
            var@p = malloc(...)<br>
          <br>
          @@<br>
          local idexpression r.var;<br>
          position r.p;<br>
          @@<br>
          * var@p = malloc(...);<br>
            ... when != false !PointerIsValid(var)<br>
                when != true PointerIsValid(var)<br>
                when != free(var)<br>
                when != return (var);</font></p>
    </blockquote>
    <p>And here is the result.<br>
    </p>
    <blockquote>
      <p><span style="font-family:monospace"><span
style="font-weight:bold;color:#54ff54;background-color:#ffffff;">mats@abzu</span><span
            style="color:#000000;background-color:#ffffff;">:</span><span
style="font-weight:bold;color:#5454ff;background-color:#ffffff;">~/lang/cocci/tests</span><span
            style="color:#000000;background-color:#ffffff;">$ spatch
            --sp-file missing_free.cocci code/malloc-example.c
          </span><br>
          init_defs_builtins: /usr/lib/coccinelle/standard.h
          <br>
          HANDLING: code/malloc-example.c
          <br>
          diff =  <br>
          --- code/malloc-example.c
          <br>
          +++ /tmp/cocci-output-177912-b5da93-malloc-example.c
          <br>
          @@ -12,7 +12,6 @@ struct something {
          <br>
          /* This should match */
          <br>
          void func_1() {
          <br>
            struct something *foo;
          <br>
          -  foo = malloc(sizeof(struct something));
          <br>
            if (!PointerIsValid(foo)) {
          <br>
              printf("Error %s", foo-&gt;here);
          <br>
              return;
          <br>
          @@ -23,7 +22,6 @@ void func_1() {
          <br>
          /* This should NOT match */
          <br>
          struct something *func_2() {
          <br>
            struct something *foo;
          <br>
          -  foo = malloc(sizeof(struct something));
          <br>
            if (PointerIsValid(foo)) {
          <br>
              foo-&gt;ok = 1;
          <br>
              return foo;
          <br>
          @@ -35,7 +33,6 @@ struct something *func_2() {
          <br>
          /* This should NOT match */
          <br>
          struct something *func_3() {
          <br>
            struct something *foo;
          <br>
          -  foo = malloc(sizeof(struct something));
          <br>
            if (!PointerIsValid(foo)) {
          <br>
              printf("Error %s", foo-&gt;here);
          <br>
              return NULL;
          <br>
          @@ -47,7 +44,6 @@ struct something *func_3() {
          <br>
          /* This should match */
          <br>
          void func_4(struct something *foo) {
          <br>
            if (!PointerIsValid(foo))
          <br>
          -    foo = malloc(sizeof(struct something));
          <br>
            foo-&gt;ok = 1;
          <br>
            printf("Error %s", foo-&gt;here);
          <br>
          }</span></p>
    </blockquote>
    <p>I was assuming that you could pass in any expression in the "when
      != true expr", since that is what the grammar says. Was that wrong
      or did I make a mistake?<span style="font-family:monospace"><br>
      </span></p>
    <p>Best wishes,<br>
      Mats Kindahl<br>
    </p>
    <div class="moz-cite-prefix">On 2024-12-19 08:53, Julia Lawall
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:da51b2de-12cd-4aad-d989-79e925ead01f@inria.fr">
      <pre wrap="" class="moz-quote-pre">Thanks for the many test cases.

You can try this:

@r@
local idexpression var;
position p;
@@
var@p = malloc(...)

@@
local idexpression r.var;
position r.p;
@@

*var@p = malloc(...)
... when != true var == NULL
    when != false var != NULL
    when != free(var)
    when != return (var);

You may want to add some more when clauses like when != e-&gt;f = var

julia
</pre>
    </blockquote>
  </body>
</html>

--------------Uw06x4RzB3p7XwTcYwSY4UO6--
