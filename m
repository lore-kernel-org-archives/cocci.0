Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3620FC369D9
	for <cocci@archiver.kernel.org>; Thu, 24 Apr 2025 08:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Kg/vqusO5+9W7QqebKB1OKeumLCf6lCb0QG3HEEF26k=;
  b=IhYuWOT5evCcd7k+At7B3emdmf6AEyAFnsLgEPSiyVC4oFRcjiDh5ssn
   ATkNDKPuBLNrpkvfk3ypU2Wd2MhwlwItTKe2kXlYFRqrx4a8NMV+ZminU
   XCgPbQND6yGHaCAKlI2t/sLmO4SASPrlpV/nTkxOC688P+eOWRoFXGO+P
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@quicinc.com
X-IronPort-AV: E=Sophos;i="6.15,235,1739833200"; 
   d="scan'208";a="219234079"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2025 10:55:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0F908E0D24; Thu, 24 Apr 2025 10:55:11 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 51058E007A
	for <cocci@sympa.inria.fr>; Wed, 23 Apr 2025 15:20:08 +0200 (CEST)
IronPort-SDR: 6808e907_OpEeOIKan4UeNTbXEFT9cAQqw+tuiqClJHwiRQ/j5bXwIyx
 w9q2pYVOU/SXUcY+qmj3ySdofNRj09TE+2YQr8w==
X-IPAS-Result: =?us-ascii?q?A0EYAACm5whog4O03M1AGhsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAgUIDAQEBCwGCQ32BDQQLSB2EOIh7hlWCJIQ7mAODUw8BAwELAQE5C?=
 =?us-ascii?q?wQBAQMEhQACiy0CHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBATkHSYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAggFXgEBHgEBA?=
 =?us-ascii?q?QMSERUIAQE3AQ8LGAICJgICVgYBDQcBAR6CYAGCZAMFDKMlQ2cqWQGBIEKJE?=
 =?us-ascii?q?gEBAXiBMoEBggwBAQaCadscAwaBGy4BiE8BgW2DfxsghDwngiiBPAuCeD6BU?=
 =?us-ascii?q?oMKg0KCaYJ2UlaEBoQ4hSCCboQ0iGQJSXscA1ksAVUTFwsHBYEmQwMqNDEjS?=
 =?us-ascii?q?wUwHYJXhSWCEYFcAwMjgxN0HIRohFItT4MvgRNwaAYdQAIBC209NwkLGwaXB?=
 =?us-ascii?q?4R8K4FaC5cmjhlooQsNhBiMGZU1BhMvhAONCYZOkn0umFAijWSVdoUOAgQCB?=
 =?us-ascii?q?AUCGIF9JIFcTSODN08DFwIPhHeJKhmDZ4UTvE82NTwCBwsBAQMJkBwugR0BA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vRALZTz6IRp5X29AIGr9Dg=
IronPort-HdrOrdr: A9a23:Is9ic6tODxsh5y5ECE6VX+ld7skD3dV00zEX/kB9WHVpmszxrb
 HIoB1p726MtN93YgBbpTngAtj6fZq4z/RICOYqXItKMDOW2ldAabsSlbcKoAeBJ8SdzIBgPM
 5bGsAUZbGeMbE5t7ed3ODSKadE/DDoytHNuQ6T9QYPcenoAJsQnzuQXW2gYzFLrV59dOcEPa
 vZ39FAoTW4f3QRc4CUOlkpNtKz1OHjpdbeehgBCAcg6A6SyRWSyJC/PSS5834lIkJyKZFLyx
 mwryXJopy5tfe10xnd0HKW1Y1fnJ/NxsZKBMmXzuQTIFzX+3SVjUBaKsPyyQwdkaWWwnYsjd
 XWpB8kVv4DlE/sQg==
X-Talos-CUID: 9a23:9G9mCm/0Uzrey1V1awyVv14aMc4Pf0aA9lDzChKyLTZjFZ+fElDFrQ==
X-Talos-MUID: 9a23:zh6yFgU8uTlvxHfq/DHJjQt7N5dW3/yJVWEvvpcJivSCPyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="114985489"
X-MGA-submission: =?us-ascii?q?MDHMshbFp+jcX2KuXVRQer/Rw5Q/iTnjIN3IVC?=
 =?us-ascii?q?xyOlthAECLgnd0jLBOne2Qh9ak5aLAnGZMDm7ORsO4ssQjn3QeiayW6E?=
 =?us-ascii?q?8cQWvU7/l9G5RIZj5a55QtSWVSU+LNTjnoQjhAlZQn6ppEBEhpQto0uf?=
 =?us-ascii?q?z2P7rZUY7haIVlRSksRVkFmA=3D=3D?=
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 15:20:07 +0200
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NAkwud014559;
	Wed, 23 Apr 2025 13:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kg/vqusO5+9W7QqebKB1OKeumLCf6lCb0QG3HEEF26k=; b=hVnOWRe+nd9oYO9w
	DgxmuwBnT9myycawSDCOJpWaBYUVC1I3pD+hsrzSu2chKJsFwBT64UcTfB24JvQL
	ODogym26to60pHPUZaG7VOun4f5AvE5JtHmQ8JtaZag/9Yi8SHzM8iFDamioGttp
	wFWDXJ+9BzhjiAytculd8UbR/5QFB5ssjWcBi05hz9iIPPLwM6ZA1yiJWnBGRaPP
	parz4ErjCB09XbP3B+1e18v9ZhZr3vMNepQQKKzDUDH/h4lhfyeAYlpsEC22WJwE
	anyuqxp+tvxUYUUC/aNYnaVciMKyQ/VcJk6cs3P7btSpiIdEMioW5RSwLsiYwFZc
	0apilg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh0j7jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 13:19:52 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53NDJpRS022364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 13:19:51 GMT
