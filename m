Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27308D3C52B
	for <cocci@archiver.kernel.org>; Thu, 17 Oct 2024 18:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=73LhArcldW9YWoGAUUDQD70Xc6UvchdZ6iaCXM4EhDw=;
  b=JveMC9XoQnLsFgu7W8FseZOUmBKb0X/AbtN8VZv0yFYaJex3UUKUNmdc
   H+WgaGOEx5TKOYbas7D0xhxSNuBpo1Rgvmmdn2Nm69ll76RtZxLQ0L0kR
   c054gjHkbAuEBPMIqOzVJa+RtTN0obNOdXoQThWQfRlroe46e3M38OXlS
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
   d="scan'208";a="189464889"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Oct 2024 20:20:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8F9AAE00B7; Thu, 17 Oct 2024 20:20:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 32C76E004E
	for <cocci@sympa.inria.fr>; Thu, 17 Oct 2024 20:20:52 +0200 (CEST)
IronPort-SDR: 67115583_wtd0vshh6W8cJmhBdZfQGrG4UK5PC+4khL40ZXt26GNnqb7
 Ooipi/YAHdtXrOBcuIHlqTtr93ybVxxku1r13kg==
X-IPAS-Result: =?us-ascii?q?A0F3AAC9VBFnfg4P49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YJDYiFUMwQLSIRWiB2JJIRrhzqQSYFWgX4PAQMBDUEBAgQBAQMENwGBVIJ0G?=
 =?us-ascii?q?IoOAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBO?=
 =?us-ascii?q?wcOCQExhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0YnEQwBAREmARgcAiYCB?=
 =?us-ascii?q?EkRARQBAYJ9gjABAzEHk1ecRIEygQGCDAEBBtpbHywiV4FjCYEaLgGFaYJIG?=
 =?us-ascii?q?gEFbYRnS4NCgSEPgVVEgTyIG4NEgmmSCYtqJYhRbpFQgU0cA1khEwFVExcLC?=
 =?us-ascii?q?QWJNYMABSEpgWuBH4JyCIE+gQYCgleBZwlgh2WBaYE+gVlHgRYGgVZKIYUYg?=
 =?us-ascii?q?QaCT2pONwINAjeCJCRcglGBJQQFhFMdQAIBC209NQYDCxsGPatOgkuaA7JHN?=
 =?us-ascii?q?AeCOIFlgWMMiQOWUgYTL5dADgaSdwEuhXOSViKjKoVUNYEyOoFcMxokgzZPA?=
 =?us-ascii?q?xkPjiGELcZNQTU7AgcBCgEBAwkBgVWDcAEBhwSBSwEB?=
IronPort-PHdr: A9a23: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
 MM3hsFjqReqn7vXotKIeAVDoHBHidDS1Xg=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:9I2DI6gLRmJx3qI/28cp69Kz1HBQXgIji2hC6mlwRA09TyVXrb
 HNoB1p726WtN93YgBHpTngAtjmfZq4z/VICOYqUotKMDOW3VdAT7sN0WKB+VHd8kTFn4Yx6U
 4KSdkbNDSfNzhHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNj2CJ5sA0+9jYDzra3GeqTM2fabQn/
 enjPZ6mw==
X-Talos-CUID: =?us-ascii?q?9a23=3AV3pXBWi+49iUNYwJnwmThD3B2zJuYnPh/Uz1BH2?=
 =?us-ascii?q?DEzx3ZZyrYG28179Aup87?=
X-Talos-MUID: 9a23:LhwPpwVewU9LnxTq/DPMpnZiPcJ22LqNCl4ov4k7sszfDhUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,211,1725314400"; 
   d="scan'208";a="99403864"
X-MGA-submission: =?us-ascii?q?MDFp/wREb9+J8TGpR09nSIiVMil53ygytFBb7w?=
 =?us-ascii?q?5aMVcm3wlz5/IGXdIIJJhQ4pRq1cJB5oSMeWzJ1u8eHoUq0sXjy+jYmz?=
 =?us-ascii?q?F/YM1jsh7bgRv64KZqNE9N5XNtMA8yhN/irlDxU2erfFlZlY3XxjDUQe?=
 =?us-ascii?q?m49HCAAYbK5/qzmPkZft3Fuw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:20:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729189236; x=1729794036; i=markus.elfring@web.de;
	bh=73LhArcldW9YWoGAUUDQD70Xc6UvchdZ6iaCXM4EhDw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SH7l+z/zURZCBEJf9HFg0Hv/Dot1gLZS6FOs17Wygp6Lz60cqRR/Xeos52Ex43BK
	 41ZViephgibZB9VuHzptkhJELAc3zW3cXEwNhPCQLO1vqFlCbkMiaMKAUmOCrH5HW
	 hzocWbtUShOexNSrWo1hnuYrg7e9DY6RjrpG6Ya5qX+COaz5lYqyt4rAyX9s23lS8
	 cM0cSpi6nnRHN3vMluVpxrirUY2fq8OOAjIeZz0ImXfo2ZaAWuPbobzfEpmkKt5uE
	 iqG2dby/pXQDl2Oa8FVzsKLzU7wMDjWJCCg7Hdp7PzelGoj63KnX8DgMwISpbpQnt
	 KUYRSnKjm3LVbhwy9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml46y-1tmyTI2g8a-00lUMp; Thu, 17
 Oct 2024 20:20:36 +0200
