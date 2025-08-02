Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BE0C87FD2
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 12:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Yjaf2bybvlYQ1lsBLJpQrIsNP9HDMwGuxClGcTPCmJM=;
  b=pk+6gS/6KuSI7kfROUfBYQxnabdP7PAWsQdzyjKEmwo7Jqxu9sQDWbgy
   aJSN5FFdS55XP+jP5GkJUrMG8lkRWy7fi5XfhPnxHg35+H1FE0X6UAGxc
   aPz4bwWggpiPpR//wOU3Z6rq4m7DjrsxMnOddxH85lNOJ2AkSAQKYHZkg
   8=;
X-CSE-ConnectionGUID: 4P6cKB/LTaCA3aqtQTL1EA==
X-CSE-MsgGUID: 8xMAsn9iRzqLM9uzTxvhfQ==
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
   d="scan'208";a="233953569"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 14:02:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 63F18E0264; Sat,  2 Aug 2025 14:02:08 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A3DC9E0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 14:02:06 +0200 (CEST)
X-CSE-ConnectionGUID: yiLSWtRHRK+UVBsj21yf+w==
X-CSE-MsgGUID: T0DG9KC+Q/6HByvbajjT0A==
IronPort-SDR: 688dfe3e_j8IGPIyQGl7Z/uHhUrFVtJNEwR08Z6fD9aa1IJ4iGy+ElXM
 ldZguGnFYpnLMOlWziHMe/Irexr319/chVKN87A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E/AADc/Y1ogAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgQZUMwQLSYRViByHNIIkhDuHPIdViHmBVYF9Ag8BAwENTgECB?=
 =?us-ascii?q?AEBAwSFAAKMGgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABATsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECA?=
 =?us-ascii?q?SMdAQERJgEECwsaAiYCAlYGARQBAYJ+giIBBhABAw4kB7BagTKBAYIMAQEG2?=
 =?us-ascii?q?l4fLCJZgWQJgRsuAYVsgmQBhieDQnonD4FVRIE8C4JHMT6EQ4NbgmmCJoEWg?=
 =?us-ascii?q?2OPBoZuUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnfYMNgQ6EJytPgiJ1g?=
 =?us-ascii?q?XlBGT+DUx4GbQ8GgRUaHi0CAgIFAkNFgWAZBhpAAgELbT03CQsbBj2TVIMhg?=
 =?us-ascii?q?hUngSSWb5sJlGM0B4I4gWeBZAyfbAYTL4Nxk2EOBpMFmQYiqR+BaDqBXDMaJ?=
 =?us-ascii?q?IM2TwMZD44hhDO9Z0E1PAIHCwEBAwmFRgEBi1uBSwEB?=
IronPort-PHdr: A9a23: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
 UNgKVzQMokZcIH2iRUKVw==
