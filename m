Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF1FC19F28
	for <cocci@archiver.kernel.org>; Wed,  3 Aug 2022 11:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=4u3KbGiaSXXpRn308/Pp/VnF2W0JiKx04YFdeWtLptU=;
  b=Lw6c4RIQVtOBE4APnzBkH1coadVXg/FccmlTmZ4Du3o8zfSzQ66rjO7G
   NS+3Wuz9buANSb0Pf0a98wh4ZqVV9tvgCjn72LDRTDy+q79Fd2OvFc6Cj
   vGOMWw8PP+KMUBPAPWtESaGPICZM/mPKVq2N2ngK2wYnpA/t05nFegFmA
   0=;
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
X-IronPort-AV: E=Sophos;i="5.93,214,1654552800"; 
   d="scan'208,217";a="47841986"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Aug 2022 13:26:55 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7B9D6E0241; Wed,  3 Aug 2022 13:26:54 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 26159E0235
	for <cocci@sympa.inria.fr>; Wed,  3 Aug 2022 13:26:53 +0200 (CEST)
IronPort-SDR: THPda64Tno0NqYLhsQNH/Jye/6L0W3NKE8YE5idLRpclH2Bmemk5ez4J/xeCdShcj8OrO2RMT4
 3AwLfx+Uegfud0OsTsbYf59reGEEzEPqb6uXHNQMlscnsEI8BAoGtoxcqFh8wGBcA589bz7oLu
 +eBBhiD3GfSzSSEguL6RogJDCOsAZt/RiNHl2Pm3qKFjqSBy6qPP8Fa2BDx3PlsHB/vA9J9Hxf
 BGfdYvZcp8hZXIPHme3j9nRylEI8dGdpCrwxq2KwDx8uqBtz8h2IC17PkHL4AnB444eIOefN2B
 lIFdA7yiEzoEXeji2poburZ2
