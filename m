Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227CBC25B75
	for <cocci@archiver.kernel.org>; Wed, 15 May 2024 07:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=331noS8DbwHmoo+nDR9iumADLE1/Y1UxrzTqVm8Z3es=;
  b=V6xSFQtsF5TwrtNH7lnCVKn9BkBo6Y2tqrv58c3KJl9qw6cD+oEDuJR1
   U6Rcq6v7xo9ejsiy9PWxH4PoE0QpJMulWe7lRlrY6KfanIE2yR+jqUMZH
   44ogj4uHQW/cXSS/5+h8jn4zkmOxnk8QAWQYKzwheu0zpPoxOFfDEf+WF
   k=;
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
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; 
   d="scan'208";a="165792067"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 May 2024 09:30:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9F6C0E0CCE; Wed, 15 May 2024 09:30:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9B8B6E004E
	for <cocci@sympa.inria.fr>; Wed, 15 May 2024 09:30:33 +0200 (CEST)
IronPort-SDR: 66446499_DzAgp1ERJPLSmFJ0jCHlGTAGycDXw6F7PcgozyGk9T4z+Jq
 OYn26ak586eh0BQ/De1CXdfHyWMjUGDgdLsdiMA==
X-IPAS-Result: =?us-ascii?q?A0GyAAAwZERmhwMP49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YJDgVQzBAtIhFaPSIF1MIQ7hzmHT4hxgVYUgSw+DwEDAQ1BAQIEAQEDBIR/A?=
 =?us-ascii?q?ohAAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBA?=
 =?us-ascii?q?SMXBw4FCyeFdA2CZwEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAQECA?=
 =?us-ascii?q?SMdAQERJwQLCxoCERUCAlYGARQBAYJ8gjABAw4jB7BagTKBAYIMAQEG2lkfL?=
 =?us-ascii?q?CJXgWMJgRouAYgtAYV8hEAnD4FVRIE8gwM+g3xHP4McgmmFEolagluDQ4UQH?=
 =?us-ascii?q?oIahVIhiDxUfRwDWSETAVUTFws+CRYCFgMbFAQwDwkLJioGNgISDAYGBlkgF?=
 =?us-ascii?q?gkEIwMIBANEAyBxEQMEGgQLB3WBdoE1BBNEA4E4iXUMgy+BdSmEHghDbBWDc?=
 =?us-ascii?q?4F2DmGDUYRLY4EUbx1AAgELbT01CQsbBiIBHacWhDPFAzQHgjaBYIFhDJ9EB?=
 =?us-ascii?q?hMvg3IBk0UOBpJomGIgqGeBbAUugVwzGiSDNk8DGQ+OIRmEFMV9QTU7AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBg1qBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:M6FGeqr8rya3gfgI485H9xoaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3A+w3QoGnj26BnEeoeimzI5gb0RTzXOS3z/m7TB0C?=
 =?us-ascii?q?7MDpoR7KlY2TKwYU/jeM7zg=3D=3D?=
X-Talos-MUID: 9a23:l57LKgsGsowgAjIVLc2ni3I4b91DvpiVGV0KlYwpsZfaFjJ3NGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; 
   d="scan'208";a="87080349"
X-MGA-submission: =?us-ascii?q?MDHuKEHah7GOEXCuB/qDdp5Rffy07JOkM/wmiM?=
 =?us-ascii?q?pi6mTrDv0vVQlRQERi4bfKqbVnT8kWSmP1Eucx2nPwRJSfHNtC3amzyY?=
 =?us-ascii?q?VN9XPt5DGRXuvVTC2nbtLLuesCfR0Xoxv8v5BkMcBmuNXSHSP0hLuyW3?=
 =?us-ascii?q?ht4iFxEoIOJnXN2u1PTrG9BA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 09:30:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715758231; x=1716363031; i=markus.elfring@web.de;
	bh=331noS8DbwHmoo+nDR9iumADLE1/Y1UxrzTqVm8Z3es=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gUw/mt3QqML72BJ7cTrK82c49c6k9t585/QOl2tEc5wl4AoQXdz1zxrWh55qb4we
	 yyHXp/82Z/TsAk8U24VF/J9UxSd9Ox6OZIR6o1FMqKJA68aF22p9KIQxZ+D8N92ao
	 /hn0OyO9jE5mZ53zSe095nXGCEyg8NtpJEvdIwoBZG9w/tL76gczqou5HOcrR3so6
	 p7rgYgTUhBz+EbEED+FqwoQ7M0HyHyKQfoOR4Dv2TNpV4+WU+Pax1RbywEXBMnfyW
	 UH0/bntNSzrgOcdzgwvI69vm1rtawfplKIm0NqQS90HalgGH/WYOBSvQeczSw8j9Z
	 70+FJmewDc9XRCLIgQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQ8ai-1rttYt3Nw0-00MCxU; Wed, 15
 May 2024 09:30:31 +0200
