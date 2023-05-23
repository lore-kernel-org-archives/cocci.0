Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343EEC7EE23
	for <cocci@archiver.kernel.org>; Tue, 23 May 2023 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=u51YzgvrdAa+3Jq7x4yHwjs91br7g+uEFMRjjYkyVqc=;
  b=TUAjNrrAcdpNY8wvAdguGgDcPDPGwEmEd6NmDXPuM6TyTfK2ZmHBZld8
   6TlhpwxEenh0jyngK7CKB1Jh1UC12EJpal0++HUJ3945jVsmCF6sMXFlS
   4PHAp8Ikrg3HW/pAN37o3iDK2XttSwpjINVVdHbyuXmV8PB6T5IySVk7R
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.00,187,1681164000"; 
   d="scan'208";a="109304509"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 May 2023 19:38:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BDC5AE033B; Tue, 23 May 2023 19:38:52 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E3CE5E00A8
	for <cocci@sympa.inria.fr>; Tue, 23 May 2023 19:38:48 +0200 (CEST)
IronPort-SDR: 646cfa26_UsortX+6wPZf9P+97WhsM5awryQtyEyVhu/38UHihCSj/RN
 wPt0sKttA1shsWBajvsH+gtHBgiht17fGFsVVtw==
X-IPAS-Result: =?us-ascii?q?A0FbAwCe+WxkgAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CL3UDUzAEC0aEUo8TgiQDhDOXXoMWPg8BAwENOwYBAgQBAQMEOIRHAoVbA?=
 =?us-ascii?q?h0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEkFwcOD?=
 =?us-ascii?q?imFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgINOj8DAyMEG?=
 =?us-ascii?q?QEBESYBDx8BBQImAgJXBgEMBgIBAYJ6AYInAQMxBwytNH8zgQGCCAEBBoJlm?=
 =?us-ascii?q?SgfLCJVgV4DBoEVLY0tgzd6Jw+BVUSBPAyBCYItgQUBgRqFf4JniVGFXIMSi?=
 =?us-ascii?q?XOBMHKBI4EogQICCQIRZ4EOCGaBc0ACDWQLC2yBO1pDH4FKAgIRQgwVBVgCg?=
 =?us-ascii?q?QQQARMDBwQCgQ4QMQcENwshBgkdNS0GXQcvJAkTFVMHhCsDCgoTJQQOAxkrH?=
 =?us-ascii?q?UACAQs7Oj01BgMLHwYmHwKCAwSBCXsGASQknSIDgn0BehMUGFCBepYArXI1B?=
 =?us-ascii?q?4IugVqBXQyKEJUGBhMvlxEOBpIqLpdbIItJgXGaVoF6I4FcMxokgzZPAxkPj?=
 =?us-ascii?q?iAXhA+EYYooAT4/NAI5AgcBCgEBAwmFRgEBhX4BAQ?=
