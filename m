Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F752D116F3
	for <cocci@archiver.kernel.org>; Mon,  1 Dec 2025 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ybmi0GsQqvwQINbW5z5kya2bTCI9V09qD4M7jYRgD3c=;
  b=qtd45pRvPQRsAwFENihmHInHmUV5WLS15oZ4Ikcrut2hAui4EyC+kQLG
   FFpTEYDwd94mzv2kdBHVvCteoGd7mnuftGrKqUANv+4us13bm99DNDJMH
   htv5Tc4a+zyFjzFuFoo2mGhGyObHHPjWpeQCrEAQ4vff+2LM2CAdCss28
   4=;
X-CSE-ConnectionGUID: JIjEEx+eSFyZZGBykYMpQA==
X-CSE-MsgGUID: Q7dPB9kJQyyK8k3PCaCVHA==
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
X-IronPort-AV: E=Sophos;i="6.20,240,1758578400"; 
   d="scan'208";a="252133593"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Dec 2025 15:00:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 63744E0AF1; Mon,  1 Dec 2025 15:00:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D5538E0157
	for <cocci@sympa.inria.fr>; Mon,  1 Dec 2025 15:00:18 +0100 (CET)
X-CSE-ConnectionGUID: rQgHexbBSLq6oH4Wp/NIVg==
X-CSE-MsgGUID: WPfeIL9NT6O6aBPhGoEmZw==
IronPort-SDR: 692d9f72_GH/ZvOszkXC8mCw/6utYRkKqvrWU22TNUYSJ7N3JP0XuH3y
 TsCIDVYYtGb+IQ0qtfOmEJsOL+9wSoaBjbkD89A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FhAABDni1pgAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4FAQELAYI/gQIGWDMEC0kIhE2PU4IkhDuPEYpOgX0CDwEDAQ1KBAECBAEBA?=
 =?us-ascii?q?wMBgUyDNAKMZQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABATsHDjuGTw2CYgGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQECDTpEAQEBAgEjHQEBESYBBAsLGgImAgJWB?=
 =?us-ascii?q?hUBAYJ+AYIiAQYQAQMPJwcNBrJTgTKBAYIMAQEGgVhB2EYfLCJZgWQDBoEcL?=
 =?us-ascii?q?gGFbYJlAYpmJw+BVUSBPIJSMT6CYQEBAoFeg1uCaYImgQ6GJJMtUngcA1ksA?=
 =?us-ascii?q?VUTFwsHBYEgQwOBCyMPPAUtHYEjIR0YE2A9F0CDSR0GZw8GgREZSQICAgUCQ?=
 =?us-ascii?q?DqBZgYcBhwSAgMBAgI6VQyBdwICBIIWfoIKD4gGgQkFLoENAgELbT03CQsbB?=
 =?us-ascii?q?j2VDFCDEC4rgVFOo2CiezQHgjiBZ4FkDIoujjOHCwYTL4RRkwEOBpMFmQaOC?=
 =?us-ascii?q?JV2hUOBbwQvgVwzGiSDNk8DGQ+OIQwWHINCM4ELxAFCNQIJMQIHAQoBAQMJh?=
 =?us-ascii?q?UYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 iM=
IronPort-Data: A9a23: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
 OnxUVYf
IronPort-HdrOrdr: A9a23:8D6w6alfAoksX1AOXhVG4fck9wLpDfL43DAbv31ZSRFFG/FwWf
 re+8jzpiWE7Qr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQ+VxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK7/oSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:yHAtUG0o3PRaw5QXihwAbrxfAPkqUnDNxl3rB1bmDkY1d6XSb36u9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AN4kVBg7yHs7eC5Dn1a+nWg0zxoxX26qjKWRct6l?=
 =?us-ascii?q?YnJeNHxRwFDCwiQaoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,240,1758578400"; 
   d="scan'208";a="252133585"
