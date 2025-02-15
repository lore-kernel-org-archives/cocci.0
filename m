Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B28C021A0
	for <cocci@archiver.kernel.org>; Sat, 15 Feb 2025 18:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JrohxxJ6YxaWT6UvAdmUu1ceyso33fNSfUV9BDFHdZ4=;
  b=rGGJWERIRcJYtsWg2qFXTKzHLQbUrJlawXtPgtaAJFsbqL/VWawEGFnZ
   iqy/V2C5vHxeZLl6eLTPRyfPjBSgq7uCSh+qxdz0f9aBwTFxYqNPdt9lj
   bKEd8Afb9isa00fzUl5w5iKQdpGXTMUpDHgBI/HyS5V94H6/FakTmdH01
   g=;
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
X-IronPort-AV: E=Sophos;i="6.13,289,1732575600"; 
   d="scan'208,217";a="208446324"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Feb 2025 19:53:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DF13BE0261; Sat, 15 Feb 2025 19:53:12 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3C3B1E0260
	for <cocci@sympa.inria.fr>; Sat, 15 Feb 2025 19:53:08 +0100 (CET)
IronPort-SDR: 67b0e293_VXmDZ9DhM6zylvxzM/eV6kayfzfre3lrjchSNgudIlB9Re1
 FVKtUM5oE4VTmEKaDZLGYrfv1XEnOenw1hoqDNQ==
