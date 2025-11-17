Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2218DCEBF61
	for <cocci@archiver.kernel.org>; Mon, 17 Nov 2025 12:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=yKVNiqptEUDx+ykSM1IgDCQfDxEGPDkr3Z0hxgEJLXw=;
  b=O2rDuSeRKmsqeAa0+fwJkE2emcO7lDL5McHzVQZWD3JRmXN7kKbI09Sn
   0Uo62ojPFWmZnpdIHMDc8kd7FXeNBO9ryR2lMFIwt81kzDxDaQK8TZ7rB
   DYAZwv9J4EFH8ywbOtI2Sa5fAyE/WykcGUl4C0A2RWe8r5mLzxkRUlBED
   A=;
X-CSE-ConnectionGUID: MOWzuy5BSMGDFHVc03B+0Q==
X-CSE-MsgGUID: OzFwktyuRGWLF2eqHWyIyg==
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
X-IronPort-AV: E=Sophos;i="6.19,311,1754949600"; 
   d="scan'208";a="249547971"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Nov 2025 13:34:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 32E61E0BE9; Mon, 17 Nov 2025 13:34:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A6D55E0171
	for <cocci@sympa.inria.fr>; Mon, 17 Nov 2025 13:34:03 +0100 (CET)
X-CSE-ConnectionGUID: UI5unumKQ7GM0AOfljmxag==
X-CSE-MsgGUID: AMDNGG+9QLensS+Ub2O6Hw==
IronPort-SDR: 691b163b_1+RUNKjevgPI0DXR1i4EfRtAuNKDIbsThZgQ7RxPpXl1M81
 RmeUqmnd/XLrqMcXedKas0YwFAaE1OG+/aTOmsQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F6BAAVFRtpgAQP49RagQmBUIJAZR1eMwQLSQiETY9Th?=
 =?us-ascii?q?l+PEYh5gVWBfQIPAQMBDUoEAQIEAQEDAwGCDI9RAh4HAQQyBw4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw2CW4EsgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQJHbR0BA?=
 =?us-ascii?q?REnNAImAnMBAYJ+AYIiAQYQAQM2Bw0GrV6BMhNuggwBAQaCadd2HywiWYFkA?=
 =?us-ascii?q?waBHC6FboJKGwEFbooaD4FVRIE8C4JHAQGDTgEDgiuDDoJpgiaBDoYnkyKBS?=
 =?us-ascii?q?hwDWSwBVRMXCwcFgWMDgQsyPDIdgSRBGHE9V4NJImgPBoESg1GJHA+KMAIBC?=
 =?us-ascii?q?209NwkLGwY9lQJRg2eBUZQoswE0B4I4gWcFgV8MiQiBJpU+BhMvl1IOBpMFH?=
 =?us-ascii?q?phojgiVYIVZgW8FLoFcMxokgzZPAxkPklSBC8FEQjUCCTECBwEKAQEDCYVGA?=
 =?us-ascii?q?QGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 PIz
