Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFCFC6FD1F
	for <cocci@archiver.kernel.org>; Sun, 19 Mar 2023 11:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CdMh8Da9qkxn8nG2HWX1Om/OpyHxK6jJUh5AAuUVOYQ=;
  b=C1E1DaSpD3RwOdaEnmkypzrOYtGQX6+vWzFtKCL/bPzUxTypMS9Ep9Ls
   5JON03JyOd250T0tj1mO17KkUDUBH/Ut0W6wHFbL1LcXeQ+ZkyIJrZEUd
   sxGCRB2/PVa1txxGFCJ3ywDmMXdB9tGfyAHSb6NFI3HUUFp7nUJEOauas
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@ibm.com
X-IronPort-AV: E=Sophos;i="5.98,273,1673910000"; 
   d="scan'208";a="97936976"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2023 12:48:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ED31DE0AEF; Sun, 19 Mar 2023 12:48:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A1EE4E0010
	for <cocci@sympa.inria.fr>; Fri, 17 Mar 2023 16:41:44 +0100 (CET)
IronPort-SDR: 64148a37_DXUnPYsKnaxNHUcQ307S0/hOWKbGjR6RevBdsdg6DKjf90p
 sF4NeOesg3x0ago5AaA3KpiWu+0xB1UscspWGPQ==
X-IPAS-Result: =?us-ascii?q?A0HpAADViBRkhwGco5RQChsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAgU+CLnWBBQQLRoRTiH6IMQOXeocYPg8BAwELAQE7BwIEAQEDBIILg?=
 =?us-ascii?q?nMChTUCHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQA?=
 =?us-ascii?q?QEBARkJFwcOBQsFIoVoDYI3KQF1PQ0+AQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEPAggFTQVYAQEeAQEBAgESER0BATcBDwsaAgUhAgIPAUcGEyKCXAGCK?=
 =?us-ascii?q?AMOIwMDDaZCgiJAiQkBAQF4gTKBAYIIAQEGgUABmxQiU4FeAwaBFCyRNCcbg?=
 =?us-ascii?q?UlEgUuCdD6BU4JELRWDQ4JngimHX456CoE0doEgDoE9gQQCCQIRa4ESCGuBf?=
 =?us-ascii?q?UECDWULDnaBTAKBWjcDRB1AAws7Oj81FCFegRokBQMLFSpHBAg5Bhs0EQIID?=
 =?us-ascii?q?xIPBiZDDkI3NBMGXAEpCw4RA0+BRwQvgV0GASYknQtSZyAmgRhCkmUUCYMjA?=
 =?us-ascii?q?Y1sgTCeQoQEgVmKGJUVMoN9jGaGMZIrLoctkA+LY4FvlQ2FEgIEAgQFAhUBg?=
 =?us-ascii?q?XkjgVwzGggbFYMiTwMZD44gGYNZhRSLAyUyAjkCBwEKAQEDCYVDJhOFRwEB?=