Message-ID: <041e8ad8-436c-472a-b7e1-ecf3e0704401@web.de>
Date: Wed, 15 May 2024 09:30:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Derek M. Jones" <derek@knosof.co.uk>, cocci@inria.fr
References: <233b3043-2539-42f4-b47a-771b0094b558@knosof.co.uk>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <233b3043-2539-42f4-b47a-771b0094b558@knosof.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qgWTwellQjYdoyasngLiEFYnR9COgbe5RYWdWNl2gQB9IOHQK6e
 gzDv/HELjAQkoAICV8rPse9We8U0Hj7akObRTf2W3GyWUMmCgGpC9uxmzWSfP/FUi60JJ5S
 Y1cO9dPbxX7zp9Vam0t2WhWZSIAO1xkPwlvSvN+y8wgWtyNawNAm45gXPPCy9uo25isb+z/
 aox+ss+0dN943sDp30imw==
UI-OutboundReport: notjunk:1;M01:P0:jg1FXrdBMvI=;4rv14Vd06J6SVBG9mlVHP4fNvZh
 aOlAmwMc3NC1yf5BbRvBzINaOrqYVBAob01Vzp7EwVMv/eIXNeNENNpFRimCl6egWL/rOU5++
 g4aQtBG8OcZ140IT5zxfojJzN7VzgonSGi1psDeI/NtiSKj7/yZgo393P4RQqgD/UF/oJ4GUC
 AwExO2loe3usUK0h54ESK97O61RfR9lRw9LbLEIzXq/ktZUEtTd7zjQT8ixKz+fjyLYWC6XjE
 MTu2XSUfUMwgOS3TFjTylv8s+JsLNSE0rBDG6mWPJiyLYq9IBL6zhSpe3UzfYc7NR980qZIVo
 pRqQinSHuJTT+ul6pCSTcWC12FqvZLI7z4E6HmTriWUI8OMC96dxsDL+ZOjgCOCus4u40bjZl
 6UIzxe+3hPXMbUGpEJ1J7+www11Qx3y3F6JToP/PK0NYnT8ASsEhfkaTKC8abzH8soCCAx1QR
 b62KprJP4AhotOhbBqNfr40xNDin4ki+5ibbKeJEqWLuI3GzD6wQqC8bM02R/3v+6Ji2WUG9h
 CcgPz7oh7cX2LUUrUMF0Q8P6WmTN4bvdG0iyhOjH6TS4b5DO77GhF8HMbi6M6M2BEqA/eV6KE
 RMje/qcWE+I9M+WumDZNLFxR5FoH1LgP6O/Tf4+GfLGpL9rOxD96zDyGMADUvQzLs1X2svNlC
 NAyRhFO0gdE76NdL+FFcf8hgYdh8SehvsO5t8rxNzCRTClQN1QAvNBcQzrlH3ucC8WrEaJoon
 tgCluMee5tDvQ/l83gyLle3Ek8ONj3jGFgGsgYjOl7tWEydL2E9OpCbixJZghtJ1qEAJZmWNF
 PH7ub56r7RL/QeuJyj89DftjymqX1/ANkQzAjIsrnlAtM=
Subject: Re: [cocci] ChatGPT 4 and Coccinelle
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1742
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/041e8ad8-436c-472a-b7e1-ecf3e0704401%40web.de>

> Our LLM overlords can create Coccinelle scripts.
=E2=80=A6
> Derek
> write a coccinelle pattern to match an if statement containing a single =
variable
=E2=80=A6

How do you think about to check if more precise wordings would trigger
the generation of SmPL scripts which would take known operation modes
better into account?

Regards,
Markus
