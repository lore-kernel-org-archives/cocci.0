Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210E7C7EE30
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 08:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TDPj7SBdys9vOoqY74UVjQFsadFc0BWLg+79DvAfuj8=;
  b=fXDhX2NFJKIBPW6plVd1daCKeUWFFZv3PxoN+7Wxs3av8jgGSt00Z+Il
   O3j4OTqdRxKL8+QZ66RbbadHKPVNouSYTVn8KX9MqzvtuTpzBTghju+oL
   C2Czyie67tHxtZecUtlVRDI3nPBGJWnYPxeLCE+zHLlEAhZkoounNsbG4
   M=;
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
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229740858"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 10:20:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8B517E0AF1; Tue,  1 Jul 2025 10:20:14 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A4AA2E0131
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 10:20:11 +0200 (CEST)
IronPort-SDR: 68639a3b_z4EwXGDSReOs9i2MAh4XnGy7WQHEtIgScXVsbDsdWaSYTMY
 pnxTbblQn1TGuFQE57N0A7uuKvuQsGmyk8PEsNw==
X-IPAS-Result: =?us-ascii?q?A0FhDgCJmWNogAMP49RaHgEBCxIMQIQXgQAGVDMEC0kIh?=
 =?us-ascii?q?E2PUIF0LQOEO48PiHeDUgIPAQMBDUoEAQIEAQEDAwGFAAKLdAIeBwEENBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECR?=
 =?us-ascii?q?0QBAQECASMdAQERJwQLCxoCJgICVgYBFAEBgn4BgiEBBhABAw4kBw0GsE6BM?=
 =?us-ascii?q?oEBggwBAQaBWEHYRR8sIliBZQMGgRsuhW2CZAGGJ4Q8Jw+BVUSBPIMDPoJhA?=
 =?us-ascii?q?QOBXoNbgkcigiaBFoR6kzZSeBwDWSwBVRMXCwcFgSBDAyo0MSNLBS0dgSd/g?=
 =?us-ascii?q?U0cgwmBDoQrK0+CJAF1gXlBGT+DUx4GbQ8GgR8bQUACAQttPTcJCxsGPZJZg?=
 =?us-ascii?q?yRoLQErBJVLkCmidzQHgjiBZoFkDIotlTwGEy+DcQGTWg4GkwIemGcijWWbN?=
 =?us-ascii?q?YF/I4FcMxokgzZPAxkPhFCJUYQzgQu6REE1AgkxAgcBCgEBAwmFRgEBiAyBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 YZIVbJRElA4RKtyNw==
IronPort-Data: A9a23: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
 YT4qa6oja17pYPM/R5cRkNo
IronPort-HdrOrdr: A9a23:CR/0Mq77uq8mxVGFogPXwBbXdLJyesId70hD6qkDc20xTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ8+6U
 4KSchD4bPLfDtHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: 9a23:R4WIB28ba0jJI0wD4YSVv0QJQdkYYmHj91z3B3a5M2JYTJKcEGbFrQ==
X-Talos-MUID: 9a23:d1qe2AtjBBWdJSKt282nlhs4DO5Bw5uUKm9WzL87uM/VZQddAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="120368908"
X-MGA-submission: =?us-ascii?q?MDG+hcW/zh5zmLIzKbsciHddjl/2MF80QaHJ1H?=
 =?us-ascii?q?+xNbA7UMIMFmN/shoHjJ5JjQHKXMvfLsoH8iHTzOvddXJpRclxfOp+gT?=
 =?us-ascii?q?/LEG1D+m/01HateyQQ8zcz+Y+VEAQKd6bgwdwAC3y8EClZ0sOPuQ2xBO?=
 =?us-ascii?q?cqy4BoQrgtncwVRGdER+iP6Q=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 10:20:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751358010; x=1751962810; i=markus.elfring@web.de;
	bh=TDPj7SBdys9vOoqY74UVjQFsadFc0BWLg+79DvAfuj8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=F/U2AeEatPto/LeRzVlY5/gR+cN4+mHlZEcGneEwLwiUQN4h99J0122DBwC/jglL
	 QDNSCML/DokXNUXL2GieEu/3OBjtfiPorGqRja9TdRcoDh8mUOZV+p7qO3DtMQRbH
	 rlKDe4YENvjPLVGLV7IK6Y+ecIvXpjnOMLJZV4L30zMqiYFnHONK1Zyp+NdUIVcPq
	 +jSZzR9Z2Hmf2KTP/AMebOS9yJB4M7EGXHKSFL3Yszz1hQ2R1RUvEdQZmlZtxWJmU
	 rI9rUNCW3w/z5qskAR1BM8pANua58uW4w+NOIMcFjQNNNHcjKASOc1oGMuK9QXqZH
	 qHlnkrkueZAA57RP8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2SL5-1uhknu3GFb-00yYRv; Tue, 01
 Jul 2025 10:20:09 +0200
