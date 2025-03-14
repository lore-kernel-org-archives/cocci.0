Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341B3C282EC
	for <cocci@archiver.kernel.org>; Fri, 14 Mar 2025 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=ErdAUNxFnl8a3q7R2K6I4y5BmQbu0eqLoFtEdY9r6Rs=;
  b=oSp9gOzvOjA+VJeagTz+och1ESpDwNAZ2u5yjq/3OoCVOIDFZfVguuZ1
   XiYZdBHQicPxsUGpx1bmoK+CKlwO76BBmF40NqCKI6+oB5zpz3mCFS136
   jJv6FA7/LU+eLchF8o3NYIsE9tvxAFprfEWvTfTCJQUexdT+ci5V2SqmA
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.14,246,1736809200"; 
   d="scan'208";a="212837324"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Mar 2025 08:52:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 32FE1E0264; Fri, 14 Mar 2025 08:52:34 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2CA3BE0260
	for <cocci@sympa.inria.fr>; Fri, 14 Mar 2025 08:52:29 +0100 (CET)
IronPort-SDR: 67d3e03c_2HTcqW3HrY//VnaD6p9f72Ai36dldGwI5Dgc2kzfCrnevNn
 w0a7fy2agcCdJfPE99rF/MFF8Lag7J5P/re437g==
X-IPAS-Result: =?us-ascii?q?A0E8CADc3tNng07ASNlagQmBU4JEYhtaMwQLSIRWj1CBd?=
 =?us-ascii?q?IRrjw6IdYFWgUA+DwEDAQ01DAECBAEBAwSCDIJqCoseAh4HAQQyBw4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBASEZBw47hXsNgluBLGUJO?=
 =?us-ascii?q?AEBAQEBAQEBAQEBAQEBAQEBAQEWAj0KRicdAQERJgE0AiYCXxQBAYJ+AYIvA?=
 =?us-ascii?q?QMxBw2vGYEygQGCDAEBBoJp13MfLCJXgWUDBoEaLoVtgkkaAQVthTWDQoEhD?=
 =?us-ascii?q?4FVRIE8glKDUAIDgiqDDoJpgjOEQGeZd4R/imyBTRwDWSwBVRMXCwcFgWwDK?=
 =?us-ascii?q?jQxMoEUeoJDaUk6Ag0CNYIbJFiCK2oEBYNahDyEP4VQghGCCIIxhUiBM4RhL?=
 =?us-ascii?q?VFoHUACAQttPTcJCxsGPaFvbDuFUitglFo8kSyhPTQHgjiBZoFjDIkFgSSVN?=
 =?us-ascii?q?QYTL4Nwk1YOBpJ8AR6YYCKNY5VWhViBbgYtgVwzGiSDNk8DGQ+OOoQUhGDED?=
 =?us-ascii?q?0I1PAIHCwEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nLt7Ja7tcT0KIrBXOAPXwBDXdLJyesId70hD6qm+c202TiXqrb
 HMoB19726TtN9xYgBGpTnkAsK9qBznmqKdjbNhWItKPzOJhILLFu1fBOLZqlWMJ8SUzJ846U
 4PSchDIeHRSX5nkM39/A60KNo4xsKbmZrY/ts2g00NcelwAZsQljuR5zzranGfz2R9b6YEKA
 ==
X-Talos-CUID: 9a23:tyU4sGyGQK2H8k14fFg+BgU2M9JiY3r9zU7wIhGUGThwUb/JdVGPrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3A9zSQMgyulmd5idemXNYlMjq7it6aqLaBUkkPtYo?=
 =?us-ascii?q?6gNS/LykvBgewrQ20RqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,246,1736809200"; 
   d="scan'208";a="111537539"
X-MGA-submission: =?us-ascii?q?MDHFFiyZoCFg2WKmsEBQHnrzJwQoPCLxsMLe/z?=
 =?us-ascii?q?HUV+tthOn5hih0vvgDOE8SpdJGfF7tFk6UvrcUeIP++4AKSmGYGw8fZz?=
 =?us-ascii?q?IJkbo5MwPPT0Cp9qB6qqVAUpPgn+G2gmxXfhNR56SuE0Jr53Ybryj+7f?=
 =?us-ascii?q?F1XZi6Jq3NTmHHthxrBqWNwQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 08:52:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741938747; x=1742543547; i=markus.elfring@web.de;
	bh=ErdAUNxFnl8a3q7R2K6I4y5BmQbu0eqLoFtEdY9r6Rs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MvRrSmldxccUSN8/HXP7Fq/Mas7tSNgniMmUE8NvG0S1JdwlPpRceLfgJjzTEZXP
	 uwKhuY37CYK2r5mnSOs9bZaqEMONAFwlX/1lvz4Ph2rTVHLPh/cPlFtFnzM22vtTn
	 AKTqyIDmZytYTLU2ToVvTjZfcnGqL0Io/LaJMuZx1gXBKuIpjLFChh6Sx4pD8L4le
	 7Z5GH4xg3Cj9Rc3FBFHXoueBnotJ5imNWWKK1H77KdWgwQvTq1WV9203S2yI8mhi6
	 ofGN1GrLlEVeHu91WGTR9QxvB4ZVL7hAWLZEV0OAfENk2ssqXEmCk344XHdIB257Y
	 z6UibC7QR72WGHhv0A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.20]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4627-1tAU9q04aP-00yacI; Fri, 14
 Mar 2025 08:52:27 +0100
