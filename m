Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC86D6EC0A
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2024 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4aLJg9VUB9HRRVJ0YdwC4TyhT84p0PsQe/a585jAmAk=;
  b=ZgvhIhfIRVd4Lsg28pBSQww9a6cp4EEJznzeL3KCp7NV2XPQoGcDeB9S
   KmXLPiSzFA1dnxLn2Q/2UTBfJnWH9hCl4gisdDHrwOkMpYYepKHGahSlJ
   X2jp7Spq3NrXwDp8RAnK4NItc5exC6WrrBLwbGNKkv6aZfSRNOoXhwADa
   k=;
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
X-IronPort-AV: E=Sophos;i="6.12,195,1728943200"; 
   d="scan'208";a="196522834"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2024 14:40:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E7B5CE013D; Fri, 29 Nov 2024 14:40:40 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 56A85E00B6
	for <cocci@sympa.inria.fr>; Fri, 29 Nov 2024 14:40:37 +0100 (CET)
IronPort-SDR: 6749c454_3ThpOJeJfEJh/ygH1r5KJI5ck2sf+rBSr90kcwPc/MCqCS8
 ta3iqQLJrtluSz9OkTEcP5TjWxECMVbjDRTpt+g==
X-IPAS-Result: =?us-ascii?q?A0FmAAB0w0lngA4P49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQgMBAQELAYJDgQNUMwQLSIRWj02BdDCEO4c7h1aIdYNUDwEDAQ1BA?=
 =?us-ascii?q?QIEAQEDBIIMgnQCimMCHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBA?=
 =?us-ascii?q?gEjHQEBESYBBAsLGgImAgJWBgEUAQGCfYIwAQMOIwexUoEygQGCDAEBBtpbH?=
 =?us-ascii?q?ywiV4FkCYEaLgGFaYJiAYVpO4Q8Jw+BVUSBPIMDPogegmmCRIUPIwKIGGicF?=
 =?us-ascii?q?VJ7HANZMgFVExcLBwWBKREQLAOBeU5/gTYogSkBQoJOSiGDDYFeBTcKPYJKa?=
 =?us-ascii?q?U03Ag0CNoIkJFmCTYElBAWDaYELg15lLwMDAwOCEYErgkldgwpDHUACAQttP?=
 =?us-ascii?q?TcGAwsbBj2iF4RUGRyBW6U1jFyUWzQHgjiBZYFjDJ9aBhMvg3EBk1EOBpJ6i?=
 =?us-ascii?q?C+QTCKpCIF9JIFcMxokgzZPAxkPjiEMFoQLxmNCNTwCBwsBAQMJhUYBAYxAg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
 chXIle6fFkyC+9cFUlvWtAPcs8fYw==
IronPort-Data: A9a23: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
 4QqbTgsfXxXgnId3Sqtl7C51f3ZUP7SI+0UUBqy
IronPort-HdrOrdr: A9a23:wRtQAq3Av0Kyf3KonF/mEAqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:7P2y2m2RDg1Jt81zhaF8CbxfQewII1vmnS/pAVaBAmg2ZJK/RQ+X0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AG1RTtQ23jgPdohkFlHEatBlUeTUj45uPGV09oKk?=
 =?us-ascii?q?/4sCqM3woNxeFtXftXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,195,1728943200"; 
   d="scan'208";a="103004996"
X-MGA-submission: =?us-ascii?q?MDFsoOFb+DDLewcu6ZjPTvv/0giWYBQ3sU9sXi?=
 =?us-ascii?q?4wfmX5aC0LidSHH4eKg9vH12Zt0OePy3tTTggq8gbHMFpqu4uEFq6HH8?=
 =?us-ascii?q?KXUbGV9b9Y4JEnjTSVJtHj+psXfja7gihHO2Kl8UNAZkuR3bSini4v5E?=
 =?us-ascii?q?MWN9hWbbF+HA9cLtkzwQUZfw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 14:40:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732887619; x=1733492419; i=markus.elfring@web.de;
	bh=4aLJg9VUB9HRRVJ0YdwC4TyhT84p0PsQe/a585jAmAk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VilcuBxjyKCJ7DLw02D+LKg3lI3vQsR7w17unbjMW/4hKrRj6tkWlUGX92+9DvQZ
	 0c+EQPcKZV0e74oTUtly47T1khYXMw6/eZkI3fPtiRm7SgP5VTnAtpG98lNkFRn3g
	 f/O40EGDiu9uxkilokXfwVqsx0aM55FVrjFsW+4kqXHQMaMeJl7hV+NfnGJ70dqA0
	 t7NlOZ9UMGzDKMerkHcmH5yClD64MiU36FG+jsUXK+6ORTr8eZq3LhD1vrKTVgF9P
	 A8KqledJc8fPXB8OjDm2tj9Kv929SPa/wpC81E95PLkPP2BWsnnB4rKhXyq6vlPKX
	 7tRLXxDvLXFthO/coA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cHJ-1tmU5u30rt-012ROY; Fri, 29
 Nov 2024 14:40:19 +0100