IronPort-PHdr: A9a23:L9AJMRzDoFCtY2HXCzL9w1BlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 hGZvqo2xwOVFazgqNt6yMPu+5j6XmIB5ZvT+FsjS7drEyE/tMMNggY7C9SEA0CoZNTjbig9A
 dgQHAQ9pyLzPkdaAtvxaEPPqXOu8zESBg//NQ1oLejpB4Lelcu62/6y9pHJbQhFhjSwbbx9I
 Ri5sA7cqtQYjYx+J6k+zRfEvmFGcPlMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3Q
 qBWAzogM2Au+c3krgLDQheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VSik4
 qx2UxLjljsJOCAl/2HWksxwjbxUoBS9pxxk3oXYZJiZOOdicq/BeN8XQ3dKUMRMWCxbGo6yb
 IUBAOUPMuhFr4fzuUUDrRW8CgawC+3i0SNIhmbs0KEmz+gsHwPL0Qo9FNwOqnTUq9D1Ob8VX
 ++v1qnIzijDb+hL0jny7IjIfAohofCKXbJ/bMHczk4hGBnfjlWTtIzlJCmZ2OsJs2iV9epgV
 OSvi2E8pgB/vDeg3d0ghZTXiY8MzF3P6Cp2zpovK9KiVE57fcCrEIFWtyyCN4Z4Qs0vT390t
 SomyrMLuJ+2cSsXxJg7xBPTd+GLfoiM7x/sSeucITh2iXNkdb+jgxu/7EitxvPzW8S2zFtHs
 yxImcTCuHAK0hzc8MmHSv1l80eixzmPzQbT5f9AIUwukqrbMZEhz7gtnZQQqUTOBjH6lFjog
 KOMaEko5Oql5/76brjmvJOROZd4hwXxP6g0lMGzHP40PwsKUmSB+umx2rvu9lDjTrpQlP05i
 KzZvYjaJcsFoq65BBdY0oMk6xaiEzeqytoZkmccI15fZR2IkZDlO1DIIP/mEfeym0qgnCp1y
 /zcILHtHJfAImLenLrhZ7pw5VZQyA8pwtBe45JUBKsBIPX2WkLps9LXFAU5Mw+pw+b8Etlz2
 YceWWyVAq+YNqPSvkSF5+wxLOaXfoMapSjyJ+Aj5/H1lXA5g0MSfbG13ZsLb3C1BulqL12DY
 XXwmtcBDXsKvg0mQeP2j12NTSJcZ3epUqIn5jA7DZqmAp3ZSoCshryBxia7EYdMamBIEFDfW
 UvvIoaJQfEBbGeQK8lgjjseTpC/RII7kxKjrgn3z/xgNOWQsikZs4/zkdZ/6+DNvQ89+CYyD
 MmH1WyJCWZukSdASyU3maxyv0F54lOCyrRjxfJCGNFf6uhKTgAic5nGwKgyK932VQ+JUtqNT
 Fu8CoGqDDU1Q8gZzNoeJUpwTZHqrBnd3iewS5ocjaCKApEmuonV2Xn1I89mgyLE3bcggkMja
 tFCOW2vmuh08A2FQ8bskk6ZnqLiVqMBwChYvDOGzm2ToEdJeBVtSqiDVncaMA+ekdT+40rZB
 42vDLEqKA5Iz8jKfrdYa9jsgE9DTfHlEM/DeG/3l2rmQV66xr6KY8LVcmMSlHHPGVkYlxJV4
 mSubFZlQCympjSNIiZpEAfKalnv7PI2hXe1VE4ywEneSkR71KeuvDMRi+adTfw7wb8O/iss/
 WYnVG2h1s7bXoLT7zFqe79RNJZkuA8vPQPxsgV8OsblNKV+nhsEdA8xuUry1hJxA4EGkM4wr
 XpswhAhYbmA3gZncDWVlYv1JqWRMnP7qTWmca3LwRfz1NiM+6EAwOs1oRPvsVLhDVIspk1uy
 MIdyH6A/tPPBQsWX4j2VxMS/gJ5uqqcTy0z/YLS2lVzPKPyvjKRk8kxCr4DzRCtN8xaLLvCF
 AL2FJgCANOyLeUxh1WzRhcDIfwU66M+ec+rHxef8IisOuso3DevjGAdpZt4zlrJ7S13DOjBw
 5cCxficmAqBTTb1ylm74IjxnshfaDceE3Daq2CsDZNNZqB0YYcACHu/a8yxyNJkgpfxWnlev
 Fe9DlIC0cWtdFKcdVv4lQFX0E0WpzSgl07ah3RRmisqs7HZ8SjA2eXkezIYN2QNSGQjxVbgL
 I6ojswLCVCyZlthnx+k6EDmgqlD8f4mdS+JGxgOJnWwdDIHMOP4rLeJbs9R5Yl9tCxWVL75e
 lWGUvvnpBBc1Sr/HmxYzTR9djewu5y/kQYp7QDVZHt1snfdftl9gBnF49mJD9tYxDkbX29Vj
 TfNB16zF8ak95OYmt2Q14L2H3LkTZBVfSTxmMmlvTG4+HYsLBmxhfG1lfX4HAJ83SKxhLwIH
 W3Y6R37ZIfszaGzN+lqK1JpCFHL4M1/Aohik4E0ifn8wFAij46OtToCmGb3a5BA3L7mKWAKT
 ngNysLU5w7s3AtiKGiIzsT3TCfVzsxkbti8KmQYv0B1p+VDEqSJ9/ppmSVvo1y3hR3ca75xk
 38RxOAv53gTn+wS8FB0lGPHWO9URBQeZmTljFyQ4sq7rblLaWrKE/D4z0d4kd27TfmDrgxaR
 Hfla8InFC504N94NQGE23ny54f4PdjIOIhK7FvOyUiG1rUTc8FU9LJCnydsNGPjsGdwzuc6i
 UYrxpSmpM2dLG4r+qulAxlePzmzZsUJ+zirg7wN+6Tel42pAJhlHS0GGZXySvf9Whcbr/f6L
 ECjFDMmq3GUMaXSF0mT5Q01yhCHW4DuLHyRKHQDmJ9HTQOeOVcZrQQaRjQ8kbYmGwrsyMGrI
 yIbrngBo1X/rBVL0OdhMRLyB3zeqAmfYTAxUJGDLRBS41IK9wLPPMeZ9O42AzBA88jrslmWM
 mLCLVctbylBSgmeClvkJLXr+dTQ773SGL+lN/WXKbSW9b4EDq3On8jwlNI8oXDVbJXIZCQHb
 bVz21IfDyogQYKDwWpJEnFRz2WXMoaavEvuoHQt6Jrlr7KyB0S3otHQQ7pKbYc1ok/w3v3Fb
 r/KwnwleXECh/ZujTfJ0ORNjARU0n8zMWDwQPJY8nSTBKPIxv0NVkFdNHk1bpMXqfp7hFYFO
 NaH2Imsifgn1LhsWg0DCwCmwJ/MB4RCInnhZgOdQh/VafLcf2yNmpqvKaKkFe8A1qMN6UD24
 23DVRW5dnGKkz2jP/y2GcdLiizTfBlXuYXnNw1oFXCmVtXtLBuyLN5wizQyh7wynHLDc2AGY
 3B6dAtWo7uc4Dk94L03EnFd7ndjMeiPmjqIp+jeJJEMtPJ3AyNy3+tE6XU+wrFR4WlKXvtw0
 CfVq9dvpRmhnIztgnJ/VwFSrz9QmI+RlUBlJLmf6ZRKH3rJvVoM4WiWFxUWto5lB9no6MUyg
 pDEkKP+LisH8sqBp5JGQZKOd4TebTx6Yn+LUHbOAQAITCCmLzTajk1ZyrSJ82GN64I9od7qk
 YYPTblSUBo0EOkbAwJrBo9nQt8/UzU6nLqclMNN62C5qUybYcxAvY3cEN+WD+/uLjmxkrROI
 RcFi+CdT8xbJsjg1kpuZ0Mv1pzNAFbVVMtRrzdJawgpvANS/XI4QmB5iCeHIku9pXQUE/Czh
 Bs/jABzNP8s+Dnb6FAyPlPWpSE0nSHZdv36jDrXfDOjdc9YuKlJBiCyu0VjavsToi5wahCu2
 1NpPnHISuAJ54Y=
