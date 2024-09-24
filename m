Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB78CF9C71
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2024 08:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kuxhWN3etFg2kF5r9Dg939stBTyO0lga4cnhltihc20=;
  b=K5mdwSCkkp0yh/ILh6qHwhIbTv3UurZD3pYpnM5WDHjeZbdDXVJZdE16
   xZ81dDeeWW1E04+nziee6WLHzuUQEzZu99ruJhQrPrqqcfqAJRC/PrCbe
   oRDfhr6POigv0I1FfAyQNVz0NZ2BZtGx6cdpNABh6qAQV9X61Twv2hGBb
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.10,254,1719871200"; 
   d="scan'208";a="184754909"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Sep 2024 10:44:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3E1FFE0145; Tue, 24 Sep 2024 10:44:44 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CA7BFE0035
	for <cocci@sympa.inria.fr>; Tue, 24 Sep 2024 10:44:41 +0200 (CEST)
IronPort-SDR: 66f27bf9_RZhulY9mU89RuU4OMA6t+py4xae6gmY4epfaX75Uu//Du2/
 HqpZTTTeuC6p2uIR9zgzvo85IdlkdrhWNw2w+hA==
X-IPAS-Result: =?us-ascii?q?A0E4AACBe/JmhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDYiFUMwQLSIRWiB2HMIF1MIQ7hzqHVIh2gVaBQD4PAQMBDUEBA?=
 =?us-ascii?q?gQBAQMEhQACigMCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBOgcOO4V1DYJjARCBFIEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHR?=
 =?us-ascii?q?AEBAQIBIx0BAREnDwsaAiYCAlYGARQBAYJ9gjABAw4jB7B1gTKBAYIMAQEG2?=
 =?us-ascii?q?lofLCJXgWMJgRouAYhKAYYihDsnD4FVRIE8gwM+hEODW4Jph2+KHotYFiWIY?=
 =?us-ascii?q?HCQQ1J7HANZIRMBVRMXCwkFiTgKgxyBbiaEFQiBKxODX4FnCWGHZ2KBDYE+g?=
 =?us-ascii?q?VkBRoJxSoNPgXkFOEmCUWtOOQINAjeCKCRqglqBJwQFg0odQAIBC209NQkLG?=
 =?us-ascii?q?wY9rV+CPoECE4IKxUaBCjQHgjeBY4FjDJ9SBhMvlz4OBpJzmHYiqHuBZzqBX?=
 =?us-ascii?q?DMaJE+CZ08DGQ+OIRmEFMd8QTU7AgcBCgEBAwmFRgEBhkGBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:l8hqcKt+dr4HkAnhf+wAcpRF7skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: 9a23:QdK1+m1disTsj3n+dvMN5rxfFpooXnLz1VPsMRXhNklJFfqoeHuzwfYx
X-Talos-MUID: 9a23:SjXhpwQTJWPTQGIeRXTnti5QOMdn0Z/+I34PvocGpuLeBBZZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,254,1719871200"; 
   d="scan'208";a="97202770"
X-MGA-submission: =?us-ascii?q?MDE28xjL91SmR0qTtxHK1DrkdiJLIFwSRa6l51?=
 =?us-ascii?q?3WxIdokTPF1CfR75F+boqJIZ8hrCEy6CVQatWKbDxzbb8nadVKSv1BEt?=
 =?us-ascii?q?+J5sNE80gfzlB8o/lvAEuZDrentzmruHJmO9hDfUBd+fhDXStvMZQZeP?=
 =?us-ascii?q?d799JfU/kEjNRWDdzpjTOwyg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 10:44:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727167479; x=1727772279; i=markus.elfring@web.de;
	bh=kuxhWN3etFg2kF5r9Dg939stBTyO0lga4cnhltihc20=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eBdbfjXDhnhR/bfL0TAchmTpcr3ngH/6wiPVYcrPmMbKPZiCqkinl6oAl02LkSlf
	 +Fapfyq0EYQVHCxpXaaTp//mrPkO8/0zCEjLFUx3gtF8OD56Hv3iaGhcIs0+XdV4a
	 JPVYEsstoMXB7RViwJITrBI+UC9bnB0NEXelhwz/zbXKIIM3nr4DPs+7JTXa+b68y
	 Xpl0M2sK1EwwRBrkHuy1tmD1pJmDmBsyee4q4Z9EFdMM+GTChLhr+jN5SXLLfvt8k
	 eiJfWKGXKleicpxcCDRLbgZL44uS8tok/Ua64CzosRm4VmaviAhjZ1P4vWI6B9nzs
	 EpSYW83eFj1Fy/YofA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNOQy-1sYZWn0nVK-00O1Pn; Tue, 24
 Sep 2024 10:44:39 +0200
