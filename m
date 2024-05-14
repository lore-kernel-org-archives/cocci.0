Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10524C04FFE
	for <cocci@archiver.kernel.org>; Tue, 14 May 2024 09:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=M57ITw7V50IjG0UlFd5VTLDi2rTJCu/hxUEtOvhOt+4=;
  b=Y/1L0v670V3WINxdQnnW7oLaLWsVgJqmBhkdP9aI+T7n/XLa1bCm4g4f
   4HmUUSkOOgjWBkRN9ZSPOF6iA4w6AFH+z213FrnTtljUt+/TooKinqM6G
   S0vzAowwOfvMfYSl9TDJBhAeAt/qfoTWB4stKl5YdiEaUGTH+dBm1T7Wd
   E=;
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
X-IronPort-AV: E=Sophos;i="6.08,159,1712613600"; 
   d="scan'208";a="165612460"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 May 2024 11:30:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E877EE0CCC; Tue, 14 May 2024 11:30:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6E95AE0AF1
	for <cocci@sympa.inria.fr>; Tue, 14 May 2024 11:30:15 +0200 (CEST)
IronPort-SDR: 66432f27_z9GVU/5sGFfrh1uhU9xSEFHby+h6MuStpoSJ3S5WNTtF+CR
 X215GXxTgvL0ntqKdJkbTQrawYtVdDj9XMrbxZw==
X-IPAS-Result: =?us-ascii?q?A0FfBAA7LkNmhk7ASNlagQmBT4JEgQBUMwQLSIRWj0iBd?=
 =?us-ascii?q?YRrhzmHT4hxgVaBQD4PAQMBDUEBAgQBAQMEgguLNgIeBwEEMQgOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEhGQcOECeFdA2CYBiBDoEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBFwJHax0BAREnNAImAnMBAYJ8gjABAzEHsUCBM?=
 =?us-ascii?q?oEBggwBAQaCZ9dyHywiV4FjCYEaLogUGgEFZ4l3D4FVRIE8iFGDDoJpiCEBk?=
 =?us-ascii?q?XiQP4FRHANZIRMBVRMXCz4JFgIWAxsUBDAPCQsmKgY2AhIMBgYGWQYaFgkEI?=
 =?us-ascii?q?wMIBANEAyAzPhEDBBoECwd1gysEE0QDgTiJdYM7gh6EHwhDWieDc4F2DmGFG?=
 =?us-ascii?q?4UrHUACAQttPTUJCxsGQL4NkHqhIDQHgjaBYIFhDIh9lkcGEy+DcgGTRQ4Gk?=
 =?us-ascii?q?miYYqM2hVGBZwI2gVwzGiSDNk8DGQ+OOoQUx2xBNTsCBwsBAQMJhUYBAYNag?=
 =?us-ascii?q?UgBAQ?=
IronPort-PHdr: A9a23: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
 27z+6rLITmJ0TXkBUjHDA==
IronPort-Data: A9a23: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
 c42ohXNA/R6/n2lqSv/KBB2bSeLC842Hk41xH0=
IronPort-HdrOrdr: A9a23:DjurNaCoVxszF4LlHem355DYdb4zR+YMi2TDpHoBKyC9E/bzqy
 nAppgmPHPP6Qr5O0tOpTnjAsS9qBrnnPYf3WB7B9eftWfdyQiVxc1Zg7ff/w==
X-Talos-CUID: 9a23:eWIkM2866QSDfFwtD+GVv0EYBNp5aFP89mWOL3aqFl9IZuKcc1DFrQ==
X-Talos-MUID: 9a23:V9NnqAUo8didgXTq/GXHjQxPDcVq2qL0Tx8pwZVZseqZKhUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,159,1712613600"; 
   d="scan'208";a="165612445"
