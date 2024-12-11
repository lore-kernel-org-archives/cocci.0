Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085A0E7717D
	for <cocci@archiver.kernel.org>; Wed, 11 Dec 2024 12:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=4WH7qtwFVdVwm8zR8h9GDW6wcvgXXtK+pmA5gdi6kbA=;
  b=nrZtAYx2KNFuVzvo0cAaQfvbJflnaY3ZhwF9GUylnmFa1PLvFpW3oe4q
   tMOY0BeGesP/r1XceyR40sNN0vxKDLbOGH1ZJ/XEiX4HIvFPYguApvCiO
   S/UhOhTT1Eq0wLw7fRl9KItRaVqjy9hFfqOJOfBHjF2TKd0LlPQb4Pk74
   U=;
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
X-IronPort-AV: E=Sophos;i="6.12,225,1728943200"; 
   d="scan'208";a="198610401"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Dec 2024 13:20:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4CA2AE0D1E; Wed, 11 Dec 2024 13:20:21 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F10E0E00A5
	for <cocci@sympa.inria.fr>; Wed, 11 Dec 2024 13:20:16 +0100 (CET)
IronPort-SDR: 67598380_inya20r24b++nu6zdLAgdUejKMBBowD/SHXVK5ieH6zRaug
 FbFqEwihX2QHuhqR0ZyW/+JQWL1ty9J9srnaqew==
X-IPAS-Result: =?us-ascii?q?A0EkCgCJgllngAMP49RagQmBU4JEYhsGVDMEC0iEVo9Ng?=
 =?us-ascii?q?XQthD6PEYh2gVYUgWoPAQMBDT0EAQIEAQEDAwGCDI1gAh4HAQQxCA4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CW4EsgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQJHbR0BA?=
 =?us-ascii?q?REnNAIRFQJzAQGCfQGCLwEDMQcNBq8pgTITboIMAQEGgVhBT9dzHywiV4FkA?=
 =?us-ascii?q?waBGi6Fa4JJGgEFbYoXD4FVRIE8glKDUAEDgReBBg6DDoJpgkCCJ4IjgQolZ?=
 =?us-ascii?q?4N+hBWCWoJhX4FfOSh7LIIDiEmBTRwDWTIBVRMXCwcFgXUDgRaCIYE/gQOCS?=
 =?us-ascii?q?WlJNwINAjaCJHyCTYElBAWDaYRphFmGJoIZgQQdQAIBC209NwkLGwY9mxp5R?=
 =?us-ascii?q?4JjNj9oGj+CMZNCslw0B4I4gWUFgV4MiQSBJJUyBhMvl0MOBpJ6mHuOApVSh?=
 =?us-ascii?q?VaBaAE4gVwzGiSDNk8DGQ+SToELvS5CNQIJMQIHAQoBAQMJhUYBAYo+gUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 DI6f04f9tV4AgtHj/85F2ETtxJY
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:zdNPC6BSWfIMIF7lHemv55DYdb4zR+YMi2TDGXocdfUnSL3/qy
 nOpoV/6faaslYssR0b8+xofZPvfZq+z+8W3WByB8bAYOCOggLBR72Kr7GM/9SKIUzDH5tmpM
 BdmsZFZeEYdWIK6frH3A==
X-Talos-CUID: =?us-ascii?q?9a23=3AqYdpLmuv/YKRnSmB5yz7ClOv6IsFdHfQ1k/xA3W?=
 =?us-ascii?q?3FH5HcbiaR2XN/b17xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A6uYC6g1HyYlvsA3Ug794h1kTeTUj/KOlCUpdrqw?=
 =?us-ascii?q?6kNiGPA5xHhGcgxToe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,225,1728943200"; 
   d="scan'208";a="198610386"
X-MGA-submission: =?us-ascii?q?MDFnhFE0Pk+lQddgyKa/SZwlcmo2k+fMNLPsn6?=
 =?us-ascii?q?1ZHF4u6RVcmQYLNbiQuOAWiTuftLKcyLKgFNV+gryhzOp58OQAtgzmL7?=
 =?us-ascii?q?KxQNl/z8YQSUd++Ujm0KlRm7pxBif6t6bMEtkXk9vx9t+Cgtf0THiN6I?=
 =?us-ascii?q?FZffwC9W27L5rjytAAE1Z/bA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 13:20:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733919615; x=1734524415; i=markus.elfring@web.de;
	bh=4WH7qtwFVdVwm8zR8h9GDW6wcvgXXtK+pmA5gdi6kbA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gVgowgETziMFpX9RlNrB55DZSTjXb3kN8ssaaoTxuLRwdzXkSbIj7+mdFfD6ibvc
	 J0cSZxymIyfOpZshTc2Wv5ZAlIk4SkSZULuoIYGxH6mzTD+SvdD5QqLhy6Grq9X4N
	 EX7/svD7rpZRBufOUZlRubJaBoC4HK/8lW4YkS7sHaW7wfACdOqzN/GRDqD+gnC5A
	 4inFLZybH0uiEsCyR2dFF0ZajDpH9ecBw+KKya172Zn55IBwYM/MqyewBS9ZYIo2W
	 SJpFVM5zeYDWhuygim2Q/XkewcQ2sUCPHnfFB/AQBuXCWc+o1pEiD1jgC6VA0Oha9
	 UoUt0+RQ5FI1rlh+LQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.70.80]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaWF-1taxZU3OMl-00r5ie for
 <cocci@inria.fr>; Wed, 11 Dec 2024 13:20:15 +0100
