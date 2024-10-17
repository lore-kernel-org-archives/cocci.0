Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2462D3C526
	for <cocci@archiver.kernel.org>; Thu, 17 Oct 2024 18:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=caX4Kd9zFGs/zyZLazYpOqVu8sjSpPjBUDdrlVEV1Eo=;
  b=h8cHEOgnZt4mOwmzD0ye7rurUcP2mHjqvQUzerx+bjCIju5CLDbHtNC6
   WRbBGNJ9rZywgl8wh/Ye5YZmPObZmT6K4VyWUEwjtI/EqzuLGQB5aiV01
   G3WxuU4zLGZW3PkP0sz+SN1QT4cRcPtT4IEpg0xE91eexaN8p00yFMk1T
   E=;
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
X-IronPort-AV: E=Sophos;i="6.11,211,1725314400"; 
   d="scan'208";a="189464686"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Oct 2024 20:18:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7F5D2E0141; Thu, 17 Oct 2024 20:18:57 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9E8DEE004E
	for <cocci@sympa.inria.fr>; Thu, 17 Oct 2024 20:18:54 +0200 (CEST)
IronPort-SDR: 6711550e_CQ0a2vv/Ebyr4hsFRrzqSFGxdtDLjljd04zB7ROT4lN4w15
 XIjDKWhuAZWIUNM7oKAEH7g1WMhZvMKD7EO5bxQ==
X-IPAS-Result: =?us-ascii?q?A0FSAADHUxFnfg4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDYiFUMwQLSIRWiB2JJDCEO4c6h1SKS4F+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?IIMgmoBCQKKJAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABATsHDgkBMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjH?=
 =?us-ascii?q?QEBESYBBAsLGgImAgJWBhUBAYJ9gjABAw4jB7AhgTITboIMAQEG2lsfLCJXg?=
 =?us-ascii?q?WMJgRouAYVpgmIBiWZ6Jw+BVUSBPIJSMT6IHoJpkgmLaiWIUW6RUFJ7HANZI?=
 =?us-ascii?q?RMBVRMXCwkFiTUKgxwpgUUmhBEIgSsTg1+BZwlghiCCIoEMgT6BWQGDOEqDT?=
 =?us-ascii?q?ByBUQU4SYJPak43Ag0CN4IkgQCCUYElBAWDPYEWHUACAQttPTUJCxsGPa4Zq?=
 =?us-ascii?q?xWhNTQHgjiBZYFjDJ9VBhMvg3IBk00OBpJ4mHepIIFnOoFcMxokgzZPAxkPj?=
 =?us-ascii?q?iGELcZTQTU7AgcLAQEDCYVGAQGHBIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aTZiIyKrIxXiaI8LCq4R0NoJQ==
IronPort-HdrOrdr: A9a23:bvmIa6EAH5kj5lP4pLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AQaPGaGvTP2JCx7svjYI2srUb6IsgWCLPzEnsAHa?=
 =?us-ascii?q?UEHRMRrSrbg7J1YRdxp8=3D?=
X-Talos-MUID: 9a23:KnjHhAk7STIkUkxemnX8dnp6Hct45fy1EHojy8gqpfugEw5rOw+S2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,211,1725314400"; 
   d="scan'208";a="99403713"
X-MGA-submission: =?us-ascii?q?MDEsIdInwDqe1zR35KYpuoY0J/vcut3xa1sVCN?=
 =?us-ascii?q?+JzYyyQ4R/KlIcXANqtboCck6I7iLAJFQKs2kKWb3LugM5nAaNSNVp2W?=
 =?us-ascii?q?TeCRXnUedpSazvvjahOPdnF7d+WInb5SCYziArxJC03aUk1uUdvA0bQO?=
 =?us-ascii?q?nZviAyNbH2kHt9jQXG1R2H3w=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:18:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729189133; x=1729793933; i=markus.elfring@web.de;
	bh=caX4Kd9zFGs/zyZLazYpOqVu8sjSpPjBUDdrlVEV1Eo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NpoP8tBh8K3IsnJvynv6e8tSjZieUJxFpszgB4GCl6qzuMzuFzMivt2Tm9sI3JIZ
	 LNXYZGDYkLFZNVbK4kvztem4DO8x799M5aU7wLLGgeOGp6gu7tLjH2ElBhbgG0a7z
	 HrVFBQwQGuCYDtjbTzplNoASUcOCixEAy8eMvRPNr353++hjgXGxteio3X69nAwjN
	 ZJmk7wLMjmHaXhSDJtgfCdT7bwz8QxOHJz8PWRQDv2ZF22T8n1py8rIkO9faF7UbD
	 NAxKscoLW2cS4kZbQ1894JnQfU1E/UByH2RC+xi3vStnUQK5uZe+F8pDgdc4RKvrQ
	 jG9bGgE1tsbpTQlhww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmymp-1tl2eR3ejv-00k6Up; Thu, 17
 Oct 2024 20:18:52 +0200
