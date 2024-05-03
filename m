Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012FFC25B4F
	for <cocci@archiver.kernel.org>; Mon,  6 May 2024 19:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=icgILRhv2g9bbI4xx9oPNlyi/zynps8oNls866OxsGs=;
  b=LdKIlOG6pst+uq7+ego227hSZdRE27Oja4K2ecofFYoF8FfM0lPL7H4J
   1x/EyIRdcSKmB3YjShyJu0u8NKRUHOH4cVbJj+oy3+vtVlA0LY/00SEvy
   5zk1YVfhsYQXZ/AgQTL5feJO0sKfcZobrOkAk7kp61lNa5f9LBiCJGVyV
   Q=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.07,259,1708383600"; 
   d="scan'208";a="164742853"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 May 2024 21:31:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D3EDEE0138; Mon,  6 May 2024 21:31:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BAF26E0035
	for <cocci@sympa.inria.fr>; Fri,  3 May 2024 16:16:26 +0200 (CEST)
IronPort-SDR: 6634f1b9_pId8E1EpyK6hi+4OzuHqcRhxkp3wcT0z3OkT3YJ149Jo8Uy
 zPiyjThMb5i+YUidEHNuX+Sk4yEJNEma//3ibYw==
X-IPAS-Result: =?us-ascii?q?A0EkAQAG8TRmf7TXVdFaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YJDfANUMwRThFaPRoF1MIQ7jwiIcYMWPg8BAwELAQE5CwQBAQMEhH8CiC4CH?=
 =?us-ascii?q?gcBBDMGDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEiGQcOD?=
 =?us-ascii?q?imFdA2CYBiBDmECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBBQINH10BAQEDEhEdARsdAQMMBgULDQICJgICIhEBBQEcGwEBHoJeA?=
 =?us-ascii?q?YIvAQMxAwQNpi6BBUKLO4EVBQIWgQGCDQbaWgoZKA1vgV8CAQYJAQqBBi4Bh?=
 =?us-ascii?q?GUlgwYDGgEFZ4hWeieCKIE8gwM+gmECgXU4gw6CaQSBE4R4ghIBjQSFBYZwh?=
 =?us-ascii?q?gAIBx8QBAkJEwYKAksNChIDBAMEBAECCxMJAwMCDgIIAwIIBg4TAT8SBBMKD?=
 =?us-ascii?q?QsDBAIFCgMIAgIHAg4BBQIBAQICAgICAgMGAhIEAgECAwICCAIHAQECCgcDA?=
 =?us-ascii?q?QECBgQDBgICBQQNAwsBAQICBAEKAgkPBQICAwMCAwEBAQIKAwkBBQICAQMCA?=
 =?us-ascii?q?gQEBwEGAwUDAwQEAgMDAgwBBQEFAQUBBQQCBgETAhICAgsFBgMGDgMLBAQBA?=
 =?us-ascii?q?gIFBAYMCQQCAgIGAQIRAwECAQcBAwMCCgEEAQILCAEFCAgBBAIDBhACCAUGB?=
 =?us-ascii?q?QICAQECAgIIBg8DBgcCAwIGAwUFAwMCAgIHBAQCAQICAgETBgQEAgMCAwQBB?=
 =?us-ascii?q?QQEAwIXCA0CBQcBCQoIDAEEBgIEAgQHAwYFBQQCAwQEEQcLAwIDBAICBAMRA?=
 =?us-ascii?q?gMEAgoCBAQHAgMBBA0GBAQKAgsDBwEBAQEFAwMJBwYCAwMFBAYCBQMDAwIDA?=
 =?us-ascii?q?goCAgIBCQEBAQISAgMOAgQCAQIFBQwEEwICAwIGCAICAgcDAwQCAwYLAxECA?=
 =?us-ascii?q?gIFAwQCAhQDBwQCBAYCBAEGAwMCBAYFCAQCAgUCAQECCAIBDwoEAwQDBQMHC?=
 =?us-ascii?q?QIFBQMCBAICBQkBAQICAgMDAwMCAwICAwMCBwMDAwcDBQMEAgMGBQcDBQMDA?=
 =?us-ascii?q?gICFAEGAgUNCAYLBQUHAgYCBAgFAgIDAwMCBgoIAwMDAgUCAgMDAQIGDwYCA?=
 =?us-ascii?q?gMFBgMDAwMGBgMDAgYDAwIDAgMCAwMBAwIDAgIDAgICCAICAwIFBAUCAgMEA?=
 =?us-ascii?q?ggaAgICAgMDCAMDCgQCAgQBBAIEAgQCBgMEAgIBBwIFAwIDAgcCAgQCAgICA?=
 =?us-ascii?q?wIGCAICAwMDAgICAQkCBQEBBgIEAwIDBQMJAwQFAgMIAQECAgcHAwMEAwECA?=
 =?us-ascii?q?QUEAgIGBQIDAgIEBAQFAwIDAgYGAgEDAgoGAwUDAwMDAgMDAgMDAgUCCAICB?=
 =?us-ascii?q?AQFBAIFBAIEAwMDAQoCBgMCAgUBAQICBQMCBAQHAgICBw8DAgcFAgUFBQIIA?=
 =?us-ascii?q?QYFAgIDAggBAgIGAQYCBAECAg0BAQICAgMBAwMDBwIEAwIIAgMDEQEDAwkGB?=
 =?us-ascii?q?QQFBAMJBA8CBAEIAwEBBAgCBAMCDAICIQIFCwQEARIKCAMBAQMBAQICAgICD?=
 =?us-ascii?q?gMCAwICAwoCAwIKAwYEAgIGAQEBBAYBBAIBAgcEDgkFCAgBAwIBBAYBAhAFA?=
 =?us-ascii?q?g8CCQMDBgQCEAYKBQMCAwUBAgUVAwgDAgkCBAwDBQgCAwMCBgMGAgYBBgMHC?=
 =?us-ascii?q?wEBBwgFAwMDAhYBAgIQCAQGDwcCAwMDBAwDEgIGDgMDAgMCAQICAgMFBAUCB?=
 =?us-ascii?q?wMDCgUCCAMCCAUDBwkECgIIBAECBgMCAgICBQ0BAQEBAgMCBQMHCQgIBAUEA?=
 =?us-ascii?q?wEBBgYMIAICAwQPAwkDBgsBBQUBAwICAg4DBQMCAwYGAQkEAQUECQIFBwYFA?=
 =?us-ascii?q?gEUBw8GAQUCCgIHAgICAwECCAsIAgMCCgQBDgQaAgUBAgIDAgMHAgMCAhMDA?=
 =?us-ascii?q?wUEBgMCAgICAwIBCgsDAgIDAwMDBQUDAwIaAgMDAgEKBQIMBQQDBAICAQIdA?=
 =?us-ascii?q?wEFAgMKAQUJAwYCAgMCBQIDBgUCBAEOAQEBAwYLBwQUAgICDAgDCQUDBQ0CD?=
 =?us-ascii?q?QIDBQICCwU9CwUBAQMCAwIECBgtAgUCBgwBAQECAwMGAgICFQUHAwUDCAEDA?=
 =?us-ascii?q?QIUCggCAgEDCgwCAgQCBgIEAwIDCgMBCAICAg8DCQIHAhICAgMDDBEEAwMDA?=
 =?us-ascii?q?wcEAgICEQkKAgICAgwIDAIJAgIDAwYBAgMDBQMBAgEBAQYPIQIEBwECAwYGD?=
 =?us-ascii?q?wMCAgIJCQoDCQMDBQMMAQYGAQIDDgEBAhUECQICAgECAgIBAQYLAgEBAgQBB?=
 =?us-ascii?q?AJJHQIJAyMPAgELCQgTPQwHMgQ0AQkLFAcGIQEBBRhooAOEciCBJZQekHpjo?=
 =?us-ascii?q?HEHhBaKaoEklSMGDwQvg3ITkzMUkmiYYoJUiyCVQoUnAgoHBhEjEoFGJIFcM?=
 =?us-ascii?q?xojgQGCNk8DGQ+OIIN6mVc+NTsCBwsBAQMJhkiCWmhgAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wRAKETSyKhIxI69FVFWJcg0F0pNb08x
