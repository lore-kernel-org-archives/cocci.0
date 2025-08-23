Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A67CA0EFA
	for <cocci@archiver.kernel.org>; Sat, 23 Aug 2025 11:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=32tAePvSv/JZ2glG/XZYJn8AC4+Bz943TofehjzDOwo=;
  b=IaSDc2fPY6y2LtLf5iVXnSti9A/SVz7RZrwx79eKzfChiJMLUxNGqdUA
   1guN3/gPrL447qG3sHkfffJrFYC4i9aq9jCwD/1ooeNbNChisRik0Fjim
   Jt96bF9ui4CCrdw52iPTHUt8I22NGNQ0aVkxN8y8mqjdTdnmuUz5b8SNP
   c=;
X-CSE-ConnectionGUID: H2qfP2/3Sjygc30OmTkpCw==
X-CSE-MsgGUID: jwpNCNRVSHaHzWyaimzNlg==
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
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="235843811"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Aug 2025 13:27:00 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AF8FDE0BE9; Sat, 23 Aug 2025 13:26:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4C9C2E0172
	for <cocci@sympa.inria.fr>; Sat, 23 Aug 2025 13:26:56 +0200 (CEST)
X-CSE-ConnectionGUID: cFUqCl8KTgm6hCwMiombow==
X-CSE-MsgGUID: ke3X/yc9RlOrSYLvbt9cgQ==
IronPort-SDR: 68a9a57f_lprWvRn8pcGYNsJaZXG9AGEisYt5eUtdYqniS9IFEq18Oop
 7c79xinAQOTRdUyHwhrWQ591yzp5EPb8FmFG9sg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EKAACMpKlogwsR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYI/gQEGVDMEC0mEVYgchzSCJGmDUo8RiHmBVYF9Ag8BA?=
 =?us-ascii?q?wENRAoBAgQBAQMEOIRIAowmAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBD?=
 =?us-ascii?q?QEBBQEBAQIBAQIEBgECEAEBAToHDgoxhk8NgmIBgSSBJgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARcCDTpEAQEBAgEjHQEBEScECwsaAiYCAlYGARICAQGCfgGCIgEGE?=
 =?us-ascii?q?AEDDyYHDbFRgTKBAYIMAQEG2l4fLCJZgWQDBoEbLgGFa4JkAYYnhDwnD4FVR?=
 =?us-ascii?q?IE8C4JHMT6CSoVUgmmCJoEWg16Mf4FtiCZSeBwDWSwBVRMXCwcFgSBDAyo0M?=
 =?us-ascii?q?SMPPAUtHYEneoMLgQ6EJytPgiJ1gXdBGT+DUx4Gaw8GgRUZHS4CAgIFAkM+g?=
 =?us-ascii?q?VwXJAYfEgIDAQICgRIQAjNAAgELbT03CQsbBj2UX4RogjGTIJFkoUU0B4I4g?=
 =?us-ascii?q?WeBZAyKLpU+BhMvg3GTYQ4GkwWZBiKLbIF6lXOFRoFoOoFcMxokgzYfMAMZD?=
 =?us-ascii?q?44hGYQahGCzUkE1AjoCBwsBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 nbeZSNhbO5r+Dq+uj/fw3LVqSF2nERjwb3Y
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:jC+FnK7/Vvl+hyYQVwPXwBbXdLJyesId70hD6qkDc20xTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ8+6U
 4KSchD4bPLfDtHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: 9a23:OA2RDWO+ifUu1+5DUwda7WUQSuMZfXiDzFzPBk6/DGxuV+jA
X-Talos-MUID: 9a23:rVM2EwVt7NE8wkrq/Dzh3wElJcw52aCJEns8tYsMp5iPOhUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="123746850"
X-MGA-submission: =?us-ascii?q?MDHU38M6zMjbSW1bxKsDNEluduqeX6ItelKmgQ?=
 =?us-ascii?q?gCJpH6VB+fIvwLWXo/vBA4uX8lqGliA960T9Mtqt4J8ukDuendaYl6Sk?=
 =?us-ascii?q?y4buLg8XJdkqOC7hYkgDa4M/PhhkVgAS1jSI48JmMCnyR/SetqD12zka?=
 =?us-ascii?q?/rBDi9IZBF1FTjwUDkzkM74Q=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 13:26:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755948414; x=1756553214; i=markus.elfring@web.de;
	bh=32tAePvSv/JZ2glG/XZYJn8AC4+Bz943TofehjzDOwo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mqcLnDzX2OCx36Smr4q+wwgeFVBT9ZxGfw8EcQyY9K5vW8H76WYOPCiTNhcUyyA4
	 PfVdlLynwHsXekVmAFNHFDeoRLS80lRZy4dsxncvPwPOMNzGqli9QZkjAbDgWY4Qw
	 jVRQ5SpqrhDGY5JyZGmUvNrjpomqJL2eIvOLm9a2JHIBZ4fRH35E3GXAPMVPjd1L3
	 7VOvjeEt7vTkKHP/gyBsOjCHWPLimcTsSaf4T5sRliPr1OwIgOrvcZgUoJuAuPdMI
	 Gami5C7Ar19GSay8akDYXs9rI/lNleoHze/VPM4s6hQuoEfJiKjhluFEIA00ll/01
	 m4KhNu0w8+EjoQf7iQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.194]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeDMb-1uHogj0ti3-00agmO; Sat, 23
 Aug 2025 13:26:54 +0200
Message-ID: <4f230982-3108-4d6c-a165-ab85e7592b8e@web.de>
Date: Sat, 23 Aug 2025 13:26:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
References: <cb904f74-22a7-49e3-8999-34fc06b1054f@web.de>
 <5E6FF0AD-40B1-40ED-A0E7-47552B565E4D@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5E6FF0AD-40B1-40ED-A0E7-47552B565E4D@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DnF29OvV4bysS2sqDUMeFhoUTw183fhcJxX/w44MB6XLMmQ3KTu
 zKIJn8Ht1ABDk4P9Rv0mT6sV8mmmeI3wRdMjoc/iRYUfSKr2hJ1t0IrpeH7ZmfmtPji0b2w
 hQwgSFJKuDSzfUuEcJVloSqSp3sNJEWGQT0P4XcbeCTaXP+yLlaeKShcGgeD2sOaHzURR6D
 Y5LtD70namjNroTW/8b5A==
UI-OutboundReport: notjunk:1;M01:P0:V8JR3qQ6bsM=;CeVVgatknX2LMyy8f2Vh2AA5QWb
 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
Subject: Re: [cocci] Reducing the scope for a selected variable with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2978
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/4f230982-3108-4d6c-a165-ab85e7592b8e%40web.de>

> The when exists is what you were missing.

I would appreciate if the application of such source code search pattern details
would become clearer somehow.


> How you arrange the rest is up to you.

I see opportunities to improve related transformation approaches further.


By the way:
[PATCH] PCI: Reduce the scope for a variable in pci_bridge_release_resources()
https://lore.kernel.org/linux-pci/599e9acf-886b-4394-86bb-099e062c5b2c@web.de/
https://lkml.org/lkml/2025/8/23/136

Regards,
Markus
