Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16210C7618E
	for <cocci@archiver.kernel.org>; Sat, 22 Apr 2023 07:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=nfSo5uOKC2dcM/LTRs558WYseEjENY5wEpYoXAWGaSk=;
  b=vzJBcfG3QmSz1OhTNVBvrktQJQUPQ67fnzf8eYwV+GjrRpaAz1RLcwD9
   LruSrvYvewSiQJPZZA40qjRTeK58fI2uGDCH4T8EQCNDgwJq91auWSKRP
   GxuNw+bgYKN9CBVM0IzPSHuMWTV417KxtYj/iEmuLmLJr7lUlnLxdC5Ky
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="5.99,216,1677538800"; 
   d="scan'208";a="104273569"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Apr 2023 09:26:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E2136E0269; Sat, 22 Apr 2023 09:26:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 27D92E019E
	for <cocci@sympa.inria.fr>; Sat, 22 Apr 2023 09:26:40 +0200 (CEST)
IronPort-SDR: 64438c2f_9yolD8qO1X6Q9ShNdRRV5cuYURqlUfYDbcmyETT6LM69t2i
 9QywHvF1Xxvy98bFmpFv2hIWTF1rwc7F7YZNqjw==
X-IPAS-Result: =?us-ascii?q?A0FhAwC2ikNkhw4P49RagQmBT4IugUsvBAtGhFOPEIZXh?=
 =?us-ascii?q?y6QKIFWgUA+DwEDAQ1BAQIEAQEDBIILiDICHQcBBDIHDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHZx0BAREnNAImAl8BDAgBAYJ6gigBA?=
 =?us-ascii?q?zEHqxeBMoEBgggBAQaCZJkoHywiVIFeCYEULYdTHlyEU4RYD4FVRIE8glOJD?=
 =?us-ascii?q?oJniWiLTmmBM3SBJ4ExgQQCCQIRa4EQCGmBc0ACDWQLDnCBRYMYBAIUQgwXB?=
 =?us-ascii?q?UIlBA4DGSsdQAIBC3U9NQkLHwZEAoIPBIEJfFGZGoMmkkewRzQHgiuBVgWBV?=
 =?us-ascii?q?AyIa5YiBhMvlwkOBpIlHpdZIKI9hUKBag0mgVwzGiSDNk8DGQ+OLA0JFYNuj?=
 =?us-ascii?q?0g/ND0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:iOpmT6OKJlzM3FXvrR2Qk8FynXyQoLVcMsEvi/4bfWQNrUohgTNWz
 mtOWj2PPvzZYWv0KdB0Ot+19U5Q7cXTn4dlTnM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5CZaQ7NNwJcaDpOsPrf8kk35ZwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGXodWrTxcd8DnsQZ705pOYnDENi7
 dMxfWVlghCr34pawZq+TfRwwNsuJo/nMevzuFk6lGufV6x5B8meBfyWjTNb9G9YasRmOP/EZ
 NcCLxdrYg7BZRJnJVodTp4z9AutriSjK2cE9QrLzUYxy1bN/hEty6DjCevIaoGRFMMKhG3Cu
 EuTqgwVBTlDaYDBkGPbmp62vcfTmCrhRIMUGZWq9/tgmlTVx2oJCRRQW0HTifK+gUW/c8lOL
 lQdvCsot6k7skKxJuQRRDW9p2OY+AERUZxcHoXW9T1h1IL65RemAFoWTARnMuwH6s9mSB4Gz
 nCgyoaB6SNUjJWZTneU97GxpDy0ODQIIWJqWcPiZVVUizUEiN5r5i8jXuqPA4bo14OuSGCYL
 ySi8HZn3eh7Ydsjiv3jlW0rlQ5AsbDvambZDC3lU3yo6Al0foGoYeREAnCHsqgaRGp1Zn+Gp
 mQE0+KE5eoHC43lqcBgaOAKAa3v+PuPdjHR6bKOI3XD32Twk5JAVdoJiN2bGKuPGptUEdMOS
 BKC0T69HLcJYBOXgVZfOupd8fgCw6n6DsjCXfvJdNdIaZUZXFbZrHs3PRfAhT+xzRVEfUQD1
 XGzLpjE4ZEyVvsP8dZKb7xCuVPW7n1jlT6CHPgXMTz+gOHAPBZ5tovpwHPXM7xntfrayOkk2
 48RboOLzQlSSuvzfmHe/uYuwaMifRAG6WTNg5UPLIare1I4cEl4UqO56e5/J+RNwvoE/s+Wp
 C3VchEDkjLX2yaYQThmn1g4NdsDq74k8SlkVcHtVH70s0UejXGHtfhCK8dnIOl2pYSOD5dcF
 pE4RilJOdwXIhyvxtjXRcCVQFVKJEvz1zGddTGoeiY+dJNGTgnEsI2sNAj2+SVESmL9ucIiq
 vfynknWULgSdTREVcz2UfOIy0/unH4/nOkpYVDEDOMOc2rR8a9rCRfLsNkJH+82Jy/+mwSqj
 zStPU9ApM3mgZMEz93StKXV86arC7RfG2RZLUn67JG3F3LowUu+86B9UcKjXzPUZEXr8oqMO
 MRXyPDdNqUcvVBo6oBTLZdi/Zgc1fDO+YBI6xtCJ2raSWirBpdLAGi07eMWuoJjnrZm6BaLA
 GSR8dxkCJC1EcLCEm9JAjE6b+6GhMomqhOL4dsbeEzFtTJKppyZWkBvPj6JuixXDJ1xFKgHm
 e4Bmson2zaTuyoQEOStr35rrjyXD3k6Ta8YmIkQA9brhioV21hyW8HgJRGs0q6fSednExcME
 mePibvgloZs4BPIU0AOGEjn2ctfgpUzuy528mISGmTRmvT5q682+DZz7QUISh9ky0Qb8uBrZ
 UluGU5HBYSP2DZKmMIYYTiIHQ1FNRzE+X7K6kAokVfBRBKCTV39L2waOMeM8nsG8mlaQCNpw
 bGAxEvhUhfoZMvUzAJofWJAtNrYUs1Xyg3OvOuFDva1NcA2ThS9i5D/eFdSjQXsBP0AoXHup
 M5ozb5WUrL6PytBmJ8LIdCW+ppIQS/VOVEYZ+9q+Z4IOmTueDuS/zyqAGLpc+NvI836y2OJO
 /ZMFOluCSvnjD2vqwoFD5EiO7V3xf4lxOQTc4PReFIpjeGtkSpLgrnxqA7O3HQmUvd/o/Ybc
 4nxTQ+PIkaUpHlTmlLOkvV6B3qFUYEESTD4jc+I87QvNpMcsetTX1k4/Zmqsl60bgZ23RKmk
 znSRq3RzuA494VImrHoM6RcBjebLcH4e/SI/TuS7fVPT4LrGuXfuzwFrmLIO1xtAoIQfNBsh
 5GhjcXS3n6ZjI0pUmvcpYaNJ5NJ6eq2QuBTFMD9d1teogevR+7u5EEl112jCJkUju5Y2Nard
 zG4ZOS0a9QRfdVXn19RSipGFiciG7bFVbjhqQy9vsazJEAkiyKfF+ye9FjtcW1/XQ0LMcenC
 gbL5tCf1uoBp4FIXBI5F/VqBqFjG2DaWIwkSYzBhWHNRC3gyFaPoaDrmhcc+CnGQCvMWtrz5
 ZXeAAPyblKusaXP18tUqJF2ogZRNntmnO0sZQgIzraaUdxh4LIudozx8KnqC624VgT304zkI
 i7AZi0uBE0RmNiCnQrUuLzessW3X4Ti+esV4hQ28knSZyre6EaoHu567ik5i5tpUmKL8QxkQ
 O3yPlXvMxL3zpwBqSP/IBCkqb8P+842DU7kNawwfwIezvre7Xg3OKRdITdw
