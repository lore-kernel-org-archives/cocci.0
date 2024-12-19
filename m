Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C471CE7718A
	for <cocci@archiver.kernel.org>; Thu, 19 Dec 2024 07:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=q4Jp8eQZrZXaCuCyEFJ/vBgr8pXCcB24ofZPZX2U55A=;
  b=clBA1wm2639vpSVNRRSkV6hzxQyzsP3YTaL1BH9p/X3Da6NAHIfPRqEw
   HKvHC7Upq97kezr6XYz7ise2bcVPShwuefiH/YwEO7zM5OA7Xc3PqTZlt
   Pzfvw/EQ19d8DGRWdUCKxldzNg5lBAudi6f3kQxhrV3w0VxkxbxdbvRXa
   4=;
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
X-IronPort-AV: E=Sophos;i="6.12,247,1728943200"; 
   d="scan'208,217";a="199956669"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Dec 2024 08:25:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A504BE007A; Thu, 19 Dec 2024 08:25:57 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 40C14E0077
	for <cocci@sympa.inria.fr>; Thu, 19 Dec 2024 08:25:52 +0100 (CET)
IronPort-SDR: 6763ca7f_TypG21t4bvD2xtbYN4gfiRZwJ4s6Q2AmYrtYOcm77mGbxOD
 fAj6Vy6u3NIg1oUoi1Tq5NoCfM0U8Pj1oXS3sBw==