IronPort-Data: A9a23:9FWsJK/UFu3l7ViYeBIWDrUD1XqTJUtcMsCJ2f8bNWPcYEJGY0x3m
 2dOUW/TbKmJMDf0KN9xa46y90sE757dx9c3GQFpqX9EQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjPzOG/ylTraZZ0idfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNuspvlDs15K6v4WpB4QRnDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9FIs+liLvybnoRSbfUOwWU4lIOM0R1qkUqSoQai87XBdJEAatlo23hc+NZl
 L2hgaeNpTIBZcUgrgiyvy5wSEmSNYUekFPOzOPWXca7lyUqeFO0qxli4d1f0ST1NY+bDEkXn
 cH0JgzhYTi+pr+rxq++adAzqeF7Be7lOIEaqnhvmGSx4fYOGfgvQo3P4sJEmig9jIZCEJ4yZ
 eJDMGApNk6fJUQSfAt/5JEWxI9EglHaeidbtUnTiK45+WnVwyRu3bKrPNe9ltmiH5kEwxrH9
 z+cl4j/Kjg/GPqw5nnUy1ahgPT03h7xAqVMNKLto5aGh3XImjxLU01JPbehmtGyjUW1WvpEO
 kkM82wvq7Iz/QqlVLHAswaQpXmZolgDVtAWH+BSBByxJrT83ifEG24ZSx14N/MD7OYRSzgo0
 0+AkIa8bdBwi4F5X05x4Z+4gFuP1cU9KGgfeWkbQAFD79SLTGAPYvDnH4sL/E2d14Od9dTML
 9ai8XlWa1I70J9j6klD1Qqb6w9AX7CQJuLP2ukoYo5VxlglNNb+N9PABanz7PFGK53RVVTpg
 UXob/O2tbhUZbnUzHLlaLxUQNmBuazZWBWC2wAHN8d6rVyFpSX8Fb28FRkkdC+FxO5eKWexO
 Cc+eGp5uPduAZddRfYoOdrrUJp3l/KI+BaMfqm8U+eiq6NZLGevlByCr2bKt4w0uBlyz/MMK
 t2AfNyyDH0XL61iwXDkD60eyLInjGR2j2/aWZmxnVzt3Ku8dUylb+4PEGKPSeQls4KCggHeq
 OhEO+Wwlh5wbezZYwvsy7A1E2wkF3YAKKrNm5RlTdLbegtCM0M9OsDV2oIkKtBEnbwKt+Lm/
 UOde05/yXikt0LmNDelV3FHQ5HsVKZZsngUE3ENP1Gp+n57eqepzv4VWKUWdIkd1t5I7KBLX
 dwaXf6fE9JzSjjj0BYMX6nX9YBNWkyiulOTAnCDfjM6Qa9FeyXI3d3VJi3U6ygEC3uMh/sU+
 rGP+FvSfsseel5EEs3TVfOIymGxt1g7nMZZfRPBAvtXSXXW3LlaEQ7Dpd5pHJhUMjTG/CWQ6
 CiOCxRBpeXtnZ48wOOUuY+69bWWA8lMNWsEOVLE7ISGFzjQpUui5o5ibNymXx7gUEHMxaHzQ
 tkNkt/dNqUckUdoorhMNe9h7ZgD6uvFo55YyQVZH0v3UWm7N4M4HF642Zhgi64c4J5Ypgq8Z
 WyX8PZ4J7iiGZ3oAXwRFiUff8WB0vAYwAfTyfEPJGT7+y5F076VWmpCPxS3qXJ8LZkkFKgH0
 OseqMotxAjnsSUTM/GClTJx21mXC349D5UcqZARBbH0hjoRyl1tZYLWDgn06sqtb+pgH1YLI
 DjOoob/nJVZm1T/dkQsGUj33eZygYoEvDZIxgQgI3WLgt/0ue8l7iZO8DgYThVn8Tsf6rhdY
 lNUDkxSIbmC2xxKh8IZBmClJFxnNS2jo0f0zwMEqX3dQ0yWTVfyFWwaO9uW3UUn4mlZLyl6/
 raZ9T7fagzUXvrNhwk8ZU00jMbYb41V1hbDk8WZDci6D8EEQT76sJSPO0sMiTXaWP0UumOWh
 NNX7N5RaLL6PxE+u6cUKZeX/pVORQGmJF5te+BA/qQIF16NIT2ZhGO8FGGsSOxwJtjh00yxO
 +pxLO1hCjW80yevqGgAJKguerVbot8g1OAgSJjKe1EUlqS5ryV7lb7t7Q38uTMbeMpvmsMDN
 Y/hTTKOPWiOj39ymWWWjs17FkenQNsDPivQ4fuU9bgXKpc9r+1cS0E+/b+qtXGzMgE83Ra1v
 hvGVpDG3d5Z1oVgsIv9IJptXzzuB4vIa92J1wSvv/BlT9DFa57OvjxIjGjXBV1dOL9JVulnk
 biIjsXM43rEm7QLSEHcpYiKEvhYxMe1XdcPCPnNElthoXKgVvPvsjw5wELpGawRxZkZroOiS
 hCjYcS9Sc8NVp0PjDdJYixZCFAGB76xcq7kojinou+RDgQGlzbKN86j6WSjeFQzmvXk4HEiI
 lScVzeSCtFkQEBkARgZG7d5DpU+LFKLtW7KsTHunWHwM4VqqgrqVnjeed4I9jzBTHWJeCo/y
 YyQXQDwLXxep4mRpOy0cOVOUtk/E3t3x+U9Fq7YFxialBjiZFM7wS8h3Vnqx32afuEeFH01W
 d0VUFYfNA==