X-IPAS-Result: =?us-ascii?q?A0FfBwBi4bBnfCmnVdFaHgErCwYMgXUCgXBSgVczBFOEV?=
 =?us-ascii?q?o9PgXQthD6HO4tJhlWBQD4PAQMBDAFCAgQBAQMEkA0CHgcBBDIHDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEiGQcOEimFew1JARABggCBL?=
 =?us-ascii?q?GECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQIsd?=
 =?us-ascii?q?xEEGQEbHgMSAw03AiQRAQUBNwEBHoJggjABAzEDAZJ0j0CBBUKLPn8WBQIWg?=
 =?us-ascii?q?QGCDQaCatdzChkoDWwDgWICBwkBCoE0hHUpTg6COB0BKoEyAoRRgzmBIQ+BV?=
 =?us-ascii?q?USBPAuCR4kNgmkEgi+BQINuhkgSgw2Df4RrkwUIBx8SCRwGCgJLBRASAwQDB?=
 =?us-ascii?q?AQBAgsJCgkDAwIOAggDAggGGQE/EgQTCg0LBwUfCggMEQooAyISKw8DWAU0A?=
 =?us-ascii?q?QgGAgIEBAIEDAIJAgIIBwIUAwIEBAIBBRIDCwEFBgUBAQQJDgICBgICAQgCA?=
 =?us-ascii?q?gEBAhMBBAMIAgUDBQMKAQEBAgEEFAYDBQMDBwMEAgMCBgIEBAYCAgMDAgMBA?=
 =?us-ascii?q?wMCAQIDCRAPFgICAwQCBgICAQQmAgEVBQIDBAICBwICAwECAQICAgQCBAICB?=
 =?us-ascii?q?gMJCAECAgcBAgICAxUCBQEECQMDBRIMIAMCAgICAwcKAwUCAQECBAMDAwMMD?=
 =?us-ascii?q?QcCAwECAQMFAwECAQIJAwYCAgMDBBIZBQMCDwMCAQUEAggQCwcBAQ8UBQQJB?=
 =?us-ascii?q?RUDBgIDAxYLBAUDAwMBDA8OAgILAxcFAQEHAQMNCAMEBAIDAwkCARABAwQCC?=
 =?us-ascii?q?QIEAQIKAgICAgIEAQEFBAIEAwIFAgIBCAQDAwMNBAMICAMFAwwSAgICCQIDA?=
 =?us-ascii?q?QIDAwMEDQgdBQkRCwIJAwQNAgQCAgEGAwYKBgUEBQYBAhgCAgYMBAMDCAMCA?=
 =?us-ascii?q?wICAQICAgERAgIJCA0FCQUGAhcDAgMIAQkDDwMCFAEGAggDBwEBBAICChEKA?=
 =?us-ascii?q?QECAgEGJQIBAQITEwcDCAICAgIGFgwBBQcDBw8FBQQCAhYDAxIEBBACAgMDA?=
 =?us-ascii?q?gEBFAYVAQUCAwYLAQYBAgUEAgMEAhICERMDAwQGAwECChACBAIJCgEFBAMHB?=
 =?us-ascii?q?QIfAwMCAgULAggCAgUCBQcDCQ4BAgUDBAkCFAIQAgICAggWAgICBRwDJgIEA?=
 =?us-ascii?q?wMDAwsBAgIOCQMENgYRBAIDAwIOAQICCwECAgQCAwEEBwkDAwkKBwEKDQcCA?=
 =?us-ascii?q?goICRABAgIPBwMCAgICBgcOAwITDwUGBgIKBw0LAgECAhMCAwkGAwUNAwcEC?=
 =?us-ascii?q?g0CFQIWBQMgAggJCwIHEQIFEgMOBQMCAhEEAgMDBQMBBwEXAwcIAgIMAgICA?=
 =?us-ascii?q?gUCBQIFFxEBDQQDAwMCCAEEFQYDCQgqGxIBAQEFAQkCAwIDBAgDAwMCAwQMC?=
 =?us-ascii?q?wIBBwgDAwYLCAkGAwIHCBkDBQQDBwULIQIGAwIEBQQBBQITDQIDGQIGAwYRC?=
 =?us-ascii?q?QwCBggHCQMHAQEBAgICCAEGBRICAwQCBQQEAQESBgIBAwICAwQJAQICCgIIC?=
 =?us-ascii?q?gEJEwQDCAMDAwMDBQECAggEEQUFAgEFChMMAQoGAwYDBAICAgsHAgMDAwIHA?=
 =?us-ascii?q?QsaCQIBAwICBQICAQUDAgIGBAMCAQEJAgMCCAECAgEBAgICBAEHAQsGAQECB?=
 =?us-ascii?q?AICNgIBAwkCBQEBAQ4CBgICAQICAgQCBAEICwQFDQEBAgECAgEBAQQBCAMBA?=
 =?us-ascii?q?QECAgMDBQMFAwgPDQEBFwsdBQQFAgIBAQEBAQITAgIBCwECAQEDGgIBAwMEA?=
 =?us-ascii?q?QsCAQEEHwQWAgICAgICBAMCAgMCAgIEBxMlAQMBAwIBBgMTAgICAgIEAgECA?=
 =?us-ascii?q?gUFBQEDBBETCQEDAgUEAgIGAgQGCgIHBAIaBAICAgEDBAYDAQIIAgIKBAIDA?=
 =?us-ascii?q?gIKAgIDAQICBxkdAgkDIw8CAQsJCBM9DAcyBDYBCQsUBwYlgQCeGwoQgRiDZ?=
 =?us-ascii?q?T+BFQgMHCuBFkAaW54IpkyBCjQHhB4FgVgGDJ9dBg8EL5dDkw+IQ5A6qQQCC?=
 =?us-ascii?q?gcGESMSgTkBMoFcMxojUDGCNk8DGQ+OLRaDWMZMQjU8AgcBCgEBAwmFaYdKg?=
 =?us-ascii?q?m6BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wQ=
IronPort-HdrOrdr: A9a23:e/FeIKv1CoTVpmr6Qvi99Da17skDWNV00zEX/kB9WHVpm7+j5r
 iTdZUgpH3JYVMqMk3I9urwXJVoLUmsjqKdgrNhWotKPjOW3VdARbsKheCSoAEIcxefygc379
 YbT0ERMqyIMbE3t7ed3CCIV/glhPeImZrGuQ4c9RtQpMNRBp2IIz0WNu9TKCxLeDU=
