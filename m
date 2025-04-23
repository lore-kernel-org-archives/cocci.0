Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D570C369CB
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 16:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gOYAltqxMUlpRjp4ssKS1jd4eneI5dfSiyhFRgDCStM=;
  b=TaTZYPV0i1VMlpQdkHWmPvXLSBvwXNwEeBztLDgkR69kNyqbIOlolGia
   YWbvMMUiweK/hc+waibDZrx254bFMwfej9EuxtdmxbqERmqRqzpD+LUhR
   WswpXP6pn/uaYo5yq/L/p+Wlpa8lmlKXqleSDPBzGfj7BWUVieGDOVosq
   8=;
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
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219154789"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 18:36:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 430BEE0D20; Wed, 23 Apr 2025 18:36:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 51BF7E0261
	for <cocci@sympa.inria.fr>; Wed, 23 Apr 2025 18:36:33 +0200 (CEST)
IronPort-SDR: 6809170c_RgRJM3hGzERkoKoyeX8JqTQeQ/MmIYM/HLJ+LKQkJByj9aH
 1L0eEtPuLgyOBZCtix9YuZX0l7XrPZeK/Kgn/hw==
X-IPAS-Result: =?us-ascii?q?A0FRAAB1FglogA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDgQNUMwQLSIRVj1CBdIRrhzuHU4h1gVWBfg8BAwENQQECBAEBA?=
 =?us-ascii?q?wSCDIJ0AhaLFwIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABATsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QCAQMjBA0MA?=
 =?us-ascii?q?QERJgEPCQIODAImAgICVAYBFAEBgn6CMAEDMQeVRJxFfzOBAYIMAQEG2lwfL?=
 =?us-ascii?q?CJXgWUJgRsuAYVsgmMBhWw7g0J6Jw+BVUSBPAuCeD6EQ4NbgmmCMYEXjWmQU?=
 =?us-ascii?q?VJ7HANZLAFVExcLBwWBJhAzAyAKNBQdAhQNEBIPBBYFMB2CV4IwT4ImghFwb?=
 =?us-ascii?q?AMDIgGDE3Qcg0OBJYQORC1Pgy+BBBBvThoGHUACAQttPTcGAwsbBj2WSp4yr?=
 =?us-ascii?q?1g0B4I4gWaBZAyfXgYQAy+XRg4Gkn0umFAiqROBbgcsgVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?YQzjwoBsk9BNTwCBwEKAQEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 TBdeF2oi31XhaI8/QiMtpKV9NwkUOvT8ggV
IronPort-HdrOrdr: A9a23:pF75wKOYgfHAusBcThWjsMiBIKoaSvp037Dk7TESdfUnSL39qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:NUHke22br/s40QH4nSugdLxfQNg9akzn9VjqKgzhGXplcv7PalHLwfYx
X-Talos-MUID: 9a23:92VTLgse8/HZhcapc82niBNADd9P4piUUGsnlawZ59jDHixLJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="115005616"
X-MGA-submission: =?us-ascii?q?MDGj7t5TgbdVHY+6MPEKip7RAp7vqTQ+7a13Pb?=
 =?us-ascii?q?OXFPmzwuFEUL+E9ikP/KNeR/XtOMueM92acNEY8qlpHGxKTtctuSIX0d?=
 =?us-ascii?q?NTK5wLGpngdQQR4vVL5oamjJkdb6Jy3Guoia0eNMIelLiNaAtp/Cyt8j?=
 =?us-ascii?q?QjCph5rL8is6Q4oewtOmNfmw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:36:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1745426154; x=1746030954; i=markus.elfring@web.de;
	bh=gOYAltqxMUlpRjp4ssKS1jd4eneI5dfSiyhFRgDCStM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kAQVfvirK/xjqkt14z8Flu0y+l+s16U3BxHcopal+hQ5iONTF8Ww4J9je/OjduPr
	 fa6rUGmv/VueRAR752FpMKCPNBsIRZJNsyYoxy/llXAmYVNZoq5dxbNyX5K6owmfy
	 Zl4zevGmaiyZ7rw4cFwHtUQLz+vbujig3f0gLTF4MmTA/mTOOqnk0d8LJ1Vj0/d51
	 TKEu9HY1j6FfKn9AM4/on4mjiFlnIw9NM2ruGxhJnW1FpxWYar2b3gCb1fq8w5VHr
	 9kjtweHlfDKM6Dn+qzqfAZKFZQw+Y02wgGxaG8lduRAQgeTI531o2btbwDIkNxxQ4
	 4cun2PHgtICQVuQ+YQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.6]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pYY-1uBSpY1UJK-00GTPt; Wed, 23
 Apr 2025 18:35:54 +0200
