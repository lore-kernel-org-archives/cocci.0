Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E959D1D89D
	for <cocci@archiver.kernel.org>; Thu,  4 Dec 2025 09:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=eijqEUHulMTyf5kS/kP6vFNFPAjOnf1wZma6lOp0d4g=;
  b=ACAsYKkP1EO3qMoAFNv67FP6kGBR57QNoKZEoaifm1rNYQaP0Gn8pOlj
   W+utM710GUbBzQdDnyss66GWjeQnCtvFd917mmpa2H0NylZatzcsyBObi
   S2lga21/WDgdILtkgZdhf49yhNCagezl/+Oud3bkW6x3Jff+9ScE9sNeH
   M=;
X-CSE-ConnectionGUID: EBVatqgsSPiryXhxms1gQg==
X-CSE-MsgGUID: rURLR5KuRzW+pvGh+WF1dw==
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
   d="scan'208";a="252704813"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2025 10:30:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7D785E0137; Thu,  4 Dec 2025 10:30:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4AB7DE0CD5
	for <cocci@sympa.inria.fr>; Thu,  4 Dec 2025 10:30:44 +0100 (CET)
X-CSE-ConnectionGUID: KhSqDfCWRhuEavflov8EIg==
X-CSE-MsgGUID: vAN7ym88RaCcxJRoxMrpOQ==
IronPort-SDR: 693154c3_+GV08eSnVg44/0UIiJ9sRAqD9N20aXtrSlEvy71pltLgvuy
 EAh5RV2fmvsNZ4xn2v5dvLoVV15X5WImBoByPXQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FNGwBqVDFpgAwR49RQCh4BPAwCCxWEEGUdBlkzBAtJC?=
 =?us-ascii?q?IRNj1OCIQNpg1KbXAIPAQMBDTQaAQIEAQEDBIFMgzQCjGcCHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgmIBg?=
 =?us-ascii?q?SSBJgEBAQEBAQEBAQEBAQEBAQEBARcCDTpEAQEBAgEjHQEBESYBBAsLGgImA?=
 =?us-ascii?q?gJWBhUBAYJ+AYIiAQYQAQMPJwcNBrFQgTKBAYIMAQEG2mEfLCJZgWQDBoEdL?=
 =?us-ascii?q?oVugmUBimYnD4FVRIE8glIxPoJKFwIFEIESDAQpg1uCaYImgQ6ZWVJ4HANZL?=
 =?us-ascii?q?AFVExcLBwWBIEMDgQsjSwUtHYEjIR0XE2A9F0CDSRgGZw8GgREZSQICAgUCQ?=
 =?us-ascii?q?DqBZgYcBhwSAgMBAgI6VQyBdwICBIIVfYIKD4gCgQgFLnsnAgELbT03CQsbB?=
 =?us-ascii?q?j2VE0+CSHkrT0xNJSQtk0CyXDQHgjiBZ4FkDIoulT4GEy+EBI0ThjsOBpMFm?=
 =?us-ascii?q?QaOCJVkhVSBfyOBXDMaJIM2TwMZD5IhM4RgtydCNQsxAgcBCgEBAwmFRgEBj?=
 =?us-ascii?q?CI0gUsBAQ?=
IronPort-PHdr: A9a23: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
 EZetw==
IronPort-Data: A9a23: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
 OnxUVYf
IronPort-HdrOrdr: A9a23:LGx3oqvMVZ3yYHUFNG4ps7Bd7skDZ9V00zEX/kB9WHVpm7+j+f
 xG+85rsCMc6QxhOk3I9ursBEDtexPhHP1OjbX5X43JYOCOggLBR72KhrGSoAEIdReeygcQ78
 hdT5Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AWOHEO2pPcJ5rXSUgYuG80UjmUeMlSWTxwlzvGU+?=
 =?us-ascii?q?lJG93RrmSVw+92awxxg=3D=3D?=
X-Talos-MUID: 9a23:ybDYvgUAlv3zN3fq/CHFom5zMZc42a2FA1Avq5IWntOcEhUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,248,1758578400"; 
   d="scan'208";a="132741733"