IronPort-Data: A9a23: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
 RHyN0Ac5iSM/6w=
IronPort-HdrOrdr: A9a23:hQW+96+XekWk4s18W9puk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOb+EYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:1BAeK20UirHPSzIztsjJZrxfPN1ifHflz07pYFKRJUd5Q5aMWQ/N0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3A2x2Q8g/CULHJs3G8GqLLJxWQf+tKpLy2B0AxqqU?=
 =?us-ascii?q?D5uytaQAhMhSnpw3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,187,1681164000"; 
   d="scan'208";a="109304497"
X-MGA-submission: =?us-ascii?q?MDFOplOjjbS/xzYQLTSjdBXeuhVDfcxlYlljTo?=
 =?us-ascii?q?lVy8rDNxbuwan3TdKKEUMae1UGeVtS/ujTRCiZ/pjIIM/nY5+RezeLiD?=
 =?us-ascii?q?iyedUjFWx7yKYAWTMVj1eamIjIyza9hEgMxV86g+cZSHzMFxjxL/zAU+?=
 =?us-ascii?q?6syjP3eeOP8ikR5KMrT525rg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 19:38:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1684863524; i=markus.elfring@web.de;
	bh=vdGIrfGbI4fUpNb7F4YLU0TiyBkiH6frHykp16SFXvw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=eEhcPfc/jeMIL38oZCfDZvOfw0CBo/QgRj1/IUtlmeFD78OA/p9fg/BD/aAgzSrJY
	 CuMK8yQcCFK8YThsHf/K6ieaVpeJjfRmRFwVl9EEcu8KP/B0CgHkLXvIf3gWEN8aGT
	 m0y6HfJwDRgJ2zCw3Sch/c8RIn1j+VliwpUdMMtT7Ls6KcvWK3AZzvkFtBC/IM8jEh
	 y+Avs6f+vdQ0bK88h+9xog4/qJLstTAeE39NCYki//uxUgMWDms0CsjekiqzubhoPD
	 Dyn1YCx3HVdcWqShdoYIKq2ischKaGn9qOzNI/tv+NfSue1NeTHM9N7hHnN7g1UgBH
	 AmCE4jxWvThSA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McZnl-1qXY0E3dT3-00cx6f; Tue, 23
 May 2023 19:38:43 +0200