IronPort-HdrOrdr: A9a23:qZNjd6krS4SS1tmxbrNQoxBea/vpDfIO3DAbv31ZSRFFG/Fw5P
 re/8jzsiWE7wr5OUtQ/exoXZPqfZqyz/FICOUqTNWftWrd1ldATrsP0WKK+VSJdhEWndQtsJ
 uIHZIfNPTNLRxdkdvw5hW+Hu0t2d+d7cmT9J/jJjtWLD2DcMtbnmFE4+ugYzRLrIIqP/AEKK
 Y=
X-Talos-CUID: 9a23:QMX5dG7Xf/uY+ERV0NssyW9JB8Y4d17kk1j1e2afB2JrTa2cRgrF
X-Talos-MUID: 9a23:l839RAt5z4LRqxF0LM2nrRROEuhHoPWXLE0Liq5FhsPeEnJQJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,311,1754949600"; 
   d="scan'208";a="249547952"
X-MGA-submission: =?us-ascii?q?MDF6nhMM5eavphtGOnt+fx2rGX67nHkIAhYVge?=
 =?us-ascii?q?bJW12WN94hZ0342w1SBS+bExd/WVqjmyq9/kOxyh8ld/sQRo6ffEH0Sm?=
 =?us-ascii?q?/zKGUXpriwBEZtFag7mrdVRi7ioDL7ZpnkBpX1niQilYz51atbtJzmX/?=
 =?us-ascii?q?By8EaI4SMKIb1/q0JDesTSNg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:34:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763382842; x=1763987642; i=markus.elfring@web.de;
	bh=yKVNiqptEUDx+ykSM1IgDCQfDxEGPDkr3Z0hxgEJLXw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qgv5/HlAGt+47B51iW97xhF5M3TNrVMWwT7Q4eV/gv2UjpkLJBZ2o7XITkFv4mKY
	 q8TSVpe+d3ilJDv6RghvbNlKbmG6WUtV34ibmyFoJPFrpCwEckohuMQbylZCbNkeU
	 9dhjRnee225lZM1x/JfV0NAK99a8PZS2nN301mlfcqda0z8xC6VlnV3krTplVgKcM
	 YDypPYJgWLvOn1Ef3jaLuHbwgRT6kPDxDszFVtUVNAU0AQbIpUGJn8Z/WX8v6i//E
	 A4flFUlEaIW6vNlIn0nxVIkRKbchCm2DQLDyk+qjNwDScBsWfw/MDCcvIiu7oGiRf
	 8BCYk2t5YopcRCveOw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.218]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMp8K-1vdjlm1odI-00LJqk for
 <cocci@inria.fr>; Mon, 17 Nov 2025 13:34:02 +0100
Message-ID: <d08dc115-5c88-4545-8a77-b588382db1e7@web.de>
Date: Mon, 17 Nov 2025 13:33:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IbZnBaOqTzKohfsjSQt/0ArbRF+m3v6G6WXRFbnOk1Ie7+x840z
 Sq4GvDYaj7RVCuD/H1Rj2QzCjaqbzpg8ZCgO3kWNeCmQpG1tXeParsAMpiHut+/iLs1myWn
 H7XTrtMFGqjyv47FaeWYjurWIHQrKfYjMEWul8Hw4uf4fwLFZivMLG20AEEN8O0EUF0Untb
 yPVUJxNCVpWqg3eegj9wQ==
UI-OutboundReport: notjunk:1;M01:P0:1WYlAwROB+Y=;AxboR60T3iAm7Kb/xDYB5lnXEdH
 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
Subject: [cocci] Data processing challenges with usage of not operators
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3187
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/d08dc115-5c88-4545-8a77-b588382db1e7%40web.de>

Hello,

I hope that the program interface =E2=80=9Ccommand-line semantic match=E2=
=80=9D can help
to clarify another recurring data processing challenge.

Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
Markus_Elfring@Sonne:~> /usr/bin/spatch --parse-cocci --sp '! 2' | grep -E=
 '^\|' | wc -l
init_defs_builtins: /usr/lib64/coccinelle/standard.h
14

How reasonable do you find the conversion of such a simple test expression
into an SmPL disjunction with 15 branches by isomorphism rules?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d2731=
a9d546dc4f0b181526e/standard.iso#L134-148

Will any adjustments become helpful here?

Regards,
Markus
