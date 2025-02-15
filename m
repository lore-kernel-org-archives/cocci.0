Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB4CC021A0
	for <cocci@archiver.kernel.org>; Sat, 15 Feb 2025 21:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=MqG7khrejxxQxeNB5GKb6lPIUnaDtS4plkvdpCqhGtQ=;
  b=GAImyydaJoKRtqyPUP/RfP/Ahd6Y2Cuo35wjUVS+JG0GJ6xHZ2zoayny
   EDZ6i5Y+64F7m35V26GuhIxqezkPJFzQ4BgUs83uUEX2g5Msj5gIMMv9a
   686C7yUzuKUiMfbtVvwlY2QFZbLmTb5gz/ZUpcpHbBBuNRZNQTpozyCpO
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
   d="scan'208,217";a="208453531"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Feb 2025 22:27:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E2367E0264; Sat, 15 Feb 2025 22:27:01 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7C800E0260
	for <cocci@sympa.inria.fr>; Sat, 15 Feb 2025 22:26:57 +0100 (CET)
IronPort-SDR: 67b106a0_C1AhNmTldlRTdgbPhvUjW/Gr5cMlBiUbsvcuNTRUy4Iavi/
 hun+sl6e38igjRD0aHRMXbJ2vkfrh7S/EIQ4nuQ==