Message-ID: <c551c670-7458-ed50-eb2f-5a2b7ba421a8@web.de>
Date: Tue, 23 May 2023 19:38:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Zheng Wang <zyytlz.wz@163.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 1395428693sheep@gmail.com, alex000young@gmail.com, hackerzheng666@gmail.com
References: <069f2f78-01f3-9476-d860-2b695c122649@gmx.de>
 <97807a2d-ccf2-1fbf-06f7-085bb1bdf451@web.de>
In-Reply-To: <97807a2d-ccf2-1fbf-06f7-085bb1bdf451@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e+SVAKZDjUgV2jhbo4iX+NViHhtDIPBuRJ1Z8q1WnjWuYLIeQph
 hAtq3iVkBUzNapFSjzuBt2ttNKuE7ypwM3IFtjWILbQ9Y4gHuG8V4wqxslnCaY6OXXGBaUU
 hmr8paOJXIKrEjql4iSL32cVSHD5kf47zgv6HaGIU6OU0+U1WeXC+Y3VNqlKEXPw7R4yyIm
 6qdxCmeeWlmapdFJs8/ZA==
UI-OutboundReport: notjunk:1;M01:P0:7Yzt70kqrtw=;iYfceZoq2vuPTPpC4WfnawjTkJX
 ZZEiHjk7/8OaoTvvlPSvY1zv5b3UAAmORwi80H0wdZMHWvHmxUhS4STK5VX1Er7i5sJjaE+xS
 XPIBpUAxsQ/RRC/QyNwaUMW7wYnkaVVcFKQv3+Z0m0wErGIYzXRoP7BMoE6cmAvC9vshMyVhs
 PehItICtU83OqFgEJ+rrdMUO+J8PZAZkG9n+g1i1HmyuBaGdcK69S8ZzahgdH7vxg0Q/oDGq8
 685AwrecSrchksseVD73Zi9fCRpD3ziKdx1S8Ou3ACqhPTnTLViz4W0UbCjcJ569HNawZ7T8i
 wbQPQmy6J6/OKD1FJ51dGlzn3MO5qeeQYfjPcgc+aiWD+nyTiYoxo13/0t47eCptvHBfAer0s
 Tuy27+H3bUHedPVGh1t9pbxbxrf8vn90xxOtiKNVKMED4ZTfCpt0vBEs3hXO4nDkqoZqN699t
 8vjrCMtS/jX1bJeTFTWSM7JVDBpkebTHpTeJOm517xnphpLk3nllNHi84QRYnCRu5vAZd7knU
 TomMDS9I3LJ7Xob4JRGZ4zdC3Q5JfB67yVg8vrGptJUO1hQbV580//DKkR6NijldCQ377UnDR
 V1N6vJ5Mj8BGG/dFwX5zZjBoaTT2+tJc2Mh1VavR1uzK5xI6NztelFTHmGd039amoi1ijkUHG
 4wlHwdO8l7qLvfL9opwaMxhWIlHL3gL5x9QsPZt5YeQF5H50s7KfiwJe6nvTiYpTvnYLXKQRt
 bCjkCldbksfyM7M3fK8B7rK1jYYfwEp28cMPZ41689MNlWJeQp3RvV95wG2okw/sBmvRvmzH0
 +PuzZiJNeVXdb+kabVaMd7noVp2lI/2HeRmhTlR3jPTD6BXi8I5ASJU9hnF40PcOz0F/Ipgkq
 zgtGFKYiBP7FBdJAR6/FOsz6yPSm4KaDl1a2xWwReKDoJ4Krj57L1QjA1jRUYn6YUPIpRHsYK
 eNuTGQ==
