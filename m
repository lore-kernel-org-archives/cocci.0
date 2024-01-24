Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E88C46CD2
	for <cocci@archiver.kernel.org>; Wed, 24 Jan 2024 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qaSd99MPm98wHQr1piDIWvRwUJYxnK+t9BPS5TwwAzo=;
  b=buiWf6wkiTiLWvJaQxEH+PUqAtZot/DyxZP77iX9H/Mg6IAL5MRLCnON
   k879VgaqCOFWxBinHL02fmDFHFX0NQDkdPa0rvIKVVqiOYm+zw8TMs6KZ
   gonCfRRuO40hZP6mWaZNDmkzeY+VC8pd1xAbzUh8FreSOekPrG/6W2CI7
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148464662"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jan 2024 19:12:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AA8F5E0CD8; Wed, 24 Jan 2024 19:12:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DAF57E0035
	for <cocci@sympa.inria.fr>; Wed, 24 Jan 2024 19:12:48 +0100 (CET)
IronPort-SDR: 65b1531f_b/2wdIHR86k3wYuAw6jClvdsYDZhsdalwMXYNp/LD36+orw
 x3thyns4abITgh2kPejZgyWbWbRk9Zf8HZxo/Dg==
X-IPAS-Result: =?us-ascii?q?A0HTAwDJUrFlhwwR49RaHgEBCxIMQIFEC4I5f1MyBAtIh?=
 =?us-ascii?q?FORNjCEO4c2h06Ib4FWgUA+DwEDAQ1BAQIEAQEDBIR1AQkCh0oCHgcBBDIHD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhWwNg?=
 =?us-ascii?q?lwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCAQICASMdAQERJw8LGgImA?=
 =?us-ascii?q?gJWBgEUAQGCfIIrAQMOIwe3CYEygQGCCgEBBq9ZHywiVoFhCYEaLogcAYVnh?=
 =?us-ascii?q?DsnD4FVRIE8glIxPogegmiYHVR/HQOBBQRcDxsQHjcREBMNAwhuHQIxPAMFA?=
 =?us-ascii?q?wQyChIMCyEFVQNABkkLAwIaBQMDBIEwBQ0aAhAaBgwmAwMSSQIQFAM4AwMGA?=
 =?us-ascii?q?woxBylVQQxQA2UfMgk8CwQMGgIbGw0nIwIsQAMREgIWAyQWBDYRCQsmAyoGN?=
 =?us-ascii?q?wISDAYGCV0JHQcPCQQlAwgEAyspAyMzQREDBAoDFAcLB3iCEIE+BBNHAxCBH?=
 =?us-ascii?q?AMZKx1AAgELbT01CQsbBj0CmyiCTRGicaJJNAeCNIFggWEMny8GEy+DcgGTO?=
 =?us-ascii?q?g4GklmYVCCoTYFqATKBXDMaJIM2TwMZD44gGYQUj0dANTsCBwsBAQMJhUYBA?=
 =?us-ascii?q?YNagUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:Aha+TKrgLjiaU8qMXMkL+SoaV5r1eYIsimQD101hICG9Afbo9P
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:XTJylmGVWcPdEhYDqmI7xFMYOsc9LETY833KGF6eLEZ1TY28HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AYLeguQxPkpVjy+IG5gY6Rc568gaaqKOxDV01qpo?=
 =?us-ascii?q?YgeerPG8tYzWcjia8e4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="77734027"
X-MGA-submission: =?us-ascii?q?MDEhW2RtbCNfSr49VUIYI4uFEuhFwpQ4Kw3Qsl?=
 =?us-ascii?q?DEpXxJW3+FbOq0X695xw83qi+p+WQ+68OhGkkE36F08unS2I+5dEUqBC?=
 =?us-ascii?q?kjXWJ3FIdguKGAE6uoHtZQo4XWlT3KhnooRruVd/x4JR5WUQgW1sQFZg?=
 =?us-ascii?q?o7QEfuG0vD0tM32qWuYDhvsw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 19:12:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706119967; x=1706724767; i=markus.elfring@web.de;
	bh=qaSd99MPm98wHQr1piDIWvRwUJYxnK+t9BPS5TwwAzo=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=AfehXZOk4XU1hAQNgnniMWgilnkBusDf757zWJhVjokayKtUOS4Md452uEb9RMnN
	 pCQBzrJs1T0klN/VmBZGdqw2M0oHFM3wK0QeLQw0QAjJOfjV3AbnXMBzDVvS6k4Aw
	 A+ruBFdWChnYIEL7WEAGJzhQLjSF9yOrK6gvA794IwEai+WSXJkpq8cDCjOE1PvcN
	 IGMpGlPKhH94d2V8xntYRMaUARxoaWcVWpWiMw7JIpzbnUj45Db7Pm+HOtxlTaApp
	 j/HBzT4ZvDCkP1beptwhVXoTRsUoVlZHT8QIv0KULGK1kRKwAAzVcituBUEHFGv9/
	 TxUH7fOFRz4WbBwCKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKtN-1qrhxM1wRn-00gfMA; Wed, 24
 Jan 2024 19:12:47 +0100
