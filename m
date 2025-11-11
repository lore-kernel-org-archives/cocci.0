Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42DECCFA1A
	for <cocci@archiver.kernel.org>; Tue, 11 Nov 2025 18:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=RPy0WjAb5tMniuXcHQYwX5k4SuD7tR2p3Er+r6KDgGE=;
  b=TZ4gr+MwG4dyAzkcoFGgwnh1DV/6pMr6hV3XJqDi33Plz1n2B4GSxAQY
   O1duLNWTJ9QHe8IQe8lGxZfAwltI7Z1w8yl9JCdOiTVJ6w2d2T8lAHiDb
   i5lVHOn4W7ZYDuo1XNgO8wDQku/21MgvsGi2p3HMwdrULzAPEdB958cnP
   E=;
X-CSE-ConnectionGUID: Vag61O62TcGKwrA6ykrUvQ==
X-CSE-MsgGUID: w2W0sKxdRT6MuiWljIdMuw==
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
X-IronPort-AV: E=Sophos;i="6.19,297,1754949600"; 
   d="scan'208";a="248614544"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2025 19:23:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D9A8EE0BE9; Tue, 11 Nov 2025 19:23:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D4D6FE0171
	for <cocci@sympa.inria.fr>; Tue, 11 Nov 2025 19:23:48 +0100 (CET)
X-CSE-ConnectionGUID: CKb+xNiKSGSM4+2WVrJYYA==
X-CSE-MsgGUID: mwZwuXMgS8mOBBhGWBmQRw==
IronPort-SDR: 69137f34_LpCiSbSjeawUf9p5Vs58TIsYF6zgc8wtxF1vdSye6HUTL+F
 A++H3+tVblZSAZP5f06Pnw1rjnEhuzFGaYFVr6w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HUDgD3fRNpe07ASNlagQmEEIECBlgzBAtJCIRNj1OCI?=
 =?us-ascii?q?WyDUpgKg1ICDwEDAQ1ECgECBAEBAwQ3AQaBTo9RAh4HAQQ0EwECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEiIA47hk8NgluBLIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQINOm0dAQERJzQCJgJzAQGCfgGCIgEGEAEDNgcNBq9/gTKBA?=
 =?us-ascii?q?YIMAQEGgmnXdh8sIlmBZAMGgRwuhW6CShsBBW6KGg+BVUSBPIJSgzkXBIIrg?=
 =?us-ascii?q?w6CaYImgQ6GJ4QKhlMGiFCBShwDWSwBVRMXCwcFgWMDgQsyPDIdgSRBGHE9V?=
 =?us-ascii?q?4NJImgPBoESg1GJHg+KTQIBC209NwkLGwY9lQ6DTygTARsQgjEMkyUXswE0B?=
 =?us-ascii?q?4I4gWeBZAyJCIEmlT4GEy+XUg4GkwWYIGaOCJVghVmBfyOBXDMaJIM2TwMZD?=
 =?us-ascii?q?4RQjVEzvzpCNQIBOQIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 JdcEtdm
