Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F50AC25B08
	for <cocci@archiver.kernel.org>; Sat, 20 Aug 2022 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:in-reply-to:date:cc:
   content-transfer-encoding:message-id:references:to:
   subject:reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=AGLZUGRhEBQVmi+ivQxh3AXI9Q6zS5zLTIvLTWKvMlo=;
  b=iJ18WWG4+RylqWq9BYUOe1N/T+LMvZHf09mhhNRZtvrvPHWEZvG47cj3
   uM/79PWInbNJfIvvC4NJjlO4Kz/5lq3XX0DVQ2pA0gCjEfl6mWIzvuZoh
   WZDy0zz9tprX0m96R373HKRN07dIuz8RbHOPQLw6G6SJ3IGDcdul0sfh7
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.93,251,1654552800"; 
   d="scan'208";a="49328643"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Aug 2022 16:47:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7064DE0AC3; Sat, 20 Aug 2022 16:47:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 934CEE00F6
	for <cocci@sympa.inria.fr>; Sat, 20 Aug 2022 14:58:02 +0200 (CEST)
IronPort-SDR: 4N+n19K0yU+xi1vgAlVxAP5RtSSqhfDs35u1sCxQkSd0ewt3bATXg7tor8kjDdHBpWdzyEugch
 yOz4PfQOvyKi2inKbHOpcj49PL2SvIZQiMVmtGH79q9DBhQQqM2N0L93NSyFadKtaBzYvxXzmA
 jotFPOZe5XxHs7nC9ResW9i0fm5Z6haFaTabEBzFa8qh5U1F+TZBVe8rvWWtn3akNbpBHls1ec
 CaQt1m7iuO5ZxXF1EpdIOqRUA/KJSvNgBBr6xnnNumWqfmk2OKEXT+UE0V5kJfB59I3KZqdohm
 7WC5aFPgR3Zij8XeC4skxoGO
