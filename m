Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3675E77184
	for <cocci@archiver.kernel.org>; Sat, 21 Dec 2024 14:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=r8wXYLrl1/UvuGyBeWBlT+Dn7AUW3Zy77oqcFKt2/lU=;
  b=EkDIKMNg5xjGlRFzeVELzVAXK2LBk6/SUZIqifuBtXUHprF9Gqd463rf
   tE+MMp+eTueAQ6koU5Tx3oWGW/g7wQzOvGWppLzUo5cbX6eg8mYjHKx4n
   zvmOyIBDy9HW/RX6NmxlMmfalnN63UypBZfZ82LNy/J9fZv4pp6JkIZnl
   s=;
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
X-IronPort-AV: E=Sophos;i="6.12,253,1728943200"; 
   d="scan'208";a="200417488"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Dec 2024 15:24:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8E331E0077; Sat, 21 Dec 2024 15:24:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 44608E0077
	for <cocci@sympa.inria.fr>; Sat, 21 Dec 2024 15:24:12 +0100 (CET)
IronPort-SDR: 6766cf8b_NZWvwJODu2ZOa/lzjw8S7pZmH3K7qUTQo4R0NyvUbM6IEl/
 OkojZPId3CefVXEmh1o4PS8c9WY666+ODBhIcLg==
X-IPAS-Result: =?us-ascii?q?A0FYBABSzmZnfC+nVdFaHQEBAQEJARIBBQUBQIFTgXJSg?=
 =?us-ascii?q?VczBFOEVo9NgXQwhDuHO4dWjAw+DwEDAQsBAUICBAEBAwQ4hEgCim0CHgcBB?=
 =?us-ascii?q?DQTAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABASIZBw4SKYV7D?=
 =?us-ascii?q?YJiAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEFAixfAQEBAxIRFQgBGx0BAwwGBQsNAgImAgIiEQEFARwGFQEBHoJfgjABA?=
 =?us-ascii?q?zEDAaMVgQVCiz6BFQUCFoEBgg0G2lwKGSgNbAOBYQIHCQEKgQYuhHQpTg6CO?=
 =?us-ascii?q?B0BiWh6Jw+BVUSBPIMDPoRYg0aCaQSCOEyCSoI9gQyDfoZsgl+ERoIDikQIB?=
 =?us-ascii?q?x8SCQkTBgoCSwsKEgMEAwQEAQILEwkDAwIOAggDAggGGQE/EgQTCg0LBwUfC?=
 =?us-ascii?q?AMHDBEKKAMiBA4RHA8DXAU0AQsDBwIIAgIGAwICBBQGAwUIAwIFBQ0CAgoCB?=
 =?us-ascii?q?AMVBAQPAQECHgIGAQIQAQcCAgEUAgoDAgUGBwIcAgIDAwQEAwEFAxIDCwEFB?=
 =?us-ascii?q?gUBAQQOAQIBAgEBAgMDDgICAwMCAgEJAgIBAQIUAQQDAQcCBQMFAwoBAQECA?=
 =?us-ascii?q?QQJBA0GAwUDAwcDBAIDAgYCBAUEAgIDAwIDAQMDAgECAwkCAQ8PCQ8CAgMEA?=
 =?us-ascii?q?gYCAgEEJgIBFQUCAwQCAgcCAgMBAgECAgIEAgQCAgYDCQgBAgIHAQICAgMVA?=
 =?us-ascii?q?gUBBAkDAwUSDCADAgICAgMHCgMFAgEBAgQDAwMDCQ0HAgMBAgEDBQMBAgECC?=
 =?us-ascii?q?QMGAgIDAwUSGQUDAg8DAgEFBAIIEgsHAQEPFAUECQUVAwYCAwMWCwQFAwMDA?=
 =?us-ascii?q?QwPDgICCwMXBQEBBwEDDQgDBAQCAwMJAgEQAQMEAgkCBAECCgICAgICBAEBB?=
 =?us-ascii?q?QQCBAMCBQICAQgEAwMDDQQDCAgDBQMMEgICAgkCAwECAwMDBA0IFg0DAg0YC?=
 =?us-ascii?q?hUTBwcDAwQLAgkDBA0CBAICAQYDBgoGBwQFBgECGAICBgwEAwMIAwIDAgIBA?=
 =?us-ascii?q?gICARECAgkIDQUJBQYCAhUDAgMIAQkDDwMCFAEGAggDBwEBBAICChEKAQECA?=
 =?us-ascii?q?gEGKAMBAQIUEwcDCAICAgIGFgwBBQcDBw8FBQQCAhYDAxIEBBACAgMDAgEBF?=
 =?us-ascii?q?AYVAQUCAwYLAQYBAgUEAgMEAhICEgMEAwoCDwMGAwQGAwECDBACBAIJCgEFB?=
 =?us-ascii?q?AMHBQIfAwMCAgULAggCAgUCBQcDCQsGAQIFAwQJAhQCEAICAgIIFwICAgUeA?=
 =?us-ascii?q?yYCBAMDAwMLAQICDgkDBDwGEwQCAwMCDgECAgsBAgIEAgMBBAcJAwMJCgcBC?=
 =?us-ascii?q?g0HAgIKCAkQAQICDwcDAgICAgYHDgMCEw8FBgYCCgcNCgMCAQICFQIDCQYDB?=
 =?us-ascii?q?Q0DBwQKDwIVAhYFAyACCAkLAgcOBQIFEgMOBQMCAhIEAgMGBQMBBwEXAwcIA?=
 =?us-ascii?q?gIMAgICAgUCBQIFGBEBDQQDAwMCCAEEFQYDCQgqCAQDCwYdAgIDAgQFAQESA?=
 =?us-ascii?q?QEBBQEJAgMCAwQIAwMDAwIDBAwLAgEHCAMDBgsICQYDAgcIGQMFBAMHBQshA?=
 =?us-ascii?q?gYDAgQFBAEFAhUNAgMZAgYDBhQLDAIGDggJAwcBAQECAgIIAQUFDAkCAwQCB?=
 =?us-ascii?q?QQEAQEIAwMEBgIBAwICAgEEAgoBAQECCgIICgEJFAQDCAMDAwMDBQEBAgIKB?=
 =?us-ascii?q?BMFBQIBBQ4TDRMdAgkDIw8CAQsJCBM9DAcyBDYBCQsUBwYlGGidKYR7GYJmp?=
 =?us-ascii?q?EmgMIEKNAeEHYFdBgyfXAYPBC+XQ5MPiCmQUqkBAgoHBhEjEoFJI4FcMxojg?=
 =?us-ascii?q?QGCNk8DGQ+OIYN6t0ZCNTwCBwsBAQMJhWmJf4FLAQE?=
