Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD68C87FCA
	for <cocci@archiver.kernel.org>; Sun,  3 Aug 2025 05:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=67ZqCxIunpwAavKVdeSUZZUWNR05tSC3z8+Snin5yeQ=;
  b=vc92WSTUmAWB2ugmFppr9tI/kmY1BfLaQhjTTKKPm6dF/slUZlkpS/Tz
   KKFx1bAoOiYRPtMg1dukNg0dZW++ZN545V7cFUHqqX5XMxA6lV5/yFXJJ
   ltGzkEtZ0e6isHo6OvPYZARsaG6X+EPvX6FBUkGrK/wBHINsjuN2OcCdQ
   c=;
X-CSE-ConnectionGUID: MJddIp8iRTKCEw/lJcXMsQ==
X-CSE-MsgGUID: B9cs502SRWqjJY9+j9dTxQ==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233992442"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Aug 2025 07:55:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 50AABE0BE9; Sun,  3 Aug 2025 07:55:41 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 030ECE0171
	for <cocci@sympa.inria.fr>; Sun,  3 Aug 2025 07:55:40 +0200 (CEST)
X-CSE-ConnectionGUID: A8QJ7jjkQhezI7L/d/z6bA==
X-CSE-MsgGUID: amkn3z/cQ9G3Lxk/nrHT7g==
IronPort-SDR: 688ef9db_5bEg/zSMDBRn1gx4arnbSiFDpdfKhlXut1JGkwDCh95JFMs
 uYuZ17y/nqCaeM9eWkWb6xlkCXqyWYXsYMj1gqg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F9AAD4+I5ogA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgQZUMwQLSYRViByHNIIkhDuHPIdViHmBVYF9Ag8BAwENTgECB?=
 =?us-ascii?q?AEBAwSFAAKMGgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABATsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECA?=
 =?us-ascii?q?SMdAQERJgEECwsaAiYCAlYGARQBAYJ+giIBBhABAw4kB7AMgTKBAYIMAQEG2?=
 =?us-ascii?q?l4fLCJZgWQJgRsuAYVsgmQBhieDQnonD4FVRIE8C4JHMT6EQ4NbgmmCJkRSg?=
 =?us-ascii?q?2ONBIhwUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnfYMNgQ6EJytPgiJ1g?=
 =?us-ascii?q?XlBGT+DUx4GbQ8GgRUaHi0CAgIFAkNFgWAZBhpAAgELbT03CQsbBj2TVIMhg?=
 =?us-ascii?q?hWYOpsJlGM0B4I4gWeBZAyfbAYTL5dSDgaTBZkGIqkfgWg6gVwzGiSDNk8DG?=
 =?us-ascii?q?Q+BSoxXhDO9C0E1PAIHAQoBAQMJhUYBAYw3gUsBAQ?=
IronPort-PHdr: A9a23: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
 10XzLm+IYlBbuUTPmR9Z1M8kImYQyLt
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:JxR1s63kYMpSZdYDnuWpaQqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3A1jP5t2nSdZCZgAYdbHY+qHiUBj3XOVSN9VWPIU2?=
 =?us-ascii?q?7MGZkWpzKbRicv7E6meM7zg=3D=3D?=
