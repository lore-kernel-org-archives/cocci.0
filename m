Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A239C83F2C
	for <cocci@archiver.kernel.org>; Sun,  3 Sep 2023 06:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pY5BaZW4axOr4207m5x9F/7UJGlf1hDuBgsuy8EdppI=;
  b=FJm51UfmNh3lVSBGkiFUUZsfgb77GEn/7GF0x5oJCGn7AJWSazmRQab9
   BsfmRvMhTp1m1nEqKHOU3fGE6ycYZcH2wM8lClnRVY2YBQkNlKZHPyNrt
   NijTEdgEd22DMlhdV2XfigCgASRaNbidui8BlFiEde44tSrql3sl7GFbE
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.02,224,1688421600"; 
   d="scan'208";a="124055032"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Sep 2023 08:40:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 06727E0CCA; Sun,  3 Sep 2023 08:40:53 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 50695E004E
	for <cocci@sympa.inria.fr>; Sun,  3 Sep 2023 08:40:50 +0200 (CEST)
IronPort-SDR: 64f42a71_mUtGGp15zNG2NddAYuEysbJ8j6LkM+FTxpDQ/eX7xBYageC
 6q+QPYXZp+7U9yEh+pNKkCdNFcYC8v7HVKa1nDg==
X-IPAS-Result: =?us-ascii?q?A0FZCADnKfRk/wMP49RagQmEBgdyUzAEC0eEUpEzMIQ8h?=
 =?us-ascii?q?zSHSYhtgxY+DwEDAQ1BAQIEAQEDBIR/AoZuAh0HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQFAQKBBhOFaA2CNykBEWSBCAEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARcCRz8BBAEjBBkBAREmAQ8LGgImAgJXBgEUAQGCeoIqAQMOIwenR?=
 =?us-ascii?q?38zgQGCCQEBBq9UHywiVYFfCYEXLYgIAYVKgzt6Jw+BVUSBFScMgkcxPoREg?=
 =?us-ascii?q?1uCZ4lhhUUHMoYIiRsqgQgIXoFqPQINVAsLZYEVgkcCAhEnExMFRXEbAwcDg?=
 =?us-ascii?q?QIQKwcEMhsHBgkXGBUlBlEELSQJExI+BIFxgVMKgQY/EQ4RgkcrNjYZS4JmC?=
 =?us-ascii?q?RUMNE52ECsEFBiBFARqHxUeNxESGQ0DCHYdAhEjPAMFAwQ2ChUNCyEFVwNIB?=
 =?us-ascii?q?kwLAwIcBQMDBIE2BQ8fAhAaBg4qBA4DGSsdQAIBC209NQkLGwZAAiehK4Njg?=
 =?us-ascii?q?XGTcrFBNAeCMYFdgV4Mnx8GEy+XFw4GkjSYLCCoJYF6JoFZMxokgzZPAxkPj?=
 =?us-ascii?q?iwWFYNzj0g/NTsCBwEKAQEDCYVGAQGGAAEB?=
IronPort-PHdr: A9a23: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
 tWdzcobyR9H9M/Iu9QRDY7YJZDfWEc=
IronPort-Data: A9a23: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
 kjtm/5u34Beaba4W4MAkSWcBleFXA==
IronPort-HdrOrdr: A9a23:ZUe0iathHq4G+tbMi08hb2gh7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:MZ2IOG/fLCkWD0wnhbOVvxMbJPA7clb88E77OGamFWBwaIGnFFDFrQ==
X-Talos-MUID: 9a23:5qMNoAiLHNmYo4vdestyd8MpHv1uuIuJVEA3zrIAitDYPBNpNnDatWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.02,224,1688421600"; 
   d="scan'208";a="124055029"
X-MGA-submission: =?us-ascii?q?MDH3Dkapuy/4b/AFyVPu8HsOo11WOgoG5IZ3Ad?=
 =?us-ascii?q?70Pzh4CfYMHwqjm0SWd2JwjB2Zjlhxttq4cPXQPVd1g43PYr7jiyTDmx?=
 =?us-ascii?q?NoH1jmVGcZ5kXKzoa909+2prxoeHhSjpHP2G9VLv2Cud9ZXmiKXOiN94?=
 =?us-ascii?q?W/9CVnRbGeote7XWwLFm/RJQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 08:40:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1693723230; x=1694328030; i=markus.elfring@web.de;
 bh=A+zPPkFhGhceN9DMkxzLl/onpCUqFtZjynCuwApburw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=NIjiZ2Fvsdd9LjfQf0oGDBAysLtwgXEB+gHcsc62t6S33VIH/NBheVED6GCy+dIOV7DLaDg
 K/ioB7Rold91l28KHMZIJGBwcRkrn1NXLJK4/+0rTBALFC3+OtQNnUU5haXx/QC9CeTY9n4R5
 DEx+GzaeoVIpjCF8WUJ1bc1CJJzHpIqeYCu/47vzli2KmBZuVAco2J7oCxAjZYN+x9K51ixcX
 p7OzD35XTrfJjLkO6ZWTFE4H5RFloXxqqEFaI4wuZULz66lB0PcvPz3oGSFFbXB07brEf1CFz
 GMK/dC2xx+bAQClIszZN4C23gCfpNVLJNiJSREGdOVq2jxyn5I2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MElVH-1qSUJJ0nQh-00G3mM; Sun, 03
 Sep 2023 08:40:30 +0200