IronPort-Data: A9a23:lBH/L6hRbBMxb7ggqjWLw09tX161IhQKZh0ujC45NGQN5FlHY01je
 htvWjrSOKnbYTOnL4glb4iy9x8Bv5+Dz4JjTlFvqS5jRCNjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+e6VaidfHgsGGeIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWULOf82cc3lk8teTa+XuDgNyo4GlF5wVnPKgR1LPjvyB94Kw3dfnZw0TQGdE88t6SH
 47r0Ly/92XFyBYhYvvNuqr7aEADXonJNgGIjHdMM4D66vSVjnFaPg4TbZLwWG8P49m7t4gZJ
 OZl6fRcfTwU0pjkw4zxZfX3/xZWZsWq8JefSZS2XFf6I0fuKxMAyN02ZK060BFxFk+azgii+
 NRBQA3hYCxviMqd47j4Ws9tpf8MF+y3f9kghGtC/ADwWKNOrZDrG80m5Pdd2yoswN9DF7DSa
 qL1axI1NUuGPEcJYwZNTs1u9AurriGXnzlwjVuPprcspUXXwhZw1rfFL9ffPNCHLSlQth/D/
 j+dojygUnn2MvSa1gia70KJidSfmATRcoI9K5e9z8R11Qj7Kms7U0FGDQDr/pFVkHWWUNVUI
 E084TsrtaF09UqxT9C7UQfQnZKflhsbRsYWDOAwrg2AokbJ3+qHLkMnRH1RTt0Fj+ANYGBpj
 GC3hfHYNBU65dV5VkmhGqGoQSSaFQV9EIPvTSoDUBdD/NTp5o0+5v4ucjqBOP/q5jEWMWurq
 9xvkMTYr+tL5SLs//jrlW0rexr2+vD0ovcdv207pF5JET+VlKb+O9zwsgiEhRqxBIeeSF6a9
 GMJ8/WjABQ1JcjVzkSlGb1ddJnwvqrtGGOH2jZHQcJ+nwlBDlb5Jui8Fhkkfx8xaq7puFbBP
 CfuhO+mzMUDbSb6MPMvPd/Z5gZD5fGIKOkJn8v8NrJmCqWdvifelM23TR/OgTLegwI3nLshO
 JyWV8+pADxIQe5k1Te6DaNVm7Mi2il0lyuZSIHZ3iaX9+OUREeUbrMZb3qITOQyt52frCvvr
 t1wCsqtyjdkatPYXBX5y4AoAG4vEWkaHrHz8sxeSf6CKFFpGUYnEP7g/okicI1EwYVQz/nEz
 kigVhVmyX76v3nmKBqLWF9nerjATZZyllNlHC0ObHKD+WkvXpar14gbL6AIRLgA8Pdx6NJFV
 NwXUpykLtUWbRqf4BUbT532jLI6RSSRnQjUYhaUOmkuTaBvVyni24HCfDK20AIsEyDul881g
 4P45zPhWZBZGjhTVpfHWsmOkWG0k2MWwt9pfk3yJdJWRkXg3a5qJwH1jd41O8s8EgrC9BTLy
 zepBQokmseVr78X6NXpgYW2n7WtGcZ6HWtYGDD/xpSyPi/44GGi4NFhVMClQDPjb173qZ6SP
 bht8/LBMfM8jAlrtah4GO1V1q4Q3YbkiIJb6QVGJ0/1SWqXJIluGETb4vkXhJZxnudYnSCUR
 nOw/sJrPOTVGcH9T38UCgkXTsWC8vA2wQvtzOkHD3j7wARV/7O3d1pYEDfRqS5aLZpzaJgEx
 8V4suEoygWPsDgYGffYsTJx6EK3MW0mb6Urkro4Eb3boFMn5X8aaKONFxKsxo+Ebut9F3UDI
 xiWtfLkvKtdzE+TSEgDPyHB8sQFjKtfpS0Q6kEJImmIvd/3hvUX+hl12hZvRyR3yiR36c5CC
 lJJBWZUe5rXpyxJgfJdVV+CAwtCXR2V2nLgwmszyVH2cROaaXzvHkYcZ8C240Erw0BNdGN6/
 ZaZ6lrffxTEQcXT5hY2CGlZ86HNbNop7QDTutGVL+LcFbkAXDfVqKuPZ20JlhjZPf0MlHD3/
 elHweIhRpD4ZAgxorI6Aba0zb4/ag6JD00cTOBD/JEmJ3D9ejaz1WKwKmS0QMdsJuPLw2C8G
 cdBNsJCbDXg9Ses/xQwJ78AHK9wp9EtvOE9Q7LMIXUUlpeitR9rjc7gzTf/j2oVXNleq8YxB
 YfPfTakEGbLp39rt0LSjctDYEyUXMIlYVDi4eWL7+k5LZIPn+Vye0UU0LHvnXG0MhNizi2Er
 jH4eK7a4Oxz+7tCx7K2PP14ODy1DtfvWMCj0gO56Y1OZOySF/b+jVoer12/MjlGObcUZc9Mq
 o2Ml9zKx2LAgqc9VjHIupuGFpQR3/6IYshsDpvVIkVZzAy4Y+290ytbrir8YdZMnchG78aqe
 xqgZYHiPZQJUtNa3ztOZzIYDx8ZDL/tY7z9oT+m6c6BEQUZzReNOebPGaUFto2HXnRg11zC5
 g7IVzKG49dFsMJTCRVCC/wO71qU5rP8cfNOSjEznWDw4qqUbpeqpbbo0xYtgd0OImfRC970u
 PopWTCnHClfe8j0IBVxrIF4+BEaZJq4bS/cYWpFk+NLZ/uG4KLq4AjT3Vjqyn2Zr8Aq6KzFW
 Q==
IronPort-HdrOrdr: A9a23:8lpf4qAvYzAZ0yTlHemO55DYdb4zR+YMi2TDpHoBKiC9Ffbo8P
 xG/c5rsSMc7Qx7ZJhOo7+90cW7MBHhHP1Oj7X5X43PYOCOggLBQb2KhrGSpgEIdRefysdg9e
 NHb7V0DsH2AGN3lMDg/WCDYq4dKZW8kZxBno3lvhFQpOxRGthdB4wVMGymLnE=
