Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAEECAC5AE
	for <cocci@archiver.kernel.org>; Fri, 26 Sep 2025 13:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=BPY/DA1LOzOXuAQJliIqCRfR9I8W4bbGdezY+STxzog=;
  b=utfKAMVwPrn/sLMvOBKz5XdxbP/3A7AJyxub2H8TX9xxZTvkA3ZkVBK3
   fTXrvkh/rHkIzRreQO2A+tcFvlsswmD/heZEy4z2lGcJCUveQE+T6AfO0
   9Ojjq0rhKDDClBtLPJgkbsZaXceQaY3vOho5DljVnUjIBXfHqRMk0/fLH
   I=;
X-CSE-ConnectionGUID: lxxz1AWPQl28pJvTwWypzg==
X-CSE-MsgGUID: IqyH46EeSAOdw5DoTR8BMA==
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
X-IronPort-AV: E=Sophos;i="6.18,295,1751234400"; 
   d="scan'208";a="241232647"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Sep 2025 15:50:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1568AE0CD8; Fri, 26 Sep 2025 15:50:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 460F1E0171
	for <cocci@sympa.inria.fr>; Fri, 26 Sep 2025 15:50:43 +0200 (CEST)
X-CSE-ConnectionGUID: oxv9i25MQ5OGTaFNxeybOw==
X-CSE-MsgGUID: YJj61eaDTva6oy7ontmmIw==
IronPort-SDR: 68d69a32_FaKTOMuxHlEMtMg62gARjCRBxaFSce662L1WZOpLgQNJa36
 lTv8elc3UiI/V9wex92aNKrKe+XFgBrr2Puh+VQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HKAwC7mdZogwsR49RagQmBU4JAZR0GVDMEC0mEVY9Qg?=
 =?us-ascii?q?iGEPo8RiHmBVYFAFicCDwEDAQ1ECgECBAEBAwSRSAIeBwEEMgcOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQE6Bw4KMYZPDYJbgSxeS?=
 =?us-ascii?q?AEBAQEBAQEBAQEBAQEBAQEBAQEBARQCCAU6JEkdAQERJzQCJgJzAQGCfgGCI?=
 =?us-ascii?q?gEGEAEDNQcNBrY4gTKBAYIMAQEGgVhBUNd2HywiWYFkAwaBGy6BYoQKgkoaA?=
 =?us-ascii?q?QVuihcPgVVEgTyGBB4CAQGCK4MOgmmCJoEWgVWCAYQAjQqJU4FKHANZLAFVE?=
 =?us-ascii?q?xcLBwWBYwOBD24yHYEng36BDYQeK0+FAj5ag1Mkaw8GgRWDW4kqQAIBC209N?=
 =?us-ascii?q?wkLGwY9mBiBAIMbLSoCgRGBLJM8kTyhRTQHgjiBZwWBXwyJCIEmlT4GEy+Dc?=
 =?us-ascii?q?ZNhDgaTBZkGjggWlUqFWYFuATOBXDMaJIM2TwMZD446g2czhGDDNkE1AgEBA?=
 =?us-ascii?q?TcCBwsBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 nPgJJvnII5VOoCpgyRf
IronPort-Data: A9a23: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
 YT4qa6oja17pYPM/R5cRkNo
IronPort-HdrOrdr: A9a23:9Za86qznKtB5WumuuQf5KrPwDr1zdoMgy1knxilNoG9uA6+lfq
 eV7ZMmPH7P+VIssRQb8uxoV5PufZqxz+8W3WBzB9mftWvd1FdARbsKhebfKlbbakjDH4BmtZ
 tIT4g7LsHsBl5nisvA7BC/CMtI+qj+zEnlv4bjJ2wGd3ANV0iM1XYBNu4Rf3cdeDV7
X-Talos-CUID: 9a23:F0wn5Gwy46XeWHvgbvNaBgUTCt50cyeA6U6NBGCEAEhPWLCEQ3iPrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3A8VOAsgyB0Z2AKv3XR5h7uIl0gi2aqJWMCh5UnJw?=
 =?us-ascii?q?qh9eNaythZDCbkDGyY5Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,295,1751234400"; 
   d="scan'208";a="126667363"
X-MGA-submission: =?us-ascii?q?MDHZ22mtIVU2cGJHVxkOv2udYtYjBe4LW0qFQW?=
 =?us-ascii?q?0k23VGybJUeHqDApoebtOJg4dB+/xTHR5GY9VD3Cn1CCV25C2GvcIEpU?=
 =?us-ascii?q?4/ivLHBDVjnJhKQvWvOV7HobXTztVx5u4Q81Q5DIpzJI47wSNy69Sfrv?=
 =?us-ascii?q?4j2Xk1igH4ZwnZCsQS95eKNg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 15:50:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758894641; x=1759499441; i=markus.elfring@web.de;
	bh=BPY/DA1LOzOXuAQJliIqCRfR9I8W4bbGdezY+STxzog=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Gzu97NZHeHAihFQ8M88lLqKDK4HopdYfojmAs4cgvXhw+IEWblYGFDbG5s1BDcsa
	 qEmw6T7b8PRjTwGB7rMPyO1OAgn59mKpFWw6aDlnEiEKEIJwqXNW0469gKlVXyLoO
	 rPi0WQZ1AFk01CMaFje4AH6lrgyRVg5654gnkGAo2YhQQ3HKQBli9DW670OeWfzeJ
	 buCcyHWIhC0K0Rwz37oeolBrY/bhOrToUV0tu+Uke01XzeJu1BVxCTqLUA+Dr2BuM
	 zNlUqvyura8KtgaplUNb0kCxTZp8wQwcxlVczO+f/FpIUSpkR8zikxMr6rz3TKa/c
	 //qYQX/bJ8E0K5/H7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZMQ-1uXDvd13qK-00ZlXQ for
 <cocci@inria.fr>; Fri, 26 Sep 2025 15:50:41 +0200
Message-ID: <c9dab7e4-402b-4f3a-8a10-f7665e38eb1d@web.de>
Date: Fri, 26 Sep 2025 15:50:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Q3b/inC3vkwyDWvAWowtt0DePOcTpuTluM6Ws8kYSsHsqKFn1mg
 JD740vQisi6etjaYwlgoZdu3LbaSMlzN7cohl4R3kEKEidDmcL5Q2VURkVeR9JFN4sc5yvl
 oTPmEY5PJnB/fcyHkge/cwxMubTb2iOEX3mCEa8BhRT6QiR7Tp/dBCCvfXSMSG8wQoGbU2t
 pBYNvAu6UM0MY6xcT1dcA==
UI-OutboundReport: notjunk:1;M01:P0:Eb9gn9W1gvI=;GiwmlK2zRrzGtjViSZRPFWe2zMx
 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
 VkNOr1xvULoo9YHnp9k2sC19m4F5O+1w==
Subject: [cocci] Support for SARIF (by SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3042
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/c9dab7e4-402b-4f3a-8a10-f7665e38eb1d%40web.de>

Hello,

The Static Analysis Results Interchange Format is published as an OASIS standard.
https://docs.oasis-open.org/sarif/sarif/v2.1.0/sarif-v2.1.0.html

Related background information is available.

* Tutorials
  https://github.com/microsoft/sarif-tutorials

* Structured Diagnostics
  https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2024/p3358r0.html#static-analyzers


How do you think about to benefit any more from source code analysis
result output in such a standard file format also by the means of
the semantic patch language?

Regards,
Markus
