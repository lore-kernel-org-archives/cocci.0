Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593E1C87FCC
	for <cocci@archiver.kernel.org>; Sun, 27 Jul 2025 13:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=rYLwvJFEjClOwF85WijduyQrWOqsBKzd9eQ/BgDG97k=;
  b=U4ROK22ujLfE/xMzuWRVbBDAMTIJW33NkO1btp3Cp5PF95X3LV9dfods
   gPz6X33BMc2FrIZGxN/EDFsDt0h+i5Rn5PqyYsCq+Jfvid/hxTwgnFFhl
   bK+92GgCkZm2ZMk48mn27BlQP6NtnJI/YzmHYhbwgoeKjlfLRdBuymh/E
   E=;
X-CSE-ConnectionGUID: WIBJmx2RQHC7mnlfZFbgZw==
X-CSE-MsgGUID: yM4RVM+XQsqoK9WFXFFBsA==
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
X-IronPort-AV: E=Sophos;i="6.16,339,1744063200"; 
   d="scan'208";a="233260407"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jul 2025 15:37:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AF44CE0172; Sun, 27 Jul 2025 15:37:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EA4D1E0BE9
	for <cocci@sympa.inria.fr>; Sun, 27 Jul 2025 15:37:00 +0200 (CEST)
X-CSE-ConnectionGUID: peOLpLM/QUqAVTyzJsu+Tw==
X-CSE-MsgGUID: E+G357EORA+SRsTP6P/8ZA==
IronPort-SDR: 68862b7c_TUL0s/y9jYnoKftb+JEd5FeW8xWokhYj+nniJVDeI/ooHrv
 PngWr1iyOFSIaLaq+kSuMz/LJtQNwVMyP1XOCQg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GJDQAsKoZogA4P49RagQmBU4JEgQZUMwQLSYRVj1CGX?=
 =?us-ascii?q?4c8h1WIeYFVgX0CDwEDAQ1OAQIEAQEDBJEbAh4HAQQwCQ4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGFTC8NgluBLIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQJHbR0BAREnNAImAnMBAYJ+giIBBhABAzIHtTWBMoEBggwBA?=
 =?us-ascii?q?QaCadd1HywiWYFkCYEbLoVtgkoaAQVtihgPgVVEgTwLgkeFf4MOgmmCJoEWg?=
 =?us-ascii?q?2WEEoh1iE+BShwDWSwBVRMXCwcFgWMDgQ8yPDIdgSeECoEOhCcrT4URQViDV?=
 =?us-ascii?q?CRtDwaBFYNqQAIBC209NwkLGwY9kz2EIxOWJbMBNAeCOIFnBYFfDIkIlmMGE?=
 =?us-ascii?q?y+DcZNhDgaTBZkGo2iFWYFoOoFcMxokgzZPAxkPjXgBhFvAbEE1PAIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYsxgUsBAQ?=
