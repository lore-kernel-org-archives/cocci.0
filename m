Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51FCC53219
	for <cocci@archiver.kernel.org>; Sat, 25 Jul 2026 11:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZBoRH8lGzaxL4Dd0YVaMryVasfc0C6Hqs/Glo/xz+as=;
  b=jVcqkKYLuEkZSQ5TH0ajEgemcsopQiA6da/NjX7AuVTtmGsr7jWXKJ3T
   LMemjl2I32iTzfoqIpF2FZaJkmyP8srt/JjoQDYVhHVhqjrzO8TjPCuTN
   mzIPcsLVpVQiHq76e8tsVxnbKURYRBAIxOq58GHUmhrRfv9jxWSNYDDkP
   Q=;
X-CSE-ConnectionGUID: iztQSlgiQxO5EbHRNQ6mdw==
X-CSE-MsgGUID: C8bAjr85TxaFVFjIJv4gOQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,184,1779141600"; 
   d="scan'208";a="287871638"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jul 2026 13:44:40 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E4BED805A7; Sat, 25 Jul 2026 13:44:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id E84FC81966
	for <cocci@sympa.inria.fr>; Fri, 24 Jul 2026 18:33:56 +0200 (CEST)
X-CSE-ConnectionGUID: iGWuEiIHSE2pbCWJan9Xfg==
X-CSE-MsgGUID: ENy9hzohRCO8W+kbli3cOA==
IronPort-SDR: 6a6393f4_YWpuZQpO7VhuVFGlg0it0pm7tUNF8eGGfFZsBjNscYVslck
 jRXGoq0UJEW80gzkJhsQ0Pt99eOESyxYoSDfLkw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GSBQDZkmNqfDDgfUpahRpagQ40BAtJhFiPUoIkiS6CG?=
 =?us-ascii?q?TACh1MDhG6HHT0CDwEDAQ1RBAEBAQIEhH4CjWACHgcBBEcBAgQDAgMBAQEBA?=
 =?us-ascii?q?QEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcODQUphk8NgmIBgSRhA?=
 =?us-ascii?q?gUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCLF4BA?=
 =?us-ascii?q?QEBAgESER0BGx0BAwwGBQsNAgImAgIhAREBBQEcBjWFAwEGEAEDECcDtl6BA?=
 =?us-ascii?q?kKKQ3qBFQUCFoEBgg0G2mgKGSgNdYFmAgcVAYEJhSYqXQOCWgGBcIQHhAJ6J?=
 =?us-ascii?q?4EYgRCBSoJ2PoRDFYNGgmoEgg2BIYJIhkmIfiYBBwEGFwMHBwkFBAkTBgUDA?=
 =?us-ascii?q?gI/CQYFChIDBAMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIICQQLBwUfCgIMF?=
 =?us-ascii?q?AooIgQOKwoBAgFVEAYaAQgGAgIEBAIEAgoCCQICBQMEAgQNAwQBAQgCAgMqA?=
 =?us-ascii?q?wEDGQgJCAILBREYDAsHMQMQCQMCHQMUFgUIETQIBhYBGgcFBgsBIBYUAQUME?=
 =?us-ascii?q?QECGwIhBB0BEAgDAQcDDgQEAgELAwEDARUECAkEDAIPAQoSFQMDCwMHDwINB?=
 =?us-ascii?q?xQFFQsDAg4CCQgMFwICAgYCAwMDCgECAQEBAQEBAQIHAwMDAgMZBwYDAwEBA?=
 =?us-ascii?q?wEEBAMDAgMFAQMDAwUCAgoGCQEBAQEDAgIIAwcDCgkCBQMbAxwGAQICAwIBA?=
 =?us-ascii?q?gMGAwcIAwgFAwQCAwMDBAECAgEBAQIDAQMDBAMBAwMCAQMHAgIDAwMLAQIDA?=
 =?us-ascii?q?wMFAwUBBQMFAgIDBQUDBQICCgIDAwMCAQMCHAMIAwYDEgEQAwMGAQMHAwcCB?=
 =?us-ascii?q?AMIBAMGAgMIAwMCCQgDFgYDAwMDBQECAgIDBQMDAwgIBAMDBAICAwwCBgMDA?=
 =?us-ascii?q?wIDAwUDAwcCBAIDBgMDAwEDAwUBAgcCAwcCAQsLCAMCBAIJBwkHAQIDCwQCB?=
 =?us-ascii?q?AYEDQkEAgQCAg8EBAUDAwcBAQIBAggFBgMCAhEFCAoFBgICAh0DIQECAQ8GA?=
 =?us-ascii?q?QkFAgEFDgcFAgIKEgMGAQEDBAUFAQMBCgELAQECAwMBBAUDAwUHAQIEAgcDA?=
 =?us-ascii?q?wMEAwMDAwEBAgIEBgQDAgMHAwMDAwMEBQUFAwIFAgQDBQMHAgMDAgEFCgEEB?=
 =?us-ascii?q?QQKAQMDAwMFBQMCAgMDBAECBAYDBAIDAQIIBAYFAwMDBQIDAwICAgMDBQEFA?=
 =?us-ascii?q?gMDAwQDAwMIBwUDAwUCCQMDCQMDCwICAyECBQMDAwMGAwcDAwQDAwMHBwIDA?=
 =?us-ascii?q?gMHAwIFAgcFAwMFAwYBAwIBAwMICxgDCwkIEz0BCwcuBAQMKgEUFAUpIV8Qj?=
 =?us-ascii?q?Wwjgj+BGoJAHIETAQEBkWySYqBqHgkBBgJggWeBChUKL6F1M6psLodmF5Bdq?=
 =?us-ascii?q?TIRJBKBSiKBXDMaI4EBbYFJUAMZD5Ijzkk4Mj0BAQcCBw4DC4FokDSBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:BwlFCaoIgaVYD1XfeBC2q6IaV5rqeYIsimQD101hICG9Lfb1qy
 n+ppkmPEHP4gr5lktQ5OxoX5PwPk80lKQFnbX5WI3MYOCIghrPEGgP1/qE/9SkIVybygc/79
 YDT0EdMqyJMbESt6+TizVQUexQpeVvm5rY/ts2oU0dNz1CWuVP60NXBg6HDlZ7XmB9dOMEPa
 vZyM4CiTTIQxQqhweAZ0XtndKsmzQDruOEXSI7
