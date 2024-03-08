Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CCBC5475B
	for <cocci@archiver.kernel.org>; Fri,  8 Mar 2024 07:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6g3EzH0eK93fcMs7SC5BQvg8510qBZmvUZA/I+BXYu0=;
  b=bZnaEOHnAG135pfsrGx5Rpt2aEmU5/N0Oeci5wwPmPaKo6Hhfo8wkFRp
   AaXvlHioV1mDARPOs99WmDTexkWEwmVX8V5PqWE0eKE7kLGQXZG9Qbywa
   YdzbQqqau7EeBsSrOEZnorjbUFpBiVTJ/JRCi7hJt20Qi+guijJ0VNGEg
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.07,108,1708383600"; 
   d="scan'208";a="155607497"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2024 08:21:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AC06AE0CD5; Fri,  8 Mar 2024 08:21:59 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C1ABCE0035
	for <cocci@sympa.inria.fr>; Fri,  8 Mar 2024 08:21:56 +0100 (CET)
IronPort-SDR: 65eabc92_H6PGg9bHTIDMR94wEwk7AET7Tp8NjIkgmhjGh0TJSs76Z4J
 fvIt3/TpQdIZsczzSGukqNcoeeQDPJwKsFjxLng==
X-IPAS-Result: =?us-ascii?q?A0EzAAAgvOplhwwR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPgMBAQELAYI4fANTMgQLSAiETY9FgXUwhDuPBohwgxY+DwEDAQ09B?=
 =?us-ascii?q?AECBAEBAwMBhH8Ch3YCHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBIxcHDhAnhWwNglwBEIEOgSYBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINOkEBAgIBIx0BAREmAQQLCxoCJ?=
 =?us-ascii?q?gICVgYBFAEBgnwBgioBAw4jBw0Gs3KBMoEBggoBAQaBWEGtQx8sIleBYQMGg?=
 =?us-ascii?q?RouAYglAYV1hDwnD4FVRIE8gwM+gmEBAQKFOYJogheDO51AVH8cA4EFBFoNG?=
 =?us-ascii?q?xAeNxEQEw0DCG4dAhEiOgMFAwQyChIMCx8FVANDBkkLAwIaBQMDBIEuBQ0aA?=
 =?us-ascii?q?hAaBgwmAwMSSQIQFAM4AwMGAwoxMFVBDFADZx8yCTwPDBoCGxQNJCMCLD4DC?=
 =?us-ascii?q?QoQAhYDHRYEMBEJCyYDKgY5AhIMBgYGXSAHDwkEJQMIBAMrKQMgdREDBBoHC?=
 =?us-ascii?q?wd4ggmBPQQTRAMQgTQGhTKEbQyDDAIFIyqBexhPAxkrHUACAQttPTUGAwsbB?=
 =?us-ascii?q?iIBHQKiNwEigjhgWYEFWZcNjWehGzQHgjWBYIFhDIoclSIGEy+DcpNBDgaSY?=
 =?us-ascii?q?phcII1QmwyBeiSBXDMaJIM2TwMZD44gGYNhM4ELjjxCNQIJMAIHCwEBAwmFR?=
 =?us-ascii?q?gEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 wQFy/X0INZLXrA=
IronPort-Data: A9a23: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
 aXZhYyJfa1jdXPMLA==
IronPort-HdrOrdr: A9a23:giT0Tqs7ZMgbG/PJjfmgdAun7skDotV00zEX/kB9WHVpmwKj5q
 eTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniDhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQouWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: =?us-ascii?q?9a23=3AhfdpsmqjnlHcmEqmVY+pEbbmUeYdLmPC0WzhHxa?=
 =?us-ascii?q?1WEI0Y+a6c0Go+7wxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ACUrBGgxsdhohLtfa6PcBeLMQvS6aqIunBnsEr68?=
 =?us-ascii?q?DguSVKBRwFyaU3A2yW4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,108,1708383600"; 
   d="scan'208";a="155607487"
X-MGA-submission: =?us-ascii?q?MDHRPtz4V0vPsAAW7gPgZtSZ6oSA2kNYy3V9My?=
 =?us-ascii?q?Ty6CTHUXb/PBJwuNr9rU9a5CHnS+7iWJa0mzPPFNhQByqh0NBQfLFOW3?=
 =?us-ascii?q?tp7GM27si8Anct3OohkHA+lW1xsDaVCKOhUhmU9484ujJ8Pam0i3uNnL?=
 =?us-ascii?q?mZle6gliJwJBYZIXVOb0hwbA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 08:21:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709882511; x=1710487311; i=markus.elfring@web.de;
	bh=g0/NPWk+5S0Jqg4RzXBFqg2bloI1tZ27Zk7zWwaUmdE=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:
	 In-Reply-To;
	b=IXZDx+Dok2ctfm/WF32oWBTsMOHV28coK8KjCvV3HEyGL4TboUHqiuvTjfJOEBaD
	 yNzxS6ib12xtHHVc/vSunXHpW6G9jjhiv7wdsVIR4GgKrtBRqgABTheNGY3caByC7
	 tAer1Nq9u9lnpqIN8bmmJTfYMHTIrbT5O5s/GBnmw8w5NgAIsia/Ox3wdeHJqa7th
	 hv/Y78JJpvq+6lvOyZIPlOKLsoo/5fBJj3Gh/mCAfmlR9AThkOLDvRWvEc3/MkCed
	 8WnY/9lop2XskOD+otg1jZq75uDkH6SctNY7NsQd4TezIIEvDQp2Vo7xhisaAd8Bb
	 NyzPI9aBj6Ywfsj2BQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeUXu-1rAFf12CE0-00aNOI; Fri, 08
 Mar 2024 08:21:51 +0100