IronPort-HdrOrdr: A9a23:DaPnoqwdBIon9VIiKHgKKrPw9b1zdoMgy1knxilNoNJuA7elfr
 OV7YwmPHjP+UkssRAb6Ky90cy7K080mqQFg7X5UY3SJjUO/VHYUb2KjrGSpgEIeReOldK1vJ
 0IG8MfNDSzNykCsS+T2miF+r0bsb66Gc6T9IHjJjtWPGVXgmJbgzuRyDz3LqS7fmZ77FMCeq
 ah2g==
X-Talos-CUID: 9a23:67ttrG7eSgmAVmt/INss+V5PBt4LeHTm8H7aBxayKj5LFqySYArF
X-Talos-MUID: 9a23:sXn7GAR8bNae0ygZRXTTmzZnCu1syJ23FWoSgY40uO+ZMCp/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,251,1708383600"; 
   d="scan'208";a="86325415"
X-MGA-submission: =?us-ascii?q?MDGk4gK7MidNznA0Tjh1KINRcyvf0riW4ReJLD?=
 =?us-ascii?q?P/KQv1H68vARE3ZoYxlgJrBrA5/k7VqiIpZ+mgr4QXoVqL2cNtXTdnye?=
 =?us-ascii?q?PX+rYVxFKhS+Eg5+A4KHsYdk9MfvfhMLOiPm+k2B1/YJbwNzrjbDlwc8?=
 =?us-ascii?q?ZXWRqTWNY/9+7lOwl+x2VJGA=3D=3D?=
