Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9C2D3B7EF
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 08:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=giSZWBGE87EKufGjJR2a2Lg1nqjg7X2LUyqW+g6O+Bs=;
  b=PZ9eklMuLfeKDuJVSPzJSc+9j4F4ygGcKvrRKomCnlRcC7ME/5wRCLch
   3MXkhcJubRJHQQUJbln3n/ZV9d1yd64hLagvBy5SplbBn6MS5in7PnugD
   rU8WHG+Ch1lH5I5t1uIt9lf7wh6xi3C1wP/ykcB/F82BlpTS/UO5BMWB7
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="195574770"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 09:40:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 58492E0D1E; Mon, 25 Nov 2024 09:40:21 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 30DE0E00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 09:40:17 +0100 (CET)
IronPort-SDR: 674437f0_QuzW/P1r/Udcdjj5A33gGKHMnl0QN79JM1pstOGSON9Q0WC
 R3XlRTDqc4khHLrFKs5Y9VzogcQx7nka0+JgKLw==
X-IPAS-Result: =?us-ascii?q?A0FUJwBINkRneAQP49RagQmBVYJCgQNUMwQLSIRWj02Bd?=
 =?us-ascii?q?IRrhzuHVoh1g1QPAQMBDUEBAgQBAQMEggyNTwIeBwEERwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEQAQEFAQEBAgEBAgQGAQIQAUMOCjGFew1JAQEECwGCAIEsgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAkdtHQEBESc0AiYCcwEBgn2CMAEDMQevcIEygQGCDAEBBoJo1?=
 =?us-ascii?q?3MfLCJXgWQJgRqGGIJIGgEFbYoVD4FVRIE8iFGDDoJHIoJEgTqLbSVXEYN+i?=
 =?us-ascii?q?VKET4kUgU0cA1kyAVUTFwsHBYF2A4NGgTaBUYMRSoJPgj2BA4JKaU03Ag0CN?=
 =?us-ascii?q?oIkfYJNgSUEBYNrhGmEXoYGHUACAQttPTcJCxsGPZ93gWOHM5NBkSChNzQHg?=
 =?us-ascii?q?jiBZQWBXgyJA5ZWBhMvg3EBk1EOBpJ6hTyTP6NShVaCIYFcMxokgzZPAxkPk?=
 =?us-ascii?q?k7HDUI1OwIHCwEBAwmFRgEBhx+CPoILgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:9Lxn5qtTluPUh4M+W4zhVlCzeOfnVGhaMUV32f8akzHdYApBsoF/q
 tZmKTjVbP7YMTH3eop+Ydzk9RhQ7MTVm4NrTVBrrik8RisTgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNscpvlDs15K6u4WpC4gRkDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJEUYONA/qt18O11D8
 N8GBRYpa0CtrdvjldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaGeOQv4AehWp22qiiHt6GD
 yYdQR9mdhfdeFtiPlkNCZQxtPiljD/zflW0rXrM/fBquTKLnFIZPL7FLdWEasOHa+lspwWHr
 U2Y8VXnUk5BO4nKodaC2inw1reUzXyTtJgpPLa//fVrqEaCw3QaThwQT1qy5/ej4nNSQPpaL
 FEIvDUjp+4++SRHU+URQTW8jnvZmU4nUOBsHugZ9iyr7q+EzSygUz1soiF6VPQqs8o/RDoP3
 1CPns/0CTEHjFFzYS3GnltzhWzpURX5PVM/iTk4oRwtz/SLnW3ephfIU8olD6O/yNH4cd0R/
 9xohHhu71nwpZdVv0lewbwhq2z2znQuZlBujjg7pkr/smtEiHeNPuREE2Tz4/daN5q+RVKcp
 nUCkMX2xLlRVsvRy3fVEL5QTOjBCxO53Nv03g8H834JqGXFxpJfVd0MumEWyLpBaZ1aIm+1C
 KMtkVkMv88DVJdVUUOHS9ntW5xxnfeI+SXNV/fSacEGeZUZSeN01HEGWKJk5Ei0yBJEufhna
 f+zKJ/wZV5EU/gP5GTsGY81j+Rxrghgnjy7eHwO507/uVZoTCTNEe9dWLZPB8hlhJ65TPL9q
 owObZHTlE8PC4UToED/qOYuELzDFlBjbbieliCdXrXrztNOSTF7WczCi6gsYZJklKlzn+LFt
 CP1EExBxVa1wTWNJQyWYzoxIPniTLRun0IdZCYMBFeP32R8QICN6KxESYA7U4N6/8NezNl1b
 cI/ReO+Ptp1RA76pgstNavGkNQ6dTCApx6/AC6+UT1uI79iX1Po//HnTCvO9Q4PLHGFiuojk
 ZKd1yfwY5kKdyJ9Bun4NdOtyFKQuyAGueRQBkHnHPhaSH/OwqNLdRPjv6QSGN4eDDn+3R6Y6
 lqmOggZruzzvIMFytnFqqSapYOPEeElPE5lM0TEzLSxbw/2w3GCxNJebeO2YjztbmP416G8b
 +FzzfunEvkmnk5PgrVsAYRQ0qMyyNv+lYB0lj0+Mi3wUG2qLbd8Ll2t/8pF7PRNz4AEnzqGY
 BuE/90CNIiZPM/gLkUqGzMkSea+ztARpCjZ6KUkAUf95RIvxoG9b2dpA0CuhhBefZxPC6F05
 cc6ucUT1R6ztQpyDPaCkRJv1jqtKl4ubvwZk680Ua7RtxoT61BdYJbjJDf8z7ORZv5tbEQ7A
 D+mq5DTprZbx0D9IiM/PiWW79V8mKYhhRFu530BLmSvhdDqqKIW3hpQ0DJvVSVT7ExN/NxSM
 1hRFX9eBPux7RJ3oslcBUa+NhpkFjTA3mDQknwnzHb4SWusXUzzdFwNA/6Hph0lwjgNbwpl8
 6G940e7dzTTJeXa/DY4AGxhoNzdFe1BzBXIwp2bLp7UDqsBQGTXh4G1bjA1sDrhO8Q6gXPHq
 cRM/Opdba7aNzYak5YkCru1hKghdxSZGFNsGf1R3rsFPWX5SgGA3TKjL0OQeMQUA9fo9US+K
 dJlJ+MRdhCY+RuNkAsmBv83E+cppMIq2dsMQaO0BGgkt7DEkCFlnqiN/QfDhUgqYe5Ur+ADF
 q3reQmvKFeg3UlvpzeVre1vGHaJXt0fVQitgMG36LooErwAgsFNcGYz8OCGgFSIAiRa/ja/n
 gDKV4nJxcNMlKVumIrNFP1YJgOWcNncasWBwDqRgf9vM+zdAJzrjBwHj3XaJCFUAOchYMt2n
 rGzr9LH5kPJk7IoWWT/mZPaNa12yeitfehQaOTbEWJ7mHacZcrS/BczwWC0BphXmtd75MP8Z
 Q+ZatO1ROEFSeVm23xZRChPISkzU52tQP/bmhq8iPCQBjw28w/Ndoqn/EC0S1BrTHYDPpmmB
 zLkv/qr2Mtjk71NIx05HNBjPY5zJQ7yeKkhduCpjwKiMEuTvgqgtIfhxD0a0hOaOkncRYy+q
 djASwPlfRu/hLDQwZsL+8ZutxkQFzBmjfN2YksZ/MVshiunCHIda94QKogCFooehxmaOEsUv
 90RRDBK5eTBsTV4ndHU5dP+QkGAC+ZINtqRyvnFOa+LQ3/eOW9CKOIJGuRcD7NeZTbpiu2qQ
 T3b0mOlJQC/m/mFWs5KjsFWQo5bKjfy2X8Cv0zw+yA379DyHp1SvEFc8MFxueAr3i0DeIgn5
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:RDBMXqnIFllS2HlwW30JPm/DfyvpDfKP3DAbv31ZSRFFG/FwWf
 rOoB19726TtN9xYgBGpTnkAsO9qBznmKKdjbN8AV7mZniEhINHRLsSkbcKgAeQZhEXz4ZmpN
 hdmtFFeaPN5AFB/LfHCWuDc+rIseP3lJxA3t2utkuFJDsCA8pdBkVCe2Sm+ytNKzWubqBJca
 Z0iPAom9OIQwVmUu2LQlcEQsnerJnxmJr9ZxluPW9c1CC+yR2p9Z/nGFyi0h0fSjNCxqpKyx
 m/ryXJoouirtCmwVvm22XS9pRbn8ak4tZPH8CXkKEuW0fRozftSoR9eqGI+Ao4p+yi8z8R4a
 HxihotJdly7HvNfmezu3LWqnrd7Ao=