IronPort-HdrOrdr: A9a23:CiYzG6wSlPJRVIm+fCbYKrPwDr1zdoMgy1knxilNoG9uA6+lfq
 eV7ZMmPH7P+VIssRQb8uxoV5PufZqxz+8W3WBzB9mftWvd1FdARbsKhebfKlbbakjDH4BmtZ
 tIT4g7LsHsBl5nisvA7BC/CMtI+qj+zEnlv4bjJ2wGd3ANV0iM1XYBNu4Rf3cdeDV7
X-Talos-CUID: 9a23:h5UUR2y8PeIAPseLZowFBgU6HNEadE/Pzk32eX+ZV2Y5RZ+5UXC5rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AB8O5Kg0V7HAzEBZOHsSHtdxoeDUj3bqcFRwWiZs?=
 =?us-ascii?q?/itSUaDchPWiHp26pa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,216,1677538800"; 
   d="scan'208";a="54024506"
X-MGA-submission: =?us-ascii?q?MDHxjk7/zE5f4CrtOUXl+Pz22MgPFLAmusQgp1?=
 =?us-ascii?q?0rRWnuHn7VIMJKa0W+PXNYrBz3/AfFHDY+L+fqZhf1zw/BxBtnKZr99V?=
 =?us-ascii?q?6TOheB4+VEK16aC6Pifc9FGemIjVNmD4mKHO2uPlV1B756qGaK5xyAVU?=
 =?us-ascii?q?bO2MoQZ7bqUPAP4FR7PuxHpw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 09:26:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682148398; i=markus.elfring@web.de;
	bh=3TRIjTpOv9+rrAVL5zbiL0bF5+ZT2G7Ss1i6F8YVzaM=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=YAcWlwqfnUrmz98BrtO2coT5DiWYUsdEGJCTHUPEfTTO5P8vzQYxPwX7ZRvcKpZ5w
	 25Bp6eMNdVmaQqOpSiNwbccsuogaA/RvnWlEdPMJ6lSoe7jarhjy291UFCWvTWBTe+
	 6hGYgLehKVE2q4un5vpbfL8UEAt18xVTuVy+zsi+hQA5prY+ug6v2CJhI6NmCLlnqQ
	 q56Q0KM//ShDX0k2wknEuHlwOpp/vNVa2UXJDqtxGBQ1FZGkLTPF5iHkos1Gf99IjZ
	 tRMn9+TDY3/Z20hH6YzUe4S3N5Lr9uoIiRvGW9coGoG03wHs8f5cuqiaaZBE8Ph/P1
	 wlZlAloqD2xBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MaHSb-1pmfH92MXl-00W9cK; Sat, 22
 Apr 2023 09:26:38 +0200
