Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3881FC38A02
	for <cocci@archiver.kernel.org>; Sat, 29 Oct 2022 07:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=661lw89D7s+CcLnlBFKiJ/XUfT5ksZ7flzXY9b6rBCI=;
  b=daKy5E2CYgmjTQXrNviRHviX7eqq9VpJmQKhhxri8IwP9X+JoUuFNjXL
   Diqe+LIP6H03epCjFFRrX/AXWP+pStMCnmYn17iwpvAo00Q1AZL6xSdqc
   CJpv2w03a0N32WmDEOxpButlaLvVDrq5IKNXEFiFHSvDmituen6TQofDd
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.95,223,1661810400"; 
   d="scan'208";a="72125050"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Oct 2022 09:15:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C7573E01BE; Sat, 29 Oct 2022 09:15:42 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5D41FE010F
	for <cocci@sympa.inria.fr>; Sat, 29 Oct 2022 09:15:36 +0200 (CEST)
IronPort-SDR: 635cd30e_9QbQa2bx/IjGxS0d/LNmcMQopG8q3m0tWAvFq0N8uHh4FVI
 GRP4T6uQoe/UsCTNHVUkm+XLbxPvq/Joew9qEOA==
X-IPAS-Result: =?us-ascii?q?A0CDAwCE0lxjhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLYEBA1MuBAtFhE6QbDGEKI5FikiBaQ8BAwENOwYBAgQBAYISgi5FAoR5A?=
 =?us-ascii?q?h0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEZCRcHD?=
 =?us-ascii?q?hAFIoVoDYI1KQGDZAECAgEjHQEBESYBDwsaAhEVAgJXBgEMCAEBgnkBgmwBA?=
 =?us-ascii?q?w0jBwysZIEygQGCCAEBBoROHywiU4FdAwaBESyMP4QwJxCBVUSBPAyCdz6CY?=
 =?us-ascii?q?gOBGEc/gxiCZo8LhyYmBA4DGSsdQAIBCzsyAwpRGzEnDgkfHAoEFw0FBhIDI?=
 =?us-ascii?q?G4FCjcPKC9nKxwbB4EMKigVAwQEAwIGEwMiAg0pMRQEKRMNKwcjcQkCAyFlB?=
 =?us-ascii?q?QMDBCgsAwkhHwcWESQ8B1gQKgEEAwIQIjwGAwkDAiJYdAIvERUFAw0XJQgFT?=
 =?us-ascii?q?gQIOgIFBlISAgoRAxIPBiZHDko+ORYGJ0QBNA8OFgNimTeCEYE/AoJ3lT2sK?=
 =?us-ascii?q?jQHgh2BS4FMDJ5hBhMulmwOBpITQJZnIKI0hSGBeSOBSAwHMxokgzZPAxkPj?=
 =?us-ascii?q?iAZhAyEYYVMPzQCATgCBwEKAQEDCYVHAQGEdQEB?=
IronPort-PHdr: A9a23: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
 UJg/A==
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:8nA4JKgT/RvZGbQdMAUKDppBonBQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726QtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykZsS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,223,1661810400"; 
   d="scan'208";a="72125042"
X-MGA-submission: =?us-ascii?q?MDGfEDXKMVz5yFjTmaYhEDXm/iZtAi8u+mLS56?=
 =?us-ascii?q?qKfcmDD2Seat2duTgLbhud6Z4sYvVcwuknCJess8DVaQ2xhSeG6wVS+5?=
 =?us-ascii?q?fDjpvL2EGPMJWi2qK5O8sgfuJg4mcVk5a4K26BXunynyiM46culgl+wt?=
 =?us-ascii?q?P6kMINAW92zTPfuw9qTxvFuQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 09:15:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1667027725; bh=661lw89D7s+CcLnlBFKiJ/XUfT5ksZ7flzXY9b6rBCI=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=ujZw/dzsHnc2+Bj/0PuxA6k3qOmMRkkn7/0VSLX1HTt38lqfsc12uRg0U6pUBNSEs
	 Wyd2BT46vPPhR1L4G2ejDW4wz18SmzbSvXGqMoJAjJ78EMb5g1xXRPucPpAUyLiYiW
	 JPZFugcGhYpL3hWq+v2Jv0hZm1koVCwxMcYEhGQuchA3N1NsdRlnBCMic87utRkwDk
	 F+Pw2fu/RmpUa8DCu/fXZMPxubvDEJhRvq2gB8fHu09WCCpUPxKvbX3lGYHw5d8P1o
	 /rsOHA43ebQiQuGUt/kNvp81lv3/OPJTP05G7xAhzwnTvH0R3NdubQu+jGucW3iq4z
	 mQ0Rd94IErd6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.160]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsKH-1pXOU20PDP-00isOr; Sat, 29
 Oct 2022 09:15:25 +0200