Message-ID: <8f9fba3e-3b89-4e24-9b0e-d56d31ac6712@web.de>
Date: Fri, 14 Mar 2025 08:52:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BLEvzTlZ6bcuoj9VTygyG3sonrQpON87rJsJacYs/FFDYg8CHQf
 Nf6VOSvOEkjmah8pUul1bGafdO8mhQYPrCMM4QPs2bcr2JwVnA6iWPrYQFpdn9V9VfFiYU8
 ElfXdHh92PL0pJL3YTVltLMPVWbni6j34GwGXDlzCwy03+42nuV3YWcK5xuBdKW8aHbllzb
 AhWYWSUxcapIEOQVCg27w==
UI-OutboundReport: notjunk:1;M01:P0:rUiU2A3Owfo=;Mjebt+AD2WYiOeBMrgAPCkbvVA6
 A7kFQTGw8qbi3LhjXfljzFKXvjEh+wt4R/JazxbH9bgs+kPYUFicNqHTJCMEK180RlvsP85yi
 /OClHXFY1aPEJAfmQFebUR+RHVNXIOVN/LGKL0RMMk/gOvYqL7mwZgG2uUJrXN/m+uM+7eLcV
 KsrM1EphVc0YjZg1C4shIA6/0bl1lIE2QqiBUgX6CNXN+x2NVrWgYrrbFBgEsEZthqa9I/zmJ
 VbIr/Yz1DMZi0dIQftiUYoIzClP7HUCvVg+U+6UsgMhMQxGNtcMCom7mu4WXhzDWNzzfbY6dD
 eqtCbsgItYBbITf1r32tMq31O9cpDmpRTFKsQiCvqRYyI7zMr5Zf2l/y5fveyzXic76AnuHPe
 z2K3+2CpAdmjBDlCNDwVDaMftCKbfqvadIsLRuUxEonJOEbAdJ2mL5Ui3olboEPBbUxLRJ+Hb
 hkseVrrO5mM0OkQ0iwYdn70IBoWkNa+N/Hhz8urI80HrSzUJDOK8iFmgzfAAtsTgBps5fOiok
 jnijOn3rA/bWdx9fBHGu4bWzebytl2O7yHW71u1BhwWUpebCWtOge0utavy8H36+ZiOVglVwu
 GxzsNxZJplbJ6zhjWZcvAhuK0rzJqFsWxv0NTw50gYEyReB350zr2bTk2qMHVpXOrygGXOguk
 hzQgSf296l0VUsAIsjq7Huhy+lqVzocxY3OkbrkmxgQnw7bqmltq4bUsZ/Oi0ofzIx0qUzNoM
 EejHcVYpdPfRVHjbO/ecAKwsTaMFTIuCyCAjmYwqtBAS/zc+1ZdteoO0U8wndRPjXd1SN+Iwj
 GU0vCTTXAcwjJpMbfGvuz+lOsQsYwL7q2OccLOPjllBNEKKNY7+Q/S4atEJg/JdghtPMx8Jj6
 SRFokAJJjUivBRILLQKhUJMe0IK8a1fX1rmuFFzMekeLzNmcfQQShIOVxGvuDprryYKjvZAeV
 O05fTsplUWL3ULVmp4VKBI2aPcaK2sFoKd36crhukv9W5Cd1034CzDAu3Ff7aJpt1QwWz4nVT
 5Eb5SObzhhuM8Mki9RSMzZ6mtoZJw1LyEAq+zR+aApnleFlmcl7kKEEN4ED1YHf/Lnspdghsg
 6yeBrg754iqSO22ODqcIrgra31bNmpUU5YMLObP6L7HehK+oTNuI6Eb2CkYiWPkG4Qvlddh2K
 P0RpKB7AVhiRUXLM1c4t7l4BREd+wL2Xodf6eE6nJ/0xRLS8LDwnAO+8dYt3u2SQO58xR6YLV
 zhjcBY3a6dV1VG+B909rB4G3i784E6PkxfGeLdPZBo5jb9wNM1wx5OLZftqaYtwINgHRrIfIv
 TxOOeC8nTokpM/jJT9WOzFIoQgVdV8IQnwgALXCSjpvAf8j2d0Tw+QgRG9GynDqaum8g+EdNe
 T4LH/KusVZvqbtSGAxkydl6GYUSiQBXqBepUvEV4YxsJBWSZQ8k8ArwizHvf4uBM1wG5OpuP5
 JCaaqrmh9DpF0L1UubNdDFSk/XSmyN7cmM9JwRMt6bAg4VzH9
Subject: [cocci] [RFC] Keeping more higher level structures for efficient
 data processing?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2584
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/8f9fba3e-3b89-4e24-9b0e-d56d31ac6712%40web.de>

Hello,

Well-known data processing approaches can depend on various input files.
The input files are usually transformed into higher level structures.
This data transformation needs some resources and efforts.
https://en.wikipedia.org/wiki/Parsing

You might be looking for ways to avoid the repetition of such resources and efforts.
I imagine that an information system can be constructed which would manage
corresponding higher level structures for a while.
How will circumstances evolve for further software evolution in such directions?

Regards,
Markus