X-Talos-CUID: 9a23:f/6Ux2zHQe627dEgWH9QBgUQNMV4VS3mx03sLkqbF0tPbLjFZ3WprfY=
X-Talos-MUID: 9a23:4IcykwVK4+ULbhrq/CLj1SF9OelE2p3tF0siz5s3pZnbbiMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="102522086"
X-MGA-submission: =?us-ascii?q?MDE/dAW0yTY8wJDZtYOAFmpYKm1ZucdQo/VcYN?=
 =?us-ascii?q?ImjKYFRrkJRRdP5oeQl/jg9TiNdCi4qxYwde/vTDMCdULq00TUcpxQLq?=
 =?us-ascii?q?LnQWCufjJGTJuvbXPxymTbM5onY8G5cD6wnI6yXSeu+aY/I0zSaNLBO4?=
 =?us-ascii?q?Tr87XPHCLjrpns72KsQ0W0zg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 09:40:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732524015; x=1733128815; i=markus.elfring@web.de;
	bh=giSZWBGE87EKufGjJR2a2Lg1nqjg7X2LUyqW+g6O+Bs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IreqnOZOvqLXol0w4e9En+Nw04fLpsaVwlw//tv7lKzgWusCIgjrIA/pJVsgGPmI
	 XeiDbrsNytrrlxqDFCaZzTxESg4FYkyeySQaUkId5dTcSmdJvoZjHZw4CS6vyd42j
	 zzBuqrNvDEze9gLw0fS2Gfr9sh5NFQeSdWTmG9qLowCVz1J55oIFBoE0kwTZe+MrQ
	 SpP2buCdI+pJJtY4+JnRdx0opVICoIgJBlzp2zj3O7jpoB4kf4YqG+wcDAVG+xrhS
	 gxOOXrSpoo6PJUi3n5gx//FXk21PQJZpHxcbEPDbjju2doFhF9wPkjKUf7xY/C/+v
	 EbWlxsoRguheIvuaFA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1rPI-1tHhYt2DSS-000lyh for
 <cocci@inria.fr>; Mon, 25 Nov 2024 09:40:15 +0100
