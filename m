Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76B5C7EE30
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 08:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=CxU+OTWaCvwzNi1+2/JCj0bCbuXpGWShCvZ/Z+8efLo=;
  b=VamsEoKHSxTYhwT8rF3BsCBHBhQrU7R3TskKUw2hGwimA+6MwhG4hSzT
   IIpt8ZWcICnptsjaPcRnjahAhbA1WEjxkSRP2HivUUr8I/YMUGeLvMCT3
   FNmvRvS+AyjtYbp4f1X54vtlMfROioVAJZ2l064n8Ocqc8SUvMms7CGVR
   I=;
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
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208,217";a="229733371"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 10:01:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F05C6E0CDA; Tue,  1 Jul 2025 10:01:11 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 31E6DE0131
	for <cocci@sympa.inria.fr>; Sun, 29 Jun 2025 21:19:25 +0200 (CEST)
IronPort-SDR: 686191bc_RdlxoujwmbhaBNZJREncPV1lWRpFSxO7rqx+fZN5nDVIHYX
 /Pu+pQDp25jf3WSwhTQ6cPVzMOaI4p8xsyJFFAw==
X-IPAS-Result: =?us-ascii?q?A0EPAAA3kWFofC7dVdFaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF/BgEBAQsBgXFSgQBaMwRUhFWDT4RNhzSBdC0Di0cyhnCEWHmEB4FVg?=
 =?us-ascii?q?X0CDwEDAQsBATQbAgQBAQQ7hEgCi3ICHgcBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEQAQEFAQEBAgEBAgQGAQIQAQEiGQcOEh4LhTVGDYJiAYJJLIEKAQEBAQIBE?=
 =?us-ascii?q?hEdARsdAQMBCwYDAgkPKgICIhEBBQEcBhMUCgSCYAGCIQEGEAEDDiQDARAGl?=
 =?us-ascii?q?VWPQIEFQopEeoEVBQIWgQGCDQaBCdlWChkoDW0DgWICAQYJAQqBNQGEdSlcg?=
 =?us-ascii?q?jwaAQUlSGsCDoRDgzl6J4FjRYE8gRSBbz6CYQEBAoILgy6CaQSCIj0DBD4UH?=
 =?us-ascii?q?YRdgQSDFIJkjDkBBwcxCQkTBggCAkgFEBIDBAMEBAECCwkKCQMDAg4CCAMCC?=
 =?us-ascii?q?AYZAT8MBgQVCAkPDB8KAggEEQooIgQOKwoDWxUFGwgGAgIEBAIEAgoCCQICB?=
 =?us-ascii?q?QMEAgQNAwQBAQgCAgMqBAMGGwkIAgsFFBYCDAQHBzIDEgEICgYDBgMEAgICC?=
 =?us-ascii?q?wcCAwMDBwELCwkCAQMCAgUCAgEFAwICCAMCAQEJAgMCCAECAgECAgIEAQcBD?=
 =?us-ascii?q?QEBAgQCAiQCAQMIBgEBDQICBAICAQICAgQCBAECBgsECAEBAgECAgEBAQQBC?=
 =?us-ascii?q?AMBAQICAwMFAwUIDw0BFQsZAwQFAgISAgIBBwECAQEDGQIBAwMEAQsCAQEEG?=
 =?us-ascii?q?wQXAhYkAhkCAQUFBQEDBAsQCQMCBQQCAgYCBA4CBwQCGgQCAgEDBAYDAQIIA?=
 =?us-ascii?q?gIHBAQGAwECAgcXAgQRAQIBAwICAgkKBAUEAwQDAgICAQwDAQIDAgIBAgEBA?=
 =?us-ascii?q?wEFBg0SAgEDDwgEAgIHAgIhDwsBAgEBBgYDAwMKAwEKAQEGAgECEgUCAgIEA?=
 =?us-ascii?q?QICBgQlAQIBAgEBAQUCAQIBAgQCBwIBAgsBBQIGAQICCQECAQICAgECAQECB?=
 =?us-ascii?q?gIBFQECAgICAgMBAwYCAgICAgIJAgICAgUCBQMCAwUCBQIDAwICAwQDCQMDC?=
 =?us-ascii?q?AMGBAIDAQEBAgECAgIBAgEFAgMJAQEDAgECAgICAwYCBQUBAwsFCQEBAgEDB?=
 =?us-ascii?q?QMDBAMGAQYHBAMCBAICAgIEAgEFAwMCBQELAQIEAgEDAwMEBAMBAgIKBwUCB?=
 =?us-ascii?q?AEBAQECAQICCgMCBQEDAwERAwQBBgUFBgIHCQMCAgMCAwIEAwkEAgQDAwICA?=
 =?us-ascii?q?gEBCgICAQIBAQMDBwYQAQICAgEPAgMDBAMEBgMFCQEDBwEBAQEBAhQDAgQBB?=
 =?us-ascii?q?BEGBAIBAR4BFQIHAQQDJx4CAgIHAQICAgIDAgIDAwMBAgEBAgMFAQMCAgMCA?=
 =?us-ascii?q?QIBBgIDAwMCBQMBCQUCAgMBAwEFAQQEAgcBAgICDgEDAgIJAgcJBAQCARMTA?=
 =?us-ascii?q?gICAgECAgECBwEBAgMCBQUIAgEBAQICAwILAgIBAgECAgMCAwIGAQkIBgECA?=
 =?us-ascii?q?QEFBAMDBwIDJAMDBAUDAgICAgcCBAMZAg0GAQQDBQMFAwgDBgICAw8DBwYHA?=
 =?us-ascii?q?gcEAgQCAgICDAQCAwMHBQICAgIEAQENBAcBAQMCAhIDAQEBAhQCCQMjDwIBF?=
 =?us-ascii?q?AgTPQwHLgQEDCoBCQsUBwYlgQAQkQhbgjVyfBMsFIExQEOBBgEBAZImL4Mwj?=
 =?us-ascii?q?CKiZjsJAQYCYIFngQoVCi2Kd4EmlTwGVZc5kxYuh2WQcoslgmKVXAiFJgIEA?=
 =?us-ascii?q?QEBAwcHESQSgTI6gVxwgW6BSVILDg+OIYQAvRNBNQIJMQIHAQoBAQMJhWmHa?=
 =?us-ascii?q?4FLAQE?=