X-IPAS-Result: =?us-ascii?q?A0AuBACyWupifyrbVdFaHgEBCxIMhDOBVy8EC0WEToEjj?=
 =?us-ascii?q?2gDizOBBol8hkWBewsBAwENEgEvBAEBhQYChHYCHQcBBEcBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAETAQENCwkHCAoHDg4FYAFhAwFEgU+BdAsDM?=
 =?us-ascii?q?Q2CNSkBg2MBAQEBAgESER0BGx0BAwELBgUEBw0qAgIiAREBBQEcBgsIGweFQ?=
 =?us-ascii?q?AEDDSUDnHWBBEKKOHqBFQUXgQGCCQaETgoZKA1nA4FZAgcSh2ECGkdMAQGDI?=
 =?us-ascii?q?4QZJ4FlRIFLgkQwPogagkMiBItri3gEBwMEBQEGDgMDAiABAgFEHgIJAyMRA?=
 =?us-ascii?q?wsQERUXAQQIAQQDAQEBDgIFBwIGAwMCAgICBQECCgIBAgQDBgYCAxABAgQBC?=
 =?us-ascii?q?gQCAwgCBwMCBgQKBAIHAgIEAQUDDQEDBQIDAQEDAwIEAQIBAQMIAQMCAwMCA?=
 =?us-ascii?q?gICBQIDAgICCQMEAQcDAgMBBAMBAgoEBAMEAgIHAgcCBAcCAQIGAwUGAQECA?=
 =?us-ascii?q?QcBAQQKBAMDAwMCBQICAwIGEgYGAgQBAwQCCgICCwIHAQECAQEBAQIDAgcFC?=
 =?us-ascii?q?wEBAQMCAwYFAgEBAwgGAgEEAQUDAQQFAwcCAQUGAgkDAwkDAQEFAQMBBgMDA?=
 =?us-ascii?q?wIHAwECDAQIAwMCAwQCAgICAQMCBwUIBAIJAgICAQICAgQCAQMaAQIDBQICC?=
 =?us-ascii?q?QsBBAICAwEDAQECCAQJBAIDBAIBAQMCAQICAQUCDgYBAQEBAgMDAQIDAQYHA?=
 =?us-ascii?q?ggCHAoBAwMDAgIFAgIBAgMCAgwBAQQCAQIBAgYBAwECAgMBAwECAgMCBgkCB?=
 =?us-ascii?q?AEFAwMCAgMBAQUPBQIEAgECBgUCAQEBBAEDBAQGAgIBAwMCDgIEAQQBAgEBI?=
 =?us-ascii?q?wMEAgMBAxcBAgECAwMDBAYHBQIBAhMBAgEBAQUBAgEBAwQEBwoDAgIEAwMFA?=
 =?us-ascii?q?QECAwIBAQEHDAICAhMCEwMBBgEOBRQDAgQCAgECAgoDAQICAQMCCQIBAgEFI?=
 =?us-ascii?q?AMBAQ8kAQECAgICAwQHAgEEBgMNAgIBAQEFBg0DAgMIAQwCBwMCAQMFAQICA?=
 =?us-ascii?q?gQBAgQKCQECAgECBAUHAgEIBgUNBQkLAQECAQMHBAMRAgUDBQUDAwIBCgUCA?=
 =?us-ascii?q?wECAQEDBAEDBAYBAQIDAgIBBgICAQEDAwQDAQIGAgIHAgMCAQQCAwMBAQEEA?=
 =?us-ascii?q?gICAgIDAwgDAggHBQEGAQIBBAMCAgECBwEEAQgCAQMDBQMEAQoDDwMFAwEDA?=
 =?us-ascii?q?wIUCgUBBQgGCQIEBQIFAwIEAgMDAgIIAwIEAwILAwIGAgICBwQPBwIDAgIFA?=
 =?us-ascii?q?gICAgIFBAMBAgICAgICBQIEAgEFAQICAQICAgQBAgIHBAIDAQMEDgMDBAICB?=
 =?us-ascii?q?wECAgEGAgcDAQIBBAMBAQQCBAECBQICBAEDAQIGAgQDCgICAwICAgYIAwMMC?=
 =?us-ascii?q?QIDBQIGAQECBwQCAgsBBgIHAgIBAgMRAQMCAQQFBQMDAwkCAgMCBAICCgEBA?=
 =?us-ascii?q?QECAgEFBQIEBw8CAgIEAgICAQIDAgIBAQICBAQJEgEBAgMGBAYFAwIIGAEGA?=
 =?us-ascii?q?gIBAQICAgMDAgYCAQIIAgQBBAUCAQICAgIEAQMGAgMBAQIBAgIDAwIBBAIEA?=
 =?us-ascii?q?wMBAQIBAgICAwICAgMCAgEQAgYGAQICAgICAwICAQIFAQIBAgQCBwICBAMCA?=
 =?us-ascii?q?QICBQICAgMBAQYCAgQLAQMCBwYBAwIHBQIDAQIDBAMDCwUMCAEFAQMBBSECA?=
 =?us-ascii?q?wICCQIIAgEFAgUFARkBAQVkmDgGPhYhGgGBcFqhHIISiziTEQeCQ4ERgUSeW?=
 =?us-ascii?q?DGoZ5Z+ohqFLRAjEoFagWdwgQGCN04BAgEBAQ0BAgEBAwECAQIJAQECjh2Dc?=
 =?us-ascii?q?opmPDE7AgYBCgEBAwmPBgEB?=
IronPort-PHdr: A9a23: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
 Kc=