Received: from [10.253.74.233] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Apr
 2025 06:19:46 -0700
Message-ID: <1d70b1c8-f5f7-4027-a0cb-b1638e309a48@quicinc.com>
Date: Wed, 23 Apr 2025 21:19:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jie Luo <quic_luoj@quicinc.com>
To: Yury Norov <yury.norov@gmail.com>, Marc Zyngier <maz@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
        Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, <linux-kernel@vger.kernel.org>,
        <cocci@inria.fr>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.linux.dev>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <86sem7jb5t.wl-maz@kernel.org> <0c97c659-bd28-45e0-8537-d9be2637cb22@lunn.ch>
 <86mscek7h3.wl-maz@kernel.org> <aAJq9mGswYsnAOS8@yury>
 <87plh9xz2d.wl-maz@kernel.org> <aAKGHIssRW5jXvdA@yury>
Content-Language: en-US
In-Reply-To: <aAKGHIssRW5jXvdA@yury>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BN88jDYWGmli4vHQcBNP_g8Tvmp6cMeZ
X-Authority-Analysis: v=2.4 cv=ftfcZE4f c=1 sm=1 tr=0 ts=6808e8f8 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=rL1jKAeQPVWMZnSF2k8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BN88jDYWGmli4vHQcBNP_g8Tvmp6cMeZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA5MyBTYWx0ZWRfXzbLcmo1j7n+4 cF/GKqx6vJwZDlKbABC0g/aYzHPNypSuZSbOqMTAGBxJlyZT1Va2fq8JoWHfI4+e7mq9M0Mt8eb 0yngKZ46t89+aaOz89gEWnUJ+9IVWPetjBnmd85XfbutXZZuclw99xOQikSTs0rOeVHCmuN28fI
 V7Q2k+Kyatbom3i9iWEQ6aWEumOMFP9prMv2aFduU2EXKOaUMpKvR2m7oF0Sz1fDUXfoJQbZc2m SKr4s9UAp1Jxcks8AfxlOYUlVADDhZ/qyb+BslC6zDZVXhY1juhIJJdzdR0JtltLXzvPNj5zA5h VEXGLprWpwE5Ctdqty/M+7DO3xFk5/S5+GWq/GFX/CSaRR15f5Dq+dSVgaCxQ1ENHXT/nn3sKxf
 D2g+34XwZg5izFbfxo5Ltkf5JFVZpy6hoOJzVyI/Zqh40tr6j+kZqw++/jtAh0okhNIvnBi4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=884 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230093
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 0/6] Add FIELD_MODIFY() helper
Reply-To: Jie Luo <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2713
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/1d70b1c8-f5f7-4027-a0cb-b1638e309a48%40quicinc.com>



On 4/19/2025 1:04 AM, Yury Norov wrote:
>>>> I think a bunch of people have found them, tooling notwithstanding.
>>>>
>>>> As for the documentation, the commit message in 00b0c9b82663ac would
>>>> be advantageously promoted to full-fledged kernel-doc.
>>> The FIELD_MODIFY() and uxx_replace_bits() are simply different things.
>>>
>>> FIELD_MODIFY() employs __BF_FIELD_CHECK(), which allows strict
>>> parameters checking at compile time. And people like it. See
>>> recent fixed-size GENMASK() series:
>>>
>>> https://patchwork.kernel.org/comment/26283604/
>> I don't care much for what people like or not. I don't see this
>> FIELD_MODIFY() as a particular improvement on *_replace_bits().
> Sad to hear that. Those people are all kernel engineers, and they
> deserve some respect.
> 
> We are talking about tooling here. People use tools only if they like
> them. Luo likes FIELD_MODIFY() over (yes, undocumented and ungreppable)
> xx_replace_bits() for the reasons he described very clearly. He's going
> to use it in his driver shortly, and this arm64 detour has been made
> after my request.
> 
>  From my perspective, both functions have their right to live in kernel.
> They are similar but not identical.
> 
> I'll take patch #1 in my branch. Regarding ARM64 part - it's up to you
> either to switch to FIELD_MODIFY(), _replace_bits(), or do nothing.
> 
> Thanks,
> Yury

Thank you for reviewing and discussing this patch series. The newly
added macro FIELD_MODIFY() will be utilized by the Qualcomm PPE (Packet
Processing Engine) Ethernet driver. Regarding the ARM64 core files,
could you please provide guidance on the preferred approach?