IronPort-PHdr: A9a23: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
 ZPqpHVFiVoLhDEdKqnZJa4PxV9V1Pvmgw==
IronPort-Data: A9a23:dmcIPayWUy9Fil0hD1d6t+eYxirEfRIJ4+MujC+fZmUNrF6WrkVRm
 GJKUGzXOPvbYWf8KYh3bIm2oB9T6pTdzoIyTgZvrlhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgmAc3l48sfrZ9Usx5qWq4lv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPM7dt1XVxtPLYjoNxJGWZfr
 dUKBzMkO0Xra+KemNpXS8Fpj8UnadbxZcYR5i8mwjbeAvIrB5vERs0m5/cChGZ21p0IR6yHI
 ZZHAdZsREyojxlnNloJDpU4leKl3yOnWzJdoVOR46Ew5gA/ySQriumxb4SFJoLiqcN9uGTDo
 mvI9GfDIVITFdCkzmK5/2mlmbqa9c/8cNlPTeXnp6ACbEeo7mgaFxQSUXOpoPyzkEf4WtRFK
 kVS9DBGhaM1/0eqZsLsWgWx5n+CpB8VHdRKe9DW8ymIw6vQphmDXy0KEmAHZ9shu8s7Azct0
 zdlgu8FGxRPnpOOGG/G94yv9wmMIS8EdUYQSiwtGF5tD8bYnKk/iRfGT9BGGaGzj8HoFTyY/
 9xshHhj71n0pZ5Uv5hX7Wz6bySQSo8lpzPZCy3SV2OhqxxjPcurO9Lu5l/c4vJNao2eSzFtX
 UToeeDPsoji7rnUy0Rhpdnh+pn0t55p1xWC2DZS82EJrWjFxpJaVdk4DMtCDEloKN0YXjTif
 VXevwhcjLcKYybzNPQqPtrpV516pUQFKTgDfqCJBjapSsguHDJrAAk0PyZ8Iki0wBF1zvhlY
 f93j+7yXC5FWP8PIMWKqxc1iuJynn9vmws/tLj0yBOo1bfWZXieD9843KimP4gEAFe/iFyNq
 b53bpPUoz0GCbGWSneNreY7cwtRRVBlXsCeliCiXrTfSuaQMDt8U6eJqV7gEqQ595loehDgp
 yvjBBAIlwCg3xUq62yiMxheVV8mZr4nxVpTAMDmFQ/AN9ULOO5DMI93m1oLkbgbGChLyPd1S
 7waYZzFDKgRDDvA/DsZYN/2q4kKmNFHQ+6RF3LNXdT9V8cIq8/1FhvMcQ7m9S1IBS2y3Sf7i
 6P1zRvVGPLvWCw7ZPs7q5uTI5eZsn0UmeY0VEzNSjWWlIMA76AyQxHMYjQLzw3g5PkNKvZ2F
 +pbPPvAmdTwng==