X-IPAS-Result: =?us-ascii?q?A0E8DwB8yWNnfLPQVdFaHAEBATwBAQQEAQECAQEHAQGBa?=
 =?us-ascii?q?AKBcFKBVzMEU4RWj02BdC2BFoMokweGVoFAPg8BAwEMARQBLQIEAQEDBI9vA?=
 =?us-ascii?q?h4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBIhkHD?=
 =?us-ascii?q?hIphXsNgluBLGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBBQIsdxEEGQEbHgMSAw03AiQRAQUBNwEBHoJfgjABAzEDAZcnj0CBB?=
 =?us-ascii?q?UKLPn8WBQIWgQGCDQaCaddzChkoDWwDgWECBwkBCoE0AYRzKU4OgjgdASqBM?=
 =?us-ascii?q?gKEUYM5gSEPgVVEgRUnggFKCAGJC4JpBII6gmeDeYcygziJKooVCAcfEgkcB?=
 =?us-ascii?q?goCSwUQEgMEAwQEAQILCQoJAwMCDgIIAwIIBh8BPxIEEwoNCwcFHwgDBwwRC?=
 =?us-ascii?q?igDIhItDwNcBTQBCwMHAggCAgYDAgIEFAYDBQgDAgUFDQICCgIEAxUEBA8BA?=
 =?us-ascii?q?QIeAgYBAhABBwQBFAIKAwIFBgcCHAICAwMEBAMBBQMSAwsBBQYFAQEEDgECA?=
 =?us-ascii?q?QIBAQIDAw4CAgYCAgEJAgIBAQINCAEEAwgCBQMFAwoBAQECAQQJBA0GAwUDA?=
 =?us-ascii?q?wcDBAIDAgYCBAQFAgIDAwIDAQMDAgECAwkCAQ8PCQ8CAgMEAgYCAgEEJgIBF?=
 =?us-ascii?q?QUCAwQCAgcCAgMBAgECAgIEAgQCAgYDCQgBAgIHAQICAgMVAgUBBAkDAwUSD?=
 =?us-ascii?q?CADAgICAgMHCgMFAgEBAgQDAwMDCQ0HAgMBAgEDBQMBAgECCQMGAgIDAwUSG?=
 =?us-ascii?q?QUDAg8DAgEFBAIIEgsHAQEPFAUECQUVAwYCAwMWCwQFAwMDAQwFDA4CAgsDF?=
 =?us-ascii?q?wUBAQcBAw0IAwQEAgMDCQIBEAEDBAIJAgQBAgoCAgICAgQBAQUEAgQDAgUCA?=
 =?us-ascii?q?gEIBAMDAw0EAwgIAwUDDBICAgIJAgMBAgMDAwQNCBYNAwINGAoVEwcHAwMEC?=
 =?us-ascii?q?wIJAwQNAgQCAgEGAwYKBgcEBQYBAhgCAgYMBAMDCAMCAwICAQICAgERAgIJC?=
 =?us-ascii?q?A0FCQUGAhcDAgMIAQkDDwMCFAEGAggDBwEBBAICChEKAQECAgEGKAMBAQIUE?=
 =?us-ascii?q?wcDCAICAgIGFgwBBQcDBw8FBQQCAhYDAxIEBBACAgMDAgEBFAYVAQUCAwYLA?=
 =?us-ascii?q?QYBAgUEAgMEAhICEgMEAwoCDwMGAwQGAwECDBACBAIJCgEFBAMHBQIfAwMCA?=
 =?us-ascii?q?gULAggCAgUCBQcDCQsGAQIFAwQJAhQCEAICAgIIFwICAgUeAyYCBAMDAwMLA?=
 =?us-ascii?q?QICDgkDBD0GEwQCAwMCDgECAgsBAgIEAgMBBAcJAwMJCgcBCg0HAgIKCAkQA?=
 =?us-ascii?q?QICDwcDAgICAgYHDgMCEw8FBgYCCgcNCgMCAQICEwIDCQYDBQ0DBwQKDwIVA?=
 =?us-ascii?q?hYFAyACCAkLAgcOBQIFEgMOBQMCAhIEAgMGBQMBBwEXAwcIAgIMAgICAgUCB?=
 =?us-ascii?q?QIFGBEBDQQDAwMCCAEEFQYDCQgqCAQDCwYdAgIDAgQFAQETAQEBBQEJAgMCA?=
 =?us-ascii?q?wQIAwMDAwIDBAwLAgEHCAMDBgsICQYDAgcIGQMFBAMHBQshAgYDAgQFBAEFA?=
 =?us-ascii?q?hUNAgMZAgYDBhQLDAIGDggJAwcBAQECAgIIAQUFEgIDBAIFBAQBARIGAgEDA?=
 =?us-ascii?q?gIDBAIKAQICCgIICgEJFAQDCAMDAwMDBQEBAgIKBBMFBQIBBRMdAgkDIw8CA?=
 =?us-ascii?q?QsJCBM9DAcyBDYBCQsUBwYlgQCbRQEKEIEwg1YLCFIoExQcd0panl2nVDQHh?=
 =?us-ascii?q?B0FgVgGDJ9cBg8EL5dDkw6IKZBSo1wLhRkCCgcGESMSgTMBOIFcMxojgQGCN?=
 =?us-ascii?q?k8DGQ+OLRaDWL9RQjU8AgcBCgEBAwmFaYoDgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vSRD6ACOXm4
IronPort-HdrOrdr: A9a23:Rtec1qtAJD7iaTmBWfppt3uU7skDWNV00zEX/kB9WHVpm7+j5r
 iTdZUgpH3JYVMqMk3I9urwXJVoLUmsjqKdgrNhWotKPjOW3VdARbsKheCSoAEIcxefygc379
 YbT0ERMqyIMbE3t7ed3CCIV/glhPeImZrGuQ4c9RtQpMNRBp2IIz0WNu9TKCxLeDU=
X-Talos-CUID: 9a23:+tYaMG79t/fQL0ku69ss0EcwOOs7b3zm5n6IZG/oNXtQEJSfcArF
X-Talos-MUID: 9a23:moMKZgZL0wJ2N+BTqD3BgyxGaPxS06X/JnxTtpEkt8rUOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,247,1728943200"; 
   d="scan'208,217";a="104718534"
