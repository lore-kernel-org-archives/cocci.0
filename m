Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03857D1D87E
	for <cocci@archiver.kernel.org>; Thu,  4 Dec 2025 07:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EeqlLckcfmMKfqBQ4No1Ro/SwwGx80q19RP/9ke1cPQ=;
  b=aB/gjkNxMza3ps0obwnmTwtwQ5G2/3c1LONCponsSU2ke4Pvtt4I81As
   Qz5zAx2KFErTZHzLm7X+jwe+klSaHbfFxMIpRPnUI8D9nBz1NufIfH358
   DkJtftekbKx6qgLlRg9qAzDsQwUkjRIha8bjUkTw4HqnPb9ACVnexS35T
   Y=;
X-CSE-ConnectionGUID: anU/XlA8Sf6eayWdGwE51Q==
X-CSE-MsgGUID: SOoQkVMSTauwuhu2h9bwxw==
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
X-IronPort-AV: E=Sophos;i="6.20,248,1758578400"; 
   d="scan'208";a="252667695"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2025 08:36:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E44A1E0AF1; Thu,  4 Dec 2025 08:36:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 55E45E00A5
	for <cocci@sympa.inria.fr>; Thu,  4 Dec 2025 08:36:08 +0100 (CET)
X-CSE-ConnectionGUID: AE4ldFedQcaqJsJoOvyflA==
X-CSE-MsgGUID: +t7kZPV4Tg+bxgPNTfiG7A==
IronPort-SDR: 693139e8_ZgLXMLac1QAJ/llAM80j5fRYuKf14uzFhy+NQ46YkJcl3oA
 MSdUZJUKsXB2+BNplE/SSm4pcA7IfhHJwOTu0Ug==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FwAwDeODFpgwsR49RagQmBUIJAZR0GWTMEC0kIhE2PU?=
 =?us-ascii?q?4IkhDuPEYpOgX0CDwEDAQ1ECgECBAEBAwSBTIM0AoxnAh4HAQQwCQ4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAToHDgoxhk8NgmIBg?=
 =?us-ascii?q?SSBJgEBAQEBAQEBAQEBAR0CDTpEAQEBAgEjHQEBESYBBAsLGgImAgJWBhUBA?=
 =?us-ascii?q?YJ+AYIiAQYQAQMPJwcNBrFsgTKBAYIMAQEG2mEfLCJZgWQDBoEdLoVugmUBi?=
 =?us-ascii?q?mYnD4FVRIE8gksHMT6CYQSBXoNbgmmCJoEOmWVSeBwDWSwBVRMXCwcFgSBDA?=
 =?us-ascii?q?4ELI0sFLR2BIyEdFxNgPRdAg0kYBmcPBoERGUkCAgIFAkA6gWgGHAYcEgIDA?=
 =?us-ascii?q?QICOlUMgXcCAgSCFn6CCg+IA4ELBS58JwIBC209NwkLGwY9lRlPgX6BboIfx?=
 =?us-ascii?q?ls0B4I4gWeBZAyKLpU+BhMvl1IOBpMFmQaOCJs4gWg6gVwzGiSDNk8DGQ+OO?=
 =?us-ascii?q?oNnM7tzQjUCATkCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 3PgLpvnII5VOoCpgiSKj3FlkY6MF0eCBbhw
IronPort-Data: A9a23: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
 P8hoYfi5ejAsex4TCjB
IronPort-HdrOrdr: A9a23:OVQXz6xjgD2E83YhWfU2KrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZEmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFeb/N5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:P420h2wBfFeRPntLGu3yBgU9N5whflPQwE7bKlaaEkRub6OER1u5rfY=
X-Talos-MUID: 9a23:WDABIQsNJOfmjqo2tc2nxy09N/VQ3fiSBwMHgZo+nfWKNAMvEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,248,1758578400"; 
   d="scan'208";a="252667684"