X-MGA-submission: =?us-ascii?q?MDHnoHYxH78LLxv5oSuaVPXL7XzcrHzlci6u0z?=
 =?us-ascii?q?TlbqxDn2ikixSnCQsF00OtvSicNfixDSUWNyDRn2/lWjg2z/C86TneJ3?=
 =?us-ascii?q?UT4dW0I8rhAAZy/2pIO4KS0HjjznXKmyPTai8gJqmLaNKXQ1So/l+sKA?=
 =?us-ascii?q?5bsTIrMI7jys2qMZPzBophqg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 11:30:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715679014; x=1716283814; i=markus.elfring@web.de;
	bh=M57ITw7V50IjG0UlFd5VTLDi2rTJCu/hxUEtOvhOt+4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BQBzVO3c4r13UdDCLsIXD2o5HUsikBAETFmeMuMe85mbRYGWysqT+LQtIGLDB8h+
	 o9rsjjqB/llOb1uZGomEjmgMIUO+dA81B0lUolNpBkdO1U9RprtdZ8P5rCuQHPHDK
	 4Pp+xdVjTn7ADa6rqaGJSAjQ90brb42/tif4xR1sn3TBsZ/wsKpi+4DFXV8TMrnoQ
	 rrdmV/7a+cTwBVA8QxFoG1CsSbaTeHMCpGoXFME5D1boDTkw5Mpm9Ws/V0yjemRhL
	 yr/Dpqb4CTe4+cU2CbFzVad0uBt/tnVQ50RMoSj8dFq7pgODv+A2B9WeOtBDjU+ak
	 WIWzt4VDjm9LggE2aQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdfCN-1sfsBg4921-00nvPy for
 <cocci@inria.fr>; Tue, 14 May 2024 11:30:14 +0200
Message-ID: <48e0b9a3-dfa0-4e39-b049-93faa76c0735@web.de>
Date: Tue, 14 May 2024 11:30:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1aisEfcFguK41mMdT/05agpK4+QFCRMZc3HyVeEMHlVP51CPnfE
 DqsImVs5z2TqSaNin3dToYXUN8alZppJjCbLuXM7SnBXt3hLTjWmQdvElfIMNWMM8nF8nyj
 mTitHMnibsleIi87GhqitsKYyBm9K73I7T6nlKsxrfmqWJ4InpeVy4L6I4ly7cHvCCZM0NF
 P1Q+xfRVQ/ctbGDiYEnhQ==
UI-OutboundReport: notjunk:1;M01:P0:zC4GOSvg+Io=;aPw6iR5tn/F5sr6gKqJuc4cS0A+
 XdEgO3RHiLwLC7g2abX2JOfZUKNFEvTFZjL+Dr6ADlLZQ0hfnt2edua4bCiRJp5QuVz7agmA7
 9bbyCqozW2It2VxBXZlWh/lugQ281m9QpLd1FmetCfohvrPDxUoAB66p6XQKQf3ImE0ZesCRK
 dD0vVQ8JAdZoL8rSbjEntIntIhygf1CaBwREouUEw66lNWSoDo1V1c2AwucxfgUzFK0UZ7BMH
 EbbuugC/YEtsOdhi0HGnQs0US/mFXmfnk2ozpdbpJownTrkRvRhHaxZzbUc9EWlXoDvaEZdTb
 9QxxYSbvYIkgdW4Op+sw3Q9oz1lgZBvdARK16TIyQTDxZMb5hn+rm6iAldm/V5PyaK9+wZcCX
 XIgZ0ZIxZR0jbJvZpwBQWAh12MCJVnxsgYCVFus4eTB5ssf9+BZ+z4SLdkH7CKornwKyuGwqN
 eE29HPd1TyjA3PCOzSQ4ELtDHMJmo2LKY5E4CpLo9mNdOW3bziqZK438ilzzSauOOLUmIEvQC
 pTTmPifu1sbCxn77I96GNuli30ikk0GkudoMk4UlwzOvvjo8EUwzr+HMRPEiM9dEe66yrJ5Yh
 byLAOQuxoDZt+NbCy6sdnPBsy7NSLiqizADM2v+BGgYwoD9kcvUWuQSLLJm3C0OzJNDDptIr9
 x7Fg2tg2uir3+Bestgc6aVkAXejm5vVAnp+gghsBGRMVlmWBL09/jLxBwLDzVqXd3Y7J+K8nZ
 VXcKLCbExKGIV+QOV52lG6Ymco2UoQUdXt9QBf5RJIZAVrffo+IqGiND9f2/lJoUtTUjOVvME
 BGKU26MGr1c0ZtSvdIfuy4UpYz/oboaKFTY0zQewA1KF4=
Subject: [cocci] Checking CTL code?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1737
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/48e0b9a3-dfa0-4e39-b049-93faa76c0735%40web.de>

Hello,

The Coccinelle software supports a computation tree logic variant.
Can CTL code be directly passed to a corresponding tool for further analyses
and system tests?

Regards,
Markus
