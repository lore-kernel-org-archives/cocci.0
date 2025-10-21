Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7360BCCD184
	for <cocci@archiver.kernel.org>; Tue, 21 Oct 2025 09:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Gr8X0DlszmJH1fsRXZENMVsU4mG1PgThEuJOF9YvmTI=;
  b=dyVMhVrWMFPi0hmck4Yuc044GNOKSjlt+vQaegKwksHCnyTk3i4Tvfiv
   8sK9V/Q/66f0icglH+QEGJ0W0GeWrr8/05bbQ6gDtq8ga+atHOR+Cz64Y
   AXj8K1JwhKNFyPkG/PAzWY0HXEq1QFC+GGE/5Wak+16xft7HXNNkLT+MH
   g=;
X-CSE-ConnectionGUID: BTXTjCjWQrmY6sJzuAb8ig==
X-CSE-MsgGUID: FIMI5/wlSueCXdAIicwGqg==
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
X-IronPort-AV: E=Sophos;i="6.19,244,1754949600"; 
   d="scan'208";a="245409908"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Oct 2025 11:40:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CD8BCE0CD5; Tue, 21 Oct 2025 11:40:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 63132E0171
	for <cocci@sympa.inria.fr>; Tue, 21 Oct 2025 11:40:43 +0200 (CEST)
X-CSE-ConnectionGUID: Af2sk8XNSGaSmSl5KtJsmQ==
X-CSE-MsgGUID: 1nVcYmaSROyiTjKw0S7uJg==
IronPort-SDR: 68f7551b_dzJOd9818ZMyAiZDWMzRGS18b5K1Yj15VbFMnsQlSCj4qaW
 saK0KuWjGvo25Kh3A22vLXXA7fhIdyFCHLQLWkA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FpAAAMVPdogAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0GAQELAYI/ZXszBAtJhFWPUoIhA4Q7hzyHVYh5gVWBfQIPAQMBDU4BAgQBA?=
 =?us-ascii?q?QMEhQACjEwCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQE7Bw4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjH?=
 =?us-ascii?q?QEBEScECwsaAiYCAlYGARQBAYJ+giMBBhABAw8nB61wgTITboIMAQEG2l8fL?=
 =?us-ascii?q?CJZgWQJgRwuAYVsgmQBhieEPScPgVVEgTyCUjE+hEODW4JpgiaBDpdjUngcA?=
 =?us-ascii?q?1ksAVUTFwsHBYEgQwMqNC0jSwUtHYEnIh8YE2A9F0CDSRsGaA8GgRMZSQICA?=
 =?us-ascii?q?gUCQjqBaSIGHxICAwECAjpXDYF3AgIEgiSBEIIpD4ZXAgELbT03CQsbBj2TO?=
 =?us-ascii?q?oJ0gXBWG20Sxls0B4I4gWeBZAyfbAYTL5dSDgaTBZkGIqkfgWoBN4FcMxokg?=
 =?us-ascii?q?zZPAxkPjiGEM71qQTU8AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 RM8zAdzM7xFyQ==
IronPort-Data: A9a23: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
 C7lNAMfNMk2YdiIndgQLjgussdzy9Hi4uvEGwE=
IronPort-HdrOrdr: A9a23:FQyq36krXTWQqex0gAqoA/Wv4rLpDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3ATTod7GmMAxtO1R6vQAs21D/sKcvXOVTTlmzTc3+?=
 =?us-ascii?q?eMklgc7iuTQKz5IF/lvM7zg=3D=3D?=
X-Talos-MUID: 9a23:DFXxRAl2OIztwGUbfwnrdno7Mvlj0qGnM3oqgJQ6ueqbbRcvJhWS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,244,1754949600"; 
   d="scan'208";a="245409892"