X-MGA-submission: =?us-ascii?q?MDEJ5UjRHDCCyFc+MtJHQD6AZAQpnT8WWv6p6t?=
 =?us-ascii?q?KlHMwQs3FHx3g5812HgGovwET0CT1t29nkOdlwZBmkuV2OyPdKiUn73y?=
 =?us-ascii?q?LmZVUnESLI6CdlBhFE8F9BbPjzjSEyhXge0+MfhXrgtUt5EcsZekumJ/?=
 =?us-ascii?q?hB2YX3Rm0Fsx1RJ8CSi7r8rw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 08:36:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764833767; x=1765438567; i=markus.elfring@web.de;
	bh=EeqlLckcfmMKfqBQ4No1Ro/SwwGx80q19RP/9ke1cPQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R3+ayABy/F5mH3jiwWAcNDhyihS96+sFp2vcRu6N77Koa39vpfQXvLLjqwG3b7ru
	 z7eVP/eCjBbvWOe+upMfdEmizAll4hCJX96FP034RhnY2RRWI6osPuWqVGxkerCMa
	 BZRtiRS+MWF9ZJwCzNXEdiELPkY71jBbR7fkkSGgDjeSWj9VnNzf72ZV2U6LIplo9
	 rDInispLBL0q3hyud+8KKy56PRJGGFReeOqY82Thb18yrwNW/ED/YFOmki6Tk8gSV
	 7Fbrz7EuK+lnR/kWjSd5naBGCDlgBhOPkhpP0tKoaDn5DNA8y8DavgmDAFh2bVvFt
	 bCQa79N3UwuX/VnQIw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmyr7-1vswVM0STn-00mddL; Thu, 04
 Dec 2025 08:36:07 +0100
Message-ID: <53bfddbe-75ff-48dd-a354-4c34d9b3b315@web.de>
Date: Thu, 4 Dec 2025 08:35:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tobias Deiminger <tobias.deiminger@posteo.de>
References: <1b8dad8151ef1409adc8cb24c728907a@posteo.de>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1b8dad8151ef1409adc8cb24c728907a@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BsU28a/85M8rqIvoA5c7DPF3UckP4R8w/1VCtEaVG9RicZFo7mo
 LARke504J50wOxyacc2Y4EPpgzB+Loshe7m+ALG4qD7R7ys9Z3ixSV3DIQeuBYeqtdCbQgT
 pVzShD7wTdK0CTIDl31oNvklarXgI4HCpqzOlD5gADbieKTaBwfTiARKiTP9kOfHL6WsQvm
 LFrjenZH7LMPtBBhqvrEw==
UI-OutboundReport: notjunk:1;M01:P0:LspVumjBNoE=;OcajWHoePvDY6WJr/4FdjBA4YcX
 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
 IbiTrOxGLmN1Ad8Z0j1OazfOlKe/9DMu/61chI
Subject: Re: [cocci] Search for the concatenation of meta variable + fixed
 string
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3238
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/53bfddbe-75ff-48dd-a354-4c34d9b3b315%40web.de>

> // The macro automatically concatenates led_status + _show for struct in=
itialization.
> static DEVICE_ATTR_RO(led_status);

See also:
https://elixir.bootlin.com/linux/v6.18/source/include/linux/device.h#L193-=
L199


> I'd like to find the position of all functions assigned by DEVICE_ATTR_R=
O. So I thought to use a 1st rule to search for the identifier inside DEVI=
CE_ATTR_RO, then use a 2nd rule to search for the inherited meta variable,=
 concatenated with the fixed string "_show". Like:

The source code search idea is reasonable.
But the indicated data processing algorithm is improvable.

Where would you like to store the identifiers which are passed to calls
of the macro =E2=80=9CDEVICE_ATTR_RO=E2=80=9D?

The corresponding data collection can be used to apply subsequent code que=
ries
also with the help of regular expressions, can't it?


How many computation resources can you invest then?

Regards,
Markus