X-IPAS-Result: =?us-ascii?q?A0FDBADNBbFnfK3QVdFaHQEBAQEJARIBBQUBghOBclKBV?=
 =?us-ascii?q?zMEU4RWj0+BdC0DhDuHO4tJiBU+DwEDAQsBAUICBAEBAwQ4hEgCiwsCHgcBB?=
 =?us-ascii?q?DQTAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABASIZBw4SKYV7D?=
 =?us-ascii?q?YJiAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEFAixfAQEBAxIRBBkBGx0BAwwGAwILDSoCAiIRAQUBHAYVAQEegmCCMAEDM?=
 =?us-ascii?q?QMBknOPQIEFQos+fxYFAhaBAYINBtpdChkoDWwDgWICBwkBCoE0hHUpTg6CO?=
 =?us-ascii?q?B0BKoEyAoRRgzl6Jw+BVUSBPIJSMT6IHoJpBIIvSnYug0CGSBKDDYN/hGuTB?=
 =?us-ascii?q?QgHHxIJCRMGCgJLBRASAwQDBAQBAgsJCgkDAwIOAggDAggGGQE/EgQTCg0LB?=
 =?us-ascii?q?wUfCggMEQooAyIEDisPA1gFNAEIBgICBAQCBAIKAgkCAggHAhQDAgQEAgEFE?=
 =?us-ascii?q?gMLAQUGBQEBBAkOAgIDAwICAQgCAgEBAhMBBAMBBwIFAwUDCgEBAQIBBBQGA?=
 =?us-ascii?q?wUDAwcDBAIDAgYCBAQBBQICAwMCAwEDAwIBAgMJEA8WAgIDBAIGAgIBBCYCA?=
 =?us-ascii?q?RUFAgMEAgIHAgIDAQIBAgICBAIEAgIGAwkIAQICBwECAgIDFQIFAQQJAwMFE?=
 =?us-ascii?q?gwgAwICAgIDBwoDBQIBAQIEAwMDAwwNBwIDAQIBAwUDAQIBAgkDBgICAwMEE?=
 =?us-ascii?q?hkFAwIPAwIBBQQCCBALBwEBDxQFBAkFFQMGAgMDFgsEBQMDAwEMDw4CAgsDF?=
 =?us-ascii?q?wUBAQcBAw0IAwQEAgMDCQIBEAEDBAIJAgQBAgoCAgICAgQBAQUEAgQDAgUCA?=
 =?us-ascii?q?gEIBAMDAw0EAwgIAwUDDBICAgIJAgMBAgMDAwQNCB0FCRELAgkDBA0CBAICA?=
 =?us-ascii?q?QYDBgoGBQQFBgECGAICBgwEAwMIAwIDAgIBAgICARECAgkIDQUJBQYCAhUDA?=
 =?us-ascii?q?gMIAQkDDwMCFAEGAggDBwEBBAICChEKAQECAgEGJQIBAQITEwcDCAICAgIGF?=
 =?us-ascii?q?gwBBQcDBw8FBQQCAhYDAxIEBBACAgMDAgEBFAYVAQUCAwYLAQYBAgUEAgMEA?=
 =?us-ascii?q?hICERMDAwQGAwECChACBAIJCgEFBAMHBQIfAwMCAgULAggCAgUCBQcDCQ4BA?=
 =?us-ascii?q?gUDBAkCFAIQAgICAggWAgICBRwDJgIEAwMDAwsBAgIOCQMENgYRBAIDAwIOA?=
 =?us-ascii?q?QICCwECAgQCAwEEBwkDAwkKBwEKDQcCAgoICRABAgIPBwMCAgICBgcOAwITD?=
 =?us-ascii?q?wUGBgIKBw0LAgECAhMCAwkGAwUNAwcECg0CFQIWBQMgAggJCwIHEQIFEgMOB?=
 =?us-ascii?q?QMCAhEEAgMDBQMBBwEXAwcIAgIMAgICAgUCBQIFFxEBDQQDAwMCCAEEFQYDC?=
 =?us-ascii?q?QgqGxIBAQEFAQkCAwIDBAgDAwMCAwQMCwIBBwgDAwYLCAkGAwIHCBkDBQQDB?=
 =?us-ascii?q?wULIQIGAwIEBQQBBQITDQIDGQIGAwYRCQwCBggHCQMHAQEBAgICCAEGBRICA?=
 =?us-ascii?q?wQCBQQEAQEIAwMEBgIBAwICAgEECQEBAQIKAggKAQkTBAMIAwMDAwMFAQICC?=
 =?us-ascii?q?AQRBQUCAQUKEwwBCgYDBgMEAgICCwcCAwMDAgcBCxoJAgEDAgIFAgIBBQMCA?=
 =?us-ascii?q?gYEAwIBAQkCAwIIAQICAQECAgIEAQcBBAcGAQECBAICNgIBAwkCBQEBAQ4CA?=
 =?us-ascii?q?gQCAgECAgIEAgQBAgYLBAUNAQECAQICAQEBBAEIAwEBAQICAwMFAwUDCA8NA?=
 =?us-ascii?q?QEXCx0FBAUCAgEBAQEBAhMCAgELAQIBAQMaAgEDAwQBCwIBAQQfBBYCAgICA?=
 =?us-ascii?q?gIEAwICAwICAgQHEyUBAwEDAgEGAxMCAgICAgQCAQICBQUFAQMEERMJAQMCB?=
 =?us-ascii?q?QQCAgYCBAYKAgcEAhoEAgICAQMEBgMBAggCAgoEAgMCAgoCAgMBAgIHGR0CC?=
 =?us-ascii?q?QMjDwIBCwkIEz0MBzIENgEJCxQHBiWBAJ4bChCBGIQkBoEjHIFBPgIaW7EBk?=
 =?us-ascii?q?1OBCjQHhB6BXQYMn10GDwQvl0OTD4hDkDqpBAIKBwYRIxKBSSOBXDMaI4EBg?=
 =?us-ascii?q?jZPAxkPjiEMFoNYxkxCNTwCBwEKAQEDCYVpijiBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:lSRyWq8VJroyC8vExoBuk+AII+orL9Y04lQ7vn2ZhyYlCfBw5P
 re4cjztCWE6gr5PUtLpTnuAtjlfZqxz+8I3WBVB8bcYOCEghrOEGgB1/qG/9SIIUSXnZ8/6U
 4jSdkFNDSZNzhHZK3BkXCF+rgbsaG6GeyT9IHj5kYoYwUvRa8I1WhE48WgfnGehjMqOXP0Lv
 ShDwN8xgadRQ==
X-Talos-CUID: 9a23:ZGOrLWMRyP5+H+5DRXRK1BZONfsfMXD3x3DLBBSbMnlOcejA
X-Talos-MUID: 9a23:SXeZJgSSkt5Kku1gRXTQrxN5bcFju52wDQczrqosueSdGQlZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,289,1732575600"; 
   d="scan'208,217";a="109206386"
X-MGA-submission: =?us-ascii?q?MDGDBNJKUEOPvC6gCC0MsZo+X1Kmu8D/4lIdmn?=
 =?us-ascii?q?jsDyRBOjuwsIFswIjK1An5uS9lroSq1dk5eUhCJ5qW3fYXmGwO5R70Ge?=
 =?us-ascii?q?2Z7Nj8/7TdKRPbE2YUtlzrRx6PZ0zNgCw2h9vEAy/9cTeoqq6MOX3EUZ?=
 =?us-ascii?q?2m+c42ISzEcjS33D4qCDTnrQ=3D=3D?=