X-MGA-submission: =?us-ascii?q?MDH+PxGGC+d7/tW6/J4s0ZhaPhXY30oHHpfY87?=
 =?us-ascii?q?+HylZ6HQjp+z1GWxMtL9beqQz0OdguhWlmMtfMYKuPnLfWpCZXCtQDEG?=
 =?us-ascii?q?M71o6qq+7V+765R3d1dHsIrZjL2lkf2WEeygd/KQyAnXXAlY0Z1silU+?=
 =?us-ascii?q?BCalrRmX9Bn30LnOK7lDHm+w=3D=3D?=
Received: from mail-lj1-f179.google.com ([209.85.208.179])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 08:25:52 +0100
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30229d5b22fso5606291fa.2
        for <cocci@inria.fr>; Wed, 18 Dec 2024 23:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734593150; x=1735197950; darn=inria.fr;
        h=subject:from:content-language:to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q4Jp8eQZrZXaCuCyEFJ/vBgr8pXCcB24ofZPZX2U55A=;
        b=NzLMwHbc+TlgCesV5Oua4zwvV3wteHvHQ/P71nQ7AH5g9n7hNeCgk7zAzmqWwS6A57
         jRonE8GzAMQXKpd2mNgYqTXnKno1ML39KzavPgsNXE0b7ZrG5zJaFD0Yzh1g+A70dqR4
         r0iC+Dz6Dr8TjWFNEyQ2R05VX8hv42wR6w3SW77ZkdMQPUboPG6QpN2ZeWN7KbGL5j0V
         zbv7jkdybCu9Td+pSAXCccXIFjqUtaDrVNN4viTbE74pZWUt8oD0pkIkwHZ9l0XeyZCM
         sM+qvy/EkCyVL/l34i+KC252mP72y9GBWBQmeopSiJvkaoVImobwvSY89RYRvfDusAjY
         qcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734593150; x=1735197950;
        h=subject:from:content-language:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4Jp8eQZrZXaCuCyEFJ/vBgr8pXCcB24ofZPZX2U55A=;
        b=igeL/fLpAFCQ+y18z+87s+z1C598wpsXNacO5L9PD3+7s9hU1twWxSlaZb/92VN8hk
         CG/N/25UAim8L2eJaka+PlPH7JE6fBibPPXzwrAmV+0jX+NZtqXL5IqdzOyO2GyfHlXg
         80eBOaIMgQj/FkafF6O6IELuS9GdgnAHkpRyRuYhzXw1rEZnuO7q3Zn+1xTpADPfnRrP
         FBu0jLqq4TLtIjw0cLVbYMNebK2631oompZetVV9PvDlVqPBPN8YKOTUxmNQNMC2Y+wt
         J737J+4SkUFEEiPsQ8EbtM6quA069KSoBS+D8ibEhHBWKOkHFm/GiB6jEt4DrMZ52rwD
         Ob5w==
X-Gm-Message-State: AOJu0YwXkgDYoU3GcmId9f05cjMvhRXuaKghhejDdq7EljbWXysmZrYA
	9JooUticlC5rVXhu6xu346+L7wtH/1CW+SSc+Ruyro0Ojke8OTyYF8Wb5Q==
X-Gm-Gg: ASbGnctwfsaL3T0QZcPWylDjn3xSZxhJi4KRhV3ptR2TOe+auRzHep4Q5JCkTuCaMw6
	SDadtdOtnbNxQrpoxaxPih+e9zT0i+hOXpy+4FvLSSd6/AFUvu1CL2xzxAzNRw95JWKd1jHTeCH
	LxD1sDxZjGgf2ipkC+hH1oy8H2uJDqPbY3/2QF09/AlNGDhdpkeAT5FfO9Gbg5gC6iB1gkPKcgE
	2Avr8/VDkfrx77TtdbN3xYRg90tjh0T6j5yMT4C8ddsXBuabEoiop4oxjQyw6e/3UYcYKp9QbBM
	6I71/ZZqv2WDLQQ8iSsrG4k2HbRlsA==
