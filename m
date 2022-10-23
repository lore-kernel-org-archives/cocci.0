Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0FFFA373E
	for <cocci@archiver.kernel.org>; Sun, 23 Oct 2022 19:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=CBdjLGUFpRzknIf9jYSN0XI5sFJYjEkABu1cSEcoQOg=;
  b=tuu8l9PmuA/jDvyMe2wM1eWsRhZkEp1oKNX8rAteRXBpq30PiAGEZK0p
   vTbmSRQmLqoIXBseWX62AMEXIbzuGluwm/UHEfZ2XlLusUasmMRFvPMnR
   Uqhy6ykAceGcqTFdDS3cVdgQ372S8McJoDGGFpTZbfNcds8aS5qRC/EfR
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@zx2c4.com
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="67941843"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Oct 2022 21:43:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 63FDAE01D1; Sun, 23 Oct 2022 21:43:14 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F0136E004E
	for <cocci@sympa.inria.fr>; Sun, 23 Oct 2022 21:39:12 +0200 (CEST)
IronPort-SDR: 63559860_98TwwJulDKpDLd8RNj+h+8kns+CZbHhY72zAi1vR/GzPsiE
 TNcXIZCWzFfcw2Ul6gbguKK+iIOGb5SUzHmx2Ug==
X-IPAS-Result: =?us-ascii?q?A0BvAgC8l1VjkNlUsotaHgEBCxIMQIN8gQFWLgQLRQOES?=
 =?us-ascii?q?4h+h3shaZ5AAQMBDTkLBAEBghKHZgIdBwEENBMBAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?wEBBQEBAQIBAQIEBAETAQEBAQEBFgkeHgUihWgNgjUpAYNkAQUjHQEBNwEPC?=
 =?us-ascii?q?xgCAiYCAhBHBhOCfQGDIAMDDas5gTKBAYIIAQEGgUABgR+EDX4DBoERLI9he?=
 =?us-ascii?q?ieCKYQ/PoJLhVCCZpVWOANEHUADCzsyDVEcWA4JHxwOFw0FBhIDIG4FQQ8oL?=
 =?us-ascii?q?2crHBsHgQwqKBUDBAQDAgYTAyICDSkxFAQpEw8tByNxCQIDIWUFAwMEKCwDC?=
 =?us-ascii?q?SEfByUkPAdYOgEEAwIQIjwGAwkDAiRXgSQmBQMNFyUIBU4ECDoCBQZSEgIKE?=
 =?us-ascii?q?QMSDwYnRw5KPjkWBidEATQPDhYDY5cCgSVygTsvgXBYwFeBNQcDg2KDTod3l?=
 =?us-ascii?q?QIylmqSJ5chjUGaM4F5I4FbcIM3EgE7HA+IS4VVg3KFFIVMPzQCATgCBgsBA?=
 =?us-ascii?q?QMJil4BAQ?=