IronPort-Data: A9a23:ptoXtK0RZlKE7gz/6fbD5Qx1kn2cJEfYwER7XKvMYLTBsI5bp2QAn
 2tLUG2FM6yIZmCneIt/bYvj9R5X75OEzoIyGgE53Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAhk/zOH/ykVbOs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82Ayaz18B56r8ks14ayi4GpA5DTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxlz8xCsmom6rMaUYDRLjfJ2Cm0hK6jID/6vTqjnVaPpcTbJLwW28P49m6t4wZJ
 OF2iHCFYVxB0psgNwgqe0Iw/ylWZcWq8VJcSJS1mZT7I0buKxMAzxjyZa2f0EJxFutfWAlzG
 fIkxD8lfxGnvN2q+pKBaapRuO44LpOyLY1cpSQ1pd3ZJa5OrZHrRqLX+ZlH0T12is0m8fT2P
 ZNDL2A1M1KZPlsUUrsUIMpWcOOAo3DlcCBD7n+Rq7A25Wf70wF7lrTgWDbQUoXQH5sIwBbJ/
 Aoq+UzFWj01Zf+0igPCrFKGl/HFlCH5ZNo7QejQGvlC2wHDnjdDV3X6T2CTqv6ygU+WQMNaM
 0VS+yw0rKF0+lbDZt30QBS8pFaWvxsWQdMWEusg6QjLxLC83uqCLm0DUyIHd9Es8sM7LdA36
 rOXt8LoIQdQrIe1c1Hey4m+tjHoYDkbbnBXMEfoUjA5y9XkpYgyiDfGQdBiDLO5g7XJ9dfYn
 GniQM8W2O17sCIb65hX62wrlBqAi/D0ouMd4wLKQiS64wk/aIPNi22UBbrzvKwowGWxFwfpU
 J04dy62srlm4XalynXlfQn1NOv1j8tpyRWF6bKVI7Ev9i6251modp1K7Td1KS9Ba5lZJWe2O
 xaN51MNtfe/2UdGi4coM+pd7Ox1ksDd+SjNC6mNMbKin7AqJVbWp38GibC4hjqzwBFEfV4D1
 WezKpr8VS1KVsyLPRK3QOEayvcwy0gDKZD7FfjGI+Cc+ePGPha9EO9bWHPXN7xRxP3e/G39r
 YwBX+PUkE83eLOlPUHqHXs7dwBiwY4TX8Cu85Q/my/qClYOJVzN/NeKke58Ktc0x/UE/goKl
 1nkMnJlJJPErSWvAW23hrpLMtsDhL4u8yxpDj9mJluyxXkobKCm6apVJdN9fqAq+KYnhbR4R
 uUMMZfISPleaCX1yxJEZ7nEratmaEuKgyCKNHGbezQRRcNraDHI3d7GRTHR0hcyIBC5juYEm
 I345DjnGcICYy9AEPfpbOmeygLtnHoFx8N3cUj6AvhSX0TOq7pVCjHDocI2B+ouKhzz4CSQ+
 CjLIBUfpMjL+5QU9vuQj4+6jo6ZKclMNWsEIHv+8pCNKjj8wmqv5aRiQdS4V2nRe02s8Zrze
 NgP6e/3NcM2uWpjsq1+Iu5N9r0/7d6+nI1q5F1oM1uTZmv6F446BGeN2PROkah/xrV5nw+Sc
 WDX8/l4PYS5Au/UIGQzFiEEMNvajeo1nwPM58sbOE/5vS973ISWWHVoYiWjtnZvE6tXAqgEn
 8Eap88k2y6ugEELM/GHrBxu2UaiE3gia5gj57YmWNLFqwxz0VxTQ43uOgmv6rG1Vth8GE0LI
 DiVuan8u4ph1nfyK3odKVWd3M52p4g/hxRR/VpTe3WLgoXkg9E07j1w8BM2bBhflSsf9+R/P
 llqak5HHoSV3jJSnMMYdXudKwJAIxy4+0LK1FoCklPCfXSoTmDgKG4cO/6H2VIwqUZwWyd9x
 66J7lrlXRLBXtDD7gFrVWFL8/XcHMFMrCvck8WZLuG5NpgdYwu9pJSxZGAN+iDVMeloiGLp/
 eBVrftNM4vlPistooo+OYmQ9ZIUbDumfGViY/VQzJklLFHmWgOZ+GaxchiqW8Z3Ofb131eyC
 JVuKuJxRh2O7nuygQ5BN5EcAY1fvaAP38UDSIPJNGRdkrq4rxhVirzy2BX6plcWR4RJrZ5gB
 KLXLymPA06Bt0tywmXtlvRJCkC8QNsDZTD/4tyLzfU0J8o9l99oIG4P0eqSnnSKMQFY0Qqek
 yHdaoT3keFz64ResLH9M6dEBgnuF9LXUd6M0QGssuZhacHEHtfOujg09HjmHVVyFpkAV+tnk
 Y+itIbM43rEm7ItQUX1poKkFZQV1f6tXeFSDN37HENakQSGRsXoxRkJoEK8FrBkj/Jf4ZOBa
 zajSc7ta+MQZchR9EdVZwdaDRwZLab9NYXkhCGlqsWzGgov6hPGIPyn5E3WQzliLAFQAKLHC
 yjwp/qKzfJbpt4VBBY7WtdXM6UhK1rnAaYbZ9n9sAeDNVaRg3SAh6DDkCQx4jSaG1iGF8fHu
 aj+fCbcTyjrmq/0z4B+ibdQ7y0nVCM3xaF6e08G4Nd5hgyrFGNMf6xXLZwCDYoSiSDoko3xY
 DbWdmY5FCHhRnJ+fA7h5Mj4FBKqbgDU1gwV+hRyl69VV8u3OG9EKL5m6zsm/Hp8PDfupA1ix
 Rfy5VWoViVdALkwLQrQ2hB/qfhqzLXWyxrkPGjjxtfqDU927aoijRRc8ckkacADO97AngPHK
 ADZgIyCrF6TESbMLCqrR5KZ9Nz1ct8iI/XEoBpjGOrihrg=