X-MGA-submission: =?us-ascii?q?MDFB746pYwBnBpUS0/DWFdTweVsuK2C/0nzEH2?=
 =?us-ascii?q?qCNIoycHeHdYa8MiXrgNzI1rZ8mOUhi1Q4ErZPWucW59XR/Y3nhEjcrB?=
 =?us-ascii?q?hv6nZSo94SJ4KfIClOBiWTkc9u4Ezl2b57meyEantbrVUUKIm3DAmcNC?=
 =?us-ascii?q?GS2ZlNRNb4wtrYp9oPiuk3vA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 15:00:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764597617; x=1765202417; i=markus.elfring@web.de;
	bh=ybmi0GsQqvwQINbW5z5kya2bTCI9V09qD4M7jYRgD3c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=blpElXguLGrs+NoO+O9VLDKVD9flQY32FO4OUedgbgxZavm1qoLTQeaJLSeTaIbj
	 DDhaO5cAzGECSCIsBR8zyFKPCesJXeT8Goxqsk5oY35cw3zlMjEedlcwPj41r9+HF
	 y6LouvQBC5hMCUZ9zRGwjbADTRwT9al/2cc996nRK5BUmhcA4gT2ZJPWUUJo/SRnu
	 X33k8J/Yb7d44d5504AE692y5Y6b2TjkHg6zmeRXo+f8929l7I1uCS/wNXY/NX4us
	 xy5zweGr1z6FNtlUxJdxk7+suBMznoBWTCXGDSA1mr7t2hwko2woWRVH0mtEe+q0x
	 BB2fqGzHNhr6HZKgVg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLijy-1vhjpB0ddo-00YEkY; Mon, 01
 Dec 2025 15:00:17 +0100
Message-ID: <ad0c89dc-89b4-4a2c-89c1-363d28a927c1@web.de>
Date: Mon, 1 Dec 2025 15:00:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tobias Deiminger <tobias.deiminger@posteo.de>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
 <2897bda0c438111e967017f6bb3422f0@posteo.de>
 <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
 <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
 <67f9e0f2-fa4e-c7a-d388-3732d8aec1e6@inria.fr>
 <67d1e00d2e22a4655cb10ec55d1a99db@posteo.de>
 <83c8a7aa-9b98-8ac1-d563-e8fe2588f9a@inria.fr>
 <fd7307f8024706d4bd128d0b7f43bb96@posteo.de>
 <29c204aa0f1f08074279425b7de42dd7@posteo.de>
 <825ab32a-2544-d2a8-bc48-38f26c62bc@inria.fr>
 <ded004b275d73e35c46c3d30c057d58e@posteo.de>
 <e88c503c-b2a1-454b-a4a4-ae2dedd79daf@web.de>
 <893abd46009f5e07e55f6b3f36645eda@posteo.de>
 <febfffa409763a47d12b330fa455c927@posteo.de>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
In-Reply-To: <febfffa409763a47d12b330fa455c927@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fFHrm3FI35AauyMMOLJSqa5rjTIwP81mXGJ4zTby+kZWF5FkfaQ
 HX3z/iXtnk4XC1BY/Xu3D5zUpl9834b1+uDAPLqlEiu5dc/KMOJsdlIT2uwU9t9/tij7K7g
 hRRZ6R5eD+IjSC5i8dAuubwNLPHwjgmgTFW9F1Z6aOJ7dCMGle/YqMTzila8Du88065NL9M
 b+9m4yk1pzR6xJ+eY66Hw==
UI-OutboundReport: notjunk:1;M01:P0:wISpwFFM5N4=;s4ffVHY5w9sKVCMy7AozrU5xcez
 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
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3228
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/ad0c89dc-89b4-4a2c-89c1-363d28a927c1%40web.de>

> What seems to happen with --dir and using the following rule
>=20
> @r@
> typedef syscall_define_t;
> identifier fn;
> @@
> syscall_define_t fn(...) {...}
>=20
> is that spatch filters .c files early by raw text search for "syscall_de=
fine_t", before it actually processes patterns.

Would you find another SmPL code variant helpful?

@display@
typedef syscall_define_t;
identifier fn;
@@
 syscall_define_t
*fn(...)
 {
 ...
 }



Did you notice any hints from a test of a known program parameter?

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-parse-cocci example_for_Tobias_Deiminger-20251201.cocci
=E2=80=A6
Grep query
syscall_define_t


> is that spatch filters .c files early by raw text search for "syscall_de=
fine_t", before it actually processes patterns.

See also once more:
coccigrep
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/4c9d00ae071800cb447ef=
affd753f3bb2be28800/docs/manual/spatch_options.tex#L235-245
https://github.com/coccinelle/coccinelle/blob/4c9d00ae071800cb447efaffd753=
f3bb2be28800/docs/manual/spatch_options.tex#L235-L245

Regards,
Markus