IronPort-Data: A9a23:Aq0pSq904yPvoXXbWq0ADrUDQ3iTJUtcMsCJ2f8bNWPcYEJGY0x3y
 zZNDDyDbPbcYGb8eNF2bIWx9UIE6J7VmINnGwQ6rC1EQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvymYAL9EngZqTVMEU/Nsjo+3b9i6mJUqYLhWVnV6
 Yup+5e31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Zz
 +Rmkq2IZwwQHvOPs6cvYj0fUA5aIvgTkFPHCSDXXc27ykTHdz713awrAh1se4If/elzDCdF8
 vlwxDIlNEjSwbLrhujiG68w3KzPL+GzVG8bkmlpyTjfDLAlaZ/GSqTOo9Rf2V/cg+gSQqaCP
 ptJMFKDajyQRBIWGwdLVahmp9642GvVURlCq1Ca8P9fD2/7lVQtitABKuH9ftWVTMFRtlSZo
 2jc9iL4BAsbPZqR01Kt+XWnje7nhjL+QItUFbui9/csjkf7+4AIIBgfVF/+uOfgz0DiAZRQL
 Esb/idopq83nKC2cjXjdxqJi1m1hjAXYvoOUMZ52jCpjen7xxnMUwDoUQV9QNAhscY3Qxkj2
 VmIg87lCFRTXFu9GSL1GlC8/WPaBMQFEYMRTXRbElZdsrEPtKl2302fFI8yeEKgpoStQWmY/
 tyckMQpa1wuYSMj0qy6+RXenWvpqMSTCAEy4QrTUySu6QYRiG+Zi26AuQWzARVodt7xory9U
 J4sxpj2AAcmUM7lqcB1aL9RdIxFHt7cWNEmvXZhHoM66xOm8GO5cIZb7VlWfRk0Y5paJGezP
 R+I5mu9AaO/2lP6PcebhKrhW6wXIVTISLwJq9iPM4QQPMEpHON51Hg+OhTOt4wSrKTcufhnZ
 c3znTeEAnEdBqBqpAdatM9MuYLHMhsWnDuJLbiil0rP+ePHOBa9FOlYWHPTMbhRxP7V+G39r
 ocEX+PXmkU3eLOkPkH/r9VIRXhUdihTOHwDg5YIHgJ1ClE2Rj9J5j646e9JRrGJaIwMyLyVr
 yvmCxYHoLc97FWeQTi3hrlYQOuHdf5CQbgTZETA5H6khCouZ5iB9qAae8dldLUr7r0xwvt9T
 v1DcMKFW6wdRjPC8jUbTJ/8sI0yLETx1VzSZ3KoMGolYpptZw3V4du7LAbi8S85CCDo58Yzp
 ruX0BzWHMgYTAN4AceKM/+ilgvjvXUUlO9ocVHPJ91fJBfl/IRwen7+i/Y2J4cHLhCanmmW0
 AOfABE5o+jRot9toIOZ2/zc94rwSrlwBEtXGWXf/I2aDyiC8zrx25JEXcaJYSvZCzH59aCkU
 uNfkKPxPfgBq1BV6tYuHrtuy5U+0NvhvbptyAppQSfQZFOxB7I8e3SL0JUdtqBJwbMF6wK6V
 ljVoYtfMLSNfdr7SRsfeFBjYeOE2vUZ3DLV6K1tckn94SZ2+puBUFlTb0bQ0n0DdOMtPdN32
 /olte4X9xe71kggPOGAg30G7G+LNHEBD/gqu81IGoPtkQZ3mFhObYaGUX3z6ZCLLsxSawwkf
 mXSi63FiLBRgEHFdiNrR3TK2ONcg7UIuQxLnABefQXXwoKdi69lxgBV/BQ2Uh9RkkdN3dV1N
 zU5LEZyP6iPo2plicUrs7pAwO2d6MB1O3AdymflUEXcRkisE3XTdSgzZbzL80ce/GZRODNc+
 dl0DYojvSnCJKnMMukaACaJaMAPifR+8wTDnIasGMHt81wSf2/+mqH3DYYXg0KPPC7y7XErY
 cFl+e9xbevwMit4T2jXzWWF/ex4dS1o71CujR2sEG3l0I0clPyPNeCyFn2M
IronPort-HdrOrdr: A9a23:3DlxSaC4BPVbCPPlHemT55DYdb4zR+YMi2TDGXoBMCC9E/bo7/
 xG+c5w6faaskd1ZJhNo6HjBEDEewK+yXcX2+gs1NWZLW3bUQKTRekI0WKh+V3d8kbFh4lgPM
 lbAs5D4R7LYWSST/yW3OB1KbkdKRC8npyVuQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,214,1654552800"; 
   d="scan'208,217";a="47841981"