Message-ID: <f0834941-4f1b-47b4-b8cc-d2ad83b75c71@web.de>
Date: Mon, 25 Nov 2024 09:40:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4PAq74ZFy4RCH/RTCSWr9Ad0Jeq+8ocWYahTBEK5JDRkp4UcJLW
 7Q3WxNNEbpP6A2KGxM2a8Wg5OeR22Ht6StezLN/hIcOtvm+fL5huLFOto9iliGLlyCgVMWb
 wCj1BcenSjIKAs0ZJuyL/EFlDdUJ1BpXHrgoLhLFv5OeAyit8ybHOEvA9V2BqL7nUVQRvAW
 PWWJcMhZt1QN3Zw40cdtg==
UI-OutboundReport: notjunk:1;M01:P0:kNYT7Gb0UsE=;0fsHdWI1/YJYvLT2/ywDC/QQP10
 RTmOmpHlXLw5d2Zu+KR6xO9TTF0tYgPePKshBSW4ShtLtPd2kN0jPcADBPOdK0iK7Dnl79thL
 UYRjceHrI5vWxjy98Tc3JW6Jm70FqD1Hn6C6LxldJppGZpbvNU1UHKbkMFuxSyuNho1UvGclD
 hrY5sJrioEg00Qoj8Dou1WK/NpUYlP/XR5v4PDo90aF2ty49zQwwO/CPplJcdTRz9/ctLjlQH
 GdxFkmYH2m/uIc2tP2427cqj4uiuBKQMLJBXnS/1UujcRWFb7W2cbFJaAkpisb+BlR3K5k7kT
 FHP9PD52ovYKebA96Ck2jVEcRpHoLxYfOAwgUxR2zUebd+p5cIMjVVTlW489jR9TlC/2IGkhY
 HyGrg11hOX7+wCyCXmGj902VMEk4jn5wtwjkEQ1RHf8nZTmzVxPuDH1mgFa1bfLQDrzdkvdkW
 Tuub6NHSI+gjENQVLfqGTul6quuxfw71jVOdhY+6Yjp/HoEu+Rweq741ayanNei0djTwcQLuY
 tWI4+XM0RGBFzSWCuH2yflzbj4ajlocJtmC5wwmJPADWujP+E+UPZ1dLGnBgU+VZb60PDQB6i
 Ehkq42pKn7b+cRC6tlyKcNM6BlukmstSwh8iq2c/oGKA8JUqn8Ebr0jPL8Vrb6s8l3QH2F+At
 Uxze8HCfSn8ooeOgHMTX4zNvMQe8TCDyNsRB539eL6l/2cpljN9qQvCFoSA3EdqsogTzfsw+S
 /gZaOgjfkNnbd+k/K16tZGJO9Y3iO9kTyKm/IQ/jgIciGB1UGKqoWPk1uSHjyRNrn7rLCcw5+
 pRz0T8IeRe0XYycs1rWz4ACrZ2+gUycyipvDdKXEa8NOTbUGx950FOOgr4tnXR6Ww+92mfXkB
 1UQX975Tk3h7u6sRsyoqfoh9z2ZWlRwgoq9FEFfPeWj6ff7phUqUk2Qvx
Subject: [cocci] Searching resources for software documentation?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2096
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/f0834941-4f1b-47b4-b8cc-d2ad83b75c71%40web.de>

Hello,

A bit of documentation was published.
It would be nice if it can be clarified further
how the software should finally behave in selected use cases.
Are we still looking for corresponding development resources?

Will the chances grow for significant contributions in this area?

Regards,
Markus
