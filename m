Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DB4C61DB9
	for <cocci@archiver.kernel.org>; Tue, 25 Aug 2026 16:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PoJY0C1PkIjCyrbXHavDi1nliL02fa21pO3TF94+T0w=;
  b=ZvO1mtAB+EwKv3G+EuYLU5S9AzwQ5EaHSPeKyKQHw1y5AvqQPpNucbIM
   tMW5aCImsqE+KbEPA8L55dFyf2IcMOYcbaWx1b7Z+JZ+KlCy8MGPT28aX
   4t0L5i81HkANyADw6kEejkKjJCKSG0izOKKTMmX08lW1yjKEoua1kTMSW
   w=;
X-CSE-ConnectionGUID: 1/Tiv7AxQsmFEC2eFa0GFA==
X-CSE-MsgGUID: IByg5mI8SSCC90EJFGvKtQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,243,1779141600"; 
   d="scan'208";a="291509089"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Aug 2026 18:37:37 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id A1EB681A6A; Tue, 25 Aug 2026 18:37:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id CC76680E5D
	for <cocci@sympa.inria.fr>; Tue, 25 Aug 2026 18:32:18 +0200 (CEST)
X-CSE-ConnectionGUID: TgP7OFCkSfeG3E/5lnUL6w==
X-CSE-MsgGUID: RDpY0GQwRh63bdBBY019lw==
IronPort-SDR: 6a8dc38a_ojPAmpLihZAy6+7WRjXTV2X1BHUBZ3rW/ASFAKUj+2RTWbi
 RARlf1XLgERec6wmg4HcEFWRdqqe9WBqwci+H5Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EGAgAlw41qg07ASNlaglmCQYFoNAQLSYRYj1KCJIQ7h?=
 =?us-ascii?q?zyHVYpPgXwCDwEDAQ1OAQIEAQEBAgSEfgKNbQIeBwEEMAkOAQIEAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBASEZBw47hk8NgluBLIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnBAsLGgIYDgICVhsBAYJ+giMBB?=
 =?us-ascii?q?hABAxAnB8AzgTKBAYIMAQEGgmrXfx8sIl2BaQmBHy6FcYJtAYp0Jw+BVUSBP?=
 =?us-ascii?q?IJTMT6EQ02DDoJqgiaBDJNVUngcA1ksAVUTFwsHBYEjQwOBBiNLBS0dgSMhH?=
 =?us-ascii?q?RcXHlgbBgUSICpBRCMDPoEZQQKBdT8jGTZ8gQlegSspYQIQF0YuFYIHAoJag?=
 =?us-ascii?q?ScCXAIBSUMOB0ciC209NwkLGQQ9j1MfzQM0B4I5gWiBZgyfbwYTL4NxAZNhD?=
 =?us-ascii?q?pMLmQipQ4FoOoFcMxokgzZQAxkPjjqEHMtoRTI9AgcCBw4DC4VEAQGMVoFMA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 XmKxjaPi1Shj/XJ1TdtFhZD+G4juQ==
IronPort-Data: A9a23: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
 T3SFrAc8PR8LlGFiNv/PsCGvNo=
IronPort-HdrOrdr: A9a23:4QRAEqxLrtpCXIwmgGJqKrPw8r1zdoMgy1knxilNoG9uA6ilfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8X3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 JdmsNFaOEYY2IK7/rS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: 9a23:Q0hVLG4nlJ4c3y0IU9ssyEEsRecLWX7mwnr/eGL/VGJvdZnLVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AP6R3jw5+e+4BSL9OYEFHaNOUxoxSz7yfUG80jq8?=
 =?us-ascii?q?G5ZKOOQZaCm/E3TCoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,243,1779141600"; 
   d="scan'208";a="291508399"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDERu0/aMxcMDBoNpMC1I0qi+jRF8edHq14ij5?=
 =?us-ascii?q?33kIR3BgS4nDfaLcVHNJCW0K82yMAwEprXr24jaCt54HI9dGwrJrC/L+?=
 =?us-ascii?q?Qo8JdjQS6YosaMzh2NYIiU8N6oVSdsYnWI1D6sWzBPa9/L8Ts5K51cWg?=
 =?us-ascii?q?ohKn4cx9+Q5qJoh3HOGQ9HhQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 18:32:10 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZMQ-1wcoo600FE-00bCLE for
 <cocci@inria.fr>; Tue, 25 Aug 2026 18:32:10 +0200
Message-ID: <5c799ed5-7f3b-4b24-bce6-05a4c5bf7bcc@web.de>
Date: Tue, 25 Aug 2026 18:32:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <228c50a2-bb15-4abe-bef9-b0f9b95f6992@web.de>
 <7cea8a1d-31ad-4475-be80-ef1cb1e3b2d1@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <7cea8a1d-31ad-4475-be80-ef1cb1e3b2d1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:muXYdO13KhJqVV/Qb9SrTD6qY0nRzgjmJLINgBkh0wGIOxQ9Y9z
 TGF6pQHZESKuRfbYPphEGoMijDPox0xy55AihmjmDHTSooVMU6hzyCvjn7J22oPMf75NREa
 i9wrITL64B1kGgccT2/t4ZWH5QPBMcxjuAAUagtXwiMN0Ts1Ymz4SHfuxkPmFdSgFnXNV06
 9JSg+B5OuQgtr3PuMZZLQ==
UI-OutboundReport: notjunk:1;M01:P0:3kMzG1rWZV0=;Tf7h2WfS/e69XhEsDI/qIclnBfK
 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
 0vah
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Avoiding duplicate elements in SmPL disjunctions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3709
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/US6naSYWifWS-Sgb3AdFFg>

> Markus_Elfring@Sonne:~> /usr/bin/spatch --parse-cocci --sp '! 2' | sort =
| uniq -c -d
> =E2=80=A6
>       3 *0 *=3D=3D *2
>       3 *!*2
>       3 *2 *=3D=3D *0

Can a command like =E2=80=9C`spatch --parse-cocci --sp '! 2' | sort | uniq=
 -c -d`=E2=80=9D
trigger further test considerations according to Coccinelle 1.3.1 and 1.3.=
2?

Questionable test result:
=E2=80=A6
      5=20
      3 @@
      8 |


Regards,
Markus