X-Google-Smtp-Source: AGHT+IE8jryktPy7tZC6q5aiRrtIhHXb2sQr2e6WMLrNPA4KGWIowjd/JpfhImRXxj2D/a11MqvgkA==
X-Received: by 2002:a2e:a592:0:b0:302:40ec:9f92 with SMTP id 38308e7fff4ca-30457a42e4emr8572701fa.32.1734593149530;
        Wed, 18 Dec 2024 23:25:49 -0800 (PST)
Received: from ?IPV6:2a02:aa1:114d:98dc:cb3:8390:555f:e497? ([2a02:aa1:114d:98dc:cb3:8390:555f:e497])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad9bb7asm1221931fa.46.2024.12.18.23.25.47
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 23:25:48 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------JF7twP9aXPiYIGzGHeSgfZcG"
Message-ID: <f0764391-b0d3-48fa-8a54-6edddf8d2c8d@gmail.com>
Date: Thu, 19 Dec 2024 08:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-US
From: Mats Kindahl <mats.kindahl@gmail.com>
Subject: [cocci] Depends on with negative matches
Reply-To: Mats Kindahl <mats.kindahl@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2184
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/f0764391-b0d3-48fa-8a54-6edddf8d2c8d%40gmail.com>

This is a multi-part message in MIME format.
--------------JF7twP9aXPiYIGzGHeSgfZcG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