X-Talos-CUID: 9a23:Mb0eomx2OLRPXn5tSl+CBgUVNf84X3z87Ez9eVeyIllLQbvEeVGfrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AH1IwTg3BHUOkIkaXTQQFtqwxdzUjzoK/WUAflpU?=
 =?us-ascii?q?8kO7UCm9zMTOc1z+Qa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287811823"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDERFit0u1FoKBpn52G2wk7bPGR1I18GRObKeb?=
 =?us-ascii?q?cBeh5mO0VjDHyTGRMBcCv6Eb874XbtWKcRTUoqb8X5hlPkNdn4e/5YKd?=
 =?us-ascii?q?fFgQ7ZG7TBNKiMOn6NqB7mCzbJ5it2UEW3HEHeKaVJxgAwZ4mq5J07IU?=
 =?us-ascii?q?J3dkSTm/YBVnI7H/9N97nz8g=3D=3D?=
Received: from mail-yx1-f48.google.com ([74.125.224.48])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 18:33:56 +0200
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66899fe9077so656022d50.1
        for <cocci@inria.fr>; Fri, 24 Jul 2026 09:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784910835; cv=none;
        d=google.com; s=arc-20260327;
        b=ejKRb0MBQ4NMnP2nCOgldtl6cdSpBh+T1nH/QWUucIWlZkRVHg7Um3hZfnhRe8KwhV
         00isg28e0QbxN9Ap/oSZ32rv7aihqdjXSomh3fJ7k8FFJi/YOY465vrdPQjAa2iZFNt8
         aOZ6g9kSvV1vZ+6lXxJ42r8rDXhEzSYilZ2NW3Tcvh0FyXTOkLWvCUtJhzsxfC0DAw/C
         xWTToc92SdDMxWSqZlt2BmXU+y02R2adby8JwSkkZfTMGI6SHFthLBYkSWcon5oTjTKI
         OSFelk06XGNTDyLkUGzmcl9DgF2qud7Ot6bN0bnTBTurL5/BJVC3p6IM+dGQFd6KRpF2
         VZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZBoRH8lGzaxL4Dd0YVaMryVasfc0C6Hqs/Glo/xz+as=;
        fh=98o/vL8tvD+D6Lk3tVkGiKTfGX1YouR5vr0DoujIoQE=;
        b=K24yc+IxinSmcBHMqoqehNh06/T1R72Uh1gu3i9RDEHo2eIeWmXh+83OKGyfmR3II1
         VkkyboelcOxsNOIVBtCtSAfn5pS71CyKtZNkbY1rPuQXduWm754xd80Gf8MTVmUjncYG
         24huwFWJ9/ooZiKmgOz3Xz9rT2JYAABrHuwWPuFe5CC9CZtjDtrkDYRC5hcyMysb2XgL
         mMwQuARGD4KGzczbN2itGM6Ucqpn0VNtqZmQKfX877kC6Uge4IDfgzCnxhsMGGT1URLT
         Xl2vFpWtVbtrnbYJctD9vHFLFB3FQ5aYLk3SW26B5rGHALOdjBt6c1WEy3lI72f35WrJ
         73hA==;
        darn=inria.fr
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784910835; x=1785515635;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZBoRH8lGzaxL4Dd0YVaMryVasfc0C6Hqs/Glo/xz+as=;
        b=aqSvcHn5JdADk/0Pq0qVb/E9Jj5DyQMt5FzGj1gn9oHG9ulOWHQQ5ezC8xC4Fp39Vl
         eDraro+61uMRtGug4gQTexspq2H2O186KVhphyQyDR3HwxPgN9grmkIhLSPHq7UkE8t0
         j2ebo2khl2u9T3UNbU4zwoq1itRI3pEKS3jIUbIZFJM8xRhf0jDfOyK2EYik19lrhzHC
         8zkqYx++IV6aiSatrTsuXvOZtvU9mpsDGqwQtNThYQOyHBpj6gxSHgBphnni0FVvwpGR
         BkC3a0mmif1/C1l5f+aUZBlKRDcxRZoOQ4Xl4+p8qAZ1RTW3mCJKD8tdGqJEH/0j+yBI
         NW6Q==
