Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40875C83F26
	for <cocci@archiver.kernel.org>; Thu, 24 Jul 2025 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IpcwUenwWmsKIHVxy3ni8zATmnDWsnL9ASnhFXoyLAY=;
  b=NSWf0KsfQVORWmHf0TuDVMcjFUu1eixD+KD4u9RtIRN1yv1TLlVJBqq6
   0Mv1jIXojDNTgY/ONNW/uF+9vDb0e3ZdT9taEqR0NBF9AB+qfr1fx8wxU
   YLRtGxfUNeYvq1sM5OcFdEp+LewfApyH7u21smX2KCAiVHIHpSy1MTRsu
   g=;
X-CSE-ConnectionGUID: blIl+n/HRwCd3VsVmXgPBQ==
X-CSE-MsgGUID: 68Bijf+TRqikXOiGMw+wyQ==
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
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="233015887"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2025 17:15:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DA795E0172; Thu, 24 Jul 2025 17:15:28 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 795D7E0171
	for <cocci@sympa.inria.fr>; Thu, 24 Jul 2025 17:15:23 +0200 (CEST)
X-CSE-ConnectionGUID: fudasb1YSIGqLNof4lM1oQ==
X-CSE-MsgGUID: c9LauGvCRcCrJhHWemodfw==
IronPort-SDR: 68824e03_QCegRcpbid9D6kRE82UUkhO3OtSxWVM08KL6IJ81tlE6ZH6
 etJnXnHMcgWg2bgcpVQJuUIhmhNPpmTCrxTN7gw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FGAACvTYJog07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgQZUMwQLSYRViByHNIZfhzyHVYh5gVWBfQIPAQMBDU4BAgQBA?=
 =?us-ascii?q?QMEggyCdAKMFgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABAQEhGQcOO4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAgEDI?=
 =?us-ascii?q?x0BAREmAQ8LGgImAgJWBgEUAQGCfoIiAQYQAQMyB7YCgTKBAYIMAQEG2l4fL?=
 =?us-ascii?q?CJZgWQJgRsuAYVsgmQBhieDQnonD4FVRIE8gwM+hEODW4JpgiaBFoNljQaIL?=
 =?us-ascii?q?1J4HANZLAFVExcLBwWBIEMDKjQxI0sFLR2BJ32DDYEOhCgrT4IidYF5QRk/g?=
 =?us-ascii?q?1MeBm0PBoEYGkoCAgIFAkNFgUVAAgELbT03CQsbBj2TFYU1REZBk0KDLa9sN?=
 =?us-ascii?q?AeCOIFngWQMn2sGEy+XUg4GkwWZBiKjTguFRoFoOoFcMxokgzZPAxkPjiEZh?=
 =?us-ascii?q?Bq/JkE1PAIHAQoBAQMJhUYBAYoxgUsBAQ?=
IronPort-PHdr: A9a23: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
 V0EzOGgRWzyHoj8xlAkdVRw2ojHSRK4YA==
IronPort-Data: A9a23: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
 IT+eYyIrIxXh6I8/QaMtkO5wC0kgQ4=
IronPort-HdrOrdr: A9a23:hTTuh6Pe0vdoCMBcThWjsMiBIKoaSvp037Dk7TESdfUnSL39qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AbaCD22i9JC6zs1aqmfSXjKHXnjJufGDRxWzaen6?=
 =?us-ascii?q?DKElwbJuSRwOU3fpjqp87?=
X-Talos-MUID: 9a23:YEZj/gmPFMFAfqiSYixEdnppZeNh/ouwI3oGuo8ku+m7OCl3NzmC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="233015857"
X-MGA-submission: =?us-ascii?q?MDHCMQLRc/LJaSHiCiGiAwqbGfePzB+R5j9fpZ?=
 =?us-ascii?q?PSKhcJt7uJjwXVs/qelGd3nyhkT9msQtVoaYjxovQPL8HP57fwiIIcw4?=
 =?us-ascii?q?NHVtp24+5KJJO/n2Yl4WyeDlyKWJS7zAilHUFSrdqz5/ddOe/luXtD8L?=
 =?us-ascii?q?0G5wsZFG3/izUyMSrpRyNPjw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 17:15:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753370114; x=1753974914; i=markus.elfring@web.de;
	bh=IpcwUenwWmsKIHVxy3ni8zATmnDWsnL9ASnhFXoyLAY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wOxjkdT7IKyXYCRNYtnyXQuXOOx7mUuaUiAkmf4UdyDa/OnKsEL2RH4qbo3cYliV
	 JLEv0jCbmGuIBcrAC0/2Hj2dfK+rapvvHbUoduUoo/IoXQ6kQm7qO6dl2oMVNbgI8
	 Fz+EV+EOiKLxQL4XLU0ClYc9xzAWTpRGgu8b/2zIGWWMmv6rA9+iyUQAoKVC3RrLv
	 7z1MauvaHrSHyDwm5cdHIObSZjccvdS9PRfjaAqldEyu6fjB7ej+qnL03Uh9mkRlr
	 AE7pQ1TyDejZZYy4G4Ng/GaoLgQpa2MBJMa26f3tdNoASQFPixZfEQXc6lRLT7BG3
	 2EMSRl80dXdw0bVS3w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKM5t-1uzVDp0BPL-00Se0v; Thu, 24
 Jul 2025 17:15:14 +0200
Message-ID: <e1366c81-c634-408a-8c53-2d16600f7bfc@web.de>
Date: Thu, 24 Jul 2025 17:15:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:suysVz5Pk01KR1gxH1UGBoFIYs+tKo+UKniMj1a+428HlXS5HPD
 4G0ZBx3mSn3s/FOqB9234O8f2D6UTuGGIK4ZIFY/UZWbVVo2rpZ4tWsyo7ReP+ohFuYWFFI
 7sJNJd+6eYp5Hhyhp/vZ0W1sGkOu2CFV05NaEYd3B7kKjamOHGdvvvKoqagYxGwVjahrzCB
 CIzAxZYo4bdugkM185JcQ==
UI-OutboundReport: notjunk:1;M01:P0:kzUh07WRTwg=;d+fTKFc4fGc/EhDkQSwn7i1tTax
 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
 xg==
Subject: Re: [cocci] Searching for questionable call pairs (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2911
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/e1366c81-c634-408a-8c53-2d16600f7bfc%40web.de>

>> * Why is the diff marking missing for the first lock call so far
>>   (within the implementation of the function =E2=80=9Chandle_uaudio_str=
eam_req=E2=80=9D)?
>>
>>
>> I would appreciate further advices.
> I would think you should do:
>=20
> @r exists@
> expression x, y;
> position p1,p2,p3,p4;
> @@
> mutex_lock(x);@p1
>  ...
> mutex_lock(y);@p2
> ...
> mutex_unlock(x);@p3
>  ...
> mutex_unlock(y);@p4
>=20
> And then use a python rule to print p1, p2, p3, p4.  That way you will k=
eep
> the different matches separated.

I miss still a corresponding answer for my original question.


Can the Coccinelle software handle call orders correctly also according to
passed (different) expressions?

Regards,
Markus
