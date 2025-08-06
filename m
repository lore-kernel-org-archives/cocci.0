Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A300FC87FD3
	for <cocci@archiver.kernel.org>; Wed,  6 Aug 2025 09:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ia+82nZXTy2Z6wsPx6owlm6W7WeVBWddouqoOJ9HLtU=;
  b=G1Wuiz59Ex1LFXPFMajLiq4CwGNjKQmUFt9lhZ3bJdBzGmYI3j358ajD
   Hdg/kWmxYk6UWwm/kzzBH0b9JLsdv/wZDmUnRbFoIa0Ypb97nAq7FaGod
   8fLYKoHAptCx+Aksf1NxKmieWfmfdDHMSLchbEARispiHsETlWZLUmNag
   I=;
X-CSE-ConnectionGUID: w4YOLFl0RW24slTKCGaknw==
X-CSE-MsgGUID: jJhhSVSBTAuWRrzP2Lsm+A==
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
X-IronPort-AV: E=Sophos;i="6.17,268,1747692000"; 
   d="scan'208";a="234329525"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Aug 2025 11:30:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0E9DAE0C55; Wed,  6 Aug 2025 11:30:32 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1929DE0171
	for <cocci@sympa.inria.fr>; Wed,  6 Aug 2025 11:30:26 +0200 (CEST)
X-CSE-ConnectionGUID: xR3SqmBZQNGLqY2YJQgTfg==
X-CSE-MsgGUID: bmGW14oYQai61Xv98dZ8Lw==
IronPort-SDR: 689320b1_9iMN/R1VFOGOzEYTrzu1yKZXr6F/QCiecNIjYAQoU1LhftC
 CgSjnsQ4CMc/SaZSnt803D1kNovnsyUtlHbE+Wg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E7AAB5H5NoewsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYI/gQZUMwQLSYRViByHNIIkhDuHPIdViHmBVYF9Ag8BAwENTgECB?=
 =?us-ascii?q?AEBAwSCDIJ0AoweAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBQg4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEXA?=
 =?us-ascii?q?kdEAQEBAgEjHQEBESYBBAsLGgImAgJWBgEUAQGCfoIiAQYQAQMOJAe2U4Eyg?=
 =?us-ascii?q?QGCDAEBBoJp13UfLCJZgWQJgRsuAYVsgmQBhieEPCcPgVVEgTyBFIFvPoRDg?=
 =?us-ascii?q?1uCaYImgRaDZI0FiQBSeBwDWSwBVRMXCwcFgSBDAyo0MSNLBS0dgSd/gw2BD?=
 =?us-ascii?q?oQoK0+CInWBeUEZP4NTHgZtDwaBFRoeLQICAgUCQ0WBYBkGHQYSQAIBC209N?=
 =?us-ascii?q?wkLGwY9k2OENkyYbq5igQo0B4I4gWeBZAyfbAYTL5dSDgaTBZkGIqkfgWg6g?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OIQwWhBG4YUE1PAIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 klQqVsXBZsePMv31h47ArGftJvHEQzcUIIVyhA=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:AdvS0K9e8Bc0dXXB/cFuk+AMI+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re+8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNSftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:G4iDIm5fTngkycKyNdss5HRPIdkgWE/k6lj0On7iOERQR4GbRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3Axy1Gdg8XBXrc8nvHcy1kKbCQf81tzJv3VEc8qJw?=
 =?us-ascii?q?H5ZC0K30gNwXNqCviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,268,1747692000"; 
   d="scan'208";a="234329509"