Message-ID: <11adee55-edad-4f0e-b80b-cfd9099ab4eb@web.de>
Date: Wed, 11 Dec 2024 13:20:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nYup08sni9QTdla7hGaJglEptcyHe7i6tvSm82wmYTF9H94Bg5F
 vxf+zcwSg4VOzQWKNr8vTBcn3PEH6t7ZD+gUorxCLXQS22DC45STJQfJm4nkxjh4uwVbHWY
 Hzet2n//gAqeo/4MNXplaF1taAm66AZ/AaxHyiCY4nQEXlyfH88bGtl8Iw1DLyEW+LePkQF
 CN/dXNuLdjU8diVnNLMaw==
UI-OutboundReport: notjunk:1;M01:P0:CIfbMhFuBPQ=;5zxMl2Npa1D4oxXp3Nji6SvqGMk
 rbDBFNvo7ZCDw4h24HKGGejNfiFgX7ndjl+f7Uf8blyKKL3/883wJAU5uEiGlp5v8L8amzGze
 SF3LjnDPtPrhMJj4ZERjmHRDj/vdZkJvEC/6sDT+2C89CBpQKvcy82L4D60CTo54dK+tcCjs4
 eRF7jKzqdRGjs6pFMYmsqUenak2ew3u9C7EYtmXZ+Pm7fFwZtS6JQRpdv1Xw6GSx5ir5nnUjc
 dXpq9VpvNCsMbwr3t3lYZ9nCtmsUZ76W7qNhXzw/OCg8ARUAshilYxliqFM4VHUXQD5U2Myrk
 I5QmiI+iKpzQ9P7Mx+9VKzxoxqzTxYoGX7T1SyReOF27MSOIJb0CHyUFUkI1dBM485M7aakWg
 68ocXoL46V+nsvJtSxn5ysNPlDGocVhXLsiG07GLhcqJA6Sv39bnHmEaKuwa9U5poFPjfuDtz
 BdM9Wv8nDxMAAYmBlyIixmrbVk2n43ovLy4wtZY9FyIuEkAh7hErUGy5nxY/LZqUDD13omw3k
 uuNn/7esS9qvfME96Dbw0wcUeHUxLANiVEgfqBR8x8J7kff3mgYXvLSA0sLQD+SgLNZQMvvSc
 sXudCgkquF0N4aAhdBYt6BK1dOLQI2thCkdhJqtv8T0whDo9JAKeihZ5n3NY2xKoiyI58mjuY
 ZJlz0Fl5qduJ8MqtHhoVjYq8STLjLt7TqKpCZv3mRKPCZefN+FfyTb5CPS3I/H48Eocuet/Ov
 8zKQHZfyQe7gx7JHWwi/uiHDIA4crKf3/poAR4hv9i9eVkppVsESTlL2RiD5NvecgJ/6gT03j
 Lj8gLDLjRNwZtdG6aZvUQz07EiKe2K5YxKpGsNRRFutjRfimQL0AL/JdpYrc3Z4+OQbhxrVKt
 nYnGIDGlA7wet/pkDquWkG/SOkM1bPdJBrwKUMpU5V0qe4GsWexwwvfrawILuots5Dg+mNCgD
 q0Py2jRdm5y11+Fe8C1KQx468wnoEOimANr6QvEWTsedF3SjdW9fUu0YgLcxuSxgjnJGyug3c
 fUQKCp7jp8oZSVoetsjpSRoBR0pRrvvX1psqNthXDLsuSGiBNq+Pd0UAwy3mm8OBtjxj8+IFq
 ZDOyqPunY=
Subject: [cocci] Development challenges for handling of selected code
 repetitions (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2176
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/11adee55-edad-4f0e-b80b-cfd9099ab4eb%40web.de>

Hello,

I hope that some software development concerns can be clarified also toget=
her
with a script variant (like the following) for the semantic patch language=
.


@adjustment@
expression call;
expression * pointer;
statement action;
@@
 if (pointer)
+{
    action
 <+... when !=3D puts("Hello");
 call(pointer);
 ...+>
+}


Questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --parse=
-cocci move_call_into_if_branch2.cocci
=E2=80=A6
12: no available token to attach to


A) Can any collateral evolution become possible according to the shown err=
or message?

B) The information =E2=80=9CDots may be modified with a when clause,
   indicating a pattern that should not occur anywhere within the matched =
sequence.=E2=80=9D
   is provided in the documentation.
   https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/ff57802f2bd1ab1bca=
063810dbeacf6fdce08b95/docs/manual/cocci_syntax.tex#L1030

   Such when clauses influence extra code which may eventually appear arou=
nd
   the searched code pattern.
   But I would appreciate here if only selected repetitions of the specifi=
ed code
   will be taken into account for this use case.
   https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/ff57802f2bd1ab1bca=
063810dbeacf6fdce08b95/docs/manual/cocci_syntax.tex#L797


Regards,
Markus
