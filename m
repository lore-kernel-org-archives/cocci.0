Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A96FCF9C64
	for <cocci@archiver.kernel.org>; Sat, 21 Sep 2024 20:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=S7Fj1hTennS19NUHYgsdZViWFLTSIsnBlj5O9lqA5rc=;
  b=Ugj4FiXVXJlRKQPlfPxU14uJ3gxK6bXUA+c2e4BHb8W9w7EH8mcu09Uz
   d6rJRgCHZSSfSIWenGvb+czGkVZrG6x4h67D4xNXYS5sCmUZgGAy1t0mM
   RmNI1OywKotMwW4jCEiBxxJZ3CUKEHOnnyT3C2GxRzxVIbpfhzZoHkFgz
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.10,247,1719871200"; 
   d="scan'208";a="184375019"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Sep 2024 22:37:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B42DAE013D; Sat, 21 Sep 2024 22:37:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7DE6EE00B7
	for <cocci@sympa.inria.fr>; Sat, 21 Sep 2024 22:37:15 +0200 (CEST)
IronPort-SDR: 66ef2e75_3+1K33oUxUxBWnFCiAv4DEBQNkkd45KjYfo8vQcEC6l3b0Y
 zLKBZ7VBvMtkKQgZQWygeFh56UDi+TUcNYvFtLw==
X-IPAS-Result: =?us-ascii?q?A0FPAAB3Le9m/wQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDB1shVDMEC0iEVogdiSWEa4c6h1SKTIF+DwEDAQ1BAQIEAQGEf?=
 =?us-ascii?q?QoCigMCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQKBC?=
 =?us-ascii?q?ggLhS9GDYJjAYQAAgEDIx0BAREmAQ8LGgImAgJWBhUBAYJ9gjABAzEHtwqBM?=
 =?us-ascii?q?oEBggwBAQbaWh8sIleBYwmBGi4BiEoBiWN6Jw+BVUSBPIJLBzE+iB6CaZINg?=
 =?us-ascii?q?hCJSBYlTYgacJEdUnscA1khEwFVExcLCQWJOAqDHCmBRSaEFgiBKxODX4FnC?=
 =?us-ascii?q?WGISYENgT6BWQGDOEqDUhyBZAU4SYJRa048Ag0CN4IqgRGCWoEvBAWEHh1AA?=
 =?us-ascii?q?gELbT01CQsbBj2uNLdUlFo0B4I3gWOBYwyfUgYTL4Nyk0wOBpJzmHapHYFnP?=
 =?us-ascii?q?YFZMxokgzZSCw4PjiGELcZQQTU7AgcBCgEBAwmFRgEBhjSBQwgBAQ?=
IronPort-PHdr: A9a23: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
 QPNo9Qor1z0yoFnKxJiVwdS7ClGjsSHsBc6UZg=
IronPort-Data: A9a23:rR1jOKBmV7OXxhVW/wXiw5YqxClBgxIJ4kV8jS/XYbTApGslhTBWm
 2tODT/VMqmIZmTxKN5yPYu/oxgA7cSAmodhOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuGYDdJ5xYuajhIs/PZ8Us11BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc532ZUSLg3NtWNVwzepY55KUqK0dU8
 vNNfVjhbjjb7w636Le8V/UqmckpasXmVG8dkis5l3eDV6lgGM2FH80m5vcAtNs0ruVHB/XDf
 Iw0bTR1bRLPSwJCMBEbBfrSmc/x1iWkLGAA8AP9Sawf0W3R0QBg87nRFpnZPe7QfchRmEKBn
 zeTl4j+KlRAXDCF8hKO9Xmnh8fUjCbjUcQTEqe5/7hkmjW7wmUMARkSfUm6pPOjgwi/XcheI
 goa4EITQbMa8Uu2Up/iUhf+rHPsUgMgZue82tYSsGmlopc4KS7AboSpZmcphAAO3CP3edAr6
 rNNt9buGCApr7CfD36QnltRQfVeJgBNRVLupwddJefG3zUniJ4+hFTDQ76P1Yar28btF2iYL
 y+i9UADanZ6sSLP/7q29xbLjlpAY3QPohEdvm3qY45u0u+1iENJqWBlBZg3IMus9Lqkc2Q=
IronPort-HdrOrdr: A9a23:zZVf0aCYHQPX0D/lHel455DYdb4zR+YMi2TDGXoBKyC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3ARPoixmj1Fr+zQE1RgbKTO1Z/nzJuQiL/lXvPDXe?=
 =?us-ascii?q?BFGMuU5yLCgK63rljnJ87?=
X-Talos-MUID: 9a23:tKZ9aAg8K8M26UfX13KM7MMpBsJq/qi/K0Ext9YK/PveDSF0PTOEtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,247,1719871200"; 
   d="scan'208";a="184375009"