Message-ID: <43712874-6f1d-435c-98b2-30ac44d25309@web.de>
Date: Wed, 23 Apr 2025 18:35:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jie Luo <quic_luoj@quicinc.com>, cocci@inria.fr,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly <joey.gouly@arm.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Marc Zyngier <maz@kernel.org>,
 Nicolas Palix <nicolas.palix@imag.fr>, Oliver Upton
 <oliver.upton@linux.dev>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Suzuki Poulouse <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 Yury Norov <yury.norov@gmail.com>, Zenghui Yu <yuzenghui@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 "Kiran Kumar C.S.K" <quic_kkumarcs@quicinc.com>,
 Lei Wei <quic_leiwei@quicinc.com>, Pavithra R <quic_pavir@quicinc.com>,
 Suruchi Agarwal <quic_suruchia@quicinc.com>, quic_linchen@quicinc.com
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <20250417-field_modify-v3-2-6f7992aafcb7@quicinc.com>
 <a1be0efc-a4c9-461d-a01a-8fb830b2c68d@web.de>
 <0ee48e2f-58db-49b0-b651-dcc0e517465e@quicinc.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <0ee48e2f-58db-49b0-b651-dcc0e517465e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:lGmGLFuUIXdZtK0t76Y7z/TLyWEnsgb+nkpeau+LW99SAidKHeo
 9YY3J0b3cjOcIXGym7BNSTWEF4yiV5NHbHyVqJL0pHTKMJH8jJ5l9pjh+J/3gbQhXKDccEd
 3zocvbiemgMFiZGsMJEWv2DhzSY6g5MmG1/LS4KXQWwHQAyG8+2uECgBA8FxretNTCQgZL/
 4iRXjqXpDP9QI4K6qFhVA==
UI-OutboundReport: notjunk:1;M01:P0:3Sp7cn4vrhw=;tPPbn82Wxe3rJ06l7ddBGtnXHNM
 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
Subject: Re: [cocci] [PATCH v3 2/6] coccinelle: misc: Add field_modify
 script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2708
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/43712874-6f1d-435c-98b2-30ac44d25309%40web.de>

4oCmDQo+PiAtcmVnICY9IH5tYXNrOw0KPj4gLXJlZyB8PSBGSUVMRF9QUkVQDQo+PiArwqDCoMKg
wqDCoMKgIEZJRUxEX01PRElGWQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIChtYXNrLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnJlZywN
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbA0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICk7DQrigKYNCj4gV2l0aCB0aGlzIGNvZGUg
dmFyaWFudCwgdGhlcmUgaXMgbm8gc3BhY2UgcHJpb3IgdG8gJnJlZywgaGVyZSBpcyB0aGUNCj4g
ZXhhbXBsZSBjb2RlIGNoYW5nZXMgZ2VuZXJhdGVkIGJ5IHRoZSBTbVBMIGNvZGUgYXMgYmVsb3cs
IGlzIHRoaXMgZXhwZWN0ZWQ/DQrigKYNCj4gKysrIGIvZHJpdmVycy9waHkvc3RhcmZpdmUvcGh5
LWpoNzExMC1kcGh5LXR4LmMNCj4gQEAgLTI0NCw4ICsyNDQsNyBAQCBzdGF0aWMgaW50IHN0Zl9k
cGh5X2NvbmZpZ3VyZShzdHJ1Y3QgcGh5DQo+IMKgwqDCoMKgwqDCoMKgIGkgPSBzdGZfZHBoeV9n
ZXRfY29uZmlnX2luZGV4KGJpdHJhdGUpOw0KPiANCj4gwqDCoMKgwqDCoMKgwqAgdG1wID0gcmVh
ZGwoZHBoeS0+dG9wc3lzICsgU1RGX0RQSFlfQVBCSUZTQUlGX1NZU0NGRygxMDApKTsNCj4gLcKg
wqDCoMKgwqDCoCB0bXAgJj0gflNURl9EUEhZX1JFRkNMS19JTl9TRUw7DQo+IC3CoMKgwqDCoMKg
wqAgdG1wIHw9IEZJRUxEX1BSRVAoU1RGX0RQSFlfUkVGQ0xLX0lOX1NFTCwgU1RGX0RQSFlfUkVG
Q0xLXzEyTSk7DQo+ICvCoMKgwqDCoMKgwqAgRklFTERfTU9ESUZZKFNURl9EUEhZX1JFRkNMS19J
Tl9TRUwsJnRtcCwgU1RGX0RQSFlfUkVGQ0xLXzEyTSk7DQo+IMKgwqDCoMKgwqDCoMKgIHdyaXRl
bCh0bXAsIGRwaHktPnRvcHN5cyArIFNURl9EUEhZX0FQQklGU0FJRl9TWVNDRkcoMTAwKSk7DQoN
ClRoZSBDb2NjaW5lbGxlIHNvZnR3YXJlIGlzIHN0aWxsIGV2b2x2aW5nIHNvbWVob3cuDQpUaHVz
IHlvdXIgdGVzdCByZXN1bHQgY2FuIHRyaWdnZXIgZnVydGhlciBkZXZlbG9wbWVudCBjb25zaWRl
cmF0aW9ucy4NCkkgaG9wZSB0aGF0IGNsYXJpZmljYXRpb25zIGFuZCBjb3JyZXNwb25kaW5nIGlt
cHJvdmVtZW50cyBjYW4gYmUgYWNoaWV2ZWQNCmFsc28gYWNjb3JkaW5nIHRvIHN1Y2ggc291cmNl
IGNvZGUgbGF5b3V0IGNvbmNlcm5zLg0KDQpSZWdhcmRzLA0KTWFya3VzDQo=