X-IPAS-Result: =?us-ascii?q?A0BTAABl2QBjXUSnVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYIjBypQVy4EUIROiH6IDgOEJYcPgQmQRoF8CwEDAQsBATMNAgQBA?=
 =?us-ascii?q?YITgnQChGECHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEA?=
 =?us-ascii?q?QYeCQkHEhUOBWABYQMBRIFPgXQLAwQGJw2CNSkBg2MBAQEBAgESER0BGx0BA?=
 =?us-ascii?q?wELBgULAQwCAhgOAgIjEQEFAQgUBhMiglsBgmwBAw0lAwQMnBWBBEKKOHqBF?=
 =?us-ascii?q?QUXgQGCCQaCYYFuChkoDRVSA1t+AgEGCQEIfywBhlWIfCeBGYEQgTwcgmc+g?=
 =?us-ascii?q?mIFgV0Vg0E3gi4EmVIEBRQPAwMCIQMJBAcFLB4CCQMjEQMLEAgHDQEWAQQIA?=
 =?us-ascii?q?QQDAQEBDgIFBwIGAwMCAgICBQECCgIBAgQDBgYCAxABAgQBCgQCAwgCBwMCB?=
 =?us-ascii?q?gQKBAIHAgIEBQMNAQMFAgMBAQMDAgQBAgEBAwgBAwIDAwICAgIFAgMCAgIJA?=
 =?us-ascii?q?wQBBwMCAwEEAwECCgQEAwQCAgcCBwIEBwIBAgYDBQYCAgEHAQEECgQDAwMDA?=
 =?us-ascii?q?gUCAgMCBhIGBgIEAQMEAgoCAgsCBwEBAgEBAQECAwIHBQsBAQEDAgMGBQIBA?=
 =?us-ascii?q?QMIBgIBBAEFAwEEBQMHAgEFBgIJAwMBCAMBAQUBAwQDAwMCBwMBAgwECAMDA?=
 =?us-ascii?q?gMEAgICAgEDAgcFCAQCCQICAgECAgIEAgEDCQECAwUCAgkLAQQCAgMBAwEBA?=
 =?us-ascii?q?ggECQQCAwQCAQEDAgECAgEFAg4GAQEBAQIDAwECAwEGBwIIAg4OCgEDAwMCA?=
 =?us-ascii?q?gUCAgECAwICDAEBBAIBAgECBgEDAQICAwEDAQICAwIGCQIEAQUDAwICAwEBB?=
 =?us-ascii?q?Q4FAgQCAQIGBQIBAQEEAQMEBAYCAgEDAwIOAgQBBAECAQEjAwQCAwEDFwECA?=
 =?us-ascii?q?QIDAwMEBgcFAgECEwECAQEBBQECAQEDBAQHCQMCAgQDAwUBAQIDAgEBAQcMA?=
 =?us-ascii?q?gICEwITAwEGAQ4FFAMCBAICAQICCgMBAgIBAwIJAgECAQUgAwEBDyQBAQICA?=
 =?us-ascii?q?gIDBAcCAQQGAw0CAgEBAQUGDQMCAwgBDAIHAwIBAwUBAgICBAECBAoJAQICA?=
 =?us-ascii?q?QIEBQcCAQgGBQ0FCQsBAQIBAwcEAxECBQMFBQMDAgEGBAUCAwECAQEDBAEDB?=
 =?us-ascii?q?AYBAQIDAgIBBgICAQEDAwQDAQIGAgIHAgMCAQQCAwMBAQEEAgICAgIDAwgDA?=
 =?us-ascii?q?ggHBQEGAQIBBAMCAgECBwEEAQgCAQMDBQMEAQoDDwMFAwEDAwIUCgUBBQgGC?=
 =?us-ascii?q?QIEBQIFAwIEAgMDAgIIAwIEAwILAwIGBAIHEwcCAwICBQICAgICBQQDAQICA?=
 =?us-ascii?q?gICAgUCBAIBBQECAgECAgIEAQICBwQCAwEDBA4EBAICBwECAgEGAgcDAQIBB?=
 =?us-ascii?q?AMBAQQCBAECBQIEAQMBAgYCBAMKAgIDAgICBggDAwwJAgMFAgYBAQIHBAICC?=
 =?us-ascii?q?wEGAgcCAgECAxEBAwIBBAUFAwMDCQICAwIEAgIKAQEBAQICAQUFAgQHDwICA?=
 =?us-ascii?q?gQCAgIBAwICAQECAgUECRIBAQIDBgQGBQMCCBgBBgICAQECAgIDAwIGAgECC?=
 =?us-ascii?q?AIEAQQFAgECAgICBAEDBgIDAQECAQICAwMCAQQCBAMDAQECAQICAgMCAgIDA?=
 =?us-ascii?q?gIBEAIGBgECAgICAgMCAgECAQUBAgECBAIHAgQDAgECAgUCAgIDAQEGAgQLA?=
 =?us-ascii?q?QMCBwYBAwIHBQIDAQIDBAMDBQYFDAgBBQEDAQUfAwICCAIHAgEFAwUBDwMCA?=
 =?us-ascii?q?gMCAgEECgECAwUCBAIBAgEECQcCBAECCwMDBgIHBRgBAgIHBAwKAgICBQYCB?=
 =?us-ascii?q?AEBAQEDAQICAQIDBwIDAgQFAQUCAQIFBAICAQECBQIMAQIBBwYCBwMCAgIDA?=
 =?us-ascii?q?QQCAQIBAwMCAwEBAQMJBgUJAgQCAwMGAQMCAgYCAgMCHEuYO4FZLYEWKyAwg?=
 =?us-ascii?q?iegTaBkBwGDVIsrlHkELpZlkg+WJ2CNOJVYhCYCBAEBAQMHBhAjEoEuA4IQM?=
 =?us-ascii?q?xojegEGgjY+EAECAQEBDQECAQEDAQIBAgkBAQKMY4E6g3KKYD80OwIGAQoBA?=
 =?us-ascii?q?QMJhUaFFgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:IKNcEK0HziCXS9JQSPbD5R53kn2cJEfYwER7XKvMYLTBsI5bp2FUx
 jcYCGHQP6mMajH3c40gO9jn/ENSu8eDy4BmGgNk3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQywIbVvqYy2YLjW1PX4
 YuoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt4h79
 Pdxipu+cgYgN5SU39U4bDNJLAgraMWq+JefSZS+mcmazkmDd3W1hvswXAc5OooX/usxCmZLn
 RAaAGpVP1bT2qTvnu39FLkEascLdKEHOKsduXUwl2mfAvc6aZ/GSqTOo9Rf2V/cg+gSTK2EP
 JpIN1KDajzPTDBRN0cYA6sZv8mZqSGlNB9B9Wia8P9fD2/7lVQtitABKuH9ftWVTMFRtlSZo
 2jc9iL4BAsbPZqR01Kt+XWnje7nhjL+QItUFbui9/csjkf7+4AIIBgfVF/+pffgz0DgC5RQL
 Esb/idopq83nKC2cjXjd0WynFy4gRkSYNtZGtRirzCo9YDF3C/MUwDoUQV9QNAhscY3Qxkj2
 VmIg87lCFRTXFu9GSL1GlC8/WPaBMQFEYMRTXRbElZdsrEPtKl2302fFI8yeEKgpoStQWmY/
 tyckMQpa1wuYSMj0qy6+RXDjWvpqMaZCAEy4QrTUySu6QYRiG+Zi26AtgKzARVodt3xory9U
 J4sxpX2AAcmUM/lqcB1aL9RdIxFHt7cWNEmvXZhHoM66xOm8GO5cIZb7VlWfRk3apdfIm+zP
 heN6Wu9AaO/2lP6PcebhKrhW6wXIVTISLwJq9iPM4QQOskhHON51Hg/OBbOt4wSrKTcufhnZ
 c3znTeEAnEdBqBqpAdatM9MuYLHMhsWnDuLLbiil0rP+ePHOBa9FOlYWHPTMbhRxP7U8W39r
 ocCX+PXmkU3eLOkPkH/r9VIRXhUdihTOHwDg4kIHgJ1ClQ2SD1J5j646ehJRrGJaIwOyL+Uo
 S/tChcHoLc97FWeQTi3hrlYQOuHdf5CQbgTZETA5H6khCouZ5iB9qAae8dldLUr7r0xwvt9T
 v1DcMKFW6wdRjPC8jUbTJ/8sI0yLETx1VzSZ3KoMGolYpptZw3V4du7LAbi8S85CCDo58Yzp
 ruX0BzWHMgYTAN4AceKM/+ilgvjvXUUlO9ocVHPJ91fJBfl/IRwen7+i/Y2J4cHLhCanmmW0
 AOfABE5o+jRot9toIOZ2/zc94rwSrlwBEtXGWXf/I2aDyiC8zrx25JEXcaJYSvZCzH59aCkU
 uNfkKPxPfgBq1BV6tYuHrtuy5U+0NvhvbptyAppQSfQZFOxB7I8e3SL0JUdtqBJwbMF6wK6V
 ljVoYtfMLSNfcfrSRsfelpjYeOE2vUZ3DLV6K1tckn94SZ2+puBUFlTb0bQ0n0DdOMtPdN32
 /olte4X9xe71kggPOGAg30G7G+LNHEBD/gqu81IGoPtkQZ3mFhObYaGUX3z6ZCLLtFCawwkf
 G/Si63FiLBRgEHFdiNrR3TK2ONcg7UIuQxLnABefQXXwoKdi69lxgBV/BQ2Uh9RkkdN3dV1N
 zU5LEZyP6iPo2plicUrs7pAwO2d6MB1O3AdymflUEXcRkisE2jDdSgzZ7bL80ce/GZRODNc+
 dl0DYojvSnCJKnMMukaACaJaMAPifR+8wTDnIasGMHt81wSf2/+mqH3DYYXg0KPPC7y7XErY
 cFl+e9xbevwMit4T2jXzWWF/ex4dS1o71CujR2sEG3l0I0clPyPNeCyFn2M