IronPort-PHdr: A9a23:HumhnRLh6qJu4hwKZ9mcuBVvWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCFvrMx1AWCBN6Lo9t/yMPu+5j6XmIB5ZvT+FsjS7drEyE/tMMNggY7C9SEA0CoZNTjbig9A
 dgQHAQ9pyLzPkdaAtvxaEPPqXOu8zESBg//NQ1oLejpB4Lelcu62/689pHJbAhEmCSxbbxvI
 Bi4rgjaq9Ubj5ZlJqst0BXCv2FGe/5RxWNmJFKTmwjz68Kt95N98Cpepuws+ddYXar1Y6o3Q
 7pYDC87M28u/83kqQPDTQqU6XQCVGgdjwdFDBLE7BH+WZfxrzf6u+9g0ySUIcH6UbY5Uim54
 qx1VBHnljsINz8h8GHWlMNwir5boAm8rBB72oLYfZ2ZOOZ7cq7bYNgUR3dOXtxJWiJPAo2yc
 ZUCAfcCM+ZWoIbyu0YBohmlCAmwGO/i0CNEimPq0aA41ekqDAHI3BYnH9ILqHnYotH7O70JU
 eCyyqnD0CnOY+lL0jnz74jIdA4uofeCXb1udcre1EcjHB7Cg1uUs4PlJDSV1uIWvmma4OtsS
 /6ghmE9pw5tpTivw94hh4/UjY0a1l7K7z92wJopJdKmUk57Z8apHZ9euSyVOIZ4TMAvTW9ot
 SsmyrMLvZy2cDYFxpkn2hPSafKKfoqV7h79WuucIjh2iXN7dLy/mxq88VSsx/P9W8SyzV1Eo
 C1FktzWuXAM0Rze8suHReVn/kenxzmP0xrf6uZeIUA7k6fQNp0vwqYom5YOv0nOGjX6lFj0g
 aKVbEkp+eel5/75brn7pJKQL495hh/kPqgwmsGzG/k0PwYKUmSB5Oix26Hv8EvkS7tQlPI2i
 LPWsJXCKMQbuKG5BwhV354+5BaxATaqys8YnX4aLFJfZB2IkZLlO1LQL/DiC/ewnVCsnC1sx
 /DcMb3tGpTNLn7dn7f9Zbtx9kBRxQ4pwdxC5Z9ZCasNLfH8V0PrqtDUEx00PxSxw+n9CdV90
 o0eWXiIAq+cKK7crEOG6P8zL+SUf4EVpjf9K+Y96vLwj3A0gV4cfKa30ZQLZ320BOhpI0KcY
 Xf0htkOC3wKvg04TOHxi12NTyRTZ3CsUKI4/D07D5imDYjbSoCrm7OOxD27EYFOZmBaFlCMF
 m/le5ucV/cWdC2SOtNhkiADVbW5V4Ah0g2huxP7y7d8NerV+igYtYr529Rv5u3Tkwsy9T1uA
 MiH3WGNVXl4nnkUSD8uwKB/vUt9x0+H0adijf1XD9hT5/dSXwY7NJ7cyvd1C8roVQ7bf9eJT
 kymQtS8Dj0rQNIx2YxGX0EoPty4jQ3YlweuDaUUkbPDULk96KHBxD7cI8hnynDJ/LYshR8qT
 50cG3ehg/s11QHIAIiBugPRu6GseKIS0SrBvi/X72OVu0dwQh4qWvmDVncaMBiF5e/l71/PG
 uf9QY8sNRFMnIvbcvMigrzBiFxHQK2mI9HCeyernGz2Ax+Ux7SKZY6semMH3SybBlJX2xsL8
 yOgMg4zTjykv3qYFCZnQHDmeETq2ftu8njnCEQzylLCdFVvgoK84QVdnvmAU7UW17MAtj0mr
 mBPJm3liuvICsTV/Ts0brUGao9761BCgEDQrAt7Fp+tNaZvghgZaQsk91j22UBRDYNN2dMvs
 GtszAd2LveA10hdcjqDwZ3qErHZNS/p+w21YKOQ2VzE1tuSvKAV55zUsn3FuwekXgon+nRji
 ZxO1meEo4/NB0wUWI7wVUA+8157oavba28z/dGc03okKqSyvjLYvrBhTOI41hatecteO6KYB
 UfzFcMdHc2nNO0tnRCgcBsFOOlY8KN8MdmhcrOK36uiPeAomzzD7ywPwolm1USk5TomQbKO1
 JEAgrmZ0gaBSzbgnQK5qMmk0YtAZDwUAi++0X29X98XP/IiO9ZXTz33fJ7SpJ02nZPmVn9G+
 UT2AloH3JXsYh+Odxnn2gYW000LoHuhkC/+zjpukjhvoLDMuU6Gi+nkahcDPXZGAWd4ilK5a
 7OOtIhPZVapcV1zpU639Rzxm+5Qo6EqDWDIRkFgfCXsKWxmFKyqufDRBqwHoINtqihRXOmmN
 Bq4Q6X6pTMIw3noQy1VwzVxJHm6/57+mRJ9kmeUKn1++WHYdc9HzhDa/NXARPRV01LqXQFAg
 CLMThi5Ntitp5CPkovb9/q5XCSnX4FSdi/iycWBsjG67CtkG0/3k/e2k9zhWQ80tE2zn+JQb
 n2dlQj9fNyx5vGoIbhsIg9jA1qpycNhHYdWkYYqgpwUn38Aid2Z8GEGnmH6LdhAvMC2JCNWF
 HhSnI6TsFSjghQ8ZnuSj5r0THCc3tdsa5Ghb2Ua1zh8p8FGBaGI7aBVyC58o162twXUMp0f1
 n8Wzfoj7mJfgvlc4VF8iHzCUvZCQQ8CZHO/8nbAp8qzp6hWemu1JL251U4k2MukEKnHuAZXH
 nDwZpYlGyZ0qMR5KlPFlnPpueSGMJHda8weshqMnlLOle9QfdgKrMFS0BN5OHyo50xw2f5hh
 kAo1pa/6aqOMGJr1KG0GBhVMnvyfcxZqVSPxe5O292b2YyiBMArIQ8wBM7RU/O2RWgj4Ob3b
 Q3SVjY7ryK5EKHYGyec5V1gonaJFIqkfSLyRjFR3ZBpQx+TI1ZaiQYfUWAhn5I3IQutwdTob
 EZz4j1Crk69sBZHzfhkcgXuSmqK7hn9cS86EdLMSXgephEH/UreNtaSq/5+Dz0NtIP0txSDc
 ySSNRxEHWQAW0jCBF35OLSqo97a/KCRVPCzK/LfJ7aDs+pTU7GP353KsMMu9mSAONrJJX5/F
 fY2nElOR3Z0H4LegTpHQn4ekjmLdMmGvhyxvC56tMay9LLsQg2Kh8PHAulJMNMp4Berm6yOc
 e2dniB0LXBfzJxE03bMzPJ3MEc6rSZoenHtFL0BsXSIV6fMgupNCBVdbSpvNcxO5qZ63w9XO
 MedhMmnnrh/xuU4DVtITzmD0omgeNAKLmehNVjGGFfDNbKIIifOyt32ZqX0QKNZjeFdvRm98
 TiBFEqrMjOGnjjvHxehVIMExDmcJwBbsZqhfwxFBWb8CsnhdwewPZl0gCcwzLlygWnFdCYdP
 TV6b0JRv+iQ4Cdf0ZAdUyRK6ntoK/XBmj7MtrKJbM9J4b07XmIuzr0JhRZyg6FY5yxFWvFvz
 S7br9o05kqjjvHK0D1sFhxHtjdMgouP+0RkI6TQsJdaChOmtFoA63udDxMSqp5rENrq7upr8
 OOXwZvtKSkXqeOB79tGDJSSI8WCZVgoKh3vMD3ZFg0ISXisL26V1Ck/2LmCs2aYqJQ3sM2mg
 J0VVrpST0A4DNsWBFsjB9sfOpx6GDApi7iWiIgP/3X0/3yzDI1K+5vAUPyVG/DmLj2U2KJFa
 xU/yrT9NY0PN4f/1iSKj3FojN7BRwzbWtUf+kWJgSc3rV9L/Xw4SXc8iRuNguKF7HEMU+Wzg
 wQ9h019bP4r+TOq5E04dAKimQ==
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:QnY5ja5PA5ldC7leVwPXwM/XdLJyesId70hD6qkQc3FomwKj5q
 OTddAgpGbJYVcqKRcdcLW7VJVoLkmzyXcY2+gs1PKZLXHbUQiTXeZfBOnZsljd8kTFn4Y3v8
 hdmupFebnN5DNB/KTHCWeDc+od/A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="67941680"