X-MGA-submission: =?us-ascii?q?MDHBnqfbX9/wLFcMlQKEPAWWgR00LOQYGeiG8A?=
 =?us-ascii?q?5YtNmX8LGZSzzRKjIw257F3HRqRA20ToNRoib3N/O6peRqOS4URMGUSo?=
 =?us-ascii?q?qXu8oBQdN/5ov5XaI9jx2t46bUUE2OLKRRb6YwVP5C8TbrbC3NU1ZF2S?=
 =?us-ascii?q?UbzP3xRq+zSW/xYmPlY3bVgQ=3D=3D?=
Received: from mail-qv1-f42.google.com ([209.85.219.42])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 13:26:52 +0200
Received: by mail-qv1-f42.google.com with SMTP id ct13so8986673qvb.9;
        Wed, 03 Aug 2022 04:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4u3KbGiaSXXpRn308/Pp/VnF2W0JiKx04YFdeWtLptU=;
        b=eYai2m9P0oSpMJfsyhK/Jtb6o83SfGVBu+4x12X0Yuk8AOsRD/SIz2yvanPeHEsCQ1
         Eu5+Bd1YUTW1vL3A1UtPGMxGXKaurhC1l6SZhqU0BBm6s0vRVV7pJab3WNaZbmilB2Ee
         HRbqnkl8q1kQ/dIdj16cUiwGd8bgb8ILxJKgXs48XDJo8sXn/SQBYvbVsWHwo54nl8mR
         YerFzcopUqk5A54U1+aInElhvV1JdaxoeKoUNO7S9VFXWJkp19cPPNxV+iRYgyYuNCTH
         dNZ5Vrz3B9QjMl+XckvbPSPsZgBp0aq9yOcsAxKtwUF7eK7iJWYZy7GqrNtIx6d62nYz
         I7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4u3KbGiaSXXpRn308/Pp/VnF2W0JiKx04YFdeWtLptU=;
        b=ZgVpmVnfoXbsm+7snNSDvGdHvzSBaAyqPhrgfIoLrgY7RaNgeYucVyYriSfPE1hoxD
         8XxbRgMLsCcH/yz63IA1I/+hx+ftZ/aidXyS1cy1QLNQcE+WO6BCFwAeWnwiljNl5uQe
         h46zSuwXJ4ZWXGpG7n8cFBozA9Oab51T9Ge1X8yGaHQ1UIHBHYDCBgE4c9c7BKmE1gbe
         iCo6WhwJ3KLWHQ0QMuKjr2zT0vndGgS/wk3XlHxbZIfqJ+K9LSr0hGR2kOpQA1wy6fg2
         PNTuXIYUniFavMn5KPY+/SN7Uo+OPZCM9XsVwALBuj2s08LxditCAUWr8zlg9VDeysAq
         CC/A==
X-Gm-Message-State: ACgBeo3EX4fdPwRFQkeDwdz46HMVjhJ8Qdxu/LajdCFrJu/iEfT7ZdSm
	6u3gYh0sP0pd5Ks37KP8a2/lz3xBX4YoPEPQDCT1NvCy
X-Google-Smtp-Source: AA6agR6oFPRAhN7P0SpgRQU69/0+AP4Q1Qb1ycmfuqOXiNvNjLMvmmS40ILQzG/SpwDwgTzkWs7G8y5MnsEJg/zRteU=
X-Received: by 2002:a05:6214:529e:b0:476:93ab:155c with SMTP id
 kj30-20020a056214529e00b0047693ab155cmr11574647qvb.25.1659526010869; Wed, 03
 Aug 2022 04:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAASoEDQCExdJXmMJy55OPAVaetG9b91g7ecdXojDVoC0iC-CRQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2208030757490.2778@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2208030757490.2778@hadrien>
From: Palani kodeswaran <palani.k@gmail.com>
Date: Wed, 3 Aug 2022 16:56:39 +0530
Message-ID: <CAASoEDQX5WA8eXoYhToficaNUBocB5Kfw2O6nGWY0wCxNH-evg@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: multipart/alternative; boundary="0000000000005f9ca305e5548274"
Subject: Re: [cocci] Can coccinelle be used for adding header files
Reply-To: Palani kodeswaran <palani.k@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 502
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/CAASoEDQX5WA8eXoYhToficaNUBocB5Kfw2O6nGWY0wCxNH-evg%40mail.gmail.com>