IronPort-PHdr: A9a23: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
 EhqbXLKG+0XgLxnemRmzgTbvMkXccM=
IronPort-Data: A9a23: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
 iaEuxADOahOFKydNHB6B+nEF1Kdn0/g1w30sTM=
IronPort-HdrOrdr: A9a23:+1+HB6+6pO6LSYsQuhtuk+AOI+orL9Y04lQ7vn2ZhyYlCvBw5P
 re5sjzsiWE9gr5OUtQ5uxoXZPrfZqyz+8R3WB8B8beYOCighrVEGgA1/qH/9SDIVydygc178
 4JGNkcNDSzNykAsS+T2mmF+r0bsb+6Gc6T9J7jJjtWPGZXQpAlwQM8JAjzKCJLrcp9aabR1q
 Dw2iOKnVSdkL0sD/iGOg==
X-Talos-CUID: 9a23:V02eGm9xlwVEde84rY6Vvx4qPOolNVvC9WjRKX6XCmQ4eZCtYmbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AgAEqcA5L5E3f60Cy6pZyucptxowv0/+XGREdiKw?=
 =?us-ascii?q?LkOjDEjQqPyia0zaOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,253,1728943200"; 
   d="scan'208";a="104940929"
X-MGA-submission: =?us-ascii?q?MDGMd6Bn4bqylBnFMESEaglFMJjaWsqFvNQ8K2?=
 =?us-ascii?q?whPp0UCcgkY9tZxXz+0+V1XIG01/Zp5LWe7CZzEo3wC7T4dd6R4wK60F?=
 =?us-ascii?q?+38ajL06Hy2XbxqsBo89OOoAGqRAZRiGxXc/lt84NvqgKsafYNaGEpxH?=
 =?us-ascii?q?ZAXqHyyzByVH1QH8s440yCXg=3D=3D?=