X-MGA-submission: =?us-ascii?q?MDFkZ8wACcOcAuU81CF3F57DJJlJNNd8B4Ue8V?=
 =?us-ascii?q?kqMe3AQaOghmwxD+FAxnMxEkUmC9ckRG0wwr52lXwtAg927o7jZo6Ged?=
 =?us-ascii?q?omMhjZaC/BXPV65uyx3W0GRlK/D0DjfMhDvHPxWxpd5GfDgC3W4WY4xC?=
 =?us-ascii?q?gcdwvSXXffz0bkP68PfROecg=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 21:39:12 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3D4F160F4F;
	Sun, 23 Oct 2022 19:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB0BC433C1;
	Sun, 23 Oct 2022 19:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1666553948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CBdjLGUFpRzknIf9jYSN0XI5sFJYjEkABu1cSEcoQOg=;
	b=gpgepcrwFAxXt6lybE7O4A8+aCFfLEOFRuMOK/VQonxaiwBdBQdwu70vTZD9EfBaRl3lD8
	r57rwXTCA4lCerrFr4NjTbRhn/882vKEa5vLsdCdzB37nzf2xxAIDW93pGekRWP9LAVMLm
	kWpvhg3gyH1E21rBDnSIxaOrHv4Sd28=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3bb9c9b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 23 Oct 2022 19:39:08 +0000 (UTC)