X-Talos-CUID: 9a23:tZBfgGF3e7O3zO1nqmJt+BQ3PMxickb3zUnoLnLkBVZMR4ysHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AqrN1qw5iNeMnYW4U0LTchcOgxoxzw+OEWBAcr6x?=
 =?us-ascii?q?BnNa0ZBFgeBWChi24F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,289,1732575600"; 
   d="scan'208,217";a="109200543"
X-MGA-submission: =?us-ascii?q?MDFdToHZverGMzX15gwVe/9Cl5ICkLrn3/NlO7?=
 =?us-ascii?q?uud7fq81D+Q88DyzR2rZOfo6YJxiLhSMAqpSjjSWAI02+VdiAC6InEmv?=
 =?us-ascii?q?PACKs53u/6i3C/5UjeUdR4XMYq3xZ4dXSiUOrIZ5hz951QiWhYm5ewht?=
 =?us-ascii?q?BQy6TK5FiWS+Apim9Rrv9jLg=3D=3D?=
Received: from mail-lf1-f41.google.com ([209.85.167.41])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 19:53:07 +0100
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5453153782aso554407e87.2
        for <cocci@inria.fr>; Sat, 15 Feb 2025 10:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739645586; x=1740250386; darn=inria.fr;
        h=subject:from:content-language:to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JrohxxJ6YxaWT6UvAdmUu1ceyso33fNSfUV9BDFHdZ4=;
        b=lqF5Jrh9X8Jmuhdb5xNQ4NHZnmzY25v4z1FCalGD6lpdiDiNvwNjf7Y4GOXNOAEplI
         uvj4qVY2Xz+kbQfXudGkxiFcS9YFowAR8IhS889mS/DE8gmWzr6C3ten2UoAfYx8JDNI
         KkfI2eAG4aPJr7usGcOYZCjV2QhDBxkySBhZTBkFas+aEExbdNN7L/3dC5eldSE5vbeB
         b0pmrinNkGLIca/alucZWCcTCC6eVSg8Oj2KNlmdebdE8VmQdqEdtlyT78fx2nprZjaN
         FF/JaWWFEtBSJef0SVzV4LG2lMTWw8n7N0oWvHzV8wyXANL5R4472J4aVA8oGTj0UimI
         UfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739645586; x=1740250386;
        h=subject:from:content-language:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrohxxJ6YxaWT6UvAdmUu1ceyso33fNSfUV9BDFHdZ4=;
        b=pk9A3T24++TycFzhiHmGOGJU7ans1vWgcfqXc1sW2wSjmiaPpgHdxR5cTxwmrh3B4+
         krqsohYESvqHueWlx6Y1FJwf0k+82yVqNTGDsLgKNxzWapfoGLDQmTVncFqMIQmAfNHb
         Ku4N2J3upQC4sT2sKMNREi/LsBcV1koljLESORaFsLoW3o688TxGa7fw/RBymcJf/o6b
         C/+RonpDl/sGUGKvQSlawaAiEEB6fJp9A75wBHqLKLds8nZ4oU107sgC7hRetyCb4WFF
         G1aChpMy0B55gxSVa0baxP20tOH/sN7FxTF2ulwrg4aHUPaEC41L7v729u6K/N7nZt1Q
         yuRQ==
X-Gm-Message-State: AOJu0Yy7Doc213a3hngm3siCUpEwoNhO/Luj+FF1uURNlVJ9FIF/12BZ
	Won/u1ddXXBjCOg+4D+Ck2dGCfJzY/WivwRWTVnRxZIfAk0Fm8ld9H7PAw==