Received: from mail-pg1-f180.google.com ([209.85.215.180])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 16:16:26 +0200
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-60274726da6so6074528a12.2;
        Fri, 03 May 2024 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714745782; x=1715350582; darn=inria.fr;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=icgILRhv2g9bbI4xx9oPNlyi/zynps8oNls866OxsGs=;
        b=SwgCWrxpSYmUcl2f4D6sjQHOsvGwE2F+aNo4b6YRY3qnq5g3B+BYjrNHHEKNvCBYO5
         nk0NkvXvWDvcrbJ3+lGlsbcUgQzHrrzxmThCU67jmMNqXdKxQhaEw2HLD8O++qm2Y1KQ
         9Qe9kLA2hvfeGWXIqZTNZcPkD5HlDQwVyamCadTVEndyzAr3onfer/EqoVgPbuS6/sZ3
         8SlzOg73oSsmXT06MEyqr/2stxhxahyt7keVyvsCO3JZVt8+iLVMOHSP3eTMN4ny+0Mg
         x94ZGpucytkgOa1d1+Cxaq+S46wENu2hhGDem3iAJARJbvCi9JXE02i9fF2ekESfIgK7
         3ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714745782; x=1715350582;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icgILRhv2g9bbI4xx9oPNlyi/zynps8oNls866OxsGs=;
        b=k943DeGIYNN1Cqi4x/aUnslx0zZ3WYADHc2ehAW/f9S2By6Zu3Zil48bod9kJ7vJLB
         lVWRUKUA4KAxto7pzD6Lz/EM4k5Lsv2nPjDQl3RwKco+WfXaRfrvbpvUyjSCU07CAz6Y
         rJNoz1pdj0XC/bKKn1IJfy63mYRK21e6BaYHsnKSeX/cVAMZ39aszdWdgNtxbBFiymW2
         Z4TNQNDO4by23XgZiKgeucPZiRclIeX6kQWB4msRslXydu/nPfz6Q6II46K7xe+LbqIx
         GVIrA+UCbRwbBd9pqQ31caaQNSREwcSRQKKuPdMBgkXCiqI7m1cCjzYXTgRjcDVHFnSm
         sQXw==
X-Gm-Message-State: AOJu0YxHCBWNcpJMC61QuhrEoxYwjNgYR27W0hG8tC3l1NtE0p7pWeCP
	EDDN8t3RKH24S+YBrb+n/5c3oESbiTc4bIxWmfRJg5l3Y2UGX8s7c8Z9fQ==
X-Google-Smtp-Source: AGHT+IE8VnGDGs7E650+bOw3e5c0l2m+IpFRNEwgET6g0KDto/llPtb4q+vSb1FeBszZin85MXsC1Q==
X-Received: by 2002:a17:90a:ca90:b0:2b2:7e94:c62f with SMTP id y16-20020a17090aca9000b002b27e94c62fmr2858258pjt.15.1714745782379;
        Fri, 03 May 2024 07:16:22 -0700 (PDT)
Received: from [192.168.1.20] ([31.215.5.80])
        by smtp.gmail.com with ESMTPSA id z23-20020a17090a541700b002b3ff977d10sm2253612pjh.20.2024.05.03.07.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 07:16:21 -0700 (PDT)
Message-ID: <47612adc-97db-4a74-82da-212d9c2413fa@gmail.com>
Date: Fri, 3 May 2024 18:16:15 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: julia.lawall@inria.fr
References: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr>
Content-Language: en-US, ru-RU
Cc: cocci@inria.fr
From: Denis Efremov <yefremov.denis@gmail.com>
In-Reply-To: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] new version 1.2
Reply-To: Denis Efremov <yefremov.denis@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1707
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/47612adc-97db-4a74-82da-212d9c2413fa%40gmail.com>

Hello,

On 3/29/24 01:05, Julia Lawall wrote:
> Hello,
> 
> There is a new version, 1.2.
> 
> For the moment, I am unable to update the web page due to a CI issue, but
> the new version can be retrieved from github.
> 
> julia

Thank you for the release. It should now be available in opam
https://github.com/ocaml/opam-repository/pull/25598

The only thing that I found is that previously 3 numbers in the version string
were used (e.g. 1.1.0). However, I don't think it's a problem.

Best Regards,
Denis