IronPort-PHdr: A9a23:3Hyn3R9mMUIXjf9uWWG2ngc9DxPPW53KNwIYoqAql6hJOvz6uci4Y
 QqFvq8m0wGBdL6YwswHotKei7rnV20E7MTJm1E5W7sIaSU4j94LlRcrGs+PBB6zBvfraysnA
 JYKDwc9rDm0PkdPBcnxeUDZrGGs4j4OABX/Mhd+KvjoFoLIgMm7yeC/94fNbwhGmjaxbrF/I
 RSrpgjNq8cahpdvJak2xhbVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3U
 bJXAjImM3so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RTKv5
 LpwRRT2lCkIKSI28GDPisxxkq1bpg6hpwdiyILQeY2ZKeZycr/Ycd4cWGFPXNteVzZZD428c
 YUCEfcPMuRWr4fzpFUBsRSwCga3CePz0z9FnGP60bEm3+kjFwzNwQwuH8gJsHTRtNj7LL0dU
 fy1zKbSyzXIcvVY2Df76IfUchAqvPaBXbRqfsrNyUkgDQXFjlGLpIzhPjOV0PkNsmeB4+phT
 u2vjnQrpB12ojiq38ohjJTCiY0JxF7e7yp53Jo1KsOiSE59edOpEpVdui+EO4Z5XM4vTWBlt
 SQ1x7AGuJO1cikHxZA6yhPCa/GKcIyF7xHhWeuMLjp2i3Nodayiihi970StxezxW8+p21hEq
 SpFl8PDtnEL1xHL6ciIVOF9/kG/1jaLzQzT7ftEIU8ymKHGKJAh2qY9moccvEnABCP6hUT7g
 aGMekk5+uWl6v7rbqj+qpKYLYN4lwDzP6o0lsGwG+g0LAgDU3Wd9O+hzrPs51f5T69PjvAuk
 qnWrpTaJcMDq668DA5Zzpws5w+jAzu6zdgXhmcLI09ZdB6alYTpI0nOIPD/Dfekn1Sjjipky
 +raMb3mB5XBNnnDkLH/crZh80NQ1QU+wNNF655JC7wMLuj/VlLxudHZFBM1LhS4w+P9B9V80
 oMeV3iPAqicMK7Kt1+H/P4vI+mWa48TvDbwMPwl5//ojX8kll4RZ6ip0oASaHyiAvtmJECZb
 WLqgtgaCWgKpBYxTPT2iF2eVj5ef2u+U7om5j4nEIKmEZvDRoe1jbOd2ye0AoFZZmFdB1CXE
 Xbocp2EVO0WZCKTJM9hiD0EWqK7R48vzxH9/DP9np9uNOnJ4WU1sZz51d56r7n2nAsx6CcyI
 sCTyWCLQElrk2lOSzJgj45lpkko7F6f0aF+y9hJE9dTr6dPWxs6PJjY5+h7Dc3iHAPLe5GCT
 1PwEYbuOi04Ut9km4xGWE16Adj3y0mbh0JCYpcQnr2PX9kv977EmmP2P4B7wmrH068oix8nR
 NFOPCuonP037BDdUqjOlUjRjKO2beIExieY8m6fzWOIuGlcUQhtQePEV3VZbUzT/pzi/k2Xd
 7a1Evw8NxdZj8uLK69EcNrs2FNPWPfqPtD2Z2O3hnf2BByNgLiLadmiYH0TiQPaDkVMiAUP5
 TCGOAw5Uz+muH7bBSdyGEjHZlO0+Kwm8CqxFENslkeSd01mzKa49lgegvn0p+o7+LUCtW9hr
 jx1GA34xNfKE5+boBIneqxAYNQ76VMB1GTDtgU7MIbyZ6ZlzkUTdQh6pSaMn11+F5lAnM42r
 Xgr0Bs6KKSW10lEfi+Z2pa4M6PeK2379hSiI6DM3VSW3NGT86YJoPM2zjer9AegCkor9XFP1
 9hTzmva55/PSgEVVNO5U0o68QR7u6CPejM0tMvf0XxhN7XxsyeXgo55QrJ7kVD5IokZafDhd
 ke6CcARCsmwJfZ/nlGoaklBJ+VO7OsvONvgcfKa2amtNeImnTS8jG0B7poutyDEvyd6VOPM2
 I4Ihv+C2Q7SHTH1kFeotMTfnYFCeCFUH2C6jyPjAcQCA886NZZOEmqoL8Ctk594joLtUnhc3
 FqiAU4Wns6jfFyZaFm3jmgynQwH5HegnyW/1Tl9lTok+7Ge0CL5yOPnbBMbO2RPSQGOlH/UK
 JOvx5AfVUmsNE0ykQe9oF393+5drbh+KG/aRQFJeTL3JidsSPn4ur2Has9JoJQm1EcfGOK1f
 VCTTLrVpxoczjOlHmFbgjs8cnmmt474kBpzlG+GZC8v/DyAJ5o2nEqBooWUTOUZxjccQShkl
 TTbYzr0d8Kk+9mZjdaLs+yzUX6gSowGdCDqyY2asy7orWZuABC5g7Wygoi+TVh8iHGgkYA3C
 2OR/3OeKsHx2q+3MPxqZBxtDV74sI9hH51m15A3nNcW0GQbgZOc+TwGl33yOJNVw/GbDjJFS
 DgVztrS+AWg1ldkKyfDwYvlVnybxuNlZt+nciUX0Cd75MdPQvTxjvQMjW5ur1y0oBiEK/50g
 jcUz/8G7H8cnvFPuQAoiC6aB/pBeCsQdTypnBOO4dekqaxRb2v6arm82n11mtW5Ba2DqAVRC
 z7pP40vFihq4oBjIUrBhTftv5r8doCaPrdx/lWE1g3NhO9PJNctm+oW0GB5bHnlsyRtyvZn3
 0Uyjdfj4tPBcjg9uv/xAwYEZGSpN4VKpGqr1PsA2J/zvcjnCJxlHn9jsILAa/WuHXpSsP3mM
 13LCzggsjKAHqKZGwaD6UBgpnaJEpaxNnjRKmNLhdNlDAKQIkBSmmV2FH0zg4I5Gwa2xcfgb
 FYx5zYf4UT9owdNzeQgPgf2U2PWrgOlIjkuT53XIB1T5wBEr0DbVK7Wpvp0BD1d94a9oRalL
 3zDbkEQVTgDAEDcXhb7Jrmp/sXN/66TAe//Z/rCbLOSqPBPAveFwZX8t+kutz2IN8iJIjxjF
 6hihhoFBC4iXZ2ExXNWGEl132rXYsWWpQmx4Hhyp8G7q7HwXR73oJCIE/1UOMlu/Ba/heGCM
 fSRjWB3M2U9tNtEyHnWxbwYxFNXhTtpcmznF70ctSfLSIrUm6lKH1gaYSY1P8xNpfFZvEEFK
 YvAh9X526QtxOYyEEtAXEf9l9uBYNxSKiTlbArNXkrTbfKePT3M2N36beW3Trga34A2/1Wg/
 D2cFUHkJDGKkTLkAguuPe97hyaeJBVCuYu5f36F7EDnTdT7elu6Otoxhjozk+VcbpziMW8aL
 Cg6cklI6LaX6HEB6h2eM2lRtnMgdbHdkXyVt7CeMo4WtuB3DygynOVfsixS9g==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:YT3MMa0IiK4xYIetpPUHqQqjBCIkLtp133Aq2lEZdPWaSL3/qy
 nIpoVq6faUskdsZJhEo7q90ca7MAnhHPJOkO0s1PKZLXHbUQiTXfNfBOnZskDd8kTFn4Y3uM
 sOHckfeb6AbykesS+52njCLz9K+qj/zEnHv5a4815dCThwbadu9gF4DRvePHFXaWB9dOQEPa
 vZ39FAoTW4f3QRc4CcPVkqG8b+h/CjruOWXfYhbyRXnDWmvHeQ87j9HAGf3hACFw9J+rs9zV
 Ph+jaJlZlLd8vLvyM0AFWjkKhrpA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,268,1673910000"; 
   d="scan'208";a="50517633"
