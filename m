Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1995FC282D1
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=iu93iujjl7tQJbseqOYTCTUJTu+5d/+uvVshk/QCkqo=;
  b=PvNtaqgjx6LH/G4pV9zHW2Aupq8+KI2juoY3I1HBvksYK9vhr1qVGsor
   lRm4uBf6LWAhFONOViWAN3SuCiAA/cj8CY68c8JOdAN4rDONERTdfFAyR
   9kgdos+yRzWaQFXtvjtv5XzaKzfTSOE5eEzMduTzewt3BmeeVzAVzj/mJ
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
X-IronPort-AV: E=Sophos;i="6.14,226,1736809200"; 
   d="scan'208";a="211585837"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 15:43:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F2CC5E0D1E; Thu,  6 Mar 2025 15:43:44 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B0947E0260
	for <cocci@sympa.inria.fr>; Thu,  6 Mar 2025 15:43:42 +0100 (CET)
IronPort-SDR: 67c9b49f_2zM+a5c1vSJIhW37e3qKKVRFPfXt7kg/7+ShhexjpHOVMT8
 PBTfjyoCj2Y1f01DdcV5/aWtdNoXj7vCcfgpH6Q==
X-IPAS-Result: =?us-ascii?q?A0HsCwABs8lngAQP49RaHgEBCxIMQIFIC4JEgVczBAtIh?=
 =?us-ascii?q?FaPT4F0hGuHO4dTiHWBVoF+DwEDAQ1BAQIEAQEDBIUAAosYAh4HAQQwCQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQJHRAIBAyMdAQERJgEPCxoCJgICVgYBFAEBgn6CM?=
 =?us-ascii?q?AEDMQevVIEygQGCDAEBBtpcHywiV4FlCYEaLoVsgmMBhiaEPCcPgVVEgTyDA?=
 =?us-ascii?q?z6EQ4NbgmmCM4RAZ5oHjm5SexwDWSwBVRMXCwcFgSlDAyo0MSOBIwU0QTqCC?=
 =?us-ascii?q?2lJOgINAjWCHiRYgitqBAWBJII3hD2EQoVSghGBXQMDFg8BgjBvdxyDT3c7h?=
 =?us-ascii?q?GkXHUACAQttPTcJCxsGPaIwq2iicjQHgjiBZoFjDJ9eBhMvg3ABk1UOBpJ9m?=
 =?us-ascii?q?H4iqRGBZzqBXDMaJIM2TwMZD44hDBaEC8cnQjU8AgcBCgEBAwmFRgEBilSBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 QAIeIyPfK13pYMd3yqtl7651Sz1ZA/S8gg=
IronPort-HdrOrdr: A9a23:Fyq4F65cXw/03pKa9wPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HKoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AhPOE4WmmStkectPhAFqXRFp5RhXXOW2H5XeTA2C?=
 =?us-ascii?q?BMnpWGZm5W3zJ4JJgsOM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A36UGcg97pMuTp5/RejglZFaQf5044oS3EgNdqq5?=
 =?us-ascii?q?YhZbbOXczAXSzsg3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,226,1736809200"; 
   d="scan'208";a="211585823"
X-MGA-submission: =?us-ascii?q?MDGyEwZxi4deINzeymp/TkekPPWwreT+Ws2Xev?=
 =?us-ascii?q?x3kohpgiINe5Vhg/iSL+PAUBxSWz239DPNMIApcnY7jLT9RrIcOxfL03?=
 =?us-ascii?q?uRxP9lOQt/GmPJ79J9cZZUU0YBbhNmP2V4Ko7FSrh+W4kns/NQAIwNr+?=
 =?us-ascii?q?X1WbR5uG8jGcFEdjzl4PYmDw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 15:43:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741272220; x=1741877020; i=markus.elfring@web.de;
	bh=iu93iujjl7tQJbseqOYTCTUJTu+5d/+uvVshk/QCkqo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rMG8B7giuxgbajQgteF4HvUP4Bx+qKK2sqtPrGvh8rDnykVdNlD+KBC+BhL4onz1
	 qxfdhogNgo/HWIjzotZW0nVvJ5vaXiSbD07Kyio1y+bZFX8uk/6pTIAZdnVwDjZ81
	 LS+Pd7vUHUTxgGS2Bh1LPQwOnv4kCu2gNsYGyZIudrwTeh7ipGZAN5Nvl70nW9UOP
	 ZLhhruqC7/eU/i9RvkdiHYmxqKhPXmZh1WNxuCwo4+ZBGbSMjpk16iq8gTG+aBBvB
	 CBMUvGqatDGz3HoqDpQ0QnIbH0duLM5HH3GC2VRI9avBX3DMBReYOqIOKEUimzItC
	 Jx0hKQiTHEFDNnxhvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.2]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MrOdf-1tVNxj292d-00ftFl; Thu, 06
 Mar 2025 15:43:40 +0100
Message-ID: <19da83f6-86c7-4cbe-8d4f-be5569bf2fca@web.de>
Date: Thu, 6 Mar 2025 15:43:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <CABDMBwh_LRL+Dxz94caz+ybJT5MLP9usBs12fLeDHaTSnOES3A@mail.gmail.com>
 <f3c7b17c-dbdc-44a3-43d9-bca26a95bf3a@inria.fr>