Message-ID: <d9cc65c8-fac0-4cef-8c53-54f6da99867d@web.de>
Date: Tue, 24 Sep 2024 10:44:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <46260c9a-4c82-476b-85a1-a4174709c5bd@web.de>
 <alpine.DEB.2.22.394.2409212209470.3471@hadrien>
 <b1872e36-154b-477f-907a-7fc98b301931@web.de>
 <c2b0fc58-a399-4376-a4a4-2f7a3ed219f0@web.de>
 <alpine.DEB.2.22.394.2409221148130.3517@hadrien>
 <5073d921-72a6-4992-97bf-36a7b792b7c5@web.de>
 <alpine.DEB.2.22.394.2409221321131.3517@hadrien>
 <d2d6b276-0f4d-43ea-86d6-6568b79f58ac@web.de>
 <alpine.DEB.2.22.394.2409221400080.3517@hadrien>
 <42f5079e-472b-42ed-9429-2c636b9a14a3@web.de>
 <alpine.DEB.2.22.394.2409221525030.3517@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2409221525030.3517@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W7yhCBKwEXYP3rnHwUs92zN2AXMVPNL6oT9WvCUuLYnVPejVQVl
 oFhRbi3afnZ9fN/wZtRVvcekZFn1qc8RvTCzlvHAQCogtwKMQUhMzLurK7nyBiptKWJS6hG
 WfdEcNhCDwUM9x7PP6hfOymYbhUbtous6iPgD3FwHdtQsxtZtGG1Ox52SJMG1y0ZBq6hxTe
 jcMdIsuSythPISdAMwvtw==
UI-OutboundReport: notjunk:1;M01:P0:sngHRMZephI=;tUvbvQ+UHdvCoJKbUVLYbVOvtA1
 KDZkG+MJF+VeQRS0hQUHdhBxi3fTZBQT/sYtr88hM1FTxlCIsb1KA1xdvFVlNkFat3dP4Oyat
 adPBHr1zrf8bzjrOVJXxIqcnRFY0INQ05KPdY6Ulj38bxmygbKiXWOs66RpT+fp0zzNNomAPo
 uGvsvs8L7qTGZq9RcODPq/Ic/sFQ/rGPyXwAOmYdd6bwG1RCRpEBKU+PUGeRQh8VcmaWkbGdQ
 xmSXXdYuiaUqU6WWwHfTfFPmPsC0/wHJOnEmzxJIz6uyBVqVVqhM7+tuAzlM/LowdS4831lQj
 eM0+tHVJ9QKf6wwMJxiObswXuW8+KeI5H8Hp8nX8l/iabhLtEYGTqiv45fkNGKo2YRnF3Q1D3
 S10vaTvCC4GzE/ItXtipe/mIUxpAp17HKhtqWNNs4xA1l4fvBA0hHULB7QUcstEebJfzVXQyL
 /vqmWDmTJ5LPxlcmnZeyUWo3av5nq8UjoXEROqsPuM7xjlWfBwq4er6XS/onjL/5ictPR40f3
 yI9wuCZf/UeQkLnpIYJLNc0iOpPfFSR4UTFyhY4860c4ITkqj3a2C6yPruP8FUVuEr/Mg9ODP
 vEW3gimptlKK52Pmu4vW2tLWvKY+lpr3MGmArZudV8PrH7mVrPj5ihjO6g0nGBqH1GmgFZsmm
 YaM7bvkN6vpR8MKEx0vHoggj2loZqfrUTfecLoxbFAuG/AY6cSMK5HhnxaQ78FD0HRTZdKF1v
 nQ1KMIpdVIB0a7HGRCiXGctJ4BDpLWSWJPhxFmus/A4TIQ9I4w3VpmKkyQ6XUxc9bO3mnITlX
 1nBfceLMvrBuXfIbFzMiEO2w==
Subject: Re: [cocci] Improving SmPL code exclusion specifications?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1887
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/d9cc65c8-fac0-4cef-8c53-54f6da99867d%40web.de>

>> I became interested in another extension of the discussed source code
>> transformation approach.
>> I would like to benefit from the SmPL question mark (singleton) togethe=
r with
>> another SmPL code exclusion specification.
=E2=80=A6
> I don't understand what you are trying to do.  It is not common to find =
an
> assignment, for example, in an argument list.  In any case, I guess that
> when is not supported on argument lists.

Can the understanding grow in more desirable directions also with informat=
ion
like the following?

Questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --parse=
-cocci avoid_duplicate_function_call3.cocci
=E2=80=A6
minus: parse error:
  File "avoid_duplicate_function_call3.cocci", line 9, column 9, charpos =
=3D 358
  around =3D 'when',
  whole content =3D  if (... when !=3D e)


Would you occasionally like to exclude any input parameters (which would u=
sually
be passed to subsequent macro/function calls)?

Regards,
Markus