IronPort-HdrOrdr: A9a23:hNsRGqns3KVKwcenl0MgPhBP/AfpDfLi3DAbv31ZSRFFG/FwWf
 re+8jztCWE9Ar5PUtLpTnuAtjjfZqxz+8R3WBVB8baYOCEghrUEGgB1/qF/9SIIUSXnZ8/6U
 4jSdkHNDSZNzhHZK3BkXKF+rgbsb262ZHtq+Ob4XkFd25XgmJbgzuRyDz3LqS7fmd7LKt8L5
 aV68dDq36FdW4MZsq2QlkpNtKz3eEjXaiGXSI7
X-Talos-CUID: 9a23:J/tva2BTErXjah76EwlJ2lVFB5skSUaH9knIJF7gIHRGS5TAHA==
X-Talos-MUID: 9a23:wPOBmgmU3s6N5QoAeaB0dnpEFpxs6qqlC3ou0pwnt/KDbRB9ID6C2WE=
X-IronPort-Anti-Spam-Filtered: true
X-URL-LookUp-ScanningError: 1
X-IronPort-AV: E=Sophos;i="6.16,276,1744063200"; 
   d="scan'208,217";a="229476846"
X-MGA-submission: =?us-ascii?q?MDG8R2Nfu7LRb3oYaMDiR2uGcqjqJzWHIPUHPa?=
 =?us-ascii?q?koo5mVKfsLRm9DcAgZ0LaRE9rMz6e85ZV/QoPLRJBRN+PhhkdZqXcugV?=
 =?us-ascii?q?9Do0ZxUmu7YyJ2V1GLOUlOVBsagqaP/eL6qCFBoVTeAMbjnd/VcRjBez?=
 =?us-ascii?q?Pijy+r1Uc1pC6DW48lSJfOZg=3D=3D?=
Received: from mail-wr1-f46.google.com ([209.85.221.46])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 21:19:24 +0200
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so751485f8f.3;
        Sun, 29 Jun 2025 12:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751224764; x=1751829564; darn=inria.fr;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CxU+OTWaCvwzNi1+2/JCj0bCbuXpGWShCvZ/Z+8efLo=;
        b=ktI4BfuwBvIszNsKL0EgYr7SLy6gMCUKHPH5tM7mu/X6P4LcWaFqRK2swnjWCjAkG5
         wetxbsoaZIOiQqAfx1u2AovydQ8INK7hFWpaj5TEoG8+iSNomYpweWQ0K9FqJTGwbgD7
         8osdVWjqP07hNjN0EpBL3CdUORTO/MgFRhmFj92O4yWBOWouQB5aSn96uBxgGTABSCqH
         ioVgz/+9Avg1VU5QDjb5RV7sz1YPfWqhkYp7WOd7J/a/IEAh7rbdyeCdw0dH5V6w01n/
         Ncd9gH+EG4qOo34v0nfUcS5dDHOf6P8SKslT9+Ad7Z+NEQzjFmKSpdHQg+fLelm7SnWI
         QYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751224764; x=1751829564;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxU+OTWaCvwzNi1+2/JCj0bCbuXpGWShCvZ/Z+8efLo=;
        b=rlqM36md0CdiGJVb1x9RemSzrI5gMZ0K95U0+GFxSFPmMI9/atBVdySdUbURv2evjD
         YnZxlWJv9+WesBqjRqTZWuiZkfQBQTWHzKOwg87iE9w+CQOSf+7atSEbq44/ik8xky4E
         tAF/bWZ61ThhX/BcrSrMY3JvQmLNdfW//VpvExe6FUYhIEXUH0//5nb9j6OBpujvZ6zb
         KYVH1qSjzI4GClp4pNneTtQsDwIJWTUz96ToTRP5EXkOIoAwHtM10Gg7G/HPVfHtpPes
         soyW4bce6z7uDu02cKpToc3M/n+pTtKdvvTQyORzN4toyBiutwzLLmrLoKQcvwDWfOIL
         +uww==