Message-ID: <39f00e80-120f-4c00-a966-53e745349e3f@web.de>
Date: Fri, 29 Nov 2024 14:40:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, cocci@inria.fr
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-11-cgoettsche@seltendoof.de>
 <b30c7227-c596-4980-aa46-a75b1d429354@web.de>
 <667e5848-a8e4-4308-a464-006800039029@inria.fr>
Content-Language: en-GB
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 LKML <linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>,
 Serge Hallyn <serge@hallyn.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <667e5848-a8e4-4308-a464-006800039029@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ihsjtGwThE3NOxosREOFxtonYZcVaZzp+KzdSy5Pukrvn2GxZi8
 nZUppE/qNkThq2JlAWUe8w1J2F6MZzU1EX47Ib2ua2NsDD/Gs2t8sY+p1TgKcTjdRDERvDY
 +QtVDkpnJyRR64cAnenpsqD5QKOGBwwF0LCF7kXX4OQpV9x6nYl4fIycyMdSfCwcHslgWla
 HMPIpzui3IQihcCnskl6Q==
UI-OutboundReport: notjunk:1;M01:P0:tIihcw65Yjo=;JSw3pFncyWEQ290xs99IRCzj06g
 /Fizon/FQiGGPLEifFjYb+LEjyZrvJowAo2LSf99jQrxQ0ujy84ye1OS/r83aR6TSgvx3ynbm
 FFMiXfb6QBVaK8RqVnNk8Galp9+awREnvuCXePMROhZFZFaDdZ8+7Jca52cuf5dbyhH2PpZjz
 LC54fWqk0VOcHEdAl4IJZGO0diTPtsud4ef8w42AkX0YZ90ogC5fVdhzKSMPTF/gR4ZKWTYZc
 +TMCYOyJZKJry+9joBpokJEY2B+X04NXZy/nGOhWFzohBx45iQPO93WUzG7o7ZVeEDQMrrXE6
 OEQRaQgOxm4pIhR2QMxseljRTQVsRNhITSw43OU7ERFJ3Pj6GF4phsJd8M3uWOlTaX30UP9DG
 AarRISMnHyprq5J5695NRczeZpNeWsFiXXAxyZw4mDWWkRDRNlsT+6bmrBvhFB1HF49X8/WPq
 1xowZhpeBqXzIVIlNo7aOwVLOhqgFcp19dqI7XDi4ot0gxyoD1P1TQcJ/EK4YXYngUYcTY6DU
 JAhDO1tWgycd1G31plkBUpBTCKLuCj3lGHdGLB/bTAKVXcBOD3oYCyc40Q7zZOQN7jG+3KZxw
 Nya1CRuQItM9GyfNKGvWrTGll1YTzUNQp89cORWHC9mOdfXj/NewheMyqQ7UpXg/oUhjkLsiz
 +jibDUAhNxDerndDabBl4lmY7fy1Mf0mrkfFBxdbU4abDr1zS6yIag1IdqQDpk93qcwjtVKFy
 PSUzehUO8apimIxg1b8JESO6fbrf6Ii9WvE5JIt+OhxdqshFQFhgdcWvzJffhPE7wUUsrRZ6d
 ZHN36DpWUhTJKGAptHAEiLNUf3hdTuzgbj9qrqJNRS0AyTbxnY8uOkbtrOH065+YZRe/8PN9V
 zjkIao12eC41m6T6fXef50+SMpDp+DqxAx53xWA75jdl+x2G8u32Cd+U/YnZeB9z4jhxFVQt+
 lC2BaOFy7kutBp/TcziH3TFqP0/Sbm/uG7oNHLCyXNxNqDErzWY21ShJSf5yFftFL2HIodFUY
 rqUrxAHSti+F786vQ8edXbKqE5szdzklgamgIGkagebHoddOSkn9vQ0G2Quhvwx0jDGfdcIi4
 1AVY4g4Xw=
Subject: Re: [cocci] [PATCH 01/11] coccinelle: Add script to reorder
 capable() calls
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2141
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/39f00e80-120f-4c00-a966-53e745349e3f%40web.de>

> Feel free to ignore Markus's comments,

I wonder about such a response.


> he is not a maintainer

How does such information matter here?


>                        and as usual,
> his questions don't make a ton of sense.
How did you come to such a conclusion?

Can software development clarifications become more constructive again?

Regards,
Markus