Message-ID: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de>
Date: Sat, 22 Apr 2023 09:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: cocci@inria.fr, Thierry Martinez <Thierry.Martinez@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0a8o4dvTsV4xn85SXbFpyQzWb1DjHSv22oL1oeBD9Z+Qjv/8sJw
 46/BahYL5wimF0sM0VNEEhwo5a40EeIZraFBhk0z6iJK/uzkRBdSeMyfnrqV6XjfOpr5NLM
 krZ6qqEeW1maiRPrs09kOu/OVk1J1YX+EdA2UliCqRofTjiwz8Aggfvurzk9MWy0GKoxBmh
 hLMOcspD6CKjwRWPcYp9g==
UI-OutboundReport: notjunk:1;M01:P0:3NwBu4Y+poQ=;2c/rT3K/+KM160MnhSw/12R92Ok
 FjrctoqiEpJFVTDU8/oMu00pmQ4z7EujVmRt2+nveDH9pHbg+jqdhZI4Po3ylcJT3HQfks8L5
 +nnOYp9q3Q0oRjbLLy/JlkJ30D3z6eLAheLZw3SoNRivVW/7nI2CxYk6LN7pl5uihUKDgZTYY
 3LN9Xngi83GCXOlHEKsDiBv8pmjLVrhaFOjvZ8ftwP1pQiN4nA5iXMnR457rF8Xw7IEULFz5g
 txKdpOE+xZxy1dUhrFTRKSx5LngLGfBwP5/VI7SEJMw8sb9zaLrqp0goZlg4TndEpyaUBOJNE
 K5dy8QGRTpePOtmvV6wok0IDqIoCcWf0lyGELZFEBaLlo8y3zpuKFqIi42JupM86D3tWQqq/B
 L0KYHld2m5bPRGLpY3w0R1MVJuqgWEbGwzJx31DMsuEt41nHvu2XBUNCEDNgI3nbgqpYzufga
 Mll32gy5H58HxEE50iuqPV0qwaKFgBEyGk/MnNqoTNXzn/ZIDQWGlDX0C/DxqtSrJF2Wv4ae0
 AleZOG9fCgJegB588nSxqN1SVgYsIMIxgPLpErqoiz8DCBkzcbuy+4j3PoiKlJvm3JdFWFYEu
 NfHhDESqXkZSd3lyILhfGK5TNkjNvBdVVNkt4+/mChLETu2gnijrz6pf8aTf0OfE9DrIXnkD7
 8pmfJ8Mqw016zbBBSoG5aV/SEBbKzMpBPdbTEogqlfrHl5nj7bArwWAsriepvN8WF4cbMQcmh
 mUzLy0rssWXeECgAKiXEJupTA7TPUakX9epGSZY/kvOhd0Id9fOLDKVAZ18zuiORWjaf+MvBT
 Y685G7E/dyer8W8LclEvr8p9j+3eJLOHxKl3jzv7cEAB+1vtFNSraO+7E3qQyC5ZzpR4xV1Ou
 nAAtKUhifLWH2gR6LORbf2r/828QGA8a2yQ8UjNLaiIIZACehoDh9wMrI