IronPort-PHdr: A9a23:pDj2sBTluHJKb8koODOFAQ9Af9psopaVAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSBsODsLkU2raP+4nbGkU+or+5+EgYd5JNUxJXwe43pCcHROOjNwjQAcWuURYHG
 t9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oI
 xi7owvcutMKjYZsJao8yR/Er3RVd+9L2W5mOFWfkgrz6cu34JNt6Tlbteg7985HX6X6fqA4Q
 qJdAT87LW0759DluAfaQweX6XUSSmoZngNWDgbK8R/2Rpj+vDf0uep7wymaINb5TasoVjS47
 qdkUwHnhSEaPDMk6m7Xi8hwjKVGoBK9ohF03oDZbJ2JOPd4Y6jQe84RS2hcUcZLTyFPAY2yY
 IQBAOQfPehWspXyqVQVoBuiHAmhHv/jxiNWinL026AxzuQvERvB3AwlB98At27brM/2NKcPS
 uC+0abGzTHNb/NM2Df97ofIeQ0mrP+LR71wa8nRyVQ0Fw/fgVuQrYLlPymU1uQLvGiW9ORhW
 vy0hGI9tg5+vCGiy8ExgYbGmowb0ErL9TllwIkrP924TlZ2bMK6HZZRtSyUOYV7T80+T2xop
 So0xaMLtIClcCYEzJkr2gLTZfOafoWL4R/uSuifLzhkiXxqd7+yhQu+/FW8x+D6S8K6005Ko
 zJbntXRqHwBzQLf5taFR/dn40us2SyD2x3c5+1cJU05mrDXJpA8zrIqkpcev17PEjLwlU7rl
 qGZbF8k9fKt6+n/YrXpuJucN4hshwH7NaQuh9C/Df42MwcQRGeX4/mz26P78U34RrVFkOE2n
 7HHvJzHO8gXvLC1DxFX34o59hqyDy2q3MkXkHUfKVJKYhOHj4znO1HUJ/D4CO+yjVO2nzdxx
 PDGI6bhDo/CIHjHnrfhZ7d960hTyAcow9FQ+YlbBqscL/3tQkPxrsDXDgclMwyoxObqEMly1
 oQCVm2TA6+UK7jSsF+N5uI3OeaAfo4VuDDnK/gk/fHil3E5mUUFcamvxpQYcGq4Eeh+I0WFf
 Xrshc8MHXoSsgoxUuPqj16MXyRLani8UKww/is7B5y4DYnAXI6gmLmB3CCmHp1KfGxHBE6DH
 mzye4qZRfgAcD+dIsxgkjwBTbWvU4Av2h+wugHm17dpKPLY9TAdtZ35zth6+/Xemwkr+zJsA
 MqRy3qNT3l6nm4QXTE7wL1xr1FlxleYyah4jeRXFdxN6PNNVQc3LYbSwfViBd79CUr9eYKCT
 12tQ/2nByswR5Q/2YwgeUF4TvCrlBPexGKHB7EPlrqETMgR+7jfwmO3CsJz0XfA24E+glNgT
 sYZZj7uvbJ26wWGX92BqE6ejav/Lcz0vQbI/WaHli+VuV1AFRV3SePDVGweYU3fqZL44FnDR
 vmgE+dvKRNPnOiFLKYCcdj1lRNeXv62Hd3EYH+q3Uq0CwyJwLykc4fgPWkQj23GEEZRqwkI5
 j6dMBQmQCKoombQFjtrQHfmeUDx6q9TrH2hT0k75x6HZQtt2un94QYb0NqbTf5bxbcYoGEhp
 jFzSU66xM7TAsGcqhBJeaJBfZUi7V0B2W+xWxVVGJumIugig1cfd18ypEbyz1BsDZ0Gl8E2r
 XQsxQ40KKSC0VoHeSnKlZb3cqbaLGX/5nXNI+bfx03e3dCK+6wO9OVwqlPtuxusH1Yj9HMv2
 sdc0n+V7JHHRAQIVpe5XkEy/hl877bUB0t1r6bdz35xKu+ZtjHY2tQmLPQowFCscpYXMa+JE
 hPzD9xPH9Kne6Qhn1mkaA5BPfgHrvdueZn8KL3fhejyYLUF/nrul2lM7YFj31jZ8iN9TrWNx
 JMZ27SD2RPBUT7gjVCnu8SxmIZeZDhUEHDsrEqsTINXeKB2ep4GTGm0JMjijPB3nZ3wQDh18
 FC5BlUJ8NCkc1yeYhauuG8YnVRSunGhlSaimnZRmisqs7HZ8SjA2eXkezIYN2QNSGQo3jKOa
 cCkytsdWkavdQ0gkhCosF37y6Zsr6N6N2DPQE1MckAaNklaW7Cr/vqHas9Ls9YztDlPFf+7e
 RacQ6L8pB0T12XiGXFfzXY1bWPitpL8lh18wGWTSRQ75F/QY8Jt3lHy4NLGRPhe9iULTm90h
 HHbC0O9MN+g4diP382a6KbkDT3nD8AVKHWjxJjIrCah4Gx2HRCz+pL70sbqFwQ3y26z1tVnU
 znJsAepZ4Dq06qgNuc0NkJsBVL69497AtQky9F23stPnyFHwMzJrh9l2S/pPN5W2Lzzdi8IT
 D8PmJvO5RT9nVZkNjSPzp74UXOUxo1gYcO7ayUYwHFYjYgCBaGK4bhDhSYwrEC/qFebRPFnn
 SoGj9Yq5mQbhe4hpwcniCmQSON3fwEQLWn3mhKE4srr5oBefmWyav6d0ERknNauJK6PqEdQV
 TyqH/VqVT815cJ5PlXW1XT14YyxY9jcY+UYsRiMmgvBhexYe9oh0+AHji19NSfhrGUonqQl2
 Ad208jw7+3lYy19ubi0CRlCOnjpatMPr3vz2L1GkJ/e1tKqGYh9XCoGVt3kQLqhQjcVqOiiJ
 wiJCiI1sHvdBrfVWwOSjSUu53udFpe2KzSdI2QfxtgkWxSXYkBSyAlGWTIngtsyDQq3wM+nK
 U5/6mlX7Vn9z3kEgus6Mh7iTiLUvwyvcC9yEZGZIEMQ5QZHr1HcNcjUhg5qNwdf+JDp7AmEK
 2jAIh9NEXlMQUucQVbqIrip49DEtemeHOu3afXUM/2IrqRFWvGEyIjKsMMu9iuQNsiJInhpD
 uEqkktFU3djHs3FmjIJAyUJniPJZsSfqV+y4Cpy5sy49f3qXkro6+7tQ/NKNs5z/hmtnaqZH
 +uXmTo/NjtSkJ8BhDfJxLUZwF8OmnRuej2qQtFi/WbGSKPdnLMSDgZOMXopcpESsORlg08UZ
 Z2+6Ju9zLNzg/8rBk0QUFXgnprsfskWOySmM0uBAk+XNbOALDmNwsftYKr6R6cD6Ycc/xC2p
 zufFFfuezqZkDy8HTWmK+JRl2e2OBJEuYeyWglgAy7vQZi1D3/zeM8yljAwzbAu0znSMnUAN
 DFnb05XhriX8D8enfh1XWBMpCkAT6HMi2OS6O/WLYwTuP1gD3Fvlu5U1389zqNc8CBOQPEdc
 M76sdNk5V2rwLHnItVPTxdE7DpG1tvjVaRKPKLE6t9fVHyC8B9ftQ2t
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:+1K9i6m3dLpfkDQQ+8wNlF2JkQDpDfPaimdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcLC7V5VoMkmsjKKdhrNhR4tKPTOWw1dASbsP0WKM+UyCJ8STzJ866U
 4kSdkHNDSSNykEsS+Z2mmF+r8bqbHokZxAx92uqEuFJTsaF52IhD0JbzpzfHcGIDWuSaBJdq
 Z1saF81kedkDksH7OGL0hAe9KGi8zAlZrgbxJDLxk76DOWhTftzLLhCRCX0joXTjsKmN4ZgC
 H4uj28wp/mn+Cwyxfa2WOWx5NKmOH5wt8GIMCXkMAaJhjllw7tToV8XL+puiwzvYiUmSAXue
 iJhy1lE9V46nvXcG3wiRzx2zP42DJr0HPmwU/wuwqQneXJABYBT+ZRj4NQdRXUr2A6ustn7a
 5N12WF87JKEBLphk3GlpX1fiAvsnDxjWspkOYVgXAae5AZcqVtoYsW+14QOIscHRj99JssHI
 BVfYvhDc5tABynhk3izydSKITGZAVzIv7GeDlIhiWt6UkboJgjpHFohPD2nR87heEAotd/lq
 f5259T5cFzp/8tHNxA7dg6MLqK40z2MGfx2TGpUCDa/ec8Sjrwl6I=