Received: from mail-lj1-f173.google.com ([209.85.208.173])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 22:26:57 +0100
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-307bc125e2eso31433851fa.3;
        Sat, 15 Feb 2025 13:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739654815; x=1740259615; darn=inria.fr;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqG7khrejxxQxeNB5GKb6lPIUnaDtS4plkvdpCqhGtQ=;
        b=ag2hWWdUOebXdnXo6mDhBvJz6wHmb3Ri7BaOH7zRL6mtpsovh4r2RYdfZm0YGgl0Pb
         4lBzKEH21xFioszUyZQGHEYwwRf/MQS+/i/mkLzpioLNBjB9P/aiMvnw4agrFeK0fwBY
         rW1QCjlCcwddR2ZQ6E+W2gm/aOv3S+mNa3dSOf04TmzOT45Rqgr1TxB+4bKxZUVjm0Ul
         M/h49WmyE+Je7LQjAuDMIeLmYMUdLTYRLmQb0ax5Lt6K4Um+3TKojQ0TnQT/9+InQgR1
         tg3hUdhLum9sRwY+aNkxVtqBmO5XA3BK8DtEzd1DXEDOpjhiTOZG1YW2rk2xc4gpitJi
         4XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739654815; x=1740259615;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MqG7khrejxxQxeNB5GKb6lPIUnaDtS4plkvdpCqhGtQ=;
        b=ZGrl6vu9Xg5sZvmREQHQtTcFK83jH6R+KlEFKSGtNnJY0ezL49szVo6bmoRowpcxSB
         JV6zhUNa6PvyinsSvIfoc52c3inKhRArXpFNThyoGkDoj19gIlnM8Z2mFHAlO+7477YE
         lYmP/Tn+lq/8VRHbz8Q/E985XDuvlTk1fI0NvlKpRsjo+phY73OSafQ88RQh7zSg2red
         Vur26WMVGUiiGGuENXeRcBJ78qojSJnhcihJoowPL47BLji+H7wtfFTbM7AHry2muRJa
         QlU2jdmp+gAtChT7VUtWwmePbPcPZUu2SP6jiOGPbZP03cwqupx9l7L9c8XQOqDm+A+q
         464A==
X-Gm-Message-State: AOJu0YzD6ttBovgkVGVRKQrLS/XVKwhCDV1zmMnXSBrSj/IiAYIofJcd
	u5pv3cHGGXSPD7LopkjZqHuHFv6PHuN0RAMQQY36o1jBJIl5Dt/yFr7keg==
X-Gm-Gg: ASbGncuKn9bVxD3yNqgf8llp0hlhbYXOOLEtnOyUYjYAWMtQC9TVPHKfibqew8SkfoU
	/BSza4cAz37irw0fd9wt+pnMOUANibrmjitEYzJxbBxbzLy9xYF2h9fVuHAKpk+HuloQwvCcR4K
	BFjOD/eXYKmkSC4ao0fcoaN4zJbLAUFkHpLl4Qrn+/q7vdl3DdT1nbl9HnfDf2O/RycV1WSPMRo
	uzyxehitDcHiUL+j015naBkeE2dRWRcKXH0Md/JL4bFHzsCMFIbT0Q/xXY0cllAPT5jSMToxq4V
	AqVWXCMtS8u4H9o3uJFJ4c0Z1ZwXY9NoBlnWKULC8pGZ7TImGeAvvRQP/i494knf6zs=
X-Google-Smtp-Source: AGHT+IHxC66qd6CeYk41EBDicAHYb6vpNh0m6nKy7GBw6JUTXwTwuTqYwVdCdxfr5YHL52cTapscEA==
X-Received: by 2002:a2e:8954:0:b0:300:38ff:f8de with SMTP id 38308e7fff4ca-30927a72243mr11100501fa.16.1739654814408;
        Sat, 15 Feb 2025 13:26:54 -0800 (PST)