X-Gm-Message-State: AOJu0YxyJj/DjNr3+Hzo9pXq3JPyNZ9EkVSqSPSucmRQU1lXR7cOi6MX
	JfzbwH7E4w9klBT9wnXpTPHKyjEfw+M563TbcnER4Rd4rbRWu33wl+A2g+8gPQqy8VWMQa7yYcB
	J2vq87Uv9eczcZSMi+0ZIfQwkMMLQquSH9DTnObY=
X-Gm-Gg: AR+sD117STz6kJm6arbcFEIiO7xh1kktnptZoHjv+cdMqj0JBT2vNgmmIfvNWBiykxJ
	NHZRqLuR7a+6+TU+uhir0Nn2eFtTZoYOEolFQ+1zuGfX25nuJdqu8oV9CrA2mIKB+YNNZoYKr9h
	t6oqsXj69aJ7rI11QgA0RyOkpnRSu+e6SCZsD2L3wIrTdTlcyYk2Rbpo7mhM2iNDuig1BkAGxBu
	ggFbSUNTcAGU9vdTy7BqqpX6FZaZa/pdWwA8zLPWOu6VWDUZfeTz+YXsHM=
X-Received: by 2002:a05:690e:2510:20b0:664:ae6d:ad2f with SMTP id
 956f58d0204a3-668a4f6fb70mr1772197d50.73.1784910835142; Fri, 24 Jul 2026
 09:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260723184538.3888637-2-ekffu200098@gmail.com>
 <b0577cf2-d8eb-473f-87af-82ecc653f29c@web.de> <CABFDxMFYvuAZSGcPmhAj4H43dwYBG01P2-UQPGa=-M=yRE8YKg@mail.gmail.com>
 <73b974fc-971b-41bd-a039-7566442ccc63@web.de>
In-Reply-To: <73b974fc-971b-41bd-a039-7566442ccc63@web.de>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sat, 25 Jul 2026 01:33:44 +0900
X-Gm-Features: AUfX_mxLKAeAr6h_oQLAkAcrcxCdk7ffjyXVXTOD-PrXHvihesP4WIxTkabK7U0
Message-ID: <CABFDxMEsXs+kJ1utqQveP9NNi+dVN-2ReNt3zWvf_TU=xofohw@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [1/36] coccinelle: misc: add
 cond_return_no_effect.cocci
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3652
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/I52_pxN7V9YSv0Er8KDuaQ>

On Sat, Jul 25, 2026 at 12:32=E2=80=AFAM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> >> =E2=80=A6
> >>> +++ b/scripts/coccinelle/misc/cond_return_no_effect.cocci
> =E2=80=A6
> > Combining them with two separate metavariables would be okay,
>
> Thanks that you can think a bit more about such a design variant.
>
>
> >                                                               but I
> > don't see much benefit in that change.
>
> Further metavariables can eventually be shared for an SmPL rule.
>
> How do you think about to avoid repeated search efforts by separate SmPL =
rules
> (for the patch mode)?

Are there impressive performance improvements from merging the rules?
If so, could you share an example or numbers?

>
> >                                        So I'd prefer to stay existing
> > form.
> There are different SmPL coding style preferences involved.
>
> Regards,
> Markus