--0000000000005f9ca305e5548274
Content-Type: text/plain; charset="UTF-8"

This works... Thank you very much.

Palani.

On Wed, Aug 3, 2022 at 11:33 AM Julia Lawall <julia.lawall@inria.fr> wrote:

>
>
> On Wed, 3 Aug 2022, Palani kodeswaran wrote:
>
> > Hello,
> >
> > I am new to coccinelle and am trying to see if it would be possible in
> coccinelle to add a header file to a source file.
> > Our current coccinelle rules change function calls to a different
> function that is defined in another header file that is not included by
> default. Would greatly appreciate if someone could point to an example that
> can accomplish adding header files.
>
> You should be able to do:
>
> @@
> @@
>
> #include <...>
> +#include <myheader.h>
>
> The problem comes if there is no include in your code at the moment.  I
> don't think there is any convenient solution for this at the moment.
>
> You could use python to print out that your Coccinelle rule has detected
> that the header file shold be added, and then add it by hand.
>
> Also, the above will not necessarily put the header file at the place
> where you want it.  I don't really remember what strategy it uses.
> Perhaps it is just put as the last one with the above rule, and as the
> first one with the following:
>
> @@
> @@
>
> +#include <myheader.h>
> #include <...>
>
> Instead of ... you can also put a file name, if there is a specific file
> you want the new header to always be before or after.
>
> You may also need to make separate rules for the case
>
> #include "..."
>
> You can give each rule a name, and then ensure that later ones are only
> run if earlier ones are not used, eg:
>
> @r1@
> @@
> - foo
> + bar
>
> @depends on !r1@
> @@
>
> - xxx
> + yyy
>
> julia

--0000000000005f9ca305e5548274
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This works... Thank you very=C2=A0much.<br><div><br></div>=
<div>Palani.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Wed, Aug 3, 2022 at 11:33 AM Julia Lawall &lt;<a href=
=3D"mailto:julia.lawall@inria.fr">julia.lawall@inria.fr</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On Wed, 3 Aug 2022, Palani kodeswaran wrote:<br>
<br>
&gt; Hello,<br>
&gt;<br>
&gt; I am new to coccinelle and am trying to see if it would be possible in=
 coccinelle to add a header file to a source file.=C2=A0<br>
&gt; Our current coccinelle rules change=C2=A0function calls to a different=
 function that is defined in another header file that=C2=A0is not included =
by default. Would greatly appreciate if someone could point to an example t=
hat can accomplish adding header files.=C2=A0<br>
<br>
You should be able to do:<br>
<br>
@@<br>
@@<br>
<br>
#include &lt;...&gt;<br>
+#include &lt;myheader.h&gt;<br>
<br>
The problem comes if there is no include in your code at the moment.=C2=A0 =
I<br>
don&#39;t think there is any convenient solution for this at the moment.<br=
>
<br>
You could use python to print out that your Coccinelle rule has detected<br=
>
that the header file shold be added, and then add it by hand.<br>
<br>
Also, the above will not necessarily put the header file at the place<br>
where you want it.=C2=A0 I don&#39;t really remember what strategy it uses.=
<br>
Perhaps it is just put as the last one with the above rule, and as the<br>
first one with the following:<br>
<br>
@@<br>
@@<br>
<br>
+#include &lt;myheader.h&gt;<br>
#include &lt;...&gt;<br>
<br>
Instead of ... you can also put a file name, if there is a specific file<br=
>
you want the new header to always be before or after.<br>
<br>
You may also need to make separate rules for the case<br>
<br>
#include &quot;...&quot;<br>
<br>
You can give each rule a name, and then ensure that later ones are only<br>
run if earlier ones are not used, eg:<br>
<br>
@r1@<br>
@@<br>
- foo<br>
+ bar<br>
<br>
@depends on !r1@<br>
@@<br>
<br>
- xxx<br>
+ yyy<br>
<br>
julia</blockquote></div>

--0000000000005f9ca305e5548274--