X-Gm-Gg: ASbGncvJGW6on2PcmFxVkPb1+GW3raSR2FpVVtJcaBCLOfzQ5vJ1IIvcoO5mzi9XzdT
	RMiL9gl42a0EP/1Qe2EuTQ8l7wrk+iPASajqY68Rpn3LQ+kbQyYKb2PeY96aiXQDQUcgz64sHkO
	LHgobSNxaO7IjFso+HDQwtc2eplFW404FFWpQdHjNgkUlrLo8EkVt1tfTLSoaBZIJnk8wOXCRsJ
	E2W/cUDsWXN4KmUZ7qNsZUKVri0zBMjPKEFiEvtW62pKv4KkKCM6d1aPWPgh9/ZaxWJAnnbLSLZ
	jHBj16iDimt1iVTuS5uod9Sx4nzsyHWrCR27YjbBmZR231SgP1gdR+vLCLqWb4U/Tz4=
X-Google-Smtp-Source: AGHT+IEjHJVdb5dkB+nRkR2CfSz2MvA34Imb0ZPd3rncVAajnOSAQ8C5x7RYA4+oZvdvj2LWi5w5rg==
X-Received: by 2002:a05:6512:308d:b0:545:2ed9:5048 with SMTP id 2adb3069b0e04-5452fea611dmr1147965e87.45.1739645585368;
        Sat, 15 Feb 2025 10:53:05 -0800 (PST)