Message-ID: <d74c2c33-e64c-4f91-baf2-20a4f31b925b@web.de>
Date: Wed, 24 Jan 2024 19:12:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <4604ee8e-a876-4545-b0cb-e4fba2e187a2@web.de>
 <c5407d97-913-f788-7ffb-11b65373cb5@inria.fr>
 <23ff96d1-8cf2-4736-be84-c00600b15a73@web.de>
 <297bf3e1-8262-a599-20ff-dc8086d5b87a@inria.fr>
 <c41c9f8e-acdd-4e04-8c2a-8f1589e50785@web.de>
 <fcfa187e-5dbd-177d-bcf3-fd42c8b6bd46@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <fcfa187e-5dbd-177d-bcf3-fd42c8b6bd46@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KRY/yWIQ/b+ImFYFD/NoC0oVvwFkcO/qMPjKIXWNIL/XjYWMDIK
 m9rjDX4eXvHaTJP5VvzD7pr7qTSlFGBzGInEg6QNzVTh4lZMVI8R38zJtFRiK7IYONFFYg2
 zqt96Ktiwe7y5jrQv/k8hGGsWSqO9ADaU64LX/4dUL4S94ifASmuprZy4yMQ8EuOFEE+R/S
 DdOSWwgC2g0XzcVbXq9/A==
UI-OutboundReport: notjunk:1;M01:P0:LrQxdax2VsI=;1t9SYLyyozy73TZML5hnckObb5g
 7+G5OFvr5i0tznIrA4m6jBihwv/mPjXQX2mZbw3ZyYmvvQr2dBBE5c7i5SrSJ7sepMmZpoR7r
 p1xT8g43mogrmx353YIvENeC1WJxT+BrDPKTpdYJiquDWwcIEVeLHy3wF1tQDFshW3LB1Bhv1
 YdlBLPPrKdlqxukUREhGSJFSxMpQow3U60MmvBgg/sxRRqGKH4G3mR9713Sxca2OCZV/me2yU
 DBLvVcrxvakND9gmDZAE1WtXBEK966yPslQLyArUxdmYvOeSf9BL0+SD+R+SnHZ/U5RfZ3lkL
 PY+/xK1kLO/eQe7yy8qj++EEgnzxYCBz+XOmY3cUD7f+oqgy6sYo9mFc+Pi5SMomf8/kfM9NX
 1Mauvfb03mZTtYqXbulKLEqCHu3H3rghNFfRn4D8SrFNNaL1eJFXTwBAzeSdXUnvFEBsgozGy
 s6fh3aLvREJAx49fYPJIpagCyErkQw0u2VvCMCy+/qqNvCdko/LlPJaofkekiHcxZCgj4ERT7
 /V4sR3gO7W/ea2B67ylvleJB2xWcEyhhuEABotfzLz0fbDyzKxnG4oOQmDI0MdBN3GVLmoMTw
 cka3TZp27Zoxucm4aSWhO6lgu/PhQjDLn42NSAdpzEF2numpzTxXG50pciK3ma7KicCGyhbbI
 wA+bvUCArQG41f5FWNAuGvQ7KHAoFqqIl8nlu1P5Zw6qk1J74CxJs1fWjXvV9vrLYCrqKSIxW
 3a7JLJ1Ft8JkWUbYFPPOPfRR2vf04YpKdYQihjFRM0bKkQbOgDPFyoTbQEbQZUbdoNHCKzdxS
 1+m1ahmbJWRoeBMC+AGqeK8QBioyLzCE73fXHE0WjdbiYPBQ3+7ejTYsiaXuCltcqPDLP+ShH
 ArkOxODMbEuFG6XvO6waYBUKdg9AeI5ay0tkM+B3RDVuPYWYQMFuv8fZ1ozTVkHiwEtGTD6n+
 N1lMNw==
Subject: Re: [cocci] Checking a parse error for detailed SmPL rule
 properties
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1483
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/d74c2c33-e64c-4f91-baf2-20a4f31b925b%40web.de>

>> Why would such a technical aspect influence the identifier selection
>> within the name space of a rule for the semantic patch language?
>
> Because or is now a keyword, and we don't allow keywords as rule names.
> You can't have if or while as a rule name either.
>
> Perhaps it could be fixed, but that is the explanation.

With which commit was the observed restriction introduced?

Regards,
Markus