X-MGA-submission: =?us-ascii?q?MDG4aKbqdH5erTh2Qxanb9zJGYdcsYttIh9kdf?=
 =?us-ascii?q?zOkMktYfGIIqqPufg9x3kb6KX4/eLPD4NM47gH6u/eMszaDHqOqzLdmm?=
 =?us-ascii?q?+TnJj59eoin1+1s+3/ewxQY2mee9ME+fSMPtYvzcfKg5YtRAaw90g8fB?=
 =?us-ascii?q?90eXaYzuSpMgo5HX9CfFKWpg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 11:30:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754472624; x=1755077424; i=markus.elfring@web.de;
	bh=ia+82nZXTy2Z6wsPx6owlm6W7WeVBWddouqoOJ9HLtU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tA7hkm9/KjgYQ4wiLPztqPU+wHAf7M/HjRxroFhWJFCUZWBkfAF5A7hWUtrfffvU
	 nUMRB9aMMiVXaLVaqwdBnnKQ/R1IEXhkjNIAmR5ldAps+yC18/293JMHhQenIQU2K
	 0p2JBTIKNtCq1GZWhaHxj24B4X7IvWzj2xhis06dBukNT6/5U9E2sAygwdDoVKEzJ
	 O2gCpPNTeCtuS7mvE2h3bPG6OYOO+Rg+cBKljlxPAAeVo+z9Z2DSTpzvpM2d62Yp1
	 H/O1zvebjeWCUiDbdmqmG2cFNWxAz/nmOU98WO1zcXFIcd7MfXVMr4VBLQT0ih4cV
	 ZjAAlwnO38GBtDE8Lg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBSB3-1uuqLP0PS3-00F0N3; Wed, 06
 Aug 2025 11:30:24 +0200
Message-ID: <cb783d18-929f-447f-ba08-98e015f5ad9b@web.de>
Date: Wed, 6 Aug 2025 11:30:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
 <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
 <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
 <6373a5a7-15b5-473d-a628-c385f12d4e26@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <6373a5a7-15b5-473d-a628-c385f12d4e26@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J2ai83Jfmg7IRsAswlvfx+AfZul8KzA0sSymHJYjrEQXSuiboKo
 2b8zBPrlrZjKINmHUv7VrX00ACV7iHvfGvHDyGtKQx0EQMzvQPl3091tdDtiBM5ldZcFlGX
 8goJkHQfWNXr9aroyPLEPjrHzvlxj7YYKEXMNZxExz9KVBzbSqk/yGRVij6KRZ7a8jyu7Lf
 bVLS0J7shuHkIm4m85orw==
