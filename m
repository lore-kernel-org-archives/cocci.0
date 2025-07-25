Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D320C83F26
	for <cocci@archiver.kernel.org>; Fri, 25 Jul 2025 07:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fQ0GW9h1XwOwnRTimpWj1PmjKKfPUfJcIYyHz37ylfM=;
  b=BmVMYWFIXU4PkDD8JAbJmJASJKWoX9vLClQAbVoBk9VEsjktZIQXsIgp
   b/P1beCArVL3+kq+FxNPffJVL+soAaLO+t97MXifa/7JQDx+dOXgdh5EX
   Ar1T0Stfja/m2chqQyIWjtrt/PMM7w7xKBH7D6soEO3JLVgE4a4KjiJFV
   8=;
X-CSE-ConnectionGUID: y8GWi11BShiiuQ12B6Qjhw==
X-CSE-MsgGUID: D9GMM2z5QXCtWsEKLfdTOw==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="233071694"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jul 2025 09:06:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 80FAFE0C55; Fri, 25 Jul 2025 09:06:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DBD61E0171
	for <cocci@sympa.inria.fr>; Fri, 25 Jul 2025 09:06:31 +0200 (CEST)
X-CSE-ConnectionGUID: Dmk9dGlHS9OY7YSzDU7Zkg==
X-CSE-MsgGUID: PpZYIP3YRYK10G9weUZUsA==
IronPort-SDR: 68832cf7_pcFkVoKX+6VbcPz3HV6+EZHGRAAiimCpg9qX6uhdTx8mWyh
 Q9WtWG6E2c2KMJC6CjF9FlnO5/iwZqvOy4qdk0A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E4AgAALINogAQP49RaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDgQAGVDMEC0mEVY9QgiSEO48RjEsCDwEDAQ1ECgECBAEBAwSCDIJ0AowXA?=
 =?us-ascii?q?h4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBO?=
 =?us-ascii?q?wcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQINOkQBAQECASMdAQERJgEEC?=
 =?us-ascii?q?wsaAiYCAlYbAQGCfgGCIQEGEAEDDiQHDQa1JIEygQGCDAEBBoJp13UfLCJZg?=
 =?us-ascii?q?WQDBoEbLgGFbIJkAYpjJw+BVUSBPAuCeD6CYQSBXk2DDoJpgiaBFoNlhnOGE?=
 =?us-ascii?q?4g6UngcA1ksAVUTFwsHBYEgQwOBDyNLBS0dgSd9gw2BDoQoK0+CInWBeUEZP?=
 =?us-ascii?q?4NTHgZtDwaBGBpKAgICBQJDRYFWQAIBC209NwkLGwY9kySEYlSYOq5igQo0B?=
 =?us-ascii?q?4I4gWeBZAyKLpU9BhMvl1IOBpMFmQaOCJs5gX4kgVwzGiSDNk8DGQ+OIYQAM?=
 =?us-ascii?q?8ApQTUCATkCBwEKAQEDCYVGAQGLKYFLAQE?=
IronPort-PHdr: A9a23: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
 Z0TVvlEWVZzGv5IUixY
IronPort-Data: A9a23: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
 FXZnVx5fXw=
IronPort-HdrOrdr: A9a23:EIYgp6D33a3x+NzlHel455DYdb4zR+YMi2TDGXoBLCC9Afbo8P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOos1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AP0FW82jkLdzst/wXxYti7lPujjJuXnjenXv/J2+?=
 =?us-ascii?q?DWEFYF4yuW3Otp5FnnJ87?=
X-Talos-MUID: 9a23:CN+1ygqbPknVL6ixhKQezwl6BvZJ2/+fMnEuyM0p6taJCB5NIB7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="233071691"
X-MGA-submission: =?us-ascii?q?MDFf9eWZtn/JflTRtVVeU9ewns/1B7REmkM/B6?=
 =?us-ascii?q?k6j7V0RvKUfZGrhW1hjJ+Pkd0c/o8sjkpXeStCSQ76n2ZGn2bMPQ97yi?=
 =?us-ascii?q?IK62cjPdX61Wieywtdd70Cha8u63gdPFL1XX2cqb7yDvMGQlHWdvdNCV?=
 =?us-ascii?q?Iy91Z7Gy6unQa35FCwSrjk9A=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 09:06:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753427190; x=1754031990; i=markus.elfring@web.de;
	bh=fQ0GW9h1XwOwnRTimpWj1PmjKKfPUfJcIYyHz37ylfM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AxLjLZE5cm87othPxYhRVHGDz7S/HpHBTyquxooeCzmLYQwhsCTqdFs13SdaVFXb
	 YsKXh1UyC0umvwLrNv7LOTPDXcSb0RA+hL1clqQUfebB0jRfxSW4qW7dIGn3Ipl6a
	 4KjFSAEcEm1klGkIFBw67C7M7igoN2H1DbflgCAC1arDRLxQrOLTe6dWQWbqEjP35
	 7bitiZ2IAQ+SmJinByihPI61jIk3U5IfEEwPl489WHnsCZXEx+kC+tnt+OelYFTUG
	 9mt+2fELA5szU/E7CyAVoYY17L756xN1DjGyq8MbuPjeFs55Z21/lv5JBEySUI9wh
	 W+oo7xrFM4fsCW2FHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.216]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRk4s-1v7HCx3VX8-00OZu7; Fri, 25
 Jul 2025 09:06:29 +0200
Message-ID: <cd9c1d0c-d3f2-4950-9844-ac0d1d2b58da@web.de>
Date: Fri, 25 Jul 2025 09:06:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UTrLUq3YaoFKwu3AQKoyZN4eXe29vZf+fCmZvGHyXCshObbWO9E
 cixSxhPZOSXeWXY+ZX21Qz72u1sMA4HvC5KWaLcAccQwUh4zrY6uS5QvOBFpj3y321kB74Q
 czkFvgV0yVmmoOvQ3l5/H996INmS9+C2O/RgyKtiJ5VAAOPWasBN9QlGZJ3t7aSnYmLglHl
 Ha79GS31R6AqUygKI/ASQ==
UI-OutboundReport: notjunk:1;M01:P0:sma85ImNQ4w=;CQHjt2tZ2IawE3MIhUIVNXxByly
 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
Subject: Re: [cocci] Searching for questionable call pairs (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2916
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/cd9c1d0c-d3f2-4950-9844-ac0d1d2b58da%40web.de>

> Will another clarification become more interesting?

Another source code search approach can eventually help to influence
some software understanding into more desirable directions.


@display@
@@
(mutex_lock
|mutex_unlock
)(
*...
 );


Another test result (by the software combination =E2=80=9CCoccinelle 1.3.0=
=E2=80=9D for example):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checkout =
next-20250722 && /usr/bin/spatch --no-loops sound/usb/qcom/qc_audio_offloa=
d.c =E2=80=A6/Projekte/Coccinelle/janitor/show_data_for_mutex_lock_and_unl=
ock_calls.cocci | grep -E '^-\s+mutex_' | wc -l
=E2=80=A6=20
39

* Will such information trigger further collateral evolution?

* Would lock guards become applicable at more source code places?
  https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/mutex.h#=
L225


Regards,
Markus