X-Gm-Message-State: AOJu0YxyHVW/4WKyb0606F9n18uMTD6761hcMyscBOc3UB2D41T0I/gN
	mYJNDLNH+dFr8K4hBjsGuaKYRMvK9Lf8Sa2U/aAUU+jf4Lj/xkfXKzCBizbAAA==
X-Gm-Gg: ASbGncvUIbaN5mw2qn9bQ/hG/5rmDp89V9wx65im6nMPV8/E8CC/Amapfq1CnmArJyt
	T2A33s54rRYDgce2nDMmwFH1I3DfwEeuSWstCjlnqGkdZ5qHQHSbRYPcLZUFVw20sdJ2NLs8Rvh
	NHcBATbf4NkANXVwv8l57PAW0cqt8LtC/38LA/3q6BEPq5T3Y/NYJVUWWFht+7Hs5ORUia59e+y
	maHvotSvPBGKoj1kpAlrjmni7Gab+zbWUNXQfCmz/G3JjE/bLtEUcw+DvXW1wAhSdxBATgbS8af
	v5l1V42i/0LVaPRQvbjmqv/BfvebmVKoCbriaahrhL+58Vju0aonz5vTIkRP1/vodm9G/2xJWda
	VqQHizgaWpr0NuhtC42HmlP4=
X-Google-Smtp-Source: AGHT+IHni0YhsjitUn4aQ1FDXN9en8ZbXniog2Pi5PTT3e93dK1QnkKBCL6GbjCY5nmkTi0kEoENZA==
X-Received: by 2002:a5d:5f47:0:b0:3a5:2b75:56cc with SMTP id ffacd0b85a97d-3a8f52b685fmr9585106f8f.23.1751224763645;
        Sun, 29 Jun 2025 12:19:23 -0700 (PDT)