UI-OutboundReport: notjunk:1;M01:P0:ffzE9cw5aPo=;4Ol3lmfmyEbOQ/Z8XVpyk0GHHu9
 KaLKVqrxnj2yUSZnLlLniVh/eaFQPqHzHtX44iXl32Nv0PqtfPFOMfaHu76Co32EUUm5JGqJO
 1vk7mFEmQo0fGpUrPQukkAssXGie4/QKJzxOe3W7ubwQxO5yhxm+EKAjSBnhqxCjDeluAHz8f
 CURZhPQy+jeirTwY34yg/s8OlZqZM9seyGkhuBNgyY3wv842k8JM+WlQR1JoWbzwqdQTDNZmA
 iO45Tbj5dtswAwDZJ8GuSWWLUmiN1K3pceoywI/pYhTNeLzAYCNrcd0NhF8HIXOWRFDU6uvAk
 zfCAJYXpNqCq2dznWQBKQDADkv/RFicB5gSmLlTi5Z8Vra9noJr+HVUMJ7W5A1ukMz3bEdNFb
 mWevpnq40T/5BYrM45nSLWjG23DG8vgFOogWPoEOWd4Vju4HbObS/0S0qFT76HbNqeJwjCDvX
 DqQt3YF1v2g+gFbD/49GYBcgbkjkYtxeInB1E+d6PIrNMAcPeotnfUfnnCrjgMY9odHQP8AhS
 1/duRswXFOdSRiy9hQIemu8zFsogOWfqy6XLzLFaw87P2kmzdoXpBZfTEYJaaYQHOCAUKK49h
 mh0mNVkZesAXkqCHtTAqZcB3NiJNU7EHNhc/gv+vfBcPuqePe2mM50+z8qYt9Mt8mX/UHSdjD
 ygjeDixoU8YpNEhqOycCXk2RcDhhfaTGyaQ+XO/tpLvbbGTgI6masSjh0Cy17TM19HTZ0qczx
 lmFR6dyp/Do7pqusqpKqCkx+eobsg6re6rf04z/PDpzcFtr8SYokn/FSIULgjsXJmrS27NM2O
 ZAHcUqv00JtnpbhPGoCl62qZasY5I/UNJ54N1uxsf8IlNt8Wrk9g2x+BlTnwA0f2t5HAO7jNc
 G2uLEs+p7Y9/+lVPPOl8uEjjSIjJn3ssAc5alGgELm2DxVt+ZEfTOiFf4Lh8Tt1W2YTrK/WFz
 eaejqC32A144aUk8Q8kreWNH7bsFIa03XDfi5ixj2/Xnq+e5Y9/suwmIRiM5VyZNSai1bkT+A
 /n08OZN1ftmcu2GxVgA/j5YXicPKuO/vQfr771O1iH5gn+eF9SotjXJCj9oSN5/fTFWaG674E
 AGLtZ/Vl6DtuW83q/uoUwsbxgi+AMX9OVhDnBeUU3vsWxJpYP5thc91mdlu7GijjRzWmUMan1
 MCnevvnm1iA4+6z3LT2ZLAIt9GoWUN0PSYoIhI5i/5pFNaWpjzBn4kBjkFjUu/yjA5SJRsxOD
 CqIwdl1iAIOZSaLdlwLgV3XWUtwXjwxw0BmVJDslQJ60OAg6GGijQ8qlU12ut2xqIGg1E3EsX
 i45CdmScCExCRLdZo+iS+THe59fYaF0WnfQZ9DB3CURQzv9OU7EFkO1ww93sA71iDX8Bkvhqa
 R/SB4hcD3J4S3IWumviuOxyhMtnwF23+nv0kJSi5btBy723XQwdfI30hUd0I2OgaiXrfE4j2P
 ZIRfPvT8VtawEUfnN3XlFu4/KyJxTsY7B2mQXbjNyPyC+Z+1gh3m1YmXuEfcIApA0k7ICJuFc
 U0A92uOKoZK9KYssrTSTMCmHxabFONRxl1pQQBtUVdnbO3MKRuOPm1LmEJ7Nx3iWxzMs+awXz
 kAo0JOBEm26AChxLk8dVdH5uSUwpTo/LQ1I8fLIY7cvcn0ZjtLFkIVRxlQpkKV/1P6wBCwZpW
 /vm6htFT6xcil/if9ZnxMrbf/7g7Ldt5cwXmBTV7Mxdl8LKJSg4PzVi7J3odFNLdwyTw1dHPh
 vOnERbt2DF/FbQxs+ZtGytiG3fABvoJBZ1Cjo65E2peKvVKgHTBvU74aQJK18bylRM4yJmdm3
 6zBZsFpZMadqtSBQPVMcjiNYpqF1WpQ8B1FiG5+HKOCcJ2jIV91eOxeW1qd2ThqcCw+UDM7an
 QG5Bkh8HbuOJ1CJtTAKMWFuGTRobTU4F01HWPRPSsEt6BOTAYyMWTzNSpJG4EZ9Mv7JqHR2Jw
 hE2q6BMV6IYN6CjNZdHhROromHtxIntUWCn3QLJiWLFPk0HzPSs8+48f4ivsL9QTU5ZE8NSaI
 Dx8+HUMTUA2uaj5j4J5ioKlkcUViwdJs83Cuo3CPiDfGYlni0HWvm2Bm92xThqmGi6dFZFqzE
 IENv41/s9Yv/WkhxUOenBi/BDdeNmTBbbvOZ5GDrIrwTXroE0zMS0SDFsEWS5gHHjTYCTkt5T
 PwyuHeDXzQOgBeJ/k7WZWiDRwUe4wYMsl9TaLFBYzP7iOsvaruqAyDekYnQ1npGBSImUFUwm+
 FBz2zKUQ5LmrHkTnyYdkTG9wi1NPjTnZ5+4mjgA830yoynoSRPHQHGUthlWJMOzB3B0qBvcZk
 VwhvBES6quVLuTl2ix9W7mx0elaKf5SLbghc/IRuh56lOwHS1xUugZFAqZy9zqKsN8KKBpfdU
 dmznUFTAHBieoO1SrNJ6lL0nIxYMW1nJv5ENOcsh02AvwE1ShCl5FeYWMFIj6SF55y3a7gqhC
 8rxBkS5kLJ1fe/eWWwxy0cDeD5qc+CXqdbYOa+BGJgTdmT3vhh64c6n2RHaM/jabXhFOj0jt3
 HJZ4I3zlpL4ZFYkdndXH9Lt9ejVYZtwGLfvzouKKmxFwr1p86n2r3LEPfEKoPqlgKFOv4DdZK
 yC3H07nHsZWFg7nEktdAEz3kfigmF9T6Rjq2QUo9JHuGtTANsStaos9vcebKykU0kLSb6WmYb
 RDDS3AHOVIWpAJu/LWFKmWNcCEHaUey3fxCfiX/RCUta5DhDTxKPhkKq0HIciR3DEYVwu9ake
 K5ByBVXSGUqr4z/70MipAtoG01cnSEZxksvmRR7rJAn6YU/HMq1nPi1FUhw9LTUPneYlV1LwU
 TBYZaxlUIIDibYavVKqn8NaUIRav+231BQbaO6PqIyqsu2wHoiqweUiTF/Xta+uJv4+iWydur
 X7hwgiyQWO6q0CJwvhmzNmgiXd7NmsXdKi4njd6XZazHVNPgeMAFfPm5knhl8trDpYqBDTQvG
 kEgZFVAcF5ohDU2ea+uTHoYX1wiudFdwY+LSdLYgQhit/Nk/KTGzhJtd8E2/GFLAP8C4HYcxB
 oR0xQgcIdFsNL47jDw2bK15GXPZRw+mYU2BUmC81LQCUQt+xr4R3KQWqB/clldbKptmUj2Gmc
 PP2vo4nIGs96cSlPYB0Tvu04vszgxQzQ2WPhOrlgooLhNYPP2ZZdcT0Y0P/Zg3WoZY4gQgB88
 A14RK5CUQu32XAinKUrMzbXm7vG+4e0aUzom0cdQynmqd9a5VdOKU4vzYsX8OOSJ6Scw3UqmA
 WXrQYThVYHUf21hCrU7Him/UuVccUYZEgLSxnN8pIXTKQfMVOzowWoyyG17CkN/6NGUOBZEb7
 zjeKkzRJ8DsFQprrZGMHyczzOZJdzjX6mOVHlqYeIcm8tlMej6ISLDkt0Rx7g+nMSoAeMFJ2M
 dLLHvpkSARX4G4tSv/ZxaT2eKkFH8By8ADKCi2/XEt5KBRzWmN84yCVvCe5KzktCr5Rqs/2FY
 8mBBR4w3VsB2Nb2llbPFRvsG253w6ZX2Mlh9vr4BkKdv+4WuuSkVz5PcS8RCHYZsSQ0On+IZd
 CDze7sDQNrX+J0O/8dS0SR+x1uEXD0Osq2dxqiFxuagR
Subject: Re: [cocci] Searching for repeated actions (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2966
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/cb783d18-929f-447f-ba08-98e015f5ad9b%40web.de>

>> What is the goal of using <+... ...+> ? =E2=80=A6

Another source file example:
void my_action_repetition(void)
{
 my_action();
 my_log("once more ...");
 my_action();
 my_log("repeated!");
}


Another SmPL script example:
@mark@
@@
 <+...
-my_action();
 ...+>


Probably expected test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
../janitor/show_repeated_actions3.cocci test-repeated_action-20250806.c
=E2=80=A6
@@ -1,7 +1,5 @@
 void my_action_repetition(void)
 {
- my_action();
  my_log("once more ...");
- my_action();
  my_log("repeated!");
 }


> Would you get into the mood to clarify data processing challenges better
> for another source code search pattern (like the following)?

Another SmPL script variant:
@mark2@
@@
 my_action();
 <+...
-my_action();
 ...+>


Questionable test result (by the software combination =E2=80=9CCoccinelle =
1.3.0=E2=80=9D for example):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
../janitor/show_repeated_actions6.cocci test-repeated_action-20250806.c
[no diff output]


How will clarification interests evolve further for this issue?

Regards,
Markus