X-MGA-submission: =?us-ascii?q?MDHRUNutMGMSFeCD51byThnMMcPESGpEynQf15?=
 =?us-ascii?q?nHFFVLxKLYYMac3caZNtvg06eytDmqq6vfa9jZRo7CWbpVItPp74nR+P?=
 =?us-ascii?q?8dv5mwEEIoupm8JiVc8RkXWySXYpPgdJJ3+cOki8Ev0xy71Z8VZSntP1?=
 =?us-ascii?q?bwwhX7DynaF5nYc7xR40FM3g=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 22:37:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726951018; x=1727555818; i=markus.elfring@web.de;
	bh=S7Fj1hTennS19NUHYgsdZViWFLTSIsnBlj5O9lqA5rc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YpSujBhAtl2rTxw1UugEgTI3D+DCqF5JGqdy79yGBRWK+Rm8HoxGr8UbtkjBfH4p
	 iPAnYTz4eKN3DQSpb1X5QwKQI6ivi/vN6da9bSfF9s3ygE+hGpIGidrErzJbHFFDU
	 /7MSD0yWobv543bwDyvpYGAxhl81rlYKd3bd9J8Fg4DIX3a805TU4wU1HaelI8Sst
	 LebYN4SObGsjirKPa21ouNGes99XnavJnBTpzsLJ6ziBdrKLD87cOmiAqItVtGdwm
	 kBM0SZtDEkrcrApZhNZZ6H3ordB7rD/imWr7Hdpk/7MpNN/QWP3ESoCK+HQzx0+9a
	 x/9q/pcCvYbWyVip9A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJWsm-1sYN2Q38oa-00ViEr; Sat, 21
 Sep 2024 22:36:58 +0200
Message-ID: <b1872e36-154b-477f-907a-7fc98b301931@web.de>
Date: Sat, 21 Sep 2024 22:36:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <46260c9a-4c82-476b-85a1-a4174709c5bd@web.de>
 <alpine.DEB.2.22.394.2409212209470.3471@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2409212209470.3471@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cAdEgVFqvNit4LyX2SHzhn48rVEmA00qSevUMUgtpAfAMFRg3kz
 vW1bo78P0XuQ2sn8i6OZRy5RqrV9ICGsXBa8Pvrrj2Bev+KMPmZ3zdYxfP5nEqQrKsSUdkf
 ue0sB5nypY3RE/mUWZyYCzvuFe6+jReFVQmi3uGAzw312Q5QZyI3SnezhAvUqB9upVbnQ51
 2xz5q2QSs56owMM9KdgmQ==
UI-OutboundReport: notjunk:1;M01:P0:tJkyOJe77+w=;4+CuXldEPVi9PJkdQVCwrV72QOk
 jL0CeTFi5qmwmJKZCHFbzvoHQiDknSQ7Lv2qzrLaX90pePT5HRaJ6uJfxMebwFsfei9XGigu5
 QgDdELtgGQzqmf8WsBgHbAx2HWOvly4HvBzmBwlQnnsbLe08Sxe3pqCe/KYlHwV+WW66Rzns1
 LXCB/c3l5Mn8al6rILmnINCuLj4LjKo9jz/9geqE1+RtRCqfSCbOt/mDF+LL0aLx4NE7dgOV8
 PoBipAVBD35GeBH1wUC038OF4ztZM2xl1fJle+k9KAgHlKybI5MPkMrs8ZfM+3hnK/25TsLjY
 oUclKhSkBkKUOpMNMRbfYCO5jEgv9vCe3fk9wX3Enycc2LS7rdXZVevOcK+Ui2QMkdjSXLKIj
 vAwBSa086OfbAKOxAPGeoGfFU63SySgUBP91+WpOjmsFiccNkw28R+eM0AP6/5WVbC+Tbsg2w
 SqIXwUiyj618Jvs33DcQd5KZa5fvDBWzXsmvglnBfBn3gpuS0Cmfetd+AxJF7d15yKtwB1ZGE
 sA1AlaXn/k5T4Oe+EB6dvApkezX9YneJdcjM65GoMtjTsZgdsBPayrkZnk8bfC2wXkPBZDsWL
 PQ0i0//ohuIqFRTjefPgCQyeKcPtKVjWUJRiYie6L4SJl8S8C7V+sRLqbGpxFrBRZXizJjbOR
 429jNaXpx6fnqJ5MZX4cDuvxypsoKGIY/9fx0t14jWIL8kbPLQ8wB5KUqvdgjxbVQ/KY3oYjY
 bFXAKPMGr+ZaTBHDxvqHUQSv+Tlw9YfISReminjO4dd9vTnyO4dtTYF1g78suTEhVBFb8ir//
 Vwo0vuArkcIW/HPbklnnchvw==
Subject: Re: [cocci] Determining a return code variable for a jump target
 (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1874
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/b1872e36-154b-477f-907a-7fc98b301931%40web.de>

> @adjustment2@
> constant c;
> expression e1, e2;
> identifier rc2, x;
> fresh identifier target =3D "free_" ## x;
> @@
>  int rc2;
>  <+...
>  if (...)
>  {
>  ... when !=3D \( x =3D e1 \| e2(..., &x, ...) \)
> -   kfree(x);
> -   return
> +   rc2 =3D
>            -c;
> +   goto target
>     ;
>
> You seem to expect that the source code contains two semicolons here.

Thanks for this feedback.

I should have used the following SmPL code at this place.

+   goto target;


I might be =E2=80=9Clucky=E2=80=9D for some function implementations
when they contain only a single integer variable for returning
result values.

Regards,
Markus