Received: from ?IPV6:2a02:aa1:104a:f928:494c:6b3d:f8ae:c70c? ([2a02:aa1:104a:f928:494c:6b3d:f8ae:c70c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461a6efd88sm56479e87.69.2025.02.15.10.53.04
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 10:53:04 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------FIeNxK2UL6KFOlYMg0eg8cl9"
Message-ID: <592e3d24-4d42-43c7-9874-8c8eb1e12deb@gmail.com>
Date: Sat, 15 Feb 2025 19:53:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-US
From: Mats Kindahl <mats.kindahl@gmail.com>
Subject: [cocci] Adding statement after declarations with zero-length match
 after
Reply-To: Mats Kindahl <mats.kindahl@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2416
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/592e3d24-4d42-43c7-9874-8c8eb1e12deb%40gmail.com>

This is a multi-part message in MIME format.
--------------FIeNxK2UL6KFOlYMg0eg8cl9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi again,

Here is one case again that is stumping me. Suppose that we want to 
write an SmPL to replace dynamic allocations inside a function where the 
allocated object is not visible outside the function. For example, 
consider this example:

    #include <stdio.h>
    #include <stdlib.h>

    struct magic {
       int i_val;
       float f_val;
    };

    extern void magic_init(struct magic *);

    void foo_2(void) {
       struct magic more = malloc(sizeof(struct magic));
       more->i_val = 1;
       printf("%d", more->i_val);
       free(more);
    }

Here we want this to be rewritten to

    void foo_2(void) {
       struct magic more;
       magic_init(&more);
       more.i_val = 1;
       printf("%d", more.i_val);
    }

However, if we for some reason return the pointer, we do not want it to 
be rewritten.

    struct magic *foo_3(void) {
       struct magic *ptr = malloc(sizeof(struct magic));
       ptr->i_val = 1;
       printf("%d", ptr->i_val);
       return ptr;
    }

There are a few more cases, but this is the basics. In particular I 
ignore assigning to and from the variable as well as calling other 
functions, because this is not part of the problem right now. Note that 
I want the call to "magic_init()" to be after all the declarations.

Using the following semantic script, we want to capture these cases and 
replace it with a stack allocation. This requires rewriting internal 
references as well, so we have a piece at the end that updates the 
references. Here I use the pattern of catching the case with a base 
rule, and then using that in a dependent rule. This allows be to capture 
the malloc call to a local idexpression but find the identifier when it 
is being declared so that I can replace it.

    @base exists@
    type T;
    local idexpression T *var;
    position p1;
    @@
       var@p1 = malloc(sizeof(T))
       ... when forall
           when != return var;

    @depends on patch exists@
    type base.T;
    position base.p1, p2;
    identifier var, fld;
    statement S,S1;
    @@
    (
    - T@p2 *var;
    + T var;
       ...
    - var@p1 = malloc(sizeof(T));
    + magic_init(&var);
    |
    - T@p2 *var@p1 = malloc(sizeof(T));
    + T var;
       ... when != S
    + magic_init(&var);
       S1
    )
       ... when any
    (
    - free(var);
    |
    - *var
    + var
    |
    - var->fld
    + var.fld
    |
    - var
    + &var
    )

However, since I match S1 after the added "magic_init(&var)", this means 
that the statement "more->i_val = 1;" does not get a replacement and the 
result is this:

    mats@abzu:~/lang/cocci/hacks$ spatch -D patch --cocci-file
    elim-malloc-free.cocci code/dynalloc.c
    init_defs_builtins: /usr/lib/coccinelle/standard.h
    (ONCE) Expected tokens malloc
    HANDLING: code/dynalloc.c
    diff =
    diff -u -p a/dynalloc.c b/dynalloc.c
    --- a/dynalloc.c
    +++ b/dynalloc.c
    @@ -9,10 +9,10 @@ struct magic {
    extern void magic_init(struct magic *);

    void foo_2(struct magic *out) {
    -  struct magic *ptr = malloc(sizeof(struct magic));
    +  struct magic ptr;
    +  magic_init(&ptr);
       ptr->i_val = 1;
    -  printf("%d", ptr->i_val);
    -  free(ptr);
    +  printf("%d", ptr.i_val);
    }

I've tried various constructions, including:

  * Skipping S1, but it insists that it needs a token to attach to.
  * Using a ( ... & ... ) to match a statement and do the replacement,
    but it insists that it needs a token to attach to.
  * Using declaration list before, but again, it needs a token to attach to.

In essence, I need some kind of "zero-length match" that can follow the 
replacement.

Any suggestions?

Best wishes,
Mats Kindahl

--------------FIeNxK2UL6KFOlYMg0eg8cl9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi again,</p>
    <p>Here is one case again that is stumping me. Suppose that we want
      to write an SmPL to replace dynamic allocations inside a function
      where the allocated object is not visible outside the function.
      For example, consider this example:</p>
    <blockquote>
      <p>#include &lt;stdio.h&gt;<br>
        #include &lt;stdlib.h&gt;<br>
        <br>
        struct magic {<br>
          int i_val;<br>
          float f_val;<br>
        };<br>
        <br>
        extern void magic_init(struct magic *);<br>
        <br>
        void foo_2(void) {<br>
          struct magic more = malloc(sizeof(struct magic));<br>
          more-&gt;i_val = 1;<br>
          printf("%d", more-&gt;i_val);<br>
          free(more);<br>
        }</p>
    </blockquote>
    <p>Here we want this to be rewritten to</p>
    <blockquote>
      <p>void foo_2(void) {<br>
          struct magic more;<br>
          magic_init(&amp;more);<br>
          more.i_val = 1;<br>
          printf("%d", more.i_val);<br>
        }</p>
    </blockquote>
    <p>However, if we for some reason return the pointer, we do not want
      it to be rewritten.<br>
    </p>
    <blockquote>
      <p>struct magic *foo_3(void) {<br>
          struct magic *ptr = malloc(sizeof(struct magic));<br>
          ptr-&gt;i_val = 1;<br>
          printf("%d", ptr-&gt;i_val);<br>
          return ptr;<br>
        }</p>
    </blockquote>
    <p>There are a few more cases, but this is the basics. In particular
      I ignore assigning to and from the variable as well as calling
      other functions, because this is not part of the problem right
      now. Note that I want the call to "magic_init()" to be after all
      the declarations.<br>
    </p>
    <p>Using the following semantic script, we want to capture these
      cases and replace it with a stack allocation. This requires
      rewriting internal references as well, so we have a piece at the
      end that updates the references. Here I use the pattern of
      catching the case with a base rule, and then using that in a
      dependent rule. This allows be to capture the malloc call to a
      local idexpression but find the identifier when it is being
      declared so that I can replace it.<br>
    </p>
    <blockquote>
      <p>@base exists@<br>
        type T;<br>
        local idexpression T *var;<br>
        position p1;<br>
        @@<br>
          var@p1 = malloc(sizeof(T))<br>
          ... when forall<br>
              when != return var;<br>
      </p>
      <p>@depends on patch exists@<br>
        type base.T;<br>
        position base.p1, p2;<br>
        identifier var, fld;<br>
        statement S,S1;<br>
        @@<br>
        (<br>
        - T@p2 *var;<br>
        + T var;<br>
          ...<br>
        - var@p1 = malloc(sizeof(T));<br>
        + magic_init(&amp;var);<br>
        |<br>
        - T@p2 *var@p1 = malloc(sizeof(T));<br>
        + T var;<br>
          ... when != S<br>
        + magic_init(&amp;var);<br>
          S1<br>
        )<br>
          ... when any<br>
        (<br>
        - free(var);<br>
        |<br>
        - *var<br>
        + var<br>
        |<br>
        - var-&gt;fld<br>
        + var.fld<br>
        |<br>
        - var<br>
        + &amp;var<br>
        )<br>
      </p>
    </blockquote>
    <p>However, since I match S1 after the added "magic_init(&amp;var)",
      this means that the statement "more-&gt;i_val = 1;" does not get a
      replacement and the result is this:</p>
    <blockquote>
      <p><span style="font-family:monospace"><span
style="font-weight:bold;color:#54ff54;background-color:#ffffff;">mats@abzu</span><span
            style="color:#000000;background-color:#ffffff;">:</span><span
style="font-weight:bold;color:#5454ff;background-color:#ffffff;">~/lang/cocci/hacks</span><span
            style="color:#000000;background-color:#ffffff;">$ spatch -D
            patch --cocci-file elim-malloc-free.cocci code/dynalloc.c
          </span><br>
          init_defs_builtins: /usr/lib/coccinelle/standard.h
          <br>
          (ONCE) Expected tokens malloc
          <br>
          HANDLING: code/dynalloc.c
          <br>
          diff =  <br>
          diff -u -p a/dynalloc.c b/dynalloc.c
          <br>
          --- a/dynalloc.c
          <br>
          +++ b/dynalloc.c
          <br>
          @@ -9,10 +9,10 @@ struct magic {
          <br>
          extern void magic_init(struct magic *);
          <br>
           <br>
          void foo_2(struct magic *out) {
          <br>
          -  struct magic *ptr = malloc(sizeof(struct magic));
          <br>
          +  struct magic ptr;
          <br>
          +  magic_init(&amp;ptr);
          <br>
            ptr-&gt;i_val = 1;
          <br>
          -  printf("%d", ptr-&gt;i_val);
          <br>
          -  free(ptr);
          <br>
          +  printf("%d", ptr.i_val);
          <br>
          }</span></p>
    </blockquote>
    <p>I've tried various constructions, including:</p>
    <ul>
      <li>Skipping S1, but it insists that it needs a token to attach
        to.</li>
      <li>Using a ( ... &amp; ... ) to match a statement and do the
        replacement, but it insists that it needs a token to attach to.</li>
      <li>Using declaration list before, but again, it needs a token to
        attach to.</li>
    </ul>
    <p>In essence, I need some kind of "zero-length match" that can
      follow the replacement.</p>
    <p>Any suggestions?</p>
    <p>Best wishes,<br>
      Mats Kindahl<br>
    </p>
  </body>
</html>

--------------FIeNxK2UL6KFOlYMg0eg8cl9--