X-Talos-CUID: 9a23:5Gtlvm3fLOgDS1Y1z/gVoLxfAs0CVmX56TDpHlaRN1p4Wp+OVBys5/Yx
X-Talos-MUID: 9a23:i3E8mguXC8xGa1exr82nqXJNb5o3zoOUIQM2q446g5e8cnxCEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,339,1744063200"; 
   d="scan'208";a="122272843"
X-MGA-submission: =?us-ascii?q?MDEi9QNwf/53afWNKj867TTa0QcflzCZ2/37Px?=
 =?us-ascii?q?1tyAv9I2x8Yu2tcnNEbIUn1g559BPzCAU8KQcXiWC6jSMJTIqJbonRq3?=
 =?us-ascii?q?vX4oFVy5uoJr94+TnhOCbVqV+IV+zLOPXcNgUWC5PIA+BxPJVVCvx1ml?=
 =?us-ascii?q?dmWN1EvClk95S2zIW7riQafg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 15:37:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753623419; x=1754228219; i=markus.elfring@web.de;
	bh=rYLwvJFEjClOwF85WijduyQrWOqsBKzd9eQ/BgDG97k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H0VTzFtUoiFYwwIdPxAg1dRh5dugpnROq39ndxEW2eeL84lcw8/7mabosvyQFCE8
	 9JtxhiAPgFNgpG5a31QmdcNMGopvUJxnAJXYfI/qL04ebyr0BciihvVM0lEXdtzOE
	 uulTjfSHV1QqfOzXW58AqYjlIp7x6w/yOnrLdk8RS1nTtq7nfSzvSwbFn0yC5xpTz
	 gDJJnSNqT6PJwDZFiPjrWf+fjXbk9mWYLCpbztr6AHpcl01uIx4DRgWTkTqSn/gW+
	 glMbgp23/PVtzTB6YGr9ofbR0N+sG98Tm0BJi41VAH41/GspLlgUC7+IeFS86ciAZ
	 hearB7u2Ida3vBcnzA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.1]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2BMA-1uXwM03582-00z1Tc for
 <cocci@inria.fr>; Sun, 27 Jul 2025 15:36:58 +0200