IronPort-HdrOrdr: A9a23:6aT9DKnCB2vZui3t9WyjA6EAYAfpDfIP3DAbv31ZSRFFG/FwWf
 re5cjzsiWE8Ar5OUtQ+uxoXZPrfZqyz+8S3WB8B8bHYOCighrOEGgd1/qY/9SQIVydygc178
 4JGMhD4Z/LfCJHZK7BgTVQeOxQpeVvnprY+Ns2DE0AceipUcxdBstCZTpzancGODWuzKBWKK
 ah
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,251,1654552800"; 
   d="scan'208";a="49323896"
X-MGA-submission: =?us-ascii?q?MDFzNnDQ1RexFXLC659oX3UcP08gX+jD5S8/YH?=
 =?us-ascii?q?PxXEKwGlTsl1wvx+79u+5vNTB8F1JHhcwspMhkMncan47bKTf0zJCkpK?=
 =?us-ascii?q?uTQ5rl91SAyJL7BYyRLkAt3ikdF5SOYVmnZSiFcSESPJAyeaaBXIPbB7?=
 =?us-ascii?q?fcgR8tdO3F94NTY6OpJSNiXg=3D=3D?=
Received: from mail-lf1-f68.google.com ([209.85.167.68])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 14:58:02 +0200
Received: by mail-lf1-f68.google.com with SMTP id b38so6770470lfv.4;
        Sat, 20 Aug 2022 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=AGLZUGRhEBQVmi+ivQxh3AXI9Q6zS5zLTIvLTWKvMlo=;
        b=ke3lCVOrbAEe4/HYGG1Z5N0evGJxrBzyu4YtX2pBv0zWwUbYGpua91v4GMypCo6bH5
         gN9luFt5aAeAzK0ThtGLeqB1z9qbXKizanlrX7APqTOSiAMQfWfxcq58jpH5eKoDfY6z
         lnAnSjDq0cZGINaCZC7vbPU6Uyavmeyj9CzB3Y5Hj35Xy/d+KMGzPD2TGSApL4SkKPtD
         TOyj1smmZgn8zmWJg56mAJV7xlT/s7XmkamdqWJAeHWdOYJ/0YVqWS1PHn+aWzHHl0zr
         4f5JTF6TBZkEdbx/Q+Wg4YIJZMu1lAFlaV6FNv3CAI2MuHFYWjr/tGqjcyGQfM+WZAsN
         ZpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=AGLZUGRhEBQVmi+ivQxh3AXI9Q6zS5zLTIvLTWKvMlo=;
        b=XCv/aWTUBluGLOxmYqJ949c0p9Pu3kg1sbQg/ymUezdDCrXjxci8yCV+4F+k8VdSYm
         d6262ffc3eoawuPABgYAyLYWvoYDH3wAhEsqGurBW7vFO1QkE/8Iph/diikjAgVu2OHU
         775yyzMaQVIOLY7OO7r9Khhugx+veQt4p4lWAEyG0ebLamAMdxQWyHaZqeorqNO4OR9r
         3azJqddK8sYirE5aLzDLBhFP44TI+0uaJSRzc22d9hQurCAOOafO9KNxP8XdhjkU/I5h
         V7UW1YZ49c4D4Q1iBp6A5wVxJYyVEoJ6s3dRKB4c+MOax7/hifnuxfHeo1+ClT7Ftq/I
         NfBg==