X-MGA-submission: =?us-ascii?q?MDFLLT67FqeBy9Fu3aJwSN/ebT0GEiSPJZM5rv?=
 =?us-ascii?q?9dF+Sn11qNdjMvFnPu/caj3BzS7G4qWOyfz6WChvdH/7TEjHcmKnHLMZ?=
 =?us-ascii?q?B5rQwHQaZRAluk6SkXYaTO0FJCT6/W4AVSruFdkgf4jud2hy5qX8EBEm?=
 =?us-ascii?q?C480cRkX0VkiW+70t/6koOfg=3D=3D?=
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 16:41:43 +0100
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HFSWgK014392;
	Fri, 17 Mar 2023 15:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=CdMh8Da9qkxn8nG2HWX1Om/OpyHxK6jJUh5AAuUVOYQ=;
 b=J0ZFWBPiJvoqxnGw7LmkuPEHhP9mNkih4i7as373N535qKOdLpOgk8LJkM5JFeKfgHHF
 KPIR5MCK1a8tp5tYd/LqMNCHmVFpwsF2V4PISAgfGR7EqW04AgnYR4gAIb3rQmg3BGVt
 IYrIs5JZM5jaTsBaHPrgBFGlfZ9dCUsweUtYm0P3xP9h+ElK68XQws+ldPDsQAPZGdUx
 CID4je4xmuay1+3+LYcLNDAVYRprJjWVEltDFhAEY4vI3QRS353zI2hB9nNfIT7LFxep
 EnkZRPdwdYAAS7r7iagJdzLbT30b4+HNk//e38Lrc4unPTItHO2ozEwfZS65AuuFE83o qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pctvqgb6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Mar 2023 15:41:35 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32HFSpSp019205;
	Fri, 17 Mar 2023 15:41:34 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pctvqgb5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Mar 2023 15:41:34 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
	by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32HDpXZo002789;
	Fri, 17 Mar 2023 15:41:33 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
	by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3pbs53990r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Mar 2023 15:41:33 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32HFfVfq31982232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Mar 2023 15:41:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0BD558059;
	Fri, 17 Mar 2023 15:41:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9AFF5805B;
	Fri, 17 Mar 2023 15:41:31 +0000 (GMT)