X-MGA-submission: =?us-ascii?q?MDHGx77egl9JBfdrhOy008DhEUwY0Lc9Rwzwak?=
 =?us-ascii?q?dQ+ZtD3b7f4a3sVlgm+9u0eKeIBlcWL1TNGh/AkyMA4sElzSCuKnk0x7?=
 =?us-ascii?q?xqIJX4mQYAW0guPCIjtHVq34NVKcifTDkr0MHlnAz/nLu2FVAi1W4JdY?=
 =?us-ascii?q?u2HsZMU8lHuTTyhNX6qvdIuw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 11:40:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761039642; x=1761644442; i=markus.elfring@web.de;
	bh=Gr8X0DlszmJH1fsRXZENMVsU4mG1PgThEuJOF9YvmTI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uxXHs4xVkV2PBSIo6UI2uQuQt3cEJC+80h3rp3ZqIXjpCUTkWwCZ1apLJLxDJowG
	 4oK8tRSuVDdYoYv+mArz5Wg0cwBAT4cB/uw5t+mMj2CZcUXTQSi+rteZiOMu+z9HE
	 c3qrNPIR8xxP9rFVC8MyKdLEFU9TaFkzp8CQkXlDaiRWnwBiZaqoVVnLRtY0NUAVG
	 9xCnFUuMAFI4JDlCe0TdZPE2TPRzMbPmqQDombUVFUGnH6dxyICtqdZ7G1YlqTGrb
	 Uek2Q/fkESQwSqzgw/szgX8UalLmq+6pTgeceXqWJ8GUwV9AssukRh+oKpMOlp3Uh
	 RllnJIRaIO00s/f71g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.255]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIyeG-1uv8RE09oA-00R4Hn; Tue, 21
 Oct 2025 11:40:42 +0200
Message-ID: <c56923eb-529f-4b00-b355-ba74df02aee6@web.de>
Date: Tue, 21 Oct 2025 11:40:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
References: <bf92f464-e5f3-409c-9bd5-1bba549dbaf0@web.de>
 <AF63C923-8861-4FF0-A7CB-734FA309318D@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <AF63C923-8861-4FF0-A7CB-734FA309318D@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WBBGALHMmzw82XrXBTYfFfgr+7nqh7fh3gEW6viLNjCH9cia54/
 N0us/1f+9FPBcclAXIKUrQhzLs8c52A99ffdH2N5vUlbMBGGu16onZqVzIvP7W2LTRcMiM8
 iNCf4sH2m09qa20JAL8pzqQNaz6tvKzamowakq8s2tdTNfqQfc5C414aeJCnGEzCNd/F6ex
 h5yMmWzKk533OzJdwhX6g==
UI-OutboundReport: notjunk:1;M01:P0:0UajE8rb68U=;hw809cmPSr/pFG/dL18ib7Xyvxm
 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
Subject: Re: [cocci] Analysis challenges with SmPL for pass-through
 functions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3093
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/c56923eb-529f-4b00-b355-ba74df02aee6%40web.de>

>>>> Will further clarifications become more interesting for corresponding=
 case distinctions?
>>> There is no guarantee that two metavariables don't match the same thin=
g.
>>
>> Some test cases seem to indicate that a source code search gets restric=
ted to unique data
>> if only a single metavariable is affected.

I assume that the initially mentioned SmPL rule =E2=80=9Cdisplay2=E2=80=9D=
 can influence development ideas
(for this discussion topic).


>> Are there further constraints to consider for the processing of data ty=
pes and corresponding
>> contents of (meta-)variables?
>=20
> I have no idea what this means.

Variables have got some properties.

Including:
* Data type

* Value


> If a maetavariable is inherited into another rule it has to have one val=
ue.

The data determination is usually needed.


> Otherwise it needs one value per control flow path.

Would related options become relevant?


> But if thee are two occurrences of a metavariable in a pattern , they ha=
ve to have the same value.

This aspect is influenced by the number of metavariable identifiers accord=
ing to a type (or kind)
in special ways, isn't it?

Regards,
Markus