Message-ID: <e8bf7b33-01da-43fb-b71e-cd86a02be2e6@web.de>
Date: Thu, 17 Oct 2024 20:20:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel-janitors@vger.kernel.org, cocci@inria.fr,
 Peter Zijlstra <peterz@infradead.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:fOqmabauarM4Mm0Kro7lXPvx52ESGm/sJk6b1D08p6JdQW/nbQv
 UVgShpEpzfIYu/mwL9TtDcPXwyr0eE3HOG9odyw+wdkeca+biwkLt1xZwqIEWcIOpz+C3ls
 Bd2dnBF/Q5KwQOzYbKwgMK3LefW3AFmVzTrJ5wyjAq/bJc4VyLhz/3zBscOUNUgnMjpOeHg
 FNAyA8c87vZVpeiDxVDiw==
UI-OutboundReport: notjunk:1;M01:P0:0r16/UDSefQ=;vb1hmPlNe6FF75IEgSKo7ctn/U1
 REFo+KnZ3gxUr9FLZgIWhNBgFErED6zsiQvGSisfzelTOnpdrZ/hDEjXhimj+lslA+N4dQbIt
 3ittcJlDxpfmdWgM94ZfDbEIuwgqTMoO3VWKBpLPwbsuOuoq8IAF7XCzQkUPbRvp+5oTNJm1V
 TmOcvkEpA2IovhaqyOKHcNrVWuP8Z+ekKGyS/feFj5sqqiEMD3FlS146JfK9znxc/pIoQwxWC
 P+R1FUmzUNL/Y/EaEWUnx6fU/L43iLMyESirJEX+d4xovlRGnkRyrL877k6NqI972a4L5w7b6
 7wZRaMIqUk9nmIEz4qWQZoy+Wb22HO2OkE9UKBBYBBV6RPOL25/eB3eC6hB1mlDwVlK7fowON
 HmRIk4Q/s9IpslLKsvk/OdSNnVyhJiQu5kYSy+HnDrDg8rsksorq4GyiJ+Uslre2AMg0PWgjx
 yP19/Q9Tcf51k2IKicdkUbYS9vioX4hZM647uBmy1kTgcGpmNxkyWxYle7PUVukyvTMWsElpC
 EbCFC0ykZ+pUoovfJ/rzYUSB7TNUHWGx/ZciNJcsTlKstX05KhUx5hlS7oj81jbTS9upZQoFR
 tN1HNMfOhCZpN5yDBFMJtUUllcBExoeLRAcZw3u/2ba1SgzWAoPubeDAcqLAMwWnS2IHJ5x6K
 r9Wd0uR6S5HiIzK1Bh+AQMD0+UyxbH143UzKdfTBeqqxMo7zsy0PPt3OCrE3tGWU3YC8q3Ige
 4LK4AB3caWjv7yNPJRQeQ88sJ/snnQHoF/MycZ/T5y6Oz+qX2F6Po9c1ccFM3LwNzKJ8QEgn7
 dGnGOPdfv5x6Yi2ZXxAVgNFw==
Subject: [cocci] [RFC] Growing usage of the attribute =?UTF-8?Q?=E2=80=9C?=
 =?UTF-8?Q?=5F=5Ffree=E2=80=9D=3F?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1915
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/e8bf7b33-01da-43fb-b71e-cd86a02be2e6%40web.de>

