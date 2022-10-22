Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DFEC04A95
	for <cocci@archiver.kernel.org>; Sat, 22 Oct 2022 12:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=F7a2b86JjEJVOxa2gLAnw+sTdJ0gF+hrCtXKQyeaL8Q=;
  b=NiHNQelQI5yHs6t2fuRhQONJ/KlbF+wQ8hq/5NO4IwESejTdN1HEgp6D
   xvO8lm0ZShJqmARMd6Q5xxmp18PnqVm2JkPIJ25uIJygT25j3axj3/VAx
   LXJ9o5/9R+zYLXXp1vl7CdCZdpNFiKGZZqqox9MZcKAMoGx0OlvSoRKIZ
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.95,205,1661810400"; 
   d="scan'208";a="67870853"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Oct 2022 14:56:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1070DE0130; Sat, 22 Oct 2022 14:56:32 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AAC74E004E
	for <cocci@sympa.inria.fr>; Sat, 22 Oct 2022 14:56:28 +0200 (CEST)
IronPort-SDR: 6353e87c_vSMuyuAQAF8BQP85bX9po5uyx/9FM6s5VnBLE0JbUPKnBmn
 3iXXbcJc+6Y6HsLtQ/DK62DUyN5sDS0+wh0K+aQ==
X-IPAS-Result: =?us-ascii?q?A0AIBACx5lNjfy+gVdFaHgEBCxIMQINUKIFWLwQLRYROk?=
 =?us-ascii?q?RqLQYEHhiKMMA8BAwENRAQBAYUFAoRxAh0HAQQ0EwECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEARMBASEZBw4OKYVoDYI1KQGDZAEBAQMSER0BGx0BA?=
 =?us-ascii?q?wwGBQsNAgImAgIiAREBBQEcBhMIGoVIAQMwA55QgQRCizKBFQUCFoEBggkGh?=
 =?us-ascii?q?E8KGSgNaAOBWgIHEn8siF+HAnonHIFJRIFLgnQ+iBuCZgSVPQEDBwMEBgUPA?=
 =?us-ascii?q?wMCIQECAUMdAgkDIw8DCwkIExcoBgECAQEMB0YEHB8DAQEPJAEBAgICAwQHA?=
 =?us-ascii?q?gEDBgMMAgIBAQEFBg0DAgMIARIDAgEDBQICBAECBAoIAQICAQIEBQcCAQgGB?=
 =?us-ascii?q?Q0FCQsBAQIBAwcEAxECBQMFBQMDAgEKBQIDAQIBAQMGBAQBAQIDAgIBBgICA?=
 =?us-ascii?q?QEDAwQDAQIGAgIHAgMCAQQCAwMBAQECAgICAgIDAwkCCAcFAQYBAgEEAwICA?=
 =?us-ascii?q?QIHAQQBCAMDBQUJDwMFAwEDAwIUCgUBAwgGCAIEBQIFAwIEAgMCAggDAgQDC?=
 =?us-ascii?q?wMFBAIHBA8HAgMCAgUCAgICAgUEAwECAgICAgIFAgMCAQUBAgIBAgICBAECA?=
 =?us-ascii?q?gcEAgMBAwQOBAMCAgcBAgIBBgIHAwECAQQDAQEEAgQBAgUCBAEDBgIEAwoCA?=
 =?us-ascii?q?gMCAgIGBQMDCggCAwUCBAEBAgcEAgILAQYCBwICAxABAwEEBQUDAwMJAgIDA?=
 =?us-ascii?q?gQCAgoBAQEBAgIBBwIEBw8CAgIEAgICAQMCAgEBAgIKEgEBAgMGBAYFAwIIG?=
 =?us-ascii?q?AEGAgEBAgIDAwIGAgECCAIEAQQFAgECAgICBAEDBgIDAQECAQICAwMCAQQCB?=
 =?us-ascii?q?AMDAQIBAgICAwICAgMCAgEPAgYGAQICAgICAgICAgEFAQIBAgQCBwIEAwIBA?=
 =?us-ascii?q?gIFAgICAwEBBgIECwEDAgcGAQMCBwUCAwEEAwQDAwsFDAgBBQEDAR4DAgIIA?=
 =?us-ascii?q?gcCAQYFAQ8DAgIDAgIBBAoCAwUCBAIBBAkHAgQBAgkDAgYCBwUYAQICBwQMC?=
 =?us-ascii?q?gICAgUGAgQBAQEBAwECAQECAwQCAwIEBQEFAgECBQQCAgEBAgUCDAECAQcGA?=
 =?us-ascii?q?gcCAgICAwEEAgECAQMDAgMBAQEDBgYFBAQCAwMGAgICBgICAwISAwYCBgMCB?=
 =?us-ascii?q?AENDwUEBQgBAgEBBwIEAgcJDgIBBgEFAgIDAgIBBQIBBgMBAgICAgUIBQMEB?=
 =?us-ascii?q?QMGDwMBAQQDAgECAQQDAgMHAwIEBAMBAgMEBgYBCQMCAgYDAgICDQMEAgIBA?=
 =?us-ascii?q?gECAwQEBgICAgECAgICAwQCAgEBAwMDAgICAwQCAwMLBgoIAgICAwIBBQsEA?=
 =?us-ascii?q?gMCAQMGCQIEAgIGAQIEAgICAgICAgMBAQMKBAIBAgMCAgYDBgIBAgECAQkFA?=
 =?us-ascii?q?gEJAwECAQIBBAEDBgQBAgIECQIDBwUEBgQCAgICCAICDgMDAgEBBAICBAUCA?=
 =?us-ascii?q?gsCAQIHAgUBAQMFBwICAQICAQQDAQkEAQICAwIBAQMDEQMDAwEEAgIFAwMNC?=
 =?us-ascii?q?QYCAgEDAgMBDQMDAQIBAgMBBQUXAwIBCAcDEwMCAQEDAgECAgMGBAEIAgIDA?=
 =?us-ascii?q?wMCAQIFAgQDAwEFAgEBAwEFAwIOAwIDAwMCBgECAQECAwIDAQwEBQEBAQEWA?=
 =?us-ascii?q?wECAwIEAgIBAQIIAQQDAQECAQIDAgIOBgEEBd82Y4MJoEcyg2QBpSyXIadkE?=
 =?us-ascii?q?CMSgUQjgVtNIxVsgjZOAxkPjiCBJgENgj6KYEIxOwIGCwEBAwmKVQEB?=