Message-ID: <959f65ff-37a1-4d86-9451-474c5db93e1c@web.de>
Date: Sun, 3 Sep 2023 08:40:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Thomas Adam <thomas@fvwm.org>
References: <7e3fdd0f-e691-4ebd-9de9-4fbdb6ece973@web.de>
 <alpine.DEB.2.22.394.2309022008310.3175@hadrien>
 <205fad47-dbef-4cfe-885b-69a2a0d4b09b@web.de>
 <alpine.DEB.2.22.394.2309022032260.3175@hadrien>
 <1326a929-8a48-4113-981c-df6dc3220474@web.de>
 <alpine.DEB.2.22.394.2309022101230.3175@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2309022101230.3175@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pDpXMgCZQqFF6L1hSoEnks7jQpK0C7KrPSWvcijm/cNrpdYqU7O
 t7/dF09OwAjz0lsI/a8EmiHgkG7ICvErGOEOX/0JHcr+mEprOWNV2AlqAodJBDrfudsbnMb
 TvnFgc1MHgugoHJ09iv4sXjwcOBb7mwZdUgSnJJ7+PfLxIva4NIkoRvDvsgiFgdS1IY33ay
 QKeOVMoyBFoWRP9vgEYsA==
UI-OutboundReport: notjunk:1;M01:P0:G3CubTzQNGs=;NsOWCnBbJ/vu18OZr7poINh2lSf
 pDiR3EmEdHctRh8ayC6XZ7u9w1CwkyVVm0Qc/HkPgeFHD5HT7rezOWGtLCvS5I2Jgbjyw3KWD
 H3V2Gsd0SBkCWxEWJepGQGYfOn0rWMpBuFpHhxfudkyKrmFR+FxkeQFxxY+9JrdePUMNtLQor
 K6mwzxGERNMZm/d2msxI/vh4pO2aJ2Pt0E8dhqkWEwAsIjLbfOsj9/gKHxysoCtUtCishbRLE
 Snbp0On9dzenCSbzkkB4FHaojNBgffqoLftpo7BjQuuHdu2LKWdZVK+lG1ngLvRtKQnL908BQ
 2zzK2GkI2perAWZuzBfB5xDmEo+2wD81URAaCHnmAgZlj0E4qV/fK249BX5xdOg2nTxSUBZQA
 OcxlOb9tIWeKSYu/x+N3UoBhvxYacy1QtmftS6ldIqOXMU3bgMr03rRnkN1f1lo0mY6AJipx7
 P7AtFKhgbchhGMzC3goO0K5JgqH3U8qaURuq0lQTBHAajE9EHCZrKF5O+sR88eLr8JKgQEzw4
 VHzd9fU2vBx2GnvkDd38M8DY1UPlfb4Y+AyZ2PTutBaXt3xGamZDzA8jncmsSAG1ZCnA6wVWW
 a58GDxf7e+CT/qlvHObmVnIPqKclB7urw7cS0G97KlbzY5lzbPqFylHMDvNhcxZVWXHN30CBl
 2xehpxkZ/nSm12qy210wZu+QaX7JGacE3SlvbmmrhXHuuh336xj3zFbwyxPxgXCskbb3o9hkv
 v6/pNfV0RFzNJMTooOohweRxcRIEgQS+jXV+t2UrpWb4NJj3mvg0CynNWRmICpESFNummR/ks
 /MYX2dUtDvwqDr7VS7TzsY7qxmGEz5epFQxqjzfw7EP2mnXMCtapzP4kE3XhJPtZnH7TU1g4X
 a3S/a15agxo16Y5mZJV/7wKo3+NSitTMaPweod/+YL7U610SFMWDgb+eJlKSyjHPPdDV7AghG
 lP37bQ==
Subject: Re: [cocci] Checking a transformation approach for the avoidance of
 duplicate code
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1235
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-09/959f65ff-37a1-4d86-9451-474c5db93e1c%40web.de>

>> The following SmPL script variant does also not produce an expected pat=
ch
>> for the source file =E2=80=9Cfvwm/colorset.c=E2=80=9D.
>>
>> @replacement@
>> declaration d;
>> statement s1, s2;
>> @@
>> -if (tint !=3D NULL)
>> -{
>> - d
>> - s1
>> - cs->tint =3D GetColor(tint);
>> - s2
>> -}
>> -else if (tint =3D=3D NULL)
>> -{
>> - d
>> - s1
>> - cs->tint =3D GetColor(black);
>> - s2
>> -}
>> +d
>> +s1
>> +cs->tint =3D GetColor(tint ? tint : black);
>> +s2
>
> OK the problem seems to be related to s2 matching an if.  I will look in=
to it.

I tried another SmPL script variant out.

@replacement@
statement s;
@@
-if (tint =3D=3D NULL)
-{
- ...
- cs->tint =3D GetColor(black);
- s
-}
+cs->tint =3D GetColor(tint ? tint : black);
+s


Markus_Elfring@Sonne:=E2=80=A6/Projekte/fvwm3> spatch test_tint_determinat=
ion2.cocci lokal/fvwm/colorset.c
=E2=80=A6
@@ -962,14 +962,9 @@ void parse_colorset(int n, char *line)
                                have_pixels_changed =3D True;
                        }
                }
-               else if (tint =3D=3D NULL)
-               {
-                       /* default */
-                       Pixel old_tint =3D cs->tint;
-                       PictureFreeColors(dpy, Pcmap, &cs->tint, 1, 0, Tru=
e);
-                       cs->tint =3D GetColor(black);
-                       if (old_tint !=3D cs->tint)
-                       {
+               else {
+                       cs->tint =3D GetColor(tint ? tint : black);
+                       if (old_tint !=3D cs->tint) {
                                have_pixels_changed =3D True;
                        }
                }


Do you get any further development ideas from such a test result?

Regards,
Markus