I want have a case where I want to find missing resource releases. The 
real case is a different one, so I am creating a similar case using 
malloc() and want to find any malloc() that is either not freeing the 
memory or returning it to the caller. Here are a few cases:

    #include <stdio.h>
    #include <stdlib.h>

    struct something {
       const char *here;
       int ok;
    };

    /* This should match */
    void func_1() {
       struct something *foo;
       foo = malloc(sizeof(struct something));
       if (!foo) {
         printf("Error %s", foo->here);
         return;
       }
       foo->ok = 1;
    }

    /* This should NOT match */
    struct something *func_2() {
       struct something *foo;
       foo = malloc(sizeof(struct something));
       if (foo) {
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
       if (!foo) {
         printf("Error %s", foo->here);
         return NULL;
       }
       foo->ok = 1;
       return foo;
    }

    /* This should match */
    void func_4(struct something *foo) {
       if (!foo)
         foo = malloc(sizeof(struct something));
       foo->ok = 1;
       printf("Error %s", foo->here);
    }

    /* This should NOT match */
    void func_5(struct something *foo) {
       if (!foo)
         foo = malloc(sizeof(struct something));
       foo->ok = 1;
       printf("Error %s", foo->here);
       free(foo);
    }

    /* This should NOT match */
    struct something *func_6(struct something *foo) {
       if (!foo)
         foo = malloc(sizeof(struct something));
       foo->ok = 1;
       printf("Error %s", foo->here);
       return foo;
    }

I tried this semantic patch, but unfortunately it does not seem to 
capture the dependencies correctly.

    // Capture any malloc() to a local variable
    @r@
    local idexpression var;
    position p;
    @@
       var@p = malloc(...);

    // Detect cases that either free the variable or return it. Expect an
    // intermediate NULL check with error handling code that can do
    // anything it likes.
    @r1@
    local idexpression r.var;
    position r.p;
    statement S;
    @@
       var@p = malloc(...);
       ...
       if (var == NULL) S
       ...
    (
       free(var);
    |
       return var;
    )

    // Detect cases that either free the variable or return it. Expect an
    // non-NULL check that then either returns or free the variable. We
    // ignore any code that follows this if statement and assume that is
    // error handling code.
    @r2@
    local idexpression r.var;
    position r.p;
    @@
       var@p = malloc(...);
       ...
       if (var != NULL) {
         ...
    (
         free(var);
         ...
    |
         return var;
    )
       }

    // If neither of the above cases match, then we have a bad malloc, so
    // mark it.
    @depends on !r1 && !r2@
    local idexpression r.var;
    position r.p;
    @@
    * var@p = malloc(...);

Unfortunately, it matches correctly in most cases, but some of the cases 
are not detected correctly.

    mats@abzu:~/lang/cocci/tests$ spatch --sp-file missing_free.cocci
    code/malloc-example.c
    init_defs_builtins: /usr/lib/coccinelle/standard.h
    HANDLING: code/malloc-example.c
    diff =
    --- code/malloc-example.c
    +++ /tmp/cocci-output-172050-d31474-malloc-example.c
    @@ -9,7 +9,6 @@ struct something {
    /* This should match */
    void func_1() {
       struct something *foo;
    -  foo = malloc(sizeof(struct something));
       if (!foo) {
         printf("Error %s", foo->here);
         return;
    @@ -44,7 +43,6 @@ struct something *func_3() {
    /* This should match */
    void func_4(struct something *foo) {
       if (!foo)
    -    foo = malloc(sizeof(struct something));
       foo->ok = 1;
       printf("Error %s", foo->here);
    }
    @@ -52,7 +50,6 @@ void func_4(struct something *foo) {
    /* This should NOT match */
    void func_5(struct something *foo) {
       if (!foo)
    -    foo = malloc(sizeof(struct something));
       foo->ok = 1;
       printf("Error %s", foo->here);
       free(foo);
    @@ -61,7 +58,6 @@ void func_5(struct something *foo) {
    /* This should NOT match */
    struct something *func_6(struct something *foo) {
       if (!foo)
    -    foo = malloc(sizeof(struct something));
       foo->ok = 1;
       printf("Error %s", foo->here);
       return foo;

I tried to look at the kmalloc() examples in the coccinellery and also 
some other examples in the source code that seems to do similar things, 
but none have this case with "either free or return" and multiple cases 
with negative dependencies. It seems like you can get it mostly correct 
if you just keep the first rule only (with the NULL check), but I want 
to capture the "positive branch" case as well, where you check for 
non-NULL and then execute some code that should end with either a free 
or a return.

Anybody have some insight into what I've done wrong or if there is a 
better way to solve this problem?

Best wishes,
Mats Kindahl


--------------JF7twP9aXPiYIGzGHeSgfZcG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi all,</p>
    <p>I want have a case where I want to find missing resource
      releases. The real case is a different one, so I am creating a
      similar case using malloc() and want to find any malloc() that is
      either not freeing the memory or returning it to the caller. Here
      are a few cases:</p>
    <blockquote>
      <p><font face="monospace">#include &lt;stdio.h&gt;<br>
          #include &lt;stdlib.h&gt;<br>
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
            if (!foo) {<br>
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
            if (foo) {<br>
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
            if (!foo) {<br>
              printf("Error %s", foo-&gt;here);<br>
              return NULL;<br>
            }<br>
            foo-&gt;ok = 1;<br>
            return foo;<br>
          }<br>
          <br>
          /* This should match */<br>
          void func_4(struct something *foo) {<br>
            if (!foo)<br>
              foo = malloc(sizeof(struct something));<br>
            foo-&gt;ok = 1;<br>
            printf("Error %s", foo-&gt;here);<br>
          }<br>
          <br>
          /* This should NOT match */<br>
          void func_5(struct something *foo) {<br>
            if (!foo)<br>
              foo = malloc(sizeof(struct something));<br>
            foo-&gt;ok = 1;<br>
            printf("Error %s", foo-&gt;here);<br>
            free(foo);<br>
          }<br>
          <br>
          /* This should NOT match */<br>
          struct something *func_6(struct something *foo) {<br>
            if (!foo)<br>
              foo = malloc(sizeof(struct something));<br>
            foo-&gt;ok = 1;<br>
            printf("Error %s", foo-&gt;here);<br>
            return foo;<br>
          }<br>
        </font></p>
    </blockquote>
    <p><font face="monospace"></font>I tried this semantic patch, but
      unfortunately it does not seem to capture the dependencies
      correctly.</p>
    <blockquote>
      <p><font face="monospace">// Capture any malloc() to a local
          variable<br>
          @r@<br>
          local idexpression var;<br>
          position p;<br>
          @@<br>
            var@p = malloc(...);<br>
          <br>
          // Detect cases that either free the variable or return it.
          Expect an<br>
          // intermediate NULL check with error handling code that can
          do<br>
          // anything it likes.<br>
          @r1@<br>
          local idexpression r.var;<br>
          position r.p;<br>
          statement S;<br>
          @@<br>
            var@p = malloc(...);<br>
            ...<br>
            if (var == NULL) S<br>
            ...<br>
          (<br>
            free(var);<br>
          |<br>
            return var;<br>
          )<br>
          <br>
          // Detect cases that either free the variable or return it.
          Expect an<br>
          // non-NULL check that then either returns or free the
          variable. We<br>
          // ignore any code that follows this if statement and assume
          that is<br>
          // error handling code.<br>
          @r2@<br>
          local idexpression r.var;<br>
          position r.p;<br>
          @@<br>
            var@p = malloc(...);<br>
            ...<br>
            if (var != NULL) {<br>
              ...<br>
          (<br>
              free(var);<br>
              ...<br>
          |<br>
              return var;<br>
          )<br>
            }<br>
          <br>
          // If neither of the above cases match, then we have a bad
          malloc, so<br>
          // mark it.<br>
          @depends on !r1 &amp;&amp; !r2@<br>
          local idexpression r.var;<br>
          position r.p;<br>
          @@<br>
          * var@p = malloc(...);<br>
        </font></p>
    </blockquote>
    <p>Unfortunately, it matches correctly in most cases, but some of
      the cases are not detected correctly.</p>
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
          +++ /tmp/cocci-output-172050-d31474-malloc-example.c
          <br>
          @@ -9,7 +9,6 @@ struct something {
          <br>
          /* This should match */
          <br>
          void func_1() {
          <br>
            struct something *foo;
          <br>
          -  foo = malloc(sizeof(struct something));
          <br>
            if (!foo) {
          <br>
              printf("Error %s", foo-&gt;here);
          <br>
              return;
          <br>
          @@ -44,7 +43,6 @@ struct something *func_3() {
          <br>
          /* This should match */
          <br>
          void func_4(struct something *foo) {
          <br>
            if (!foo)
          <br>
          -    foo = malloc(sizeof(struct something));
          <br>
            foo-&gt;ok = 1;
          <br>
            printf("Error %s", foo-&gt;here);
          <br>
          }
          <br>
          @@ -52,7 +50,6 @@ void func_4(struct something *foo) {
          <br>
          /* This should NOT match */
          <br>
          void func_5(struct something *foo) {
          <br>
            if (!foo)
          <br>
          -    foo = malloc(sizeof(struct something));
          <br>
            foo-&gt;ok = 1;
          <br>
            printf("Error %s", foo-&gt;here);
          <br>
            free(foo);
          <br>
          @@ -61,7 +58,6 @@ void func_5(struct something *foo) {
          <br>
          /* This should NOT match */
          <br>
          struct something *func_6(struct something *foo) {
          <br>
            if (!foo)
          <br>
          -    foo = malloc(sizeof(struct something));
          <br>
            foo-&gt;ok = 1;
          <br>
            printf("Error %s", foo-&gt;here);
          <br>
            return foo;<br>
        </span></p>
    </blockquote>
    <p>I tried to look at the kmalloc() examples in the coccinellery and
      also some other examples in the source code that seems to do
      similar things, but none have this case with "either free or
      return" and multiple cases with negative dependencies. It seems
      like you can get it mostly correct if you just keep the first rule
      only (with the NULL check), but I want to capture the "positive
      branch" case as well, where you check for non-NULL and then
      execute some code that should end with either a free or a return.<br>
    </p>
    <p>Anybody have some insight into what I've done wrong or if there
      is a better way to solve this problem?<br>
    </p>
    <p>Best wishes,<br>
      Mats Kindahl<br>
    </p>
    <p><br>
    </p>
  </body>
</html>

--------------JF7twP9aXPiYIGzGHeSgfZcG--