Subject: [cocci] Checking data processing for capturing groups in regular
 expressions (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1109
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/037507d2-ab0a-7d93-bf3b-10e51e70fbc6%40web.de>

Hello,

I tried script variants out again for the semantic patch language.
Software combnination: Coccinelle 1.1.1-00448-g8e007c83 (OCaml 5.0)


@initialize:python@
@@
import re, sys

@script:python selection1@
@@
text =3D '"]"'
sys.stderr.write('text: ' + text + '\n')
match =3D re.match('"([^"]+)"', text)
if match:
   content =3D match.group(1)
   sys.stderr.write('content: ' + content + '\n')
   if (len(content) =3D=3D 1) or ((len(content) =3D=3D 2) and (content[0] =
=3D=3D '\\')):
      sys.stderr.write('Result: c\n')
   else:
      sys.stderr.write('Result: s\n')
else:
   sys.stderr.write('no match\n')


Expected test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch match-202=
30422-debug.cocci seq_printf1.c
=E2=80=A6
text: "]"
content: ]
Result: c


A corresponding source file example:
int main(void)
{
	seq_printf(seq, "]");
	seq_printf(seq, "<>");
	seq_printf(seq, "%s", "Test");
	return 0;
}


@initialize:python@
@@
import re, sys

@find_update_candidate@
constant char[] input_string;
expression input_context;
position pos;
@@
 seq_printf@pos(input_context, input_string);

@script:python selection2@
call;
param << find_update_candidate.input_string;
pos << find_update_candidate.pos;
text;
@@
sys.stderr.write('param: ' + param + '\n')
match =3D re.match('"([^"]+)"', param)
if match:
   content =3D match.group(1)
   sys.stderr.write('content: ' + content + '\n')
   if (len(content) =3D=3D 1) or ((len(content) =3D=3D 2) and (content[0] =
=3D=3D '\\')):
      x =3D "c"
      mark =3D ["'", content, "'"]
      t =3D ''.join(mark)
   else:
      x =3D "s"
      t =3D param

   coccinelle.call =3D "seq_put" + x
   sys.stderr.write('call: ' + coccinelle.call + '\n')
   coccinelle.text =3D cocci.make_expr(t)
else:
   cocci.include_match(False)
   sys.stderr.write('include_match(False)\n')


Unexpected test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch use_seq_p=
utc_or_seq_puts-20230422-debug2.cocci seq_printf1.c
=E2=80=A6
param:   "<>"
include_match(False)
param:   "]"
include_match(False)


Why do I observe an undesirable difference for the evaluation of regular e=
xpressions here?

Regards,
Markus