Received: from ?IPV6:2a02:aa1:104a:f928:e313:31b7:4f7e:6f2a? ([2a02:aa1:104a:f928:e313:31b7:4f7e:6f2a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091011d347sm9974891fa.45.2025.02.15.13.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 13:26:53 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------yP3VPAp3LIzN1D7tMlBaKLAq"
Message-ID: <4c36f3b9-734b-4db9-9f12-0f433e452038@gmail.com>
Date: Sat, 15 Feb 2025 22:26:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <592e3d24-4d42-43c7-9874-8c8eb1e12deb@gmail.com>
 <alpine.DEB.2.22.394.2502152014120.17391@hadrien>
Content-Language: en-US
From: Mats Kindahl <mats.kindahl@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2502152014120.17391@hadrien>
Subject: Re: [cocci] Adding statement after declarations with zero-length
 match after
Reply-To: Mats Kindahl <mats.kindahl@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2419
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/4c36f3b9-734b-4db9-9f12-0f433e452038%40gmail.com>

This is a multi-part message in MIME format.
--------------yP3VPAp3LIzN1D7tMlBaKLAq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-02-15 20:17, Julia Lawall wrote:
>
> On Sat, 15 Feb 2025, Mats Kindahl wrote:
>
>> Hi again,
>>
>> Here is one case again that is stumping me. Suppose that we want to write an SmPL to replace dynamic allocations inside a function where the allocated object is not visible outside the function. For example, consider this example:
>>
>>        #include <stdio.h>
>>        #include <stdlib.h>
>>
>>        struct magic {
>>          int i_val;
>>          float f_val;
>>        };
>>
>>        extern void magic_init(struct magic *);
>>
>>        void foo_2(void) {
>>          struct magic more = malloc(sizeof(struct magic));
>>          more->i_val = 1;
>>          printf("%d", more->i_val);
>>          free(more);
>>        }
>>
>> Here we want this to be rewritten to
>>
>>        void foo_2(void) {
>>          struct magic more;
>>          magic_init(&more);
>>          more.i_val = 1;
>>          printf("%d", more.i_val);
>>        }
>>
>> However, if we for some reason return the pointer, we do not want it to be rewritten.
>>
>>        struct magic *foo_3(void) {
>>          struct magic *ptr = malloc(sizeof(struct magic));
>>          ptr->i_val = 1;
>>          printf("%d", ptr->i_val);
>>          return ptr;
>>        }
>>
>> There are a few more cases, but this is the basics. In particular I ignore assigning to and from the variable as well as calling other functions, because this is not part of the problem right now. Note that I want the call to "magic_init()" to be
>> after all the declarations.
>>
>> Using the following semantic script, we want to capture these cases and replace it with a stack allocation. This requires rewriting internal references as well, so we have a piece at the end that updates the references. Here I use the pattern of
>> catching the case with a base rule, and then using that in a dependent rule. This allows be to capture the malloc call to a local idexpression but find the identifier when it is being declared so that I can replace it.
>>
>>        @base exists@
>>        type T;
>>        local idexpression T *var;
>>        position p1;
>>        @@
>>          var@p1 = malloc(sizeof(T))
>>          ... when forall
>>              when != return var;
>>
>>        @depends on patch exists@
>>        type base.T;
>>        position base.p1, p2;
>>        identifier var, fld;
>>        statement S,S1;
>>        @@
>>        (
>>        - T@p2 *var;
>>        + T var;
>>          ...
>>        - var@p1 = malloc(sizeof(T));
>>        + magic_init(&var);
>>        |
>>        - T@p2 *var@p1 = malloc(sizeof(T));
>>        + T var;
>>          ... when != S
>>        + magic_init(&var);
>>          S1
>>        )
>>          ... when any
>>        (
>>        - free(var);
>>        |
>>        - *var
>>        + var
>>        |
>>        - var->fld
>>        + var.fld
>>        |
>>        - var
>>        + &var
>>        )
> You can try
>
> (
> + magic_init(&var);
>    S1 & <... ( - free(var); | and so on ) ...> )
> &
> <...
> (
> - free(var);
> |
>    // other cases
> )
> ...>
> )
>
> I would suggest to separate the second rule into two, which will require
> duplicating the first rule, because you can't inherit a position over a
> change.  I will play around with it shortly and get back to you.

Thanks Julia!

Splitting the rules worked and does what I expect:

    @base2 exists@
    type T;
    local idexpression T *var;
    position p1;
    expression E;
    @@
       var@p1 = malloc(sizeof(T))
       ... when forall
           when != return var;
           when != E = var
           when != var = E

    @depends on patch exists@
    type base2.T;
    position base2.p1;
    identifier var;
    identifier fld;
    @@
       var@p1 = malloc(sizeof(T))
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

    @base3 exists@
    type T;
    local idexpression T *var;
    position p1;
    expression E;
    @@
       var@p1 = malloc(sizeof(T))
       ... when forall
           when != return var;
           when != E = var
           when != var = E

    @depends on patch exists@
    type base3.T;
    position base3.p1, p2;
    identifier var;
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

Best wishes,
Mats Kindahl

--------------yP3VPAp3LIzN1D7tMlBaKLAq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2025-02-15 20:17, Julia Lawall
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:alpine.DEB.2.22.394.2502152014120.17391@hadrien">
      <pre wrap="" class="moz-quote-pre">

On Sat, 15 Feb 2025, Mats Kindahl wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Hi again,

Here is one case again that is stumping me. Suppose that we want to write an SmPL to replace dynamic allocations inside a function where the allocated object is not visible outside the function. For example, consider this example:

      #include &lt;stdio.h&gt;
      #include &lt;stdlib.h&gt;

      struct magic {
        int i_val;
        float f_val;
      };

      extern void magic_init(struct magic *);

      void foo_2(void) {
        struct magic more = malloc(sizeof(struct magic));
        more-&gt;i_val = 1;
        printf("%d", more-&gt;i_val);
        free(more);
      }

Here we want this to be rewritten to

      void foo_2(void) {
        struct magic more;
        magic_init(&amp;more);
        more.i_val = 1;
        printf("%d", more.i_val);
      }

However, if we for some reason return the pointer, we do not want it to be rewritten.

      struct magic *foo_3(void) {
        struct magic *ptr = malloc(sizeof(struct magic));
        ptr-&gt;i_val = 1;
        printf("%d", ptr-&gt;i_val);
        return ptr;
      }

There are a few more cases, but this is the basics. In particular I ignore assigning to and from the variable as well as calling other functions, because this is not part of the problem right now. Note that I want the call to "magic_init()" to be
after all the declarations.

Using the following semantic script, we want to capture these cases and replace it with a stack allocation. This requires rewriting internal references as well, so we have a piece at the end that updates the references. Here I use the pattern of
catching the case with a base rule, and then using that in a dependent rule. This allows be to capture the malloc call to a local idexpression but find the identifier when it is being declared so that I can replace it.

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
      + magic_init(&amp;var);
      |
      - T@p2 *var@p1 = malloc(sizeof(T));
      + T var;
        ... when != S
      + magic_init(&amp;var);
        S1
      )
        ... when any
      (
      - free(var);
      |
      - *var
      + var
      |
      - var-&gt;fld
      + var.fld
      |
      - var
      + &amp;var
      )
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
You can try