X-MGA-submission: =?us-ascii?q?MDFeqpetchrbP/+a6p1x11PUAuaWreZadIMrIB?=
 =?us-ascii?q?Ngmfr1M7Vgyhi2lkAu03bWCeLv6pNcFsS8Jdt73o0Ah7xzRbKwTI6fIW?=
 =?us-ascii?q?FMjwRLE8eNuPXlfOzzhwobO+apPoeVimdMjQkV35kPqp5bz1WaLleGUZ?=
 =?us-ascii?q?9tvUeKJ+54enaYXFS8n2K7XQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 10:30:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764840636; x=1765445436; i=markus.elfring@web.de;
	bh=eijqEUHulMTyf5kS/kP6vFNFPAjOnf1wZma6lOp0d4g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iVsemkN4DCOtplP7MMaWFofWhSKjIrx+/PNBxFjn+DLqw8bluUYMvBW8YkgfniaG
	 1t7iMqlsWwEEeQ0WcDoo8iiplChmK8IAFkpbTwMTH77spz86YsmTJ/9l7ylRw5o9w
	 iO5S44l3iTrCo267GFjl3S3ENF6fEdrTrligiDli0M1hT+alG+/7Uz8dbqcksZRQt
	 CulzxSPSKYqENOpeGjrFP7i33zZAha+ojJxOGuvD9uu0N14R5RfAdq05erQRJJ2ie
	 YKUMJjdGzBFXBXHBWckRInmHCWCA9iv9+i0RsJo3q8CN+/NRNCOSM106EAuF5RS58
	 E2t+RbO4qlWPBp8B3w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9qhD-1vNUlN23TJ-000dUN; Thu, 04
 Dec 2025 10:30:36 +0100
Message-ID: <9236a588-225b-440e-92c1-b3416cf2e4c4@web.de>
Date: Thu, 4 Dec 2025 10:30:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tobias Deiminger <tobias.deiminger@posteo.de>
References: <1b8dad8151ef1409adc8cb24c728907a@posteo.de>
 <9ab63cb6ee4a0354c053f22fb0934317@posteo.de>
 <1534c930-426e-4939-8fcb-ad4a32c3e23c@web.de>
 <b5b21fa8f7d361142b60027d84edd34c@posteo.de>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b5b21fa8f7d361142b60027d84edd34c@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2L88IxPfyygR2mnCXWlEYIMhiKGaUSwtgqTuwfEgxySBlNCE2j9
 Nxt2op8a1/Ngjwllm2ZWuGrS8cHgdtx3DHvWvXqL7Pf2qOF/v4v1kUESUjqh16xJa8Id9RI
 6jt7lqMAcFxlhc7UlMRqrnL3paDx5X34Dn9mMuLDywBe/W5fxmb0fOEziZPsmv0TAYovO2M
 9XUq4GMYyvQZwHtNr3Iag==
UI-OutboundReport: notjunk:1;M01:P0:q6GnMkk20x4=;u6iZNWpKYNDvCrAvmVSTpn7dljo
 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
 LMoANCtds5fnH6Sr54xg9Bcev43zP
Subject: Re: [cocci] Search for the concatenation of meta variable + fixed
 string
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3242
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/9236a588-225b-440e-92c1-b3416cf2e4c4%40web.de>

>> Are you more interested in an =E2=80=9Cordinary=E2=80=9D source code se=
arch?
>
> Correct, it's only about searching.

Thanks for this acknowledgement.


> But not "ordinary".

Corresponding views are varying.


> If there's another OSS tool that could do semantic code search,

There are further tools available for this purpose.


> can deal with C macros and supports "hops" like first search marro, then=
 search definition of function referenced by macro please tell me.

The alternatives are more restricted then.
But it seems that you are also looking for help on algorithm design.


> Coccinelle is the only tool capable enough I currently know.

The semantic patch language has got a lot of potential for more convenient=
 data processing.


>> I suggest to take another look
>
> I took reasonable amount of looks and found no better way than this [1].

It seems that your views can become too limited so far.

doc: Use coccinelle to identify important functions
https://github.com/haxtibal/linux/commit/ff6904ce23a022908fd8bbfc0b8049001=
54ae48b


https://github.com/haxtibal/linux/blob/tdmg/cocci/cocci/sysfs.cocci


> That's why I'm posting here and hope to receive SmPL snippets that demon=
strate a more idiomatic less complex way.
>
>> at algorithmic properties.

There are special development challenges to consider because you need to p=
erform
data processing especially with macros.


> The linux tree was searched in 44 s locally, which is fine for me.

It is nice that your computer is sufficiently powerful for your initial ex=
periments.


>> Would you need to extract identifiers from selected macro calls?
>
> Yes, I print functions names and positions in python scripts. The result=
, verified with samples, looks complete [2].

Would you get further development ideas from any public SmPL script exampl=
es
(which I published over the years)?

See also:
Deletion of checks before specific function calls in Linux source files
https://build.opensuse.org/package/show/home:elfring:semantic_patching:Del=
etion_of_checks_before_specific_function_calls/Deletion_of_checks_before_s=
pecific_function_calls_in_Linux_source_files


How do you think about to split and configure your data processing steps s=
imilarly?

Regards,
Markus