Received: from [2a04:ee41:3:2418::ffff] ([2a04:ee41:3:2418:ec97:de8:ed49:4bc4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad1adsm143664115e9.24.2025.06.29.12.19.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jun 2025 12:19:23 -0700 (PDT)
Date: Sun, 29 Jun 2025 21:19:17 +0200
From: devnoname120 <devnoname120@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <e2f071a2-59bb-412e-a3cd-da90247f7173@Spark>
In-Reply-To: <alpine.DEB.2.22.394.2506292057190.95572@hadrien>
References: <7c65be39-dfc3-4b9c-9acd-dd94d1225db8@Spark>
 <alpine.DEB.2.22.394.2506291925100.95572@hadrien>
 <55f3b1f1-2537-4bc3-88d3-d7da1136060a@Spark>
 <alpine.DEB.2.22.394.2506292057190.95572@hadrien>
X-Readdle-Message-ID: e2f071a2-59bb-412e-a3cd-da90247f7173@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="686191ba_661e3f1e_1255"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [HELP] Using macro `randomized_struct_fields_end` as
 context?
Reply-To: devnoname120 <devnoname120@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2826
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/e2f071a2-59bb-412e-a3cd-da90247f7173%40Spark>

--686191ba_661e3f1e_1255
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The reason is that I want to create a patch that applies to a broad varie=
ty of vendor kernels for Android. They all have minute differences, botch=
ed up backports, etc.

Previously I created semantic patches for KernelSU Next (Android rooting =
at the kernel level) that cleanly applies to all the 3.4 to 6.15 kernels =
that people threw at it (20+ of them). This would not have been possible =
without semantic patches and beforehand people were painstakingly trying =
to manually fix rejects when applying the traditional diff patches.

You can see the result here: https://github.com/devnoname120/kernelsu-coc=
cinelle/blob/40c9c0caab5773680c07278e71d0fbaaeb39eccb/scope-minimized-hoo=
ks/kernelsu-scope-minimized.cocci

Now my new project is to port SUS=46S (a series of kernel patches to hide=
 KernelSU and other system modifications from user apps) to semantic patc=
hes so that they can also cleanly apply. Currently the SUS=46S developer =
maintains 7 distinct branches to cover 7 different kernel versions, but e=
ven then people have a lot of rejects due to patches that vendors applied=
 to the kernel of their device.

The full SUS=46S patch that I'm trying to port over to semantic patches i=
s here:
https://github.com/devnoname120/susfs4ksu-coccinelle/blob/7388e1613b3ee62=
67cc0d2784eebcce9fcaa8a09/50=5Fadd=5Fsusfs=5Fin=5Fkernel-4.14.patch

It's a big chunk but I'm convinced that I can get there with enough time.=
 This would be a huge win for the community. I would like to keep it simp=
le by having a single Coccinelle file that can be applied with spatch wit=
hout additional patches and scripts, just like I've done for my kernelsu-=
coccinelle patches. The exception is the Makefile but it only requires to=
 add 1 line in there so it's OK.

Thank you,
Paul
On Jun 29, 2025 at 20:59 +0200, Julia Lawall <julia.lawall=40inria.fr>, w=
rote:



> On Sun, 29 Jun 2025, devnoname120 wrote:
>
>
> > Here is my new semantic patch:
> >
> > =40depends on file in =22include/linux/sched.h=22 exists=40
> > declarer name randomized=5Fstruct=5Ffields=5Fend;
> > =40=40
> >
> >
> > struct task=5Fstruct =7B
> > ...
> > +=23ifdef CON=46IG=5FKSU=5FSUS=46S
> > + u64 susfs=5Ftask=5Fstate;
> > + u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;
> > +=23endif
> > randomized=5Fstruct=5Ffields=5Fend
> > ...
> > =7D
> >
> > And here is the error:
> >
> > =E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --l=
inux-spacing include/linux/sched.h
> > init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coc=
cinelle/standard.h
> > SPECIAL NAMES: adding randomized=5Fstruct=5Ffields=5Fend as a declare=
r
> > SPECIAL NAMES: adding u64 as a type
> > minus: parse error:
> > =C2=A0=46ile =22include/linux/sched.h.cocci=22, line 12, column 0, ch=
arpos =3D 247
> > =C2=A0around =3D '...',
> > =C2=A0whole content =3D ...
> >
> >
> > If I add a semi-colon after =60randomized=5Fstruct=5Ffields=5Fend=60 =
in the semantic patch:
> >
> > =E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --l=
inux-spacing include/linux/sched.h
> > init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coc=
cinelle/standard.h
> > SPECIAL NAMES: adding randomized=5Fstruct=5Ffields=5Fend as a declare=
r
> > SPECIAL NAMES: adding u64 as a type
> > minus: parse error:
> > =C2=A0=46ile =22include/linux/sched.h.cocci=22, line 11, column 28, c=
harpos =3D 246
> > =C2=A0around =3D ';',
> > =C2=A0whole content =3D randomized=5Fstruct=5Ffields=5Fend;
> >
>
> The problem is that getting the semantic patch to parse is not enough
> anyway; the associated C code has to be parsed as well.
>
> But I have the impression that you want to do something at one specific=

> place in sched.h. Why not just make the change by hand=3F
>
> julia
>
>

> > Paul
> >
> > On Jun 29, 2025 at 19:26 +0200, Julia Lawall <julia.lawall=40inria.fr=
>, wrote:
> >
> >
> > On Sun, 29 Jun 2025, devnoname120 wrote:
> >
> > Hello,
> >
> > I'm trying to insert two fields inside a struct, right before the use=
 of the macro =60randomized=5Fstruct=5Ffields=5Fend=60. You can find more=
 information about the macro here: https://stackoverflow.com/a/72675757
> >
> > Here is the unified diff that I'm trying to convert to a semantic pat=
ch:
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 9ea614e09f56..c153abffd4c5 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > =40=40 -1467,6 +1467,10 =40=40 struct task=5Fstruct =7B
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * New fields for task=5Fstruct should =
be added above here, so that
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * they are included in the randomized =
portion of task=5Fstruct.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=23ifdef CON=46IG=5FKSU=5FSUS=46S
> > +=C2=A0=C2=A0=C2=A0 u64 susfs=5Ftask=5Fstate;
> > +=C2=A0=C2=A0=C2=A0 u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;
> > +=23endif
> > =C2=A0=C2=A0=C2=A0=C2=A0 randomized=5Fstruct=5Ffields=5Fend
> >
> > =C2=A0=C2=A0=C2=A0=C2=A0 /* CPU-specific state of this task: */
> >
> > Here is the file that it applies to: https://github.com/devnoname120/=
kernel=5Fxiaomi=5Fsm6150/blob/fce5582771e1254af065aaa2778940659e246611/in=
clude/linux/sched.h=23L1470
> >
> > I tried the following semantic patch:
> >
> > =40depends on file in =22include/linux/sched.h=22 exists=40
> > =40=40
> >
> > struct task=5Fstruct =7B
> > ...
> > +=23ifdef CON=46IG=5FKSU=5FSUS=46S
> > + =C2=A0 u64 susfs=5Ftask=5Fstate;
> > + =C2=A0 u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;
> > +=23endif
> > randomized=5Fstruct=5Ffields=5Fend
> > ...
> > =7D
> >
> >
> >
> > You can try putting in the metavariable section
> >
> > declarer name randomized=5Fstruct=5Ffields=5Fend;
> >
> > But I suspect it will still object due to the lack of a ; after
> > randomized=5Fstruct=5Ffields=5Fend.
> >
> > julia
> >
> >
> > However I have the following error:
> >
> > =E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --l=
inux-spacing include/linux/sched.h
> > init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coc=
cinelle/standard.h
> > SPECIAL NAMES: adding u64 as a type
> > minus: parse error:
> > =C2=A0=46ile =22include/linux/sched.h.cocci=22, line 11, column 0, ch=
arpos =3D 194
> > =C2=A0around =3D '...',
> > =C2=A0whole content =3D ...
> >
> > I also tried the following code:
> >
> > =40depends on file in =22include/linux/sched.h=22 exists=40
> > identifier END =3D=7E =22randomized=5Fstruct=5Ffields=5Fend=22;
> > =40=40
> >
> > struct task=5Fstruct =7B
> > ...
> > +=23ifdef CON=46IG=5FKSU=5FSUS=46S
> > + =C2=A0 u64 susfs=5Ftask=5Fstate;
> > + =C2=A0 u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;
> > +=23endif
> > END
> > ...
> > =7D
> >
> > But it yields the following error:
> >
> > =E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --l=
inux-spacing include/linux/sched.h
> > init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coc=
cinelle/standard.h
> > SPECIAL NAMES: adding u64 as a type
> > minus: parse error:
> > =C2=A0=46ile =22include/linux/sched.h.cocci=22, line 11, column 0, ch=
arpos =3D 209
> > =C2=A0around =3D 'END',
> > =C2=A0whole content =3D END
> >
> > I'm not sure why I have this error and I couldn't find an answer afte=
r looking on the internet and reading the Coccinelle grammar.
> > Could you help me figure this out=3F
> >
> >
> > Thanks=21
> > devnoname120
> >
> >
> >

--686191ba_661e3f1e_1255
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div>The reason is that I want to create a patch that applies to a broad =
variety of vendor kernels for Android. They all have minute differences, =
botched up backports, etc.</div>
<div>&=23160;</div>
<div>Previously I created semantic patches for <a href=3D=22https://githu=
b.com/KernelSU-Next/KernelSU-Next=22>KernelSU Next</a> (Android rooting a=
t the kernel level) that cleanly applies to all the 3.4 to 6.15 kernels t=
hat people threw at it (20+ of them). This would not have been possible w=
ithout semantic patches and beforehand people were painstakingly trying t=
o manually fix rejects when applying the traditional diff patches.</div>
<div>&=23160;</div>
<div>You can see the result here: <a href=3D=22https://github.com/devnona=
me120/kernelsu-coccinelle/blob/40c9c0caab5773680c07278e71d0fbaaeb39eccb/s=
cope-minimized-hooks/kernelsu-scope-minimized.cocci=22>https://github.com=
/devnoname120/kernelsu-coccinelle/blob/40c9c0caab5773680c07278e71d0fbaaeb=
39eccb/scope-minimized-hooks/kernelsu-scope-minimized.cocci</a></div>
<div>&=23160;</div>
<div>Now my new project is to port SUS=46S (a series of kernel patches to=
 hide KernelSU and other system modifications from user apps) to semantic=
 patches so that they can also cleanly apply. Currently the SUS=46S devel=
oper maintains 7 distinct branches to cover 7 different kernel versions, =
but even then people have a lot of rejects due to patches that vendors ap=
plied to the kernel of their device.</div>
<div>&=23160;</div>
<div>The full SUS=46S patch that I'm trying to port over to semantic patc=
hes is here:</div>
<div><a href=3D=22https://github.com/devnoname120/susfs4ksu-coccinelle/bl=
ob/7388e1613b3ee6267cc0d2784eebcce9fcaa8a09/50=5Fadd=5Fsusfs=5Fin=5Fkerne=
l-4.14.patch=22>https://github.com/devnoname120/susfs4ksu-coccinelle/blob=
/7388e1613b3ee6267cc0d2784eebcce9fcaa8a09/50=5Fadd=5Fsusfs=5Fin=5Fkernel-=
4.14.patch</a></div>
<div>&=23160;</div>
<div>It's a big chunk but I'm convinced that I can get there with enough =
time. This would be a huge win for the community. I would like to keep it=
 simple by having a single Coccinelle file that can be applied with spatc=
h without additional patches and scripts, just like I've done for my kern=
elsu-coccinelle patches. The exception is the Makefile but it only requir=
es to add 1 line in there so it's OK.</div>
<div>&=23160;</div>
<div>Thank you,</div>
<div>Paul</div>
</div>
<div name=3D=22messageReplySection=22>
<div>On Jun 29, 2025 at 20:59 +0200, Julia Lawall &lt;<a href=3D=22mailto=
:julia.lawall=40inria.fr=22>julia.lawall=40inria.fr</a>&gt;, wrote:<br />=

&=23160;</div>
<br />
<br />
<blockquote style=3D=22margin: 5px 5px; padding-left: 10px; border-left-w=
idth: thin; border-left-style: solid; border-left-color: =231abc9c;=22>
<div>On Sun, 29 Jun 2025, devnoname120 wrote:<br />
<br />
&=23160;</div>
<blockquote style=3D=22border-left-width: thin; border-left-style: solid;=
 border-left: thin solid =23e67e22; margin: 5px; padding-left: 10px;=22>
<div>Here is my new semantic patch:<br />
&=23160;<br />
=40depends on file in =22include/linux/sched.h=22 exists=40<br />
declarer name randomized=5Fstruct=5Ffields=5Fend;<br />
=40=40<br />
<br />
&=23160;<br />
struct task=5Fstruct =7B<br />
...<br />
+=23ifdef CON=46IG=5FKSU=5FSUS=46S<br />
+ u64 susfs=5Ftask=5Fstate;<br />
+ u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;<br />
+=23endif<br />
randomized=5Fstruct=5Ffields=5Fend<br />
...<br />
=7D<br />
&=23160;<br />
And here is the error:<br />
&=23160;<br />
=E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --linux=
-spacing include/linux/sched.h<br />
init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccine=
lle/standard.h<br />
SPECIAL NAMES: adding randomized=5Fstruct=5Ffields=5Fend as a declarer<br=
 />
SPECIAL NAMES: adding u64 as a type<br />
minus: parse error:&=23160;<br />
&=23160;=46ile =22include/linux/sched.h.cocci=22, line 12, column 0, char=
pos =3D 247<br />
&=23160;around =3D '...',<br />
&=23160;whole content =3D ...<br />
&=23160;<br />
&=23160;<br />
If I add a semi-colon after =60randomized=5Fstruct=5Ffields=5Fend=60 in t=
he semantic patch:<br />
&=23160;<br />
=E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --linux=
-spacing include/linux/sched.h<br />
init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccine=
lle/standard.h<br />
SPECIAL NAMES: adding randomized=5Fstruct=5Ffields=5Fend as a declarer<br=
 />
SPECIAL NAMES: adding u64 as a type<br />
minus: parse error:&=23160;<br />
&=23160;=46ile =22include/linux/sched.h.cocci=22, line 11, column 28, cha=
rpos =3D 246<br />
&=23160;around =3D ';',<br />
&=23160;whole content =3D randomized=5Fstruct=5Ffields=5Fend;<br />
&=23160;</div>
</blockquote>
<div><br />
The problem is that getting the semantic patch to parse is not enough<br =
/>
anyway; the associated C code has to be parsed as well.<br />
<br />
But I have the impression that you want to do something at one specific<b=
r />
place in sched.h. Why not just make the change by hand=3F<br />
<br />
julia<br />
<br />
&=23160;</div>
</blockquote>
<br />
<blockquote style=3D=22margin: 5px 5px; padding-left: 10px; border-left-w=
idth: thin; border-left-style: solid; border-left-color: =231abc9c;=22>
<blockquote style=3D=22border-left-width: thin; border-left-style: solid;=
 border-left: thin solid =23e67e22; margin: 5px; padding-left: 10px;=22>
<div>Paul<br />
&=23160;<br />
On Jun 29, 2025 at 19:26 +0200, Julia Lawall &lt;julia.lawall=40inria.fr&=
gt;, wrote:<br />
<br />
<br />
On Sun, 29 Jun 2025, devnoname120 wrote:<br />
<br />
Hello,<br />
&=23160;<br />
I'm trying to insert two fields inside a struct, right before the use of =
the macro =60randomized=5Fstruct=5Ffields=5Fend=60. You can find more inf=
ormation about the macro here: https://stackoverflow.com/a/72675757<br />=

&=23160;<br />
Here is the unified diff that I'm trying to convert to a semantic patch:<=
br />
&=23160;<br />
diff --git a/include/linux/sched.h b/include/linux/sched.h<br />
index 9ea614e09f56..c153abffd4c5 100644<br />
--- a/include/linux/sched.h<br />
+++ b/include/linux/sched.h<br />
=40=40 -1467,6 +1467,10 =40=40 struct task=5Fstruct =7B<br />
&=23160;&=23160;&=23160;&=23160;&=23160; * New fields for task=5Fstruct s=
hould be added above here, so that<br />
&=23160;&=23160;&=23160;&=23160;&=23160; * they are included in the rando=
mized portion of task=5Fstruct.<br />
&=23160;&=23160;&=23160;&=23160;&=23160; */<br />
+=23ifdef CON=46IG=5FKSU=5FSUS=46S<br />
+&=23160;&=23160;&=23160; u64 susfs=5Ftask=5Fstate;<br />
+&=23160;&=23160;&=23160; u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;<br />
+=23endif<br />
&=23160;&=23160;&=23160;&=23160; randomized=5Fstruct=5Ffields=5Fend<br />=

&=23160;<br />
&=23160;&=23160;&=23160;&=23160; /* CPU-specific state of this task: */<b=
r />
&=23160;<br />
Here is the file that it applies to: https://github.com/devnoname120/kern=
el=5Fxiaomi=5Fsm6150/blob/fce5582771e1254af065aaa2778940659e246611/includ=
e/linux/sched.h=23L1470<br />
&=23160;<br />
I tried the following semantic patch:<br />
&=23160;<br />
=40depends on file in =22include/linux/sched.h=22 exists=40<br />
=40=40<br />
&=23160;<br />
struct task=5Fstruct =7B<br />
...<br />
+=23ifdef CON=46IG=5FKSU=5FSUS=46S<br />
+ &=23160; u64 susfs=5Ftask=5Fstate;<br />
+ &=23160; u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;<br />
+=23endif<br />
randomized=5Fstruct=5Ffields=5Fend<br />
...<br />
=7D<br />
<br />
<br />
<br />
You can try putting in the metavariable section<br />
<br />
declarer name randomized=5Fstruct=5Ffields=5Fend;<br />
<br />
But I suspect it will still object due to the lack of a ; after<br />
randomized=5Fstruct=5Ffields=5Fend.<br />
<br />
julia<br />
<br />
&=23160;<br />
However I have the following error:<br />
&=23160;<br />
=E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --linux=
-spacing include/linux/sched.h<br />
init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccine=
lle/standard.h<br />
SPECIAL NAMES: adding u64 as a type<br />
minus: parse error:&=23160;<br />
&=23160;=46ile =22include/linux/sched.h.cocci=22, line 11, column 0, char=
pos =3D 194<br />
&=23160;around =3D '...',<br />
&=23160;whole content =3D ...<br />
&=23160;<br />
I also tried the following code:<br />
&=23160;<br />
=40depends on file in =22include/linux/sched.h=22 exists=40<br />
identifier END =3D=7E =22randomized=5Fstruct=5Ffields=5Fend=22;<br />
=40=40<br />
&=23160;<br />
struct task=5Fstruct =7B<br />
...<br />
+=23ifdef CON=46IG=5FKSU=5FSUS=46S<br />
+ &=23160; u64 susfs=5Ftask=5Fstate;<br />
+ &=23160; u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;<br />
+=23endif<br />
END<br />
...<br />
=7D<br />
&=23160;<br />
But it yields the following error:<br />
&=23160;<br />
=E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --linux=
-spacing include/linux/sched.h<br />
init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccine=
lle/standard.h<br />
SPECIAL NAMES: adding u64 as a type<br />
minus: parse error:&=23160;<br />
&=23160;=46ile =22include/linux/sched.h.cocci=22, line 11, column 0, char=
pos =3D 209<br />
&=23160;around =3D 'END',<br />
&=23160;whole content =3D END<br />
&=23160;<br />
I'm not sure why I have this error and I couldn't find an answer after lo=
oking on the internet and reading the Coccinelle grammar.<br />
Could you help me figure this out=3F<br />
&=23160;<br />
&=23160;<br />
Thanks=21<br />
devnoname120<br />
<br />
<br />
&=23160;</div>
</blockquote>
</blockquote>
</div>
</body>
</html>

--686191ba_661e3f1e_1255--