Message-ID: <67e35fac-d223-4067-882b-a632a57c792c@web.de>
Date: Sun, 27 Jul 2025 15:36:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FVLVjT67sPiIogzEzTOWA4LkmYIHPqx16lgXVY81xZHrOqIWmZd
 IdCXnOEoEWbsnUJUoUpIzZF2yGWxOeWGFAFkzyIu+qTX4CEij3p0Q70WjZD23hsU4gzwPKD
 czOYo7FBfRu1CpdIe/1vGmJ01nVCcZABEyhpSWRhTABm39oYbUQFAotP2+FR8DuEsR80XYp
 ztShBLSNuPOs8xuK2dhBw==
UI-OutboundReport: notjunk:1;M01:P0:4UXhOxob5RM=;iT3WrUNIRgP3o0EGOVbF1Mr4u58
 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
 wx5PqtiyQWLqVul8zyvddlg=
Subject: [cocci] Supporting expression fragments with SmPL dot variants?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2917
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/67e35fac-d223-4067-882b-a632a57c792c%40web.de>

Hello,

I would like to try something out with another script for the semantic pat=
ch language.


@display@
expression x, y;
@@
*(1 * x) /
 ...
*(2 * y) /
 <+...
*(4 * x) /
 ...+>


Unfortunately, I stumbled on the following test result then.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci show_questionable_evaluation_order1.cocci
=E2=80=A6
minus: parse error:=20
  File "show_questionable_evaluation_order1.cocci", line 9, column 1, char=
pos =3D 76
  around =3D '...+>',
  whole content =3D  ...+>


Can the data processing be extended anyhow also for expression fragments?

Regards,
Markus