(
+ magic_init(&amp;var);
  S1 &amp; &lt;... ( - free(var); | and so on ) ...&gt; )
&amp;
&lt;...
(
- free(var);
|
  // other cases
)
...&gt;
)

I would suggest to separate the second rule into two, which will require
duplicating the first rule, because you can't inherit a position over a
change.  I will play around with it shortly and get back to you.</pre>
    </blockquote>
    <p>Thanks Julia!</p>
    <p>Splitting the rules worked and does what I expect:</p>
    <blockquote>
      <p>@base2 exists@<br>
        type T;<br>
        local idexpression T *var;<br>
        position p1;<br>
        expression E;<br>
        @@<br>
          var@p1 = malloc(sizeof(T))<br>
          ... when forall<br>
              when != return var;<br>
              when != E = var<br>
              when != var = E<br>
        <br>
        @depends on patch exists@<br>
        type base2.T;<br>
        position base2.p1;<br>
        identifier var;<br>
        identifier fld;<br>
        @@<br>
          var@p1 = malloc(sizeof(T))<br>
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
        <br>
        @base3 exists@<br>
        type T;<br>
        local idexpression T *var;<br>
        position p1;<br>
        expression E;<br>
        @@<br>
          var@p1 = malloc(sizeof(T))<br>
          ... when forall<br>
              when != return var;<br>
              when != E = var<br>
              when != var = E<br>
        <br>
        @depends on patch exists@<br>
        type base3.T;<br>
        position base3.p1, p2;<br>
        identifier var;<br>
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
        )</p>
    </blockquote>
    <p>Best wishes,<br>
      Mats Kindahl<br>
    </p>
  </body>
</html>

--------------yP3VPAp3LIzN1D7tMlBaKLAq--