Received: from localhost (unknown [9.163.4.251])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Mar 2023 15:41:31 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
        Christophe Leroy
 <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Paul Moore <paul@paul-moore.com>,
        linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
In-Reply-To: <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de>
 <871qln8quw.fsf@linux.ibm.com>
 <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de>
Date: Fri, 17 Mar 2023 10:41:31 -0500
Message-ID: <87v8iz75ck.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VAnCAZbvkGVP7qumF8JkX5udQ_eHDj6e
X-Proofpoint-ORIG-GUID: reTzuusy-TiznGKUgMe0DpjY9hsBVW0w
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_10,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170106
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] powerpc/pseries: Fix exception handling in
 pSeries_reconfig_add_node()
Reply-To: Nathan Lynch <nathanl@linux.ibm.com>
X-Loop: cocci@inria.fr
X-Sequence: 895
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/87v8iz75ck.fsf%40linux.ibm.com>

Markus Elfring <Markus.Elfring@web.de> writes:
>>> The label =E2=80=9Cout_err=E2=80=9D was used to jump to another pointer=
 check despite of
>>> the detail in the implementation of the function =E2=80=9CpSeries_recon=
fig_add_node=E2=80=9D
>>> that it was determined already that the corresponding variable contained
>>> a null pointer (because of a failed function call in two cases).
>>>
>>> 1. Thus return directly after a call of the function =E2=80=9Ckzalloc=
=E2=80=9D failed.
>>>
>>> 2. Use more appropriate labels instead.
>>>
>>> 3. Delete a redundant check.
>>>
>>> 4. Omit an explicit initialisation for the local variable =E2=80=9Cerr=
=E2=80=9D.
>>>
>>> This issue was detected by using the Coccinelle software.
>> Is there a correctness or safety issue here?
>
> I got the impression that the application of only a single label like =E2=
=80=9Cout_err=E2=80=9D
> resulted in improvable implementation details.

I don't understand what you're trying to say here. It doesn't seem to
answer my question.

>> The subject uses the word "fix" but the commit message doesn't seem to i=
dentify one.
>
> Can you find the proposed adjustments reasonable?

In the absence of a bug fix or an improvement in readability, not
really, sorry. It adds to the function more goto labels and another
return, apparently to avoid checks that are sometimes redundant (but not
incorrect) at the C source code level. An optimizing compiler doesn't
necessarily arrange the generated code in the same way.

>> Can you share how Coccinelle is being invoked and its output?
>
> Please take another look at available information sources.
> https://lore.kernel.org/cocci/f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de/

I wasn't cc'd on this and I'm not subscribed to any lists in the
recipients for that message, so not sure how I would take "another"
look. :-)