Message-ID: <2af3eb18-f7d5-42db-ab3f-0448066d96a4@web.de>
Date: Tue, 1 Jul 2025 10:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
References: <80682a1c-b4c2-468e-84a4-c7c860d47e4a@web.de>
 <fa0a3e28-0e7f-4528-8786-a9347e9f4e82@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <fa0a3e28-0e7f-4528-8786-a9347e9f4e82@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ot8hwJHnON6LxlZuPxX8Tu4BflXD697xRqMUiZa+rj3fukf9ez9
 m9ihBACOPpKFYErmHHNBegn8faY4QBzQOHQoKcguuCWTTs06A+mSUrjyGQHaykpNEOZ139u
 VXnMv4BI08XqA1o9zdugUujyU7K8hcUJidVdIWEnCKOZ1cawSS4tAHSnqc2qZJH8YI3ThHY
 ZKpJaToqwNYJzy1se9wSQ==
UI-OutboundReport: notjunk:1;M01:P0:NcsidlvKFP0=;km6gJSCEFa0MSW82pRSj6GmHzTX
 pUsswuV8T/nzfl7uMm/2jOTT7VTDlyb3/Ej4QGOgN8Y4buXP88OWseGv3+413oWiHM79i8Lkw
 0aCTjmNTDn1bojQm9+eeSGBvCDeJH0BRjYnriZymFg0xurkqW6EXbuflQJWNS0hYdds4Sq9Yl
 qTkA9OG/KWs6PhNI6MgnzXQi4a9Kf87eb7XZ9p/ec/sjqk1y5RQirAQDni94unLtgz3+VHkd1
 D57MWpSrEU4snsZk+iRSc9O+/hfw8k/QM5IDXidqTL3KFu43ZGOBxGW8G/oLdjnPmbnBrZJip
 YusuZI6HbxW2JpPcLgHGmXtodw9+COzFBLYi3msCWYA8eXolTcvPJL3MQUq7OPINd4eRleZSX
 qJR+ianrOOyfitlAI2nJYX8aBlMRmGc8n9dd9GOf+voy3OYetHiN2CM+ZJ0FmgcY7gkGEyb+6
 Xc53kSwbwrsiMmQrGD80q0fcUtahAZN2xCB9laXCoGWmTgNaQnKu2B+VS+MNUR22GGDUd3Clf
 9/ocKb1mbsLsinj5F16IxzAvwRTXeJ28Hu65YeTQJwjhX/f9Jm+bySlTGXhbXEjlYih+zx6wN
 d51iCLTPGBLhNYBR/74IiMk2VVju0X7vXZL5FZRZ5hfX1H1GpIwOHChuvXJg9GgdibDPMxKww
 G+Shp5tcFHCVuPP0YzT7TKqbwJiANi3EFriq0Npu3aBvyOknEvWEQ7I+M0AaBu0YYGFe34auX
 sqaLT0jYYRFfTmo/NfVycTF0K2pRpNREG/T10DwOxel2EBwdu+aO3uzoiXcZeh1jn947jgizf
 Agm6XVvr1XnY9TKKJCxqsHM7oVKGuczi3H7051gbmMrxYaDWyq9XucNYyiJcX47ntg4CeYll6
 Kouq9Oqu8R7jhff4SfUGugi3V0AZT1nb2LBUKUOqqSTkIc4iPixiO7MqeY6d9yA8j1jCIGJHT
 KlQHwhryW5lhq/tlmG7aj58oJzfksupbTetDvX/3ATr+bFc9Ey4WBacaGFNl44RXRksolLLPo
 wRGWOmx8NQ2Yr7QzoEuoPSBeaDiMAKsy3JmyRAEafZbe90LOtAyNwwF/Mf/4meO9weOGQYGJ4
 aWd5q2GhRTqfRQCcgtX5QZl1ug4f6r9b81IZmVP/NZdMpultsnnwIxgO+DP+PnzVbw6hyficO
 OYBtYrWhKHVudYzXPOkzCxS7H0BBP3vTzt04TGOGrPFhupj+dUZM3vk6w5spJud3eoJ7kVAQ0
 KNHalht15VBBtyC7tF3T6EqlePDii6ti5+bFmigBMRlO2u2i1OwfsiZDe0Y3fcQ/SiZsNvtVl
 a6GOSHncHL1MPhIzxKXDWkrxUIqbqTO8vJ3HmZ7l/FMTJp4aByzXZ1tOGc2O6cbNI9fRznPFe
 jnu1XIGQUOoEaDpsyx6Lt/y3OG/eSLcWsZgLrfXfThlBjqlE/HXu6zuFAcEpCV8+c9+65Y1Gl
 6qKdPALVd47agDdEkVtZbHbk91Lu3n3yjzjxC5zMU7otpIjrtzsEqMbFZ5IZI5sb3qGz7CjJv
 2JgqmygASKEGSC37rlyFDxGu2+OY5iJTElbzhAv12c++zYO0mVaVLQAYrBC8nbmuCmUtU60Ni
 VrzWujtoQZKr0cvtaetL3L2f6ocqkXSx3CNRF1sapIbpVJnEiXXDz3Qvk4Lj1yQnQZMYSD9H1
 kG+LWxtRXQJX5GvNeQW6vsQVSpLNWTwJzUQ6jzfuj+jd4NjR5wNaa20uaC2HdVh9rXUyKGwMK
 e8fLtUVmUN8CmxRDIgZlXR7d3xDfXd0S2OowrDoynXJScy0zsOAaQ85XPP5KHQia/fhxZQt6j
 iqqwkRK34tEqa3I89QnnzaPBN3WQop20an3zI54tlLKdXpHiDPd8IVAuTsvKpmmGK+egbxbtK
 owT+a/Th1Gbhepho/oUkttVpKmb9R26uZGEArth2xxLwNF0taxaoiOmGOo0vSYCVbryOTIx7G
 j8AjWdS8NQkjPtjE3bLkExER0611LSlXEXqmDdU11xGrmpJKM37Fe0BIsXgMLJMKzwOfS2of7
 QWzNqleHmSa9Xo8oBr3eT9KMGXy4wDqCbvS21cTm9SkmAqH9qh926E99y/E22pqlECrRusa1X
 Qz1PH6LuNsfeIpUGR5KQkF9Yb0vJ+HIn4o0D5hRltAlyFGxKxXOWKNmDgrWfGiuLeUgwu6aw6
 JqLeCvxvCJD4Qyofd+LzCGcbPJ5lMe0SwQFMW6pG/l1XS6GZLVGgIVCJG2XrJxv/oE+/EBVqp
 RXgFVVhEbAV84SeFGwiLqiJq6rhANs9fYjUjzI1Jbj1jqLE4i8nm0CI3eltVgBzl56tI+hfmU
 vCdwHfXx6KimMDuIC93MPrVS/W9ilMtxxe3G0XkE53S1sJ3FiwSdBo9drl2wiwoq7jOKqeYG2
 v6hROV2PreCiWmB4JxtU99uMkhdexrttAJIUQQFQPkRca3bOTjbcKjLK/BiRQM6friww6SRWE
 UXMlvSESZv51n1484Gc3f23wY6mkpZY3ftyc3NQ3sygsDcvk11phpwRlrXEoRbUZVo0JpF5v4
 ISUAeIaCpV//xs2hmm89WsIHW40Q7+XqzIxR6fAZN7GEtAWMzfKMqyX+x01JP2QmoRn5XgVhO
 Hy68MMjuB7hAd0qzFBitXFjr1nblDVZ5ED1y/wMtFlDWn0iXIpDP4ySAPMzhEEftPR0s8sQ8o
 UloqupWFGXxhV5+HuOgzXw77vGL7jMbJlFGG9KPtK7gsXsbwjQUo8VnLVghY61fcqVJiZazqZ
 EVpK7jAa+jh69Lb26iMvSXFKoyQE+A0t2L9c7W7NLYte/xJ2cum3G4+yetBcDrUZ9qGV634uB
 Tk4B77mtHAgYpeaYZvlvFCtSBvcOF7uAK4KWB03Fwfn4F+Zi7mzIZbK92Nildi5UUv0UtUZDH
 1YB9ho3fIk03qW97ITKMNu4XkqHiO8MaTsXRvcXjJ74EKg9oHbsiTrDwDK8xSK7Kttm1SyN6/
 NnELF+sA7cX/9sam0MXWTTebmWuUQEg4sa8rydjpXMzc309If9K7XmXy6g+6sXgiBA8x1Hw/1
 2mZDnz4Me+Z3mmebY8GCFO8nkgyX/ierPgNChXTkeqWaspbUaggZYlVlJ7gjoXtDl4q2CzEab
 Kv2Hr95CxhccIdwYf+IxEHYHJ+BwzEb6dHyYlfH6THUz3SAeDUci1JLA0WV6211V6xc8zn+0y
 OzvPlyXHjrC9FqpKovoCaUWLPP26SotKJ5jdlEniJDI8GYC5XHO3iHI1dExqhX24aEs+ZA+Du
 JSVibWW+YN0vDYEwhVbUEXE/zFpLxnjSbFqv4uyWZjrzmkYlRL3a6FFG0enZgzPZoT5NcRQGs
 P5whd4FqQqxSuxtHBDSwM6J2r9DPPVbC0UcO14ZvN3Qemvl94Fhuad9l7MWkHGOEAg1PNNTKZ
 1cERQeh1jrMBe4MPx6oMErZvrdEbM8G4slf0pjXJeQda/9qv/3vMcO7idYLA+YOLeX9PhqtR0
 2fgh1QOVy5/3nb9Txl5G+L+FrPSz8uLyT3o4QgJamINLFM4TEMzYS
Subject: Re: [cocci] Excluding files from data processing?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2830
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/2af3eb18-f7d5-42db-ab3f-0448066d96a4%40web.de>

> Have=C2=A0you=C2=A0checked=C2=A0if=C2=A0--ignore=C2=A0fits=C2=A0your=C2=
=A0use=C2=A0case?

The filter criterium =E2=80=9Cfile name prefix=E2=80=9D would often be ina=
ppropriate
when other implementation details trigger special development concerns.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/b00c5adb1a485321c8845=
0bdaa9e0d9ff93123dc/docs/manual/spatch_options.tex#L261-264

Regards,
Markus