SGVsbG8sDQoNClRoZSB1c2FnZSBvZiB0aGUgYXR0cmlidXRlIOKAnF9fZnJlZeKAnSBpcyBldm9s
dmluZyBzaW5jZSBpdCBiZWNhbWUgc3VwcG9ydGVkDQpmb3Igc29tZSBwcm9ncmFtbWluZyBpbnRl
cmZhY2VzIGJ5IGNvbnRyaWJ1dGlvbnMgb2YgUGV0ZXIgWmlqbHN0cmENCm9uIDIwMjMtMDUtMjYu
DQpTZWUgYWxzbyB0aGUgY29tbWl0IDU0ZGE2YTA5MjQzMTFjN2NmNTAxNTUzMzk5MWU0NGZiOGVi
MTI3NzMgKCJsb2NraW5nOg0KSW50cm9kdWNlIF9fY2xlYW51cCgpIGJhc2VkIGluZnJhc3RydWN0
dXJlIikuDQoNCkkgd291bGQgbGlrZSB0byBwcmVzZW50IGEgY29ycmVzcG9uZGluZyByZXN1bHQg
d2hpY2ggY2FuIGJlIGRldGVybWluZWQNCmFsc28gYnkgdGhlIG1lYW5zIG9mIHRoZSBzZW1hbnRp
YyBwYXRjaCBsYW5ndWFnZSAoQ29jY2luZWxsZSkNCmJhc2VkIG9uIHNvdXJjZSBjb2RlIG9mIHRo
ZSBzb2Z0d2FyZSDigJxMaW51eCBuZXh0LTIwMjQxMDE34oCdLg0KDQrilZTilZDilZDilZDilZDi
lZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDi
laTilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZcNCuKVkSAgICAgIHZhcmlhbnQg
ICAgICAgICAg4pSCIGluY2lkZW5jZSDilZENCuKVoOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKV
kOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVquKVkOKVkOKVkOKV
kOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVow0K4pWRIGtmcmVlICAgICAgICAgICAgICAgICDilIIg
ICAgMjQzICAgIOKVkQ0K4pWRIGRldmljZV9ub2RlICAgICAgICAgICDilIIgICAgOTQgICAgIOKV
kQ0K4pWRIGZ3bm9kZV9oYW5kbGUgICAgICAgICDilIIgICAgOSAgICAgIOKVkQ0K4pWRIHFjb21f
dHptZW0gICAgICAgICAgICDilIIgICAgOSAgICAgIOKVkQ0K4pWRIGdwaW9fZGV2aWNlX3B1dCAg
ICAgICDilIIgICAgNyAgICAgIOKVkQ0K4pWRIGt2ZnJlZSAgICAgICAgICAgICAgICDilIIgICAg
NyAgICAgIOKVkQ0K4pWRIGJpdG1hcCAgICAgICAgICAgICAgICDilIIgICAgNiAgICAgIOKVkQ0K
4pWRIHB1dF9kZXZpY2UgICAgICAgICAgICDilIIgICAgNiAgICAgIOKVkQ0K4pWRIHB1dF9jeGxf
cm9vdCAgICAgICAgICDilIIgICAgNSAgICAgIOKVkQ0K4pWRIGZyZWVfcGVyZl94YSAgICAgICAg
ICDilIIgICAgNCAgICAgIOKVkQ0K4pWRIHBjaV9kZXZfcHV0ICAgICAgICAgICDilIIgICAgMyAg
ICAgIOKVkQ0K4pWRIHB1dF9jeGxfcG9ydCAgICAgICAgICDilIIgICAgMyAgICAgIOKVkQ0K4pWR
IGtmcmVlX3NlbnNpdGl2ZSAgICAgICDilIIgICAgMiAgICAgIOKVkQ0K4pWRIHNuZF9jYXJkX3Vu
cmVmICAgICAgICDilIIgICAgMiAgICAgIOKVkQ0K4pWRIHg1MDlfZnJlZV9jZXJ0aWZpY2F0ZSDi
lIIgICAgMiAgICAgIOKVkQ0K4pWRIGNsZWFudXBfZGF4ICAgICAgICAgICDilIIgICAgMSAgICAg
IOKVkQ0K4pWRIGRlbF9jeGxfcmVzb3VyY2UgICAgICDilIIgICAgMSAgICAgIOKVkQ0K4pWRIGRz
bWFzICAgICAgICAgICAgICAgICDilIIgICAgMSAgICAgIOKVkQ0K4pWRIGZpcm13YXJlICAgICAg
ICAgICAgICDilIIgICAgMSAgICAgIOKVkQ0K4pWRIGZwdXQgICAgICAgICAgICAgICAgICDilIIg
ICAgMSAgICAgIOKVkQ0K4pWRIGZyZWVfY21kX21lbSAgICAgICAgICDilIIgICAgMSAgICAgIOKV
kQ0K4pWRIGZyZWVfY21kcyAgICAgICAgICAgICDilIIgICAgMSAgICAgIOKVkQ0K4pWRIHBzdG9y
ZV9pcHV0ICAgICAgICAgICDilIIgICAgMSAgICAgIOKVkQ0K4pWRIHBzdG9yZV9wcml2YXRlICAg
ICAgICDilIIgICAgMSAgICAgIOKVkQ0K4pWRIHB1dF9jeGxyZCAgICAgICAgICAgICDilIIgICAg
MSAgICAgIOKVkQ0K4pWa4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ
4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWn4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ
4pWQ4pWQ4pWdDQoNCg0KSG93IHdpbGwgZGV2ZWxvcG1lbnQgaW50ZXJlc3RzIGV2b2x2ZSBmdXJ0
aGVyPw0KDQpSZWdhcmRzLA0KTWFya3VzDQo=
