Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF4ECCF9F0
	for <cocci@archiver.kernel.org>; Sat,  1 Nov 2025 09:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=59UYRpKZSp6FuJKfSygC4KfjZcbzvxJXrHh5f6z91Gw=;
  b=CxxDLGIVmkOM9q/lNXtTtTHGc1DC2FvtEcuLh85KS164GvfHLKUgeaK9
   yD9DJmCereJDQ/iCvdL/XUV/DwYlxYshC004LjrVQTXK/ASTJB2fBA5GG
   6oJc3Oqo3ivTVl6ap+n3lwudTeafHz/YEO9aiacz7PfF0BKfex+Rb7xMZ
   s=;
X-CSE-ConnectionGUID: Ael/GqiEQjC3/FhiM9UGSQ==
X-CSE-MsgGUID: U11jG3JHRrWxDvBOA/jJvg==
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
X-IronPort-AV: E=Sophos;i="6.19,271,1754949600"; 
   d="scan'208";a="247087924"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Nov 2025 10:07:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 41DDCE0264; Sat,  1 Nov 2025 10:07:50 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4FF70E0171
	for <cocci@sympa.inria.fr>; Sat,  1 Nov 2025 10:07:44 +0100 (CET)
X-CSE-ConnectionGUID: hvgGaV1NSkiWVEDR4hwxiw==
X-CSE-MsgGUID: Rt+MRA3qTJOQZqSov9jfIA==
IronPort-SDR: 6905cde0_mrj01nTVVo26lb5fL7hwwPSVUrumFWOjOp8w35ktCivUBzX
 cBa60PLPithN26dopaArBRtKtxpZ/6+QOZxWUxg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F2CgBWzAVpe07ASNlagQmBUIJAZSNYMwQLSYRVj1KGX?=
 =?us-ascii?q?4c8h1WIeYNSAg8BAwENTgECBAEBAwSCDI9JAh4HAQQzBg4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBIiAOO4YgLw2CW4EsgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAkdtHQEBESc0AiYCcwEBgn6CIwEGEAEDNgexN4EygQGCDAEBB?=
 =?us-ascii?q?oJp13YfLCJZgWQJgRwuhW2CShoBBW6KGA+BVUSBPIJShX+DDoJpgiaBDoYnk?=
 =?us-ascii?q?mWBShwDWSwBVRMXCwcFgWMDgQsyPDIdgSRBGHE9V4NJIWgPBoESg1GJKQ+JR?=
 =?us-ascii?q?gIBC209NwkLGwY9lFGDeBODI5MCswE0B4I4gWcFgV8MiQiWZAYTL5dSDgaTB?=
 =?us-ascii?q?ZkGo2iFWYF+JIFcMxokT4JnTwMZD414AYRbyz9CNTwCBwEKAQEDCYVGAQGMV?=
 =?us-ascii?q?oFLAQE?=
IronPort-PHdr: A9a23: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
 9KJmK+hcV+qEvrR+tYAQdfZIoSLPSh5WSc=
IronPort-Data: A9a23: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
 Qw=
IronPort-HdrOrdr: A9a23:814Fv6Al68auMW/lHemO55DYdb4zR+YMi2TDpHoBKiC9Ffbo8P
 xG/c5rsSMc7Qx7ZJhOo7+90cW7MBHhHP1Oj7X5X43PYOCOggLBQb2KhrGSpgEIdRefysdg9e
 NHb7V0DsH2AGN3lMDg/WCDYq4dKZW8kZxBno3lvhFQpOxRGthdB4wVMGymLnE=
X-Talos-CUID: 9a23:jmNjfG78kKJf9HlLctss9FAbNckbK1vmz3bvHWKUMzppV62UVgrF
X-Talos-MUID: 9a23:hD8TagmVw2GyzTc9E6SvdnpYKIRN2Y31EXwvtqw0ovKDK31yNRa02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,271,1754949600"; 
   d="scan'208";a="247087920"
X-MGA-submission: =?us-ascii?q?MDEEBpBSoF8c3BDB2o3hdS1DPttEvPA69bo3LC?=
 =?us-ascii?q?ZlNIfOb84ar8j7Xxu+wiuBdBOX7W9uhb2rsTfmcatetrKF49y7enJc2T?=
 =?us-ascii?q?TfelQ5zX1ph8tD4lrua7TZTiQGjOEL7aNAVSHNACzEJpLEdn01v+HHKG?=
 =?us-ascii?q?cijxRkVdlLo2OHici6AIBRUQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 10:07:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761988063; x=1762592863; i=markus.elfring@web.de;
	bh=59UYRpKZSp6FuJKfSygC4KfjZcbzvxJXrHh5f6z91Gw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fN3o3Dwo9gN154bGW6ozev+pYS9Ci43YQF1FSauZkNjgA3vl11uWa0de54TF74/U
	 rvADWlTuIuIXdeYjZzDuSwRFKWIBdyf+FnNDOYV6hw6rsyZWCmfTScoqHmxDxRkpq
	 T8CGoNCjHAiZyHPdCeR+terOfz3FXbb5/oa1QOo0Z7Ei/Xf0k1acAXcLF3jpAjcOR
	 sB9GvVvCF4Ca3JYTOSOaWldvZYqrVZyGMWyhQmeiMGTpTVg2VXIH7B9uMi/wC/5Ug
	 VRj8ToQVN2h4A8Ugsx9qM7Vp9Y5n1wXaNcfcw11fb2XcHT2O4pn2SPBwpo6XbuXoE
	 GfAACjo3m/EG8SFjzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.236]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbCHy-1vqN8w3hCC-00iBrI for
 <cocci@inria.fr>; Sat, 01 Nov 2025 10:07:42 +0100
Message-ID: <8586e8c0-a756-4d43-8bf5-2e26fccceeff@web.de>
Date: Sat, 1 Nov 2025 10:07:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NT0Efd0gD9FQsZFQ8NKeSsAiLM6qQzgBH/wFpS2vWRaYjICCbJ1
 eiPciI3gsd5yIa2M+alCeVef/e2uVTtexhmyB7KdYlG3Cd/oAnOunOnQGG3eoF68ueOfSW0
 JPowyDaEJuitBB/4SJR1eqZE9opHX3acTKJYWZrN8eWNFVI9+SHdauE4BRLa7EkpTnya6O0
 bbPUgquDeYW+GdvSbzvsQ==
UI-OutboundReport: notjunk:1;M01:P0:wnE5ne6myW0=;RE3Xj7GJO8p0ay6cOVJ01gB8QT9
 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
Subject: [cocci] Improving expression list selections with SmPL ellipses?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3131
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/8586e8c0-a756-4d43-8bf5-2e26fccceeff%40web.de>

Hello,

Would you find the following SmPL script variant reasonable?

@display@
@@
*my_action("Hello!", ..., ...);


Unfortunately, I was disturbed by the following information.

Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-parse-cocci parse_test_for_ellipsis_as_last_parameter.cocci
=E2=80=A6
minus: parse error:=20
  File "parse_test_for_ellipsis_as_last_parameter.cocci", line 3, column 2=
6, charpos =3D 39
  around =3D '...',
  whole content =3D *my_action("Hello!", ..., ...);


Under which circumstances will such data processing work also without usin=
g
extra metavariables (instead of SmPL ellipses)?

Regards,
Markus