Date: Sun, 23 Oct 2022 21:39:05 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Message-ID: <Y1WYWT0xU5hv1Gr9@zx2c4.com>
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2210200705030.2988@hadrien>
 <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
 <trinity-3c34f082-c650-4c08-9ff9-f746f20e4183-1666533323595@3c-app-webde-bap48>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <trinity-3c34f082-c650-4c08-9ff9-f746f20e4183-1666533323595@3c-app-webde-bap48>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] algebraic simplification possibilities with SmPL
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 676
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/Y1WYWT0xU5hv1Gr9%40zx2c4.com>

On Sun, Oct 23, 2022 at 03:55:23PM +0200, Markus Elfring wrote:
> > There's another one in that series that's kind of interesting:
> >
> > https://lore.kernel.org/lkml/20221022014403.3881893-6-Jason@zx2c4.com/
> >
> > This one has a very simple rule:
> >
> > @@
> > expression H;
> > expression L;
> > @@
> > - (get_random_u32_below(H) + L)
> > + get_random_u32_between(L, H + L)
> >
> > This worked as expected, but I had to do a lot of hand simplification.
> > For example, a lot of code had a pattern of:
> >
> > get_random_u32_below(H - L + 1) + L
> >
> > which then got converted into
> >
> > get_random_u32_between(L, H - L + 1 + L)
> >
> > which I then had to clean up manually into
> >
> > get_random_u32_between(L, H + 1)
> >
> > It's not like that's all that hard to do. But it would be cool if
> > Cocinnelle had some sort of algebraic simplification possibility.
> 
> I imagine also that it will occasionally be nicer if further optimisation
> rules would belong to the standard functionality of the Coccinelle software.
> But I guess that you can achieve desirable transformations also by using
> additional rules for the semantic patch language.
> 
> How do you think about a change approach like the following?
> 
> @cleanup@
> identifier H, L;
> @@
>  get_random_u32_between(L,
>                         H
> -                         - L
>                           + 1
> -                         + L
>                        )
> 

I can do something like that. These seem to work:

@@
expression H;
expression L;
@@
- (get_random_u32_below(H) + L)
+ get_random_u32_between(L, H + L)

@@
expression H;
expression L;
expression E;
@@
  get_random_u32_between(L,
  H
- + E
- - E
  )

@@
expression H;
expression L;
expression E;
@@
  get_random_u32_between(L,
  H
- - E
- + E
  )

@@
expression H;
expression L;
expression E;
expression F;
@@
  get_random_u32_between(L,
  H
- - E
  + F
- + E
  )

@@
expression H;
expression L;
expression E;
expression F;
@@
  get_random_u32_between(L,
  H
- + E
  + F
- - E
  )


Kind of annoying that Coccinelle doesn't do commutativity itself, but
that's fine.

Jason
