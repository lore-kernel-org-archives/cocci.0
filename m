Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CC9CCFA18
	for <cocci@archiver.kernel.org>; Tue, 11 Nov 2025 07:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9GTvRfjhYAGiubFz5OzoFE3mLHHXPsmwW23MHZS3JEA=;
  b=r2TfuSSksu+rTdXG46jpTER43B0IYtEl/DZUGdQ8V90V746kF+hVoUBF
   R5BQlhYlb45LcvVTJHWQWvY2ZV94BCD1LWLgqahU+CpXtDON52F6JPX4R
   0FJDPKuhwkrvtGLuy+6IP5VXfnLr6P3aWTzhUCK9msw8vNaeErURgjqND
   E=;
X-CSE-ConnectionGUID: 3pYGlMTzR86nSkFoxDRQsQ==
X-CSE-MsgGUID: ZUyervEATxGWcfo+r9boYg==
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
X-IronPort-AV: E=Sophos;i="6.19,295,1754949600"; 
   d="scan'208";a="248558553"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2025 08:06:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D4CF3E0BE9; Tue, 11 Nov 2025 08:06:12 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D155BE0171
	for <cocci@sympa.inria.fr>; Tue, 11 Nov 2025 08:06:06 +0100 (CET)
X-CSE-ConnectionGUID: +uDwxwMPSjytHBupp3CPgg==
X-CSE-MsgGUID: Hq+nbOENSyuzrYycBqI90g==
IronPort-SDR: 6912e05e_fP8ph+/OanFZhjmfAShuwmzWi6CF1kCuVu9ss8KuwMZD8Dn
 pcd5XkHE9Qi7iokPO3q59Nncdx9MBJASbURiRiA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EbEAAN3xJpeAwR49RagQmBUIJAZR0GWDMEC0kIhE2PU?=
 =?us-ascii?q?4ZfjxGKToF9Ag8BAwENRAoBAgQBAQMEhQACjFsCHgcBBDIHDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAUMOCjGGTw2CYgGBJIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQINOkQCAQMjHQEBESYBDwsaAiYCAlYGFQEBgn4BgiIBBhABA?=
 =?us-ascii?q?zYHDQawMoEygQGCDAEBBtpfHywiWYFkAwaBHC6FboJlAYlHJXonD4FVRIE8C?=
 =?us-ascii?q?4J4PoJhBAGBXYNbgmmCJoEOhieTNlJ4HANZLAFVExcLBwWBIEMDgQsjSwUtH?=
 =?us-ascii?q?YEkIh8YEWA9F0CDSRwGaA8GgRIZSQICAgUCQDqBaAYcBhwSAgMBAgI6Vw2Bd?=
 =?us-ascii?q?wICBIIZfoIKD4lmdwIBC209NwkLGwY9lROENALIejQHgjiBZ4FkDIoulT4GE?=
 =?us-ascii?q?y+DcZNhDgaTBZkGjgibOYFvDiWBXDMaJIM2TwMZD5IhM75pQjUCATkCBwsBA?=
 =?us-ascii?q?QMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 alMKzrOAb5c3eMISA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:7RqsRqlLDAL6KPRK1a6512slNmzpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:KWwpUG+IO0avVrHJnPGVvw0JNt81bVjl93XBP2+SFH5xE5atRlDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A1FKw8w0keU1KdpAo/VdxIkjvmTUjw73tDkoqvLM?=
 =?us-ascii?q?9qtSWLx1hMB2ErWXvTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,295,1754949600"; 
   d="scan'208";a="248558548"
X-MGA-submission: =?us-ascii?q?MDHfZ9LZEv09Q5qeRS22dVUDgH8t8IvkQTjhmO?=
 =?us-ascii?q?KrezGxzTwKoTHq3yQvYdF6l7uWGoOUpBdcsD+/zhLfeAKF65Dr4sSvo0?=
 =?us-ascii?q?26FLJORTmMdtNI0j5Fokcqp9cLc/l1q7kVwrPJovX+/sLqcsENd+g80p?=
 =?us-ascii?q?6z2kqHeXnjYPaQ4l2Jlh/0ZQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:06:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762844765; x=1763449565; i=markus.elfring@web.de;
	bh=9GTvRfjhYAGiubFz5OzoFE3mLHHXPsmwW23MHZS3JEA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=m50BIYc7ImdkO3FC94HGQDJ1kQNlQfPaZSyH2VSNVrdWbxK1vo2q8ft1RvXLMIGt
	 siAOLjN9/3ccUdeYR5WRAnwsgb9Hl69Wf4Mi3WvAiuWHFj1uzhpniAbdZsRclnJih
	 BeMfGWhr4Hn0xJgU1IT3fbvSS31XAF/NiqrCWzsbVQfFkhhkuF+SdgttBk2txWPrp
	 /jAlUNIPl+55p07D53A5UJR3qB+DuCts6RyLoviHzDEk28oZzmP38Q8YqCpV02zrL
	 aik0myTHZKa/P5bXilKW0KJZmUmUH5kuINs3wwTaou3sRa3HoQt5MU5kYFa0o5idP
	 C1qlH3lcjUSFnYL22A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.1]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8Vsx-1wDxuO1VUv-015lZ7; Tue, 11
 Nov 2025 08:06:05 +0100
Message-ID: <cd413c87-f5d2-4706-ad87-652075f39eac@web.de>
Date: Tue, 11 Nov 2025 08:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: cocci@inria.fr
References: <a2551ccb-edd1-403c-bcd6-3f9cd5381bcb@web.de>
 <338F2B21-0F98-450A-BDA0-6F7E4F22F9FD@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <338F2B21-0F98-450A-BDA0-6F7E4F22F9FD@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A5GgXYlA9McI6MYVqbfcOoJ+kwHv+D4I1oQOO6alPtLm7Usuprx
 q8l0LLY5C3vqaqXspH35XojwaF4e9zWb4L1zdsIvDBBStqFN6QQfqzbWUKfXo/0C1Z6Bf3j
 /y4OlRFEAVp18FQ//0HAyXL1s2ZqumZAjml2NtMSetBngIuiH6saADBppOMA+cOk8OVGNAc
 G2Z1Yso9lSGI64WzrQ3bQ==
UI-OutboundReport: notjunk:1;M01:P0:GwXKrdMD3ng=;3J8Oo8vew0jqlBLMaST9zDNdYSD
 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
Subject: Re: [cocci] Moving string literals with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3158
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/cd413c87-f5d2-4706-ad87-652075f39eac%40web.de>

>> // See also:
>> // crypto_rng_show()
>> // https://elixir.bootlin.com/linux/v6.18-rc4/source/crypto/rng.c#L82-L=
86
>> @adjustment@
>> constant char[] last_literal, literal;
>> expression context;
>> @@
>> -seq_printf(context, literal);
>> seq_printf(context,
>> +           literal
>=20
> Why is there no comma after literal?
>=20
>>            last_literal,
>>            ...);

I would like to use adjacent string literals here.
https://en.cppreference.com/w/c/language/string_literal.html#Explanation

Regards,
Markus