X-Gm-Message-State: ACgBeo3p3g42g3+GYpr5r9b++APW9z703DKPDqmX8xS58oHBN+8gpP+/
	DdLgcjpbyzTVs4pb5ouC2EiylI7vIzIeoQ==
X-Google-Smtp-Source: AA6agR5evCAkhXBqyC43fVpr0MWLWf0YVvlYoLRgYupaS15WcRZ4v7aoPWWpINK3YOeHtUl0xnKHEw==
X-Received: by 2002:a05:6512:4026:b0:48b:e4d:6657 with SMTP id br38-20020a056512402600b0048b0e4d6657mr3741733lfb.449.1661000280824;
        Sat, 20 Aug 2022 05:58:00 -0700 (PDT)
Received: from smtpclient.apple (2-108-233-170-cable.dk.customer.tdc.net. [2.108.233.170])
        by smtp.gmail.com with ESMTPSA id k1-20020a2eb741000000b00261b175f9c4sm1047717ljo.37.2022.08.20.05.57.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Aug 2022 05:58:00 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
From: Jakob Koschel <jkl820.git@gmail.com>
In-Reply-To: <d9e428c2-f4d2-13bb-bf42-447a1f0ffa73@web.de>
Date: Sat, 20 Aug 2022 14:57:58 +0200
Cc: Julia Lawall <julia.lawall@inria.fr>,
 cocci@inria.fr