Message-ID: <98a053ec-42f2-17ba-8258-018f1041b4ee@web.de>
Date: Sat, 29 Oct 2022 09:15:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Thierry Martinez <Thierry.Martinez@inria.fr>, cocci@inria.fr
References: <e3746c66c0f9c0747620dd7536c98ca6deb5399b.camel@gmail.com>
 <3ee3239d-4b72-9239-893e-b08acbae7df9@inria.fr>
 <f0cc086369f9d48bf5ee47349d936335cac13005.camel@gmail.com>
 <ow4zgdj3t7l.fsf@inria.fr>
Content-Language: en-GB
Cc: Jan Tojnar <jtojnar@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ow4zgdj3t7l.fsf@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/aZRZI3OFw2+RTgJXyfRXjZxml8crwnkjL8zDAZp2GVd/+Mg2LY
 3AlcZiQNiM64SET6GkB/K7bFGQPe/1KVyXIAxTprqDTwy00/nDAvCJ2Uz5VhTuIVGVn3s3r
 Ojjc+PqanzwFXQjv63TBEB+yADsm7E3LU9VnyygXgpYCnIays5OZWlAfVmp+pY4ymCLMRQD
 gI9V8sndw/bGTDeT/nXAQ==
UI-OutboundReport: notjunk:1;M01:P0:W1+wqYSh8s0=;Ia1uN9zLIg+barb9C3mC7whvPcR
 cHCuAaeVXl7Oh5P/Gf8KkeWLvRixwPYucB7AgWGPNgYltruPrEz8ReRUDeAYO72CV2jTaHNxS
 VRjgvQ2QEhW0oYZY1jEDrtTSTO3JJ0f1m7ug4Hfw676+FhLIk8oQ4mVun7fCPiOPHgVehe6H+
 mfbz0hTkFzavx7eZP2qfvqBj1cuyMlix6cAYbzMGhSik8z6CYdV3m+7m2NSnuA7m3Rv1RO67m
 SHPIsYg2LilD+lK3JJa8IsJRvCeZtfk+WXBGgNb8Q5qN/SLIrzLFwRJSYmUtu/e0IOQJGSHYW
 358jwOHVJ018pXX+24b1JYfLdwQ3zdUL0zfpELDLIAueepSLWa3bCtpZ7mm72SuS6Tm4ry3Bz
 5xinp8lfDKEDk3FINEg/jXLJAbO1L85Chd/0CQ7et5Dger0uiiqt3lO7nbG2rRLpOOlPwaJFn
 7jLhgD+LV8w59IyFeODhGMvG+3kmnTqAYoFPAdHhoH3/eTKiMLHuSyl7Egw/27IuxW9wgQr0/
 cYWPQJx542Rcvm6FZ7nxwq7TWo2pMXlj7jWmh3BiUP2MwSvIs/WgIQ4ZfW8MEBbrsjh9aJ9Gy
 iGX95GpqW7mL06TwsRqDWNw04EqLRNjg8qinrSiCRHkdaaIlrPjlUjRruD6Px46bxZYIl6fPz
 3TocU2JrpzLBDeV6vDMYgDii+mGiA292twlv3OJf9dD4/oEkixkA3qZj+FyUVYSHt2rvdu40a
 Rg4hBGXsLOpj8vKhDHowfhITFVo1gnPXRPIcN2xOk0XC9fjw7XBrPgWDeyShcRYy/tZwep+RB
 XpT3xPeN/e1HOOl5DHckEEEhMuZQudOXCZSzTIsht3SGBSC+nvNz2jxnTt6f/IQtSsg0zZOc1
 GwM7u7tXPpQUFA3VvjhKL1o5PTtTZKA78Z7My6QegCM9aLBgON/C5JBabyQ1j2wu3OF3CSFeK
 J3NSVA==
Subject: Re: [cocci] Checking quotation variants
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 694
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/98a053ec-42f2-17ba-8258-018f1041b4ee%40web.de>

>> Apparently, three braces are sufficient to make it work but why that is
>> the case eludes me. m4 language is simply beyond my comprehension.
> Oops, you are correct: [[..]] is the proper way for quoting strings if w=
e
> want to preserve inner square brackets
> (cf. https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_nod=
e/Quotation-and-Nested-Macros.html).

Would you occasionally like to take the usage of quadrigraphs into account
(according to the application of M4 quotation)?
https://www.gnu.org/software/autoconf/manual/autoconf-2.71/html_node/Quadr=
igraphs.html


A parameter for the command =E2=80=9Cecho=E2=80=9D is enclosed by double q=
uotes so far.
Variable expansion is not applied in the passed string.
Can it be nicer then to enclose this argument by single quotes?

Regards,
Markus
