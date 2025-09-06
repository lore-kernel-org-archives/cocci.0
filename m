Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3D7CA1012
	for <cocci@archiver.kernel.org>; Sat,  6 Sep 2025 08:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Fb8lNKGxMfemdVOMcRSD+mEPAzyA7lG/FS7ovzi5NIg=;
  b=PBBA3O23df2QTHII0WQ+ekDL3pW3+acwtRI0SK+FfA+jmyB/8dLOoxew
   awj+UJAFWT8ZAuqTFT+tdJ63hWz3bcGIyz/ssxFsA0BZf/QvKKycjPSq4
   AfOlcHCbswk9EgD2l4Mn4OXcRYuIv6lD1ux2QKyvuaQzrs0ufk7BSbeu9
   8=;
X-CSE-ConnectionGUID: 7AXxaEaqSEqc0HMCeU9OUA==
X-CSE-MsgGUID: U3U7dVykR0my2nU+60gnrQ==
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
X-IronPort-AV: E=Sophos;i="6.18,243,1751234400"; 
   d="scan'208";a="237804405"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2025 10:10:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F1A31E0BE9; Sat,  6 Sep 2025 10:10:49 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 281B4E0171
	for <cocci@sympa.inria.fr>; Sat,  6 Sep 2025 10:10:46 +0200 (CEST)
X-CSE-ConnectionGUID: fBN2JtH6Q/29TjzQOcEimA==
X-CSE-MsgGUID: QxbaeyyGQKK2MDZK3Frn3Q==
IronPort-SDR: 68bbec85_2hn98zpmtaw7d5jY0UnaS8V9YHFWt2D2ZFpjsvttxUtPaDW
 uA0hc7sjcLzI8YO74EGDgKCclcT2yT8/H4b/XyA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ERAACB67tog07ASNlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYI/gQdUMwQLSYRViByHNIIkhDuHPIdViHmBVYF9Ag8BA?=
 =?us-ascii?q?wENTgECBAEBAwSCDIJ0AowpAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBD?=
 =?us-ascii?q?QEBBQEBAQIBAQIEBgECEAEBASEZBw47hk8NgmIBgSSBJgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARcCR0QBAQECASMdAQERJw8LGgImAgJWBgEUAQGCfoIjAQYQAQMPJ?=
 =?us-ascii?q?gexRoEygQGCDAEBBtpfHywiWYFkCYEbLgGFa4JkAYYnhDwnD4FVRIE8C4J4P?=
 =?us-ascii?q?ogegmmCJoEWg1iPCUeIRVJ4HANZLAFVExcLBwWBIEMDKjQxI0sFLR2BJ3mDB?=
 =?us-ascii?q?4ENhB4rT4IacoF0PhlAg1MeBmsPBoEVGUkCAgIFAkM+gW0iBh8SAgMBAgI6V?=
 =?us-ascii?q?xCBfQICBEtAAgELbT03CQsbBj2Vc4capQShRTQHgjiBZ4FkDJ9sBhMvg3EBk?=
 =?us-ascii?q?2AOBpMFmQYiqR+BaDqBXDMaJIM2TwMZD44hGYQaujhBNTwCBwsBAQMJhUYBA?=
 =?us-ascii?q?YxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 nYL
IronPort-Data: A9a23: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
 IT+eYyIrIxXh6I8/QaMtkO5wC0kgQ4=
IronPort-HdrOrdr: A9a23:6QiUN61s5u722UL2/s0rBgqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:hqWwpGNJkNegR+5DVgNBrmwIOp4cNSeM8HXCGmizJGdsYejA
X-Talos-MUID: 9a23:aTh4KAXjKf17ixjq/Ab8jjhvJdZH2oeNUmUho7ZdldOCbhUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,243,1751234400"; 
   d="scan'208";a="124815643"
X-MGA-submission: =?us-ascii?q?MDHrxMG3WtoTndN6B++OULfvIO8bTFoqda8MG8?=
 =?us-ascii?q?CtjAcRnSav1A5i6A69/TzJWPjfaCbolLrcDg/ppmqBFGCedi6quP3Lde?=
 =?us-ascii?q?RWijzFJed2zeJAMhZiDxuNBsnJgd/Dbh4R6cdLn3AJVRJVGkgqSVjTfY?=
 =?us-ascii?q?PxoA4CmaWVGEF6by/gJmvoRQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 10:10:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757146244; x=1757751044; i=markus.elfring@web.de;
	bh=Fb8lNKGxMfemdVOMcRSD+mEPAzyA7lG/FS7ovzi5NIg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cD/boyIEobGR0KrCOzewclMe/OfX1UhJBaSSMTTqgrIeqXs73T9ziR94rll6tNEf
	 GZO7yjCpYaYkCsOTtjGOcDD9CK/krylTIFmbmXXklw85UXeqBTDJMD3D5mVm50WqN
	 +ymRKDu17ovw91zOcuaDysWZlMuR+v72PUBKyemCA+d0OUVxb+EFJ9oHfP7cvqZIv
	 xZCM+E4IEd3Nv+olUe5OIXXQBWmvurdzoTs3249eV338WwBre9uZQwh6wsGqyYnfx
	 JDEd3xlTAyVqfg3PxSmFJ1e/+pYycIAuqhNUc/rvxRLDbMtHCk5mkwWAjNg+0UF9d
	 fEub3QrtzAvjAPVg+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmhjw-1uDBSs25NG-00iDsc; Sat, 06
 Sep 2025 10:10:44 +0200
Message-ID: <b0221946-43a5-43c0-8573-32c12e149681@web.de>
Date: Sat, 6 Sep 2025 10:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
 <f798ce14-0401-4116-bbee-2b78ad0f774b@web.de>
 <4c46da9-1fa9-9b4f-f0c7-6c7fd094e163@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4c46da9-1fa9-9b4f-f0c7-6c7fd094e163@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FXyod+/s+O+b2J/6lpSanVyXiMm7U2G0HYWZtjt/QZ8Ij18QwGw
 qvjW4pYsjyvjk60sB7aOHYTIlPnxuYrLVsu/S4ECVfTU63yhAy+I38UG9uM55F1F61aIfJv
 Zot7An3UaDJTYnWuSH6zHPK+1VEl/KDlGflYmXRq0Y24VLu4+BLRLs3/98+YAi1UTmGSymn
 KVCqzjZYPq8h2sE5SCrvQ==
UI-OutboundReport: notjunk:1;M01:P0:hIf3KhrtoAE=;z581C82U0sznBahWk9GM/7b+vTW
 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
Subject: Re: [cocci] Searching for selected variable assignments (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2998
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/b0221946-43a5-43c0-8573-32c12e149681%40web.de>

>> Such an SmPL script can become another bit more generic.
>> How can be achieved that the search for variable assignments will be repeated
>> after such a statement was found?
> There is no after.  Such variable assignments are matched throughout the
> entire function.

Do I indicate a desirable extension for the Coccinelle software?

Regards,
Markus