IronPort-HdrOrdr: A9a23:TgW8b6nmpBM5kE8TnkBlXNK0AqHpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AAVmzm2opeGqSpo2W+77mO33mUdEkVkbi0E3wGWz?=
 =?us-ascii?q?7NFhDU7/PEE6eu7wxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AaOLczQ9o2lrG1UWDV5QgwaOQf/swz4v/K2tOqNJ?=
 =?us-ascii?q?Ym+OVKyZ5OTWh1B3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="122656892"
X-MGA-submission: =?us-ascii?q?MDGPXx+9sMBLg8xgszFFNwYUmkVI+Dsp27FqQ+?=
 =?us-ascii?q?y7nCROA0W1Y82gpeC9JoSCRR1+czM+cMjyTGc0zRsoiI7ZpuZzNvS3wP?=
 =?us-ascii?q?HNbAv7TvktT6HoXWR8hVPzU/A+wTUXgV6AZm/7Uu+2KXUErQl5Axo/PJ?=
 =?us-ascii?q?d35dA665p4/qnSJxVyUNG/vA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 14:02:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754136125; x=1754740925; i=markus.elfring@web.de;
	bh=Yjaf2bybvlYQ1lsBLJpQrIsNP9HDMwGuxClGcTPCmJM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Yu6tbiJLmsBCcC4kboz1Y9JvaGo5ExJVyEY0nBOfn2IchkRqHhylm61eADT8pjwL
	 G34Zx1Be/uKnllkMcFiD2JLCGE3xABN4NZFIVGMGqQIHMtgYY35wS8HBwmHKLgek+
	 qCR9tTlg1dVKyd/Ql/DsuDsVgFNzqmkQESMV0chVXjEX54H2WzKWXWymYONGDayC9
	 YdOn6J7c0BYidNhToOlqwlzB05/T+/xH/uMu3sP481ivQxi6gEVyI304kX6e5pPjx
	 lzS+4Tu/pLKpA+8ykUQhKR6Xb7C+rEq1v9PiIQ1R4Fsy8w4K//2HVyHMxev2nYKrc
	 9HlEV00lzZvmZvJUXQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M43KW-1uiAw83HSC-00E1we; Sat, 02
 Aug 2025 14:02:04 +0200
Message-ID: <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de>
Date: Sat, 2 Aug 2025 14:02:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
 <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
 <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
 <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de>
 <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de>
 <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
 <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de>
 <alpine.DEB.2.22.394.2508021353080.3428@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508021353080.3428@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eplytln0bgyhQnY/M1EZ/ExnJe41jqd4l9IhY02byJVKh2xfds0
 YRGliD5grcnWxq5Q3SxmdpPdKEIXj1LSJhMNXAJ9HOFrZy8phEEWMgxyPLQZeMFdgrlqLUJ
 mwvxeisI+hKy+7WWHP2LX/06uU/B58hm1Cb7ySqb/socCSmoS3xEqzn9xZlo6EgCs/fR7z+
 aG8s1h6kNwgNvXGkYsQRw==
UI-OutboundReport: notjunk:1;M01:P0:ZWyF33XVi/A=;yiIbPPDH3q/wtBHWNIPJZw3EPcn
 +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
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2930
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/e0519749-0043-4cb0-a12d-6a34e2076f58%40web.de>

>> May I expect that only a single call should be marked for such a test c=
ase?
>=20
> No, I already explained why two calls are marked.

I see further challenges with this explanation approach.


> The shortest path constraint is that for A ... B, the ... doesn't contai=
n
> A or B.

This is generally fine.


>          It doesn't mean that the rule can't match at multiple places in
> the function.

I find that this information will need further clarifications.

Regards,
Markus