Message-ID: <154e99c9-fd57-476a-85df-800de64572b2@web.de>
Date: Fri, 8 Mar 2024 08:21:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <CO1PR11MB49149F1167679926A2917E0997202@CO1PR11MB4914.namprd11.prod.outlook.com>
 <alpine.DEB.2.22.394.2403072154550.3161@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Alan Brady <alan.brady@intel.com>,
 "Jacob E. Keller" <jacob.e.keller@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <alpine.DEB.2.22.394.2403072154550.3161@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ypw6qeuZwWksxRukzbZdV/o/z86DG5RkS0UsyXnQUhFqnrEJmxa
 L5wluWrm8p+AyPEGrIpREK4jXjusNmRzRxeG/wIia3vMpnkba92JCUJzOA8cDgdx5S0Ksqj
 5BUAxTSqRrDalG7pI9w9vlHl07bKSnt7w7aMa6/ehoY/PlOJp3KBCMkfNxUUfhFhidgCwXk
 5HAmj7Btdfwna/EbM6v6Q==
UI-OutboundReport: notjunk:1;M01:P0:HsdgQb1Fznk=;4ZhyazAZU2ren795gVbr8z8Qou3
 KnaSk1CaZOwdha2r8TBg+1bU0WvLX2igMf4qYK9YbpNry04vfW0i41MKIIzJHnWwqY1Ow2vOj
 Z2RXk7BZfTwmNLtrMOnPsATp5BcEtPgHtnEmlZMQ18qI4I3+VABP3sRs7PszB1bKVlLqO16In
 cH0kimhXnzbxvcDrkjPOAwv4ocKzQz8aMv7WRYPc+h2xK6gpxEOPCUL/ypVwUGXR+jVtkiOB7
 3sZo/fyuoaT0umiu+BkztIDk7ZydKG8Lu9Uo1tq+pAAGoFMhtStVEjBXD2aWpqB+VYrXq8lRW
 NGk3lyCBEKvf919b/Sp6rkkgmJj+wqZAJLIuaq84XQF/VM9n9if3Hq/6ftIy1/nJ56/ZBZoCu
 pN7sGDnbHALpJ3GbvflAicJVR2knzVbt6LiqV2QNlyAAYFq/YR22X3AJjmZw9trU7ECWGybaZ
 xLUNpkKZQtQNxkpTxLNYfpX6+47ERmPq57DMP3amPPVuz51DfASm4Yt5ASuzl4bOC2YG4yWDs
 IhOCVfY+yIZwBlXSBCAKclEhfQzAqSBoqvwBPSTQMZIuVsNPWJU3iJr3mFlZ+ExsW0+9xEuXF
 0fqPQzJ6B/4aekpiJ3UBW0KeS6XxkHVd8BRFsolBLeV9zcQInpP6YaRXK8zkJo6PSIbTqhFXR
 IKj9GmmUCiujQxLjHA7+wTOC4ly91WahHJSIHrwerDmU5rAod5c7Xx+dR5fKOXidqmvBrNmuZ
 zrTxirw1QXourmqJjvtyPm+DL0KXzj5Ep59DiK4vqUWx3H3v8/vxwYyDZnLm/i/eFIwcYgpt1
 fqfN8SCBVYA9qppsqcsGF6GGwy0WTI3xkT2MhBIArXfX4=
Subject: Re: [cocci] question about kernel cocci and cleanup.h
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1612
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/154e99c9-fd57-476a-85df-800de64572b2%40web.de>

>                     For kmalloc etc, I see a lot more code that makes one
> wonder whether there is a dangling pointer somewhere, so in many examples,
> it would be necessary to check a number of other called functions.

Do you indicate known development challenges here also according to
intra- and inter-procedural source code analyses?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/cd606526ca79e58c7a2af89ab8b7fed4316b7064/docs/manual/cocci_syntax.tex#L1771
https://github.com/coccinelle/coccinelle/blob/cd606526ca79e58c7a2af89ab8b7fed4316b7064/docs/manual/cocci_syntax.tex#L1771

Regards,
Markus