Content-Transfer-Encoding: quoted-printable
Message-Id: <5369B40D-9EA4-401F-A9CB-2CA1C0E3332E@gmail.com>
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
 <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
 <alpine.DEB.2.22.394.2208162306410.2625@hadrien>
 <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
 <alpine.DEB.2.22.394.2208171631050.2482@hadrien>
 <92b5eb33-9c76-7e45-7651-6296c9795a67@web.de>
 <88152C77-84AD-4515-A403-71F827180FD9@gmail.com>
 <cf4058d8-13ca-0637-fe0c-d9d8582c5673@web.de>
 <17A83354-2406-47E5-94EE-4955E09819DA@gmail.com>
 <d9e428c2-f4d2-13bb-bf42-447a1f0ffa73@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Working with parameter/expression lists by SmPL
Reply-To: Jakob Koschel <jkl820.git@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 525
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/5369B40D-9EA4-401F-A9CB-2CA1C0E3332E%40gmail.com>



> On 19. Aug 2022, at 19:00, Markus Elfring <Markus.Elfring@web.de> =
wrote:
>=20
>> I'm trying to detect certain code patterns spanning across files with =
this.
>> They will *probably* not easily be automatically patchable since I'm =
trying to
>> find bugs with this in an ongoing research project.
>=20
>=20
> Would you like to add a link for this evolving information source?

I'm not sure what you mean "link for this evolving information source". =
There is no
public information on this yet since it's an ongoing project.

>=20
>=20
>=20
>> You're right, the positions can be omitted here, but I'm using them =
with a
>> simple python script afterwards to report the matches I found where =
the positions
>> will be useful.
>=20
>=20
> Would you like to improve the distinction for the usages of mentioned =
variables
> any further by using operation modes (or variants) for SmPL scripts?
>=20
> Would it become helpful to use the name =E2=80=9Dinteresting_func=E2=80=9D=
 as another metavariable?

yes I've done that afterwards but for my use case it doesn't matter =
since it will only be
one specific function regardless.

>=20
>=20
>=20
>>> =E2=80=A6
>>>> +++ /tmp/cocci-output-test1.c
>>>> @@ -6,7 +6,8 @@ int interesting_func(int argc, char *str
>>>> }
>>>>=20
>>>> int main(int argc, char *argv[]) {
>>>> -  int x =3D 0;
>>>> +  int x =3D 0
>>>> +    // test;
>>>>=20
>>>>  func1(x, "asdf");
>>>> }
>>> Do you vary comment additions for your test results?
>> yes exactly.
>=20
>=20
> Do you stumble on any more development challenges for adding comments
> by the Coccinelle software?
>=20
> How do you think about possibilities to add multi-line comments
> (instead of specifying desirable messages behind double slashes)?
> https://en.cppreference.com/w/c/comment
>=20
> Are you looking for better source code formatting according to =
semicolons?

I'm not exactly sure what you mean with that? I've only used adding the
comment to see if the matching works correctly, I'm not intending to
do anything with comments in the final version.

>=20
>=20
>> Only issue I'm having now is that it doesn't work across files.
>=20
>=20
> Would you like to explain remaining development concerns any more?
>=20
> Regards,
> Markus
>=20