Received: from mail-lf1-f47.google.com ([209.85.167.47])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 15:24:12 +0100
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso2973511e87.0;
        Sat, 21 Dec 2024 06:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734791050; x=1735395850; darn=inria.fr;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r8wXYLrl1/UvuGyBeWBlT+Dn7AUW3Zy77oqcFKt2/lU=;
        b=U7wEc1WWuOzFkQKKSpGokOjOdhv2xoFhW8Exhmq5CdiELn19uNsocZ37ok6JzfaRto
         1R6P4gIoJKDInwzslfC9XWkxPJDnzg5aPUGnhD3tbjsssKE8tCfMJ1JWBSfDRGr+zvef
         pHoQsEIutPlZl7w0+GxMeIAywQ9XkRuPR+wA6e8M5QJMglqzFqWSZ0xIkJeFt7rwVxGK
         9pIbmkiHSnyUzEMw+spX+5NXfa8nRKCmkCRnLz00OvCN0Wrur6lbREHpOTrZLuVjzxGw
         8TtFDXxTjgWo6pb6hV+FRXvBUK672HfQNLUDpnRzwmoERpZlP5dm3HZ9QphxMyY/rZFS
         9TMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734791050; x=1735395850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8wXYLrl1/UvuGyBeWBlT+Dn7AUW3Zy77oqcFKt2/lU=;
        b=D1hcFTqX01mczgsDS/r9fRn/lof7EITnWs4dn9NdUwyCH/sKKcYUNp/DphLISoM7Oe
         Nwb57o4Mip/Lt/Svwexm9OkiOPCrYe06ENQEcO188WFv4jKbpTLUawFJi/dLX50/fyOx
         TgbdxOVN544L2w5Q97B49vvZBB6s7eAIDSSSHaygwYfUH1orakVZzJEn36MgakDDg3Rs
         /7S+EliRUgVj/bkSn2qMJZ19/N7dVNnsyNJc+dWrdZmAGuF5PgW93cuMGIvZIcBRITRc
         nwNUVuXiHv8jFAhSFUQqcpgJZ7gxdhX71ENOJBC7wbYw3QbYzx6FH0XYH5JaacULGqAH
         yCfA==
X-Gm-Message-State: AOJu0YzOpKoeD3/AnZXKW60GKvS+ml+5+qzCEwZkF3yZoSBoMtd26Y/d
	cXUSJg8SiTzygzOFVSGN7RFbBO7nkMRDIn0VQsIqBjIRl3y6X1RsoBH4Cg==
X-Gm-Gg: ASbGncv9dykM94cebGBZuH7zM7rqEnipu25TAyZUG5WNMU6YkWt79AhiH44N7YyqZX9
	iAmEtrn+yxOAWONQlorbKUrQvtv45RJAXT8x9jIi/e1wOnsBFadCTcvCv6C5DCKBuSizAsSm8Ni
	v2/kg6djUUS1HA9Ue6jHJf3FWm+nHKvBhQLh8LjrjQevyIkzH3i/ou1xN9sc/VcUg4Qo1vECdJw
	F08jB0DCMtuwUsgLekJ9B69H28Gt3qrgTFO2LNrTec1mcFoIv2IulRG35iLiRDpd9h24TxITRIC
	bUBHyGmbB1flNQ43JVqQPM6aa9tMfPyU
X-Google-Smtp-Source: AGHT+IFMqfIIAqetE8gGrszNgEZ5B/ivfB9xN3uPHRqpzo/R7JQ9F0iSu0KmKCRihD2mw2odbdWWSA==
X-Received: by 2002:a05:6512:318d:b0:542:2192:3eb6 with SMTP id 2adb3069b0e04-5422956bdb6mr2082493e87.52.1734791049332;
        Sat, 21 Dec 2024 06:24:09 -0800 (PST)
Received: from ?IPV6:2a02:aa1:114d:98dc:ea53:5dad:de3e:454f? ([2a02:aa1:114d:98dc:ea53:5dad:de3e:454f])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223832b93sm748241e87.267.2024.12.21.06.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 06:24:08 -0800 (PST)
Message-ID: <0146ddc0-016a-481a-89e7-b83a8493df6c@gmail.com>
Date: Sat, 21 Dec 2024 15:24:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <f0764391-b0d3-48fa-8a54-6edddf8d2c8d@gmail.com>
 <da51b2de-12cd-4aad-d989-79e925ead01f@inria.fr>
 <a1e9628f-4d97-4fe3-99d0-585a0196d988@gmail.com>
 <alpine.DEB.2.22.394.2412202253060.4924@hadrien>
Content-Language: en-US
From: Mats Kindahl <mats.kindahl@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2412202253060.4924@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Depends on with negative matches
Reply-To: Mats Kindahl <mats.kindahl@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2192
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/0146ddc0-016a-481a-89e7-b83a8493df6c%40gmail.com>

Hi Julia,

Thanks you! I feel really stupid, but now it works. My only excuse is 
that the documentation for "when != true <expr>" is not very elaborate. :)

Thanks again Julia,
Mats Kindahl

On 2024-12-20 22:54, Julia Lawall wrote:
> I think you just had true and false backwards:
>
> // Capture any malloc() to a local variable
> @r@
> local idexpression var;
> position p;
> @@
>    var@p = malloc(...)
>
> @@
> local idexpression r.var;
> position r.p;
> @@
> * var@p = malloc(...);
>    ... when != true !PointerIsValid(var)
>        when != false PointerIsValid(var)
>        when != free(var)
>        when != return (var);
>
> For example, you don't want to complain if there is a path with no free,
> but that path goes through a failing pointer is valid test.
>
> julia