IronPort-PHdr: A9a23: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
 ISQ0q30LzhG/pTf+s5OX6Dp
IronPort-Data: A9a23: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
 4QqbTgsfXxXgnId3Sqtl7C51f3ZUP7SI+0UUBqy
IronPort-HdrOrdr: A9a23:nHVe8K3qPwx/0cktW7Hg+gqjBI0kLtp133Aq2lEZdPWaSL3gqy
 nOpoVi6faQslwssR4b6LW90cW7MBHhHNtOkOos1NSZPTUO2lHYSL2KhLGKq1bd8m/FltK1vp
 0QFJSWZueAa2SSTvyX3OB7KbsdKRW8n5xATN2x80tQ
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,205,1661810400"; 
   d="scan'208";a="67870849"
X-MGA-submission: =?us-ascii?q?MDEpXSf45Y/AvqwU+8PoY11hVfKELsJK1fvd54?=
 =?us-ascii?q?vvwcNVcmKQGMz+70VtF+60vfU8Qy64KDYh06gSro631iSxT5Xlu70LEy?=
 =?us-ascii?q?2KCBFxyYaPJO0WPU7Pu/EJAawvV9+7IHpgr5wEkiHNySgbyhMN8l8MlQ?=
 =?us-ascii?q?kOc1He6oxh0zodaXlmHju3JQ=3D=3D?=
