Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBE4C7EE30
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 08:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=qbC5ed657bbNkodDQsyy430UbZCqkFkhzqAtOYQXWoA=;
  b=VMw3X5JZXfiWUt7G1XssRtqLPCsjwsvilQSUtEk1P/ViVhAsKn+up2hi
   35yDCVyFgXRTarzc0NbYPEbKDdHnx0hig0r91FAEzp2Fi/IiPDO7hbvGP
   DoUSVERY9vglP+fRmMTT9JirHzMdmgNJkPwqfXDzjk318kefPBMchxV1d
   8=;
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
   d="scan'208";a="229733592"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 10:01:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 67649E01A8; Tue,  1 Jul 2025 10:01:28 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DBDE6E0157
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 10:01:23 +0200 (CEST)
IronPort-SDR: 686395d3_J5BXX4D6sP4R7uRsVjNWWHf0ulr4tTl7QA57JQ4yQszH/Ly
 YIrJN7cuQg63ML3gPb21qzFEub9okfdniOIJdnw==
X-IPAS-Result: =?us-ascii?q?A0HZEQBTlGNogAMP49RaHgE8DAILFYQXgQAGVDMEC0kIh?=
 =?us-ascii?q?E2PUIF0hGuPD4h3g1ICDwEDAQ1ECgECBAEBAwSQdgIeBwEENBMBAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CW4EsgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAg06bR0BAREnNAImAnMBAYJ+AYIhAQYQAQMyBw0GsHKBMoEBg?=
 =?us-ascii?q?gwBAQaCadd1HywiWIFlAwaBGy6FbYJKGgEFbYoYD4FVRIE8C4YXBIIrgw6Ca?=
 =?us-ascii?q?YImgRaEeoQXgmeMOIFKHANZLAFVExcLBwWBYwOBDzI8Mh2BJ3+EcoEOhCsrT?=
 =?us-ascii?q?4UTQViDUyRtDwaBH1xAAgELbT03CQsbBj2SWYRlgkiTL7J4NAeCOIFmBYFfD?=
 =?us-ascii?q?IkHgSaVPAYTL4Nxk1sOBpMCmQWOB5VchVmBfyOBXDMaJE+CZ08DGQ+SITO7T?=
 =?us-ascii?q?0E1AgE5AgcBCgEBAwmFRgEBiAyBSwEB?=
IronPort-PHdr: A9a23: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
 hBjfkkLorDCtEuwY916HHFdqGVoJ6+IlnTBh9Q=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:5oxLEKgCcyDnXfkOAA9EPoTf3XBQXvgji2hC6mlwRA09TyXqrb
 HMoB19726StN9xYgBFpTnkAsK9qBznmqKdjbNhX4tKPzOJhILLFu1fBOLZqlWMJ8SUzJ856U
 4PSchDIeHRSX5nkM39/A60KNo4xsKbmZrY/ds2g00NcelwAZsQiTuR5zzra3Gfz2R9b6YEKA
 ==
X-Talos-CUID: 9a23:rKMgtGBdqyjY+jr6ExI+900bINInSWLmxVz5DlfhCW9YY7LAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3ACcVG1wzfTsKvrs25NkvCqBKa3nGaqOO+ARxUsrk?=
 =?us-ascii?q?egvGZbzJrPzutiwibR4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229733571"
X-MGA-submission: =?us-ascii?q?MDF2bWqVAPKVhnRD8FwFiacqlDHZaiJyq0yv2f?=
 =?us-ascii?q?MABXR3Qn3WaFbReodH7ZyXNIAP90BDKUzJSBldVgdDiENZniEpljRnxa?=
 =?us-ascii?q?2fRUnP4Oti2UH5vXlAhetjvcEM2TXC+Eg0Iqz/ZyORD2kqM0iTvCKryR?=
 =?us-ascii?q?jzMVaywhIa28TJm8PazgjbNA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 10:01:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751356882; x=1751961682; i=markus.elfring@web.de;
	bh=qbC5ed657bbNkodDQsyy430UbZCqkFkhzqAtOYQXWoA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CGbuwcN8con7h2m18lINYsN++0eqNEf3lthi8FYbysuOG6deyXXx0AysiRWxlMW2
	 W8lc8xgD+Fm0Du3b51B2jYdIJ1ENBNERHYQ7zCJ1W0j8cQ0z2iMd4pyvz9/TH3dW9
	 UnOne+dfSQF7PvQQyoxPrSjMFVqGlEbeyBUCCmP9CX2+S6aCO2fPAMk/L87V2NDy8
	 XVDNnVowX9d2IUC9SPk4VPnz3T5KGhTmUHGcpLCEaOTYPB9tcQ3AduQoY867D61gj
	 QuuGfQwa3si95UmDcVYCWoRAZktOUeGV51AikAj8T1OJJwEUnapDjYcFLFVBrXUEv
	 yxidWVbQ4YuV+0PPcQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDvDU-1uOqQw2Jj2-006ayG for
 <cocci@inria.fr>; Tue, 01 Jul 2025 10:01:22 +0200
Message-ID: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
Date: Tue, 1 Jul 2025 10:01:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/R7ealPbbs4e0bNa0dLqZVZ9SEJCQ1GrQIO+WbHTUeT+l/3r8oZ
 onClMfbkrRLPv6cOrX+VgOz6bHqFBnnElXsI5FPAwuQ8XRrrj7Y/sW3z1EAOJI3Tg0q6G4m
 De/yi7rVd8wycpkqUXweTVsBVbzycVVSA/CYehiPewuxphEbIfgB7cKzqqkf2/WGbMMo+eD
 btj+ZgwdNg2QZZXfUw4uA==
UI-OutboundReport: notjunk:1;M01:P0:1z0cYr8MM6g=;wki2guumv2mSkBvwGD3T6W8Nogw
 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
 Qzbyms3NZ9g==
Subject: [cocci] Searching function implementations with more than a single
 return?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2828
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/3675aefe-7163-4b02-a4ad-07b7a23a4b13%40web.de>

Hello,

May I expect that a function like usb_ss_max_streams() can be found with t=
he help
of the following source code search pattern?
https://elixir.bootlin.com/linux/v6.16-rc3/source/include/uapi/linux/usb/c=
h9.h#L721-L737

Another SmPL script example:
@display@
statement list sl;
identifier i;
type t;
@@
(return ...;
|
?t i;
*sl
)


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/show_functions_wi=
th_more_than_single_return.cocci include/uapi/linux/usb/ch9.h
=E2=80=A6
real    0m0,245s
user    0m0,214s
sys     0m0,028s


Regards,
Markus