X-Talos-CUID: 9a23:+x5zu2DVKu3HC4X6EwJE/g0EPMEGSVLm6SuTeXCGE0RYeZTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3ANLIGWA/jurIe5P621FYdzziQf8J30buzOGUCqsU?=
 =?us-ascii?q?DnOOuNQNPETKktiviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,297,1754949600"; 
   d="scan'208";a="130535018"
X-MGA-submission: =?us-ascii?q?MDENpzLYiJfeQ731a2/WmOEz+/EgEPc7stf7ET?=
 =?us-ascii?q?SgHBy6pqfE1iHiPnhYHaoBXj1Se5XhaH3Bnh0AY7+/ObQxUYcSj7IMJK?=
 =?us-ascii?q?6QWXox5mBlo+ztalKV4y7XD5nOxlFVeV8HaGV8TUsWiisbuoEe5Y4YU1?=
 =?us-ascii?q?n6cYoMz8pDoL2LqxLfnauiaA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 19:23:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762885427; x=1763490227; i=markus.elfring@web.de;
	bh=RPy0WjAb5tMniuXcHQYwX5k4SuD7tR2p3Er+r6KDgGE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TdqP2BJO9hOqTRL26dNAIH3FOWCI3FUor1plrZCb/Odc0U2UiGxuM/5vCabcIMsD
	 qoftsY4tFMUYH+AbjkqOmobWQ6DBxFCy/nyPddKMk9EaMk6+oPt0D94SAoRMvAVcB
	 sktyBQ5LM8046IfUYtfgL6fvjMymMRZb6KRnAoykjNhqwh7TY7e1OQi2nIMPpJ4Hb
	 efb+cmNFvKMVFX+PhfK6x0wVK44gduVQ9RJE3yknMD63uIZiFuNcXv/7OtwCA8PYz
	 VquAatd2t+OpKKeobHS2MwV4ucDtm8BNAjB5ZuOdv9fMn8IK/l/e5F0K2L1gtjPAl
	 HbCCzrdHveFYbjIEgw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.1]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWQyX-1vg80803h5-00O1GN for
 <cocci@inria.fr>; Tue, 11 Nov 2025 19:23:47 +0100
Message-ID: <ca1862a2-8a84-49b8-bbfd-fca9f15c6787@web.de>
Date: Tue, 11 Nov 2025 19:23:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p84iMPleUOk3jcHUYnr5HKiaDkLXsBhEAgAbN+Kzb173TjnmV5p
 5xobxs+TqbXgFW2Dp7c2w5JDxmc0FTw0fSPkufJLVDgzYhEzSSSmUGtZcE1hFeb5L06DYJk
 V05WjtxPki6nYkRxg6+ao57H255/pKp24m0CHNPburyw92x+yEGvZAoR9SRBPoL63+DrOWm
 WQByduShE3ukD4RqDSPGA==
UI-OutboundReport: notjunk:1;M01:P0:xUTo+OG8FQU=;rxMdDONeyQjNvNt8np35xbD2rNv
 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
Subject: [cocci] Checking SmPL support for two special expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3162
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/ca1862a2-8a84-49b8-bbfd-fca9f15c6787%40web.de>

Hello,

I constructed another SmPL script variant. It exported some data from
selected function implementations which were found in header files.
Data processing difficulties were detected then.

See also:
https://elixir.bootlin.com/linux/v6.18-rc5/source/include/drm/drm_crtc.h#L=
48-L55

It seems that contents can usually be handled from such a file.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> /usr/bin/spat=
ch --parse-c include/drm/drm_crtc.h
=E2=80=A6
nb good =3D 1344,  nb bad =3D 0 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 100.00% good =
or passed


Two SmPL rules were generated accordingly.
Unfortunately, I am wondering about the following information.
Questionable test results (according to the software combination =E2=80=9C=
Coccinelle 1.3.0=E2=80=9D):

A)
@r26@
expression val;
@@
-( uint64_t ) * ( ( uint64_t * ) & val )
+I642U64(val)

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-parse-cocci drm_crtc-I642U64-20251111.cocci
=E2=80=A6
minus: parse error:=20
  File "drm_crtc-I642U64-20251111.cocci", line 4, column 31, charpos =3D 5=
6
  around =3D ')',
  whole content =3D -( uint64_t ) * ( ( uint64_t * ) & val )

B)
@r27@
expression val;
@@
-( int64_t ) * ( ( int64_t * ) & val )
+U642I64(val)

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-parse-cocci drm_crtc-U642I64-20251111.cocci
=E2=80=A6
minus: parse error:=20
  File "drm_crtc-U642I64-20251111.cocci", line 4, column 29, charpos =3D 5=
4
  around =3D ')',
  whole content =3D -( int64_t ) * ( ( int64_t * ) & val )


Under which circumstances will such data processing become better supporte=
d?

Regards,
Markus