Content-Language: en-GB
Cc: Danikka Jelski <cmj136@scarletmail.rutgers.edu>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f3c7b17c-dbdc-44a3-43d9-bca26a95bf3a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NQyyfr9cMdZVNnSoEg2ayivOLjJF+ffI7z1+lAPlMtxLcVIZylu
 d91eueG/KUfx4UydlnPAtP7dr05qK0VhPUTamcSGIRpBE6kU5S0ZBB1Y0YkNey1SThcSqr0
 J4TI4qjJ9uQHChfmDTn6doFEUgLSq5FIetGsQcmLy9vBERq5Ptod+Dzk8OuVY/2Ot0UCPwO
 cCX83zxYxdGljSV+qj5tQ==
UI-OutboundReport: notjunk:1;M01:P0:7/I2QM7z0TE=;WSKcx1b1vXfpQJ4K4c8hHJ50f0o
 Ni+bXwoG2QlHX6agshKtjJJGoa16YLSNQHFCJxbfe5nNjEj1NkrHPsITMTAT3j5Fe0Wjx+zqk
 LLOQ98G7P13Yn8BKgydsW7S9WRV6zEF2x1OTmVbZC/umnG0hV4nr4oINWnMvjwmmOAN+mYy0h
 OSs/UG/iwaw4XQS1xsMmo7SJ5ULkLjKvsJrI8Fj4avNY30P65AU7cTtJYfqEDNEy5M/ce/DWH
 Ou24L1wAtrMAFtZS7Iy+G0NdYn+GpqbZo/epo/0pEJ5c1C/Fs3kSwxAxgsBpg5/oSrmrjgOos
 WSOEypQCSWaM+lkNgVFRe/ptHAvgZZmKQ+QijfH3Y9zZHhs7xEyNF2heHLo3XAObKHbPTUrW1
 BftZKoQkQvtud+IWDSx7qXMiO7zwsrN5Al8YrE5yyMp2F9FpG3mUiqar5q0IHwf3OrdhMS8ZX
 pWw+6RZk6Z56wexoQ/RpybsqQK7yqJwgK6X7S/q7GbWwFFPWWNyplGiwoLNWoLjTKZzZMwyQB
 549UzsMSavZm1zHMH/LWcRJ+tcjU+wDdtyU188I8jvELf6gpNNn9NYrpzWanch6/c82Ua9ihL
 +txfGlg4xkii/wDr62U9xGT5KzDe0ac6e0lwif4P0qgnZZ62j1B7mx7F69yingheEgkhKl4kZ
 icSZ2hBLLiuS8hSrVEkIMDCFrwKGHnxllcqJw84tJd4VasSLVsPMBIaujcOsIa4SNhDKIIIhO
 85vADdXm5/T3v5OTl/8tN2bSqCZ3ddyM39ali9fUXaOJ1IrGl3adxvUCDIqTW/PD8V3lzq5wa
 PEyPU4ZRNYX5x6RQKDdBfn2OpFvntZ8/s1g0lyeoZADVVf2VX+s9ccohbJNxFAfb1eEz/r3d3
 V88qPMLKr29kzuTje4fVZdv0dGlf5fScb6UOZ2cbUeaMdkdU8X16o+MG9WyGa3L5HQO8Px08d
 wNjf+8t4GU59hKkJBBGRQBtiBe35XBR1op4oN/K88BjrZ8NN9i9+H4oKGXkP5PPKWEtw9unx3
 eQl773DP7JeGowmdBeawe6pi/LNR25/P9UMnhe2C21pAyeIiL3H1dgQebOSndA6/I5oEBS/xt
 cRG06fcguZnn6idGzTj8SXlORB0hEjZcWHYlgxSjqc2KAOgUH7eHUrZV8FUXhuHNv+kOIj/Au
 FYcG4MHk19qDLUXXLVK+TLb3JVADoD+OuMfc/Q9OQBygXwmemXrRjeKWA8luPMiAK5v6L4r24
 jw4cR8UPLhxFw+VcDiQ0qxPLoeEKcM2A3mjAfcmtiXLo4oRZWwP1JxgFgvsrfXJ7XotbS8LpA
 kH9ofzS6EMMXr/xSSPS+VFk6pjpBckJBAsfC7DTBVM/vcOQijoGlLh3ZrZHXNQNTCS8fe4PMX
 ciqpIdr2qlA1u6kB2dYRMHoHj0Cg63B9uxExZCWCmvmU6bXmtSTMrDNBS8WbRNpOmwFgs8BVx
 Rkgwzng==
Subject: Re: [cocci] Modifying BPF map definitions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2568
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/19da83f6-86c7-4cbe-8d4f-be5569bf2fca%40web.de>

=E2=80=A6
>> =C2=A0=C2=A0__uint(max_entries, 1);
>>
>> } port_state SEC(".maps");
=E2=80=A6
>                                         you can get rid of "port_state
> SEC(".maps");". =E2=80=A6

How do you think about the applicability of another transformation approac=
h?


@replacement2@
attribute name SEC;
declarer name __uint;
constant char[] text;
@@
 struct
 {
 ...
 __uint(type,
-       BPF_MAP_TYPE_ARRAY
+       BPF_MAP_TYPE_PERCPU_ARRAY
       );
 ...
 } port_state SEC(text);


Regards,
Markus