Message-ID: <a89dfb58-621a-4c0b-a0a1-ba01d5df51ce@web.de>
Date: Thu, 17 Oct 2024 20:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <9c059950-a17c-49e4-ad4e-ffab2d6c0ea9@web.de>
 <ced9a857-0da6-4cfc-ad35-9095ea20771d@web.de>
 <d69dc642-7a57-449b-170-a67c3a9fc1c@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d69dc642-7a57-449b-170-a67c3a9fc1c@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LA3cbQscawiLNDzNHa6RVl3GQM4K9e78aHqU4wc8Y3PW4H25mff
 h13KV8eGwuo54DyXm5s1fZE44dQAbFhcFzYwyK5BfpOJ7BKjTM48XujRiMb2Zjxy6olyale
 Mxj3/BCRVF4MR8XKVzUo5U85P8D41Z0QZxFPWXqmmK1mPgUhyj4qtWGSgdFUW9LsjLxL00W
 4NFJwJJYvZgqpJGT9nDdg==
UI-OutboundReport: notjunk:1;M01:P0:9HZ+uBhsjfY=;k0NAJo4y0spEx8g5haTqfZHP6TX
 89/fzHW/a4qHehKDfWrfZK2iLRhibUKSpCFkH1DmOLH0JbPnnWWX40tQjd6QF9mklUQNDrO27
 A8LsR8Aw276qkD8o3auqmWMEAf+XsdetXezcp4EKIjGBvPVI/jgBvZk2ErTEZitntnzW7srcW
 BL7/PxMWoahyoQMDmbsQ0vwtc6MdXgZNlMt8krhzy96/rRIhqTKHIKhSh5o+RVFKE4MCE12iD
 K+Ty2Bbm4ObfeU3NvPtIO0vfaCt2ar+SvqC6yCCmAITULtqadOngavp6bEVyDDXfGBo6RBkP2
 IIkPmosqFSSACmdiTBNj6zW2GjeWYTnzpEOu70qGiHAsbXrIf319pv0fTMiYP0pdvPZ1trIYX
 SzTcER9MA2XrEIgw70K/l2BElSrrU7WZf5Nz2NmADxPfQuVPLeawjgRThI50qacnlh/jspR6d
 qarsCaN6tEv8UPhj4bzZBKojwGQ3lal8l9/kn7hC0p9J3AyXly6ZYBgmkAp/D9DNOfUsgbTGM
 BpSRoylF3mVgwMwr1OkcTePlUJLBjeNHvpwU5btaJsQj7clTjhBQYx9dybEvHBs2VMWhpDQFa
 ocJ2t2NTqDJCEZ/vA1iWHXExfflx/FRe58fDJLJYuBP8XkVw70aZeqdoGx294XLYe2JWiOayP
 qCq+1nRM5x2AjED+OWqhXsd4Eb3XjOFNA5mexsxhAlemagNjQc0h9OkZPNntLUJeTL3CZuqJ9
 wunwJcKbIiHCnlK8kXUxo1RCftMpOLqBy366isZvzRKVDpFq0XOmBHOoB3XNn9mo8cDaH0UsB
 MREXYaY9AFatZwiEPxagwKzQ==
Subject: Re: [cocci] Challenges with selection of an SmPL Python version?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1914
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/a89dfb58-621a-4c0b-a0a1-ba01d5df51ce%40web.de>

> I can't test this because you use libraries that I don't have.

Would you dare to install any of the mentioned software libraries (on demand)?

Regards,
Markus