X-Talos-MUID: 9a23:R9rwxwsknmLGcO2JAc2njTRhMpx6pK+XWW9WtYUF/M+eFRAvNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233992440"
X-MGA-submission: =?us-ascii?q?MDHJbV2vrgqS4bhv83YUBWCqb6cZmZOGjVCytk?=
 =?us-ascii?q?G854lIaasCBbB4havEeHZShO32MjCh5dMJrPuHCs634Us8P/iMnOT80G?=
 =?us-ascii?q?97YOWUbWojJcGXbOzFk/ZYa+Ggg8cAL4J5JoVk5h4UD4biqj0Ol93Rnp?=
 =?us-ascii?q?tzDgZCHMevi1wYfqBKz6LFlw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2025 07:55:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754200538; x=1754805338; i=markus.elfring@web.de;
	bh=67ZqCxIunpwAavKVdeSUZZUWNR05tSC3z8+Snin5yeQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=piIkVMpyjLUlQhWmUnc/olk4vkUY7qUuhND1WBkwB6MMquh93sX+zoxBt8bxENB2
	 AtYrYSvefNSONAcTu3ggnMkr7HMSCpFsHN3ApFbWzpQwAbN5OgWzVUUKfRJh3DYcl
	 V5G3fwELRyBlgiAtsig37LXxq5x5DeGWpnZWFKQbIH1b2kkcxfaOsfmLHVq2c4eD3
	 xyJSNF8gmAOf6OeXfnJVB1frHDve7YZCPpc3hghl9avLSrmOCSqBQ3MsN246IHHKg
	 TD1eDMYFskDZt5P8Q91UYjcLeC2zLyJ3LUxICWeZCW+zv1eG2JwQyD2x2bTDpshH0
	 A9ArTeRNKztReDL3uA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuVGA-1uQ5lI0w7e-016Gif; Sun, 03
 Aug 2025 07:55:38 +0200
Message-ID: <7e7607e3-fc0d-4067-b4e3-3603b2f33cab@web.de>
Date: Sun, 3 Aug 2025 07:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
 <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de>
 <alpine.DEB.2.22.394.2508021353080.3428@hadrien>
 <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de>
 <alpine.DEB.2.22.394.2508021409080.3428@hadrien>
 <c5042d2d-43df-4276-9611-da4f30763940@web.de>
 <alpine.DEB.2.22.394.2508021502250.3428@hadrien>
 <6239d52e-3213-4083-8d97-9b1f59d2d5b4@web.de>
 <alpine.DEB.2.22.394.2508021745180.3428@hadrien>
 <2130ab11-8ec0-4e57-9a73-5e1ac9e41f7f@web.de>
 <alpine.DEB.2.22.394.2508021803360.3428@hadrien>
 <51664351-746c-4d7a-ae45-2a610ba45176@web.de>
 <alpine.DEB.2.22.394.2508021822490.3428@hadrien>
 <5e8e1f8a-6832-49af-bca5-41d2a13b1322@web.de>
 <alpine.DEB.2.22.394.2508021935250.3428@hadrien>
 <a86ce687-61a5-4e52-92fa-6a0d53db9360@web.de>
 <alpine.DEB.2.22.394.2508022111230.3428@hadrien>
 <74b74c33-22d9-4282-bb2c-1c475d715e5d@web.de>
 <alpine.DEB.2.22.394.2508030730570.3678@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508030730570.3678@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4SErQUTfN228h9rivPShB+FE8ByQLd5lTkvfhF1P6AubmiSvUrz
 9j27KSAWKATgt0FPEX87PtyUSSlrgpjoHI5xmGCEy8Y8PpQiGFYGu1UFq9HCwgJTE28Ta/X
 kLZ0Jxv/T/ZiPmZWA5q1L1YqAWQMDM8fcKConG+7DNT/teDudxAcbw9w+Vmmq9ekmmV5R4w
 VOs9YYy/nv0a469SA5h4A==
UI-OutboundReport: notjunk:1;M01:P0:iGLvsrXp6aQ=;/ob6hyE78/oL0Iq5r8Cn8iPTyT5
 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
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2954
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/7e7607e3-fc0d-4067-b4e3-3603b2f33cab%40web.de>

>> One of the recurring source code analysis tasks can be to point the beg=
inning
>> of a sequence out.
>> Thus there are corresponding case distinctions relevant.
>>
>> * Presenting only the first hit
>=20
> Which one is th first one?

We tend to interpret the control flow in one direction =E2=80=92 from top =
to bottom,
don't we?


>                             The first one it finds?

Probably, yes.


>                                                      That seems meaningl=
ess.

Development views can evolve further.


>               Coccinelle works bottom up.  It finds all nodes that match
> some pattern, then all nodes that are connected to that one, etc.  There
> is no notion of first one.

Is another general concept helpful here?


> If you mean the first one that appears in the function, I already told y=
ou
> that you can get that by putting ... at the top of the pattern.  It may
> greatly degrade the execution time, though.

Thanks for such a reminder.

Sequence beginnings occur at several well-known places.

Regards,
Markus
