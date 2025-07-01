Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A05C83038
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 13:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=juYnGuvyP90n2T2dkCzv1vB4+ifjideg456JGqc3pC0=;
  b=gomNIIDGohPqwzmwTi6NXUVHysBbPfsUfZttVO0vtxBxP0nadvOKedni
   bdjyBe0W26noTJASBm/0dLKiphBZXAEkDvhtLw9pdHSUqr/KapcC6wk3Z
   Z/lezoqk6/DWWNuDlviAOIVBkndMZMzJ7qzSJjQAi3+bE8DiFTC+YtdGa
   g=;
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
   d="scan'208";a="229808696"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 15:01:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7C8A2E0131; Tue,  1 Jul 2025 15:01:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4E139E0131
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 15:01:47 +0200 (CEST)
IronPort-SDR: 6863dc3b_nfdi9Aageg7IjTHqEtPsGKdXjNf+Tvhz+jculQeI+T4vB7L
 o2sKhvW+n1HMpjhJi9g7UM76Espj9hoFYzC6aoQ==
X-IPAS-Result: =?us-ascii?q?A0H5DQAw22NogAQP49RagQmBU4JEgQZUMwQLSYRVj1CBd?=
 =?us-ascii?q?DCEO4c8h1OMSQIPAQMBDU4BAgQBAQMEOIRIAot0Ah4HAQQzBg4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CW4EsgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaAiYCAlYbAQGCfoIiAQYQAQMOJ?=
 =?us-ascii?q?AewG4EygQGCDAEBBoJp13UfLCJYgWUJgRsuhW2CZAGKYycPgVVEgTyDAz6EQ?=
 =?us-ascii?q?02DDoJpgiaBFoR6kzNSeBwDWSwBVRMXCwcFgSBDA4EPIw88BS0dgSd/gU0cg?=
 =?us-ascii?q?wmBDoQsK0+CJHWBeUEZP4NUHgZtDwaBHxtBQAIBC209NwkLGwY9kluHLcYnN?=
 =?us-ascii?q?AeCOIFmgWQMn2kGEy+DcZNbDgaTApkFqTyBfiSBXDMaJE+CZ08DGQ+SVLtPQ?=
 =?us-ascii?q?TU8AgcBCgEBAwmFRgEBiAyBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:KQWvW6yhl15w/bEFIxfyKrPw8r1zdoMgy1knxilNoG9uA6ilfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8X3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 JdmsNFaOEYY2IK7/rS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: 9a23:0745R2G554Z0XhMfqmJfxG0yJsoFNUb051D6JR+HU2RvVb6aHAo=
X-Talos-MUID: 9a23:wVwolAY3PJrQNeBTkhHMvBNcEdhU+oO+AxofsrQssc2hHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229808684"
X-MGA-submission: =?us-ascii?q?MDGDVuwy7Sk7OIPcu6zwFpzYemiUtP0gCf/f/K?=
 =?us-ascii?q?kBL4jT1BlJ2cHv/WG2FFuFMJPWyNtrOecDr5/8UFp9Iqi43bNiynySZk?=
 =?us-ascii?q?NdcgesvWtDOBveeiW+uq5HqPFycNdA8468F9vypLhi3I46MwLwWyat3W?=
 =?us-ascii?q?6NY4vc1AdMeL9IB6RgbqJjOA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 15:01:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751374906; x=1751979706; i=markus.elfring@web.de;
	bh=juYnGuvyP90n2T2dkCzv1vB4+ifjideg456JGqc3pC0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tQplmN+AzDOQjspRv1+KjQ+SAxHzywd18x8LSQuYRB9kyMdd0XdvSdZh/YvkmyAb
	 blTpFatWfx6OWRBfDJUjLtRbTouSKqQel0uSrBDRXxflxbHbE5dZzUxSwoUxmaHO1
	 G8fZMlCjBkuIC4W/wN5oTeCCI5IRel1EATfY6nmzPMD3yddCdobddCAQOxZSvy0Zz
	 dBMTCQK9NBT9eAgDrXGrmooPgW6xOEd0rF6VaCKAs4jw8W3WXGCNdylo0qMbWUYpo
	 nhzHRu7VIiz+lhHp/CFXD2SHJ6n/QVpmDRW660qj6zzo0QiSyhTqqXQ5cXdArBHJN
	 0nYZdroUPHPphFH2EQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlLE9-1uztkS2prR-00e9CT for
 <cocci@inria.fr>; Tue, 01 Jul 2025 15:01:45 +0200
Message-ID: <38ed2bf4-4bb2-4ace-87c8-191e19f8445b@web.de>
Date: Tue, 1 Jul 2025 15:01:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M55mfwtYjcplk1WtJThOyKvh1lQTj3mPc16jsI4ecHbmBGnsTTz
 qcaS+ynez144QIid/V9InxnJrkiWAPM2EJbJeLNFsxJc6e7k+JtK4vEILHYwXfjZ4yQKrak
 ZGJfXZqfeeuiuYa3cGEfu3imPk0l9KkoEQxUZAltuSZSWw7Zk0SBWp9brIQ9nQ3loSKozjT
 yEI0zT9Qt9uDiugDO/2KQ==
UI-OutboundReport: notjunk:1;M01:P0:3udUf8hP1dw=;1PL8Th7cW01FLO0635XMMxZJrw1
 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
Subject: Re: [cocci] Searching function implementations with more than a
 single return?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2837
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/38ed2bf4-4bb2-4ace-87c8-191e19f8445b%40web.de>

> Another SmPL script example:

for further development considerations?

@display@
identifier i;
statement s;
statement list sl;
type t;
@@
(return ...;
|t i;
(
 <+...
*s
 ...+>
|
*sl
)
)


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/show_functions_wi=
th_more_than_single_return2.cocci include/uapi/linux/usb/ch9.h
=E2=80=A6
@@ -668,7 +668,6 @@ usb_endpoint_maxp_mult(const struct usb_
=E2=80=A6
@@ -723,17 +722,10 @@ usb_ss_max_streams(const struct usb_ss_e
=E2=80=A6
real    0m0,250s
user    0m0,217s
sys     0m0,030s


Regards,
Markus
