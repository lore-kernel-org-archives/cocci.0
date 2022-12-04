Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0E2C4321E
	for <cocci@archiver.kernel.org>; Sun,  4 Dec 2022 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nUEUMZID0y1NscXN8JkEFPleBP9kPgBDwkbNP1gmyHo=;
  b=aiFeCPOCCgkE0RYReO8idk0yRkTt9wtPaz3JE3pbmm754PgYL15y3gSO
   vn5InnmLrsVyJF/SvBfgv3akdMild/Agy0bTj3w6r0DcQUs7/4DOJsucd
   12fy0wJENILhVQoT2U5Nm8XpXayqvaJ3L23GNNGci3cKUQ2itmstA7fcd
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="81598203"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2022 15:54:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A7CDFE019F; Sun,  4 Dec 2022 15:54:39 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CE548E013A
	for <cocci@sympa.inria.fr>; Sun,  4 Dec 2022 15:54:38 +0100 (CET)
IronPort-SDR: 638cb4ae_zw6tjD0xyomxTXrRGXZztRD0yhm+QO5rk/b2WNRn9bBoSW8
 zwxcz8hc1PBu09hrAqkNEUCn7ezdKLMEFqw69DQ==
X-IPAS-Result: =?us-ascii?q?A0GpAQAutIxjmBOg6VVagQmBT4ItgQVWLgcIRYRPg0+NU?=
 =?us-ascii?q?J8zDwEDAQ01DwQBAQQDgguCcwKFDwIeBgEEMwYOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAQBAQIQAQEBAQEBAQEVCRkFDhAFIoVoDYI1IoIELA1Se?=
 =?us-ascii?q?AECAgEjFUYLCxoCJgICVxMIAQGCegGCfyMDBK5ngTKBAYMWnEGBYQaBFC2RF?=
 =?us-ascii?q?xcQFgaCDYE8D4J0PoURgwqCZwSWd2IlBA4DGSsdQAIBC20KQzUJAhFMKxwbB?=
 =?us-ascii?q?4EMKigVAwQEAwIGEwMiAg0oMRQEKRMNKydvCQIDImEFAwMEKCwDCUAHFREkP?=
 =?us-ascii?q?AdWNwEEAwIPIDgGAwkDAiJUcwIuERUFAwsVJQgFSQQIOQUGUxICChEDEg8GJ?=
 =?us-ascii?q?kUOSD45FgYncg4OEwNdgWkEM4F7XZhUg1qCeqItoBqDc4tRlHQGDwQug2UBk?=
 =?us-ascii?q?woUkhaXP6d6gXgkgVxNNASDIk8DGQ+OOYNZil5BNDsCBwsBAQMJih8BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 u3yNpE90tZdD32pqSsuCiSHvNpa
IronPort-HdrOrdr: A9a23:I+3/UqE40Dno88HCpLqE68eALOsnbusQ8zAXPjNKKCC9Ffbo8f
 xG/c5rsiMc5wx9ZJhNo6HjBEDEewK5yXcX2+Us1NWZNjUOaFHYSb2KhLGKq1bd8m/Fh41gPM
 xbHZSWZueRMbE3t6nH3DU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="41672558"
X-MGA-submission: =?us-ascii?q?MDGhHsaWJGvfxgW8kkvjtm31nc8ae5KzMsfpIa?=
 =?us-ascii?q?KBnlako2t6/K+HkOpknwGXg3Q2Skey1RjfDf8sJnrGNUV/pwwIN48l33?=
 =?us-ascii?q?0ydIqyKd5mMEB33weNEEmPv8QpZ0PhzIG1zpKzYeNd7pmDtkqncyjQ5L?=
 =?us-ascii?q?EcyezovPZpoDg/u0M7ekZqqQ=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 15:54:37 +0100
Received: from [152.37.86.21] (helo=[192.168.1.100])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1p1qO5-0008ps-AY
	for cocci@inria.fr;
	Sun, 04 Dec 2022 14:54:37 +0000
Message-ID: <0cbd1764-a998-f89f-2a05-b2d50e91f3d7@knosof.co.uk>
Date: Sun, 4 Dec 2022 14:54:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: cocci@inria.fr
References: <a9cad00c-ede3-338d-da7d-801dab7d51c2@knosof.co.uk>
 <alpine.DEB.2.22.394.2212040832050.3337@hadrien>
 <b404ba8b-df56-1f22-c0c4-a3d3be6aea30@web.de>
 <414c04de-1014-d41d-dfb6-774a8666f22e@knosof.co.uk>
 <alpine.DEB.2.22.394.2212041501550.3337@hadrien>
 <579b8cb5-f08a-df16-567c-71c1eca4a617@web.de>
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <579b8cb5-f08a-df16-567c-71c1eca4a617@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Clarification for SmPL search techniques
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 771
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/0cbd1764-a998-f89f-2a05-b2d50e91f3d7%40knosof.co.uk>

Markus,

>> If you write something that you think others would find helpful,

My plan is to start a github page and use Markdown to
make it look reasonable.

> Some information sources grew through the years.
Everybody probably has useful tricks they use that others
are not aware of.
A concentrated summary would save a lot of searching.

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com