Received: from mail-oa1-f47.google.com ([209.85.160.47])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 14:56:28 +0200
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-132fb4fd495so6771559fac.12;
        Sat, 22 Oct 2022 05:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F7a2b86JjEJVOxa2gLAnw+sTdJ0gF+hrCtXKQyeaL8Q=;
        b=GNr8ij6QjO6m7uxXmqGBV3HUSJfozpGNWZeAtRbjHD03fzOCW719a7MgZBBaEU50H4
         yEZA3NPtXMtSfbGLUk8Pguv8Oaf5AWyIrzT8T1i7xcX31rnU+ifq3MiwScAOqv79l+Lv
         a4W+K0ro3i57qZJiXCycRs2LorEMRbtMXjZ97L9Uic8aZ2wMIPl/D4H0yZ3ISzTmubAZ
         iUe1m/Zm6Fd/whA5FY17NEWX8vouao4h/zO22h1SMWA5KBUCu5j6/z83vvqmEcAQqeip
         dkqTpQbTVmFMmZX1NGbNQ0gUIB0WZi5wBURJYQykkJ/l7TQM5COtzvddWO6C2LJPFgq1
         r4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7a2b86JjEJVOxa2gLAnw+sTdJ0gF+hrCtXKQyeaL8Q=;
        b=ncLGQdDfG+Z3UBUadeL5ISr3FvhNYFZIlKpxaANJWJVbmCb0q4CyTfFQfK71OzBkzy
         XS+3PVm0UoqWj6htPos1UsDinTqkdz1+BN1udTTMNQOhbAVvFI0A3wQ9iRJPPzemITVn
         qObU8+Ui+3IJdJyxODAX/o+DP0tU4nFJLBysVDaAynqAOaFAtz2HpVqbfnAKskjUPOoy
         rs/quey0fiWwNpv/Kz7gGOAMNsoBSuuf3Hy1MIcKB8JxJoXSsCL/QaBUawGrW7/fdkbp
         2nhg9jLsttAzZXQQ0sjzAVJM1XJm8SD3hi3xPeROs6pU3cpgY6aM9rCjesNSfrH0F4qV
         CjdQ==
X-Gm-Message-State: ACrzQf093Qex8insjK+lE00HuiN3tS7vyPWGo8UVclZoX61SycnRbI9J
	PdU/WFWEKP9nhqBMAzW0MQgjlcTDRcSUg03M2c5vZOpA
X-Google-Smtp-Source: AMsMyM62zet+y7bUNUe8KcKVZiBSYSGhgxighhrW7HUFWDt/w8rjTPLw4cIitDwo1AyOPf8jCUbymH+40jN4oyRzj9c=
X-Received: by 2002:a05:6870:2487:b0:131:4fee:aec2 with SMTP id
 s7-20020a056870248700b001314feeaec2mr30818204oaq.69.1666443386605; Sat, 22
 Oct 2022 05:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <7691aca779054e7e2145d01bd95ff02a00a9da0a.camel@gmail.com> <alpine.DEB.2.22.394.2210221445570.2783@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2210221445570.2783@hadrien>
From: Jan Tojnar <jtojnar@gmail.com>
Date: Sat, 22 Oct 2022 14:56:14 +0200
Message-ID: <CAFGSp1tyufX3J-rV2ueSHcbwsoZn4bm49tXPpuObuRYTy8Y08Q@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [cocci] [PATCH 2/2] Distinguish script-based fresh ids with
 differing args
Reply-To: Jan Tojnar <jtojnar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 670
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/CAFGSp1tyufX3J-rV2ueSHcbwsoZn4bm49tXPpuObuRYTy8Y08Q%40mail.gmail.com>

On Sat, 22 Oct 2022 at 14:46, Julia Lawall <julia.lawall@inria.fr> wrote:
>
> Yes, I will take care of it.  Thanks for the contribution, and sorry for
> the delay.

No worries, I am applying the patch locally for now. Just wanted to
mention it so that the regression does not sneak into the next
Coccinelle release.

Jan