Subject: [cocci] [PATCH 1/4] fbdev: imsttfb: Fix error handling in
 init_imstt()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1148
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/c551c670-7458-ed50-eb2f-5a2b7ba421a8%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 23 May 2023 14:32:39 +0200

The return value was overlooked from a call of
the function =E2=80=9Cfb_alloc_cmap=E2=80=9D.

* Thus use a corresponding error check.

* Add two jump targets so that a bit of exception handling
  can be better reused at the end of this function.


Reported-by: Helge Deller <deller@gmx.de>
Link: https://lore.kernel.org/dri-devel/069f2f78-01f3-9476-d860-2b695c1226=
49@gmx.de/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: c75f5a550610 ("fbdev: imsttfb: Fix use after free bug in imsttfb_pr=
obe")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/video/fbdev/imsttfb.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 975dd682fae4..d3532def4707 100644
=2D-- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1351,6 +1351,7 @@ static int init_imstt(struct fb_info *info)
 {
 	struct imstt_par *par =3D info->par;
 	__u32 i, tmp, *ip, *end;
+	int ret;

 	tmp =3D read_reg_le32(par->dc_regs, PRC);
 	if (par->ramdac =3D=3D IBM)
@@ -1419,8 +1420,7 @@ static int init_imstt(struct fb_info *info)
 	if ((info->var.xres * info->var.yres) * (info->var.bits_per_pixel >> 3) =
> info->fix.smem_len
 	    || !(compute_imstt_regvals(par, info->var.xres, info->var.yres))) {
 		printk("imsttfb: %ux%ux%u not supported\n", info->var.xres, info->var.y=
res, info->var.bits_per_pixel);
-		framebuffer_release(info);
-		return -ENODEV;
+		goto e_nodev;
 	}

 	sprintf(info->fix.id, "IMS TT (%s)", par->ramdac =3D=3D IBM ? "IBM" : "T=
VP");
@@ -1452,17 +1452,25 @@ static int init_imstt(struct fb_info *info)
 	              FBINFO_HWACCEL_FILLRECT |
 	              FBINFO_HWACCEL_YPAN;

-	fb_alloc_cmap(&info->cmap, 0, 0);
+	ret =3D fb_alloc_cmap(&info->cmap, 0, 0);
+	if (ret)
+		goto release_framebuffer;

 	if (register_framebuffer(info) < 0) {
-		framebuffer_release(info);
-		return -ENODEV;
+		fb_dealloc_cmap(&info->cmap);
+		goto e_nodev;
 	}

 	tmp =3D (read_reg_le32(par->dc_regs, SSTATUS) & 0x0f00) >> 8;
 	fb_info(info, "%s frame buffer; %uMB vram; chip version %u\n",
 		info->fix.id, info->fix.smem_len >> 20, tmp);
 	return 0;
+
+e_nodev:
+	ret =3D -ENODEV;
+release_framebuffer:
+	framebuffer_release(info);
+	return ret;
 }

 static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id=
 *ent)
=2D-
2.40.1

