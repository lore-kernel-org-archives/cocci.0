Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03809C6FD1F
	for <cocci@archiver.kernel.org>; Wed, 22 Mar 2023 10:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=tF9DPR4BziRpIYNIxnHYz1rUjU1J1WPHeaPCtVN4Vy0=;
  b=CYnZSKQM8OU3WX2D7S8Erc+U8yk5sCrCWAnhRSVsvTQfYejkVjrsiVGl
   P4KqZppcNKECjilDk3+rS/a/0qiQ4rBDXuP5l8F+8JPeqf/ojyUDhInf8
   tOIQTKLxNqDqgB4o0jLpol0Mm/79DqPH0c+wmv44xVVDF1KT+b8xRDGi3
   c=;
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
X-IronPort-AV: E=Sophos;i="5.98,281,1673910000"; 
   d="scan'208";a="98472383"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Mar 2023 11:20:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F2559E0D40; Wed, 22 Mar 2023 11:20:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AF01DE0A9B
	for <cocci@sympa.inria.fr>; Mon, 20 Mar 2023 16:39:02 +0100 (CET)
IronPort-SDR: 64187e15_Hvodtd67Nza1ita9tz2f04HByVRspzDQnesR82YGoOSxqwY
 Jp/Udrh77MsmV8ltE7B2lOI3h1eAUxeziU3gd/w==
X-IPAS-Result: =?us-ascii?q?A0HMAACBfRhkhgWeo5RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBT4IugXcDBAtGhFOIfogxl3+HGD4PAQMBCwEBQgIEAQEDBIILgnMCh?=
 =?us-ascii?q?TceBwEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEBG?=
 =?us-ascii?q?QcZBw4QBSKFaA2CNykBdT0NPgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBD?=
 =?us-ascii?q?wIIUl0BAR4CAQMSEQQZAQE3AQ8LGgIFIQICDwFHBhMiglyCKQMxAwOnEYIiQ?=
 =?us-ascii?q?IkJAQEBeH8zgQGCCAEBBpxVIlOBXgmBFCyRNEKBSUSBS4J0PoFTgnEVg0OCZ?=
 =?us-ascii?q?4Ioh1yPBgqBNHWBIA6BPYEEAgkCEWuBEghrgX1BAg1lCw5ygUsCgVw3A0QdQ?=
 =?us-ascii?q?AMLOzo/NRQhXoEZJAUDCxUqRwQIOQYbNBECCA8SDwYmRA5CNzQTBlwBKQsOE?=
 =?us-ascii?q?QNPgUcEL4FaCgYBJiSdCgJSKF8mgRhCWoxihT0JgyMBjWyBMJwMgjaEBIFZm?=
 =?us-ascii?q?CCHDTKDfYxmhjGSKy6HLZAPp3ECBAIEBQIVAYF5I4FcMxoIGxWDIk8DGQ+OI?=
 =?us-ascii?q?BmDWZAXJTI7AgcBCgEBAwmFQyYThGhfAQE?=
IronPort-PHdr: A9a23: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
 Tx9dV5d6Lya6GVThfAtQgR8
IronPort-Data: A9a23:mtRs963hdB7krTr8mfbD5Qh1kn2cJEfYwER7XKvMYLTBsI5bpzUDz
 TROXDiGPP/Zazf8Kdp3PI3g904E68PQy4IySFc93Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOH9IQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3ZRn0i1aYDkpOs/jY8Eg15Kyr0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJW3/tn8o1DXE/AdMJ2dpeGDxWt
 swZay9YO3hvh8ruqF66Yux83s1mdJGyNtkT4igm1SnZCu06TJyFSKLPjTNa9G5s1oYXQ62YP
 pdJL2cHgBfoO3WjPn8RAY4+leGsrn3+dSBI7lOfoOw85G27IAlZjeCyaYGPJYDiqcN9nh+Bj
 ETa9DTFRQwUFoelyGSo20iTv7qa9c/8cNlISOfirqACbEeo7mcUAxYXfUCqpOGwzE+4QdNWb
 UIOkhfCtoA35BShC4GlBhfirCbd+AYEW91LD+A2rgqKz8I4/jp1GEAAT2J+M90WvfNoVB8W/
 0bUh5DZBH9w5ej9pW2myp+Yqja7OC4wJGAEZDMZQQZt3zUFiN5o5v4oZok8eJNZnuEZChmrn
 G/X9HlWa6E7yJ9Uh//irDgrlhr1/sCRJjPZ8Dk7SY5M0++UTIu1P4btsQCC56xMdN/fVkGBu
 2MYlsTY5+cLZX1sqMBvaLVUdF1Kz6zeWNE5vbKJN8V+n9hK0yP7Fb28GBkkeC9U3j8sIFcFm
 nP7twJL/4N0N3C3d6JxaI/ZI510kvm6SIy7DK2KNIAmjn1NmOmvo30Giam4gD+FraTQufxX1
 WqzK5bwVChy5VpPlWPnGLl1PUAXKtAWnjmPH8qjkXxLIJKGfnmSR68CMV2SKqg46qjCyDg5A
 P4PX/ZmPy53CbWkCgGOqdB7BQlTcRATWM6qw+QKKL/rClQ9QwkJVaSOqY7NjqQ+w8y5YM+To
 ynhMqKZoXKj7UD6xfKiMCE5MO2wBs4vxZ/5VAR1VWuVN7EYSd7HxM8im1EfJtHLLcQylKImf
 OpPYMiaHPVERxLO/jlXP9G3r5VveF7vzUiCNjasKmp3NZNxZR37yvm9dCvW9Q4KEnWWs+k6q
 OaezQ/1e8cIaDljK8f0U8iR6W2Nk0ITo89MenfZA8JyfRzs+bd6Kiaqgf4QJdoNGCr5xTCb9
 li3BE5EgMbgv6oZ2cn4h4KHiquEDuBeNE1QRE+D34mPKBiAr3aCwJBBYsmMbzvyRGP5w4T8R
 OR3ntXXEuwLo0ZOiKV4S41U9KMZ48D9gpNj1SFmFyjvQ3XyLZh/M16q+8VrnY9c9I9z4AeZd
 BqGxYhHBO+vJsjgLm80GCMkSeamjtQ/hTjY6KUOEnXQvSNY0uKObhRPAkOqlidYEbpSNbEly
 8cHvOo9yVS2qjguA+a8ohFkzUa+BV1ebPx/rbAfOpHhtSQzwFIbYZD8ND7/0KvSV/pyaHsVM
 h2mr4ucoYQE3UfTUWsBJV6U18pnuJk+khRrzlgDGle3puT4lsIHhCN2zzBmYTlWnzNm0v1yM
 FdFL0daB7uD1BY2idlhX1KDIRBgBhqY8GP11lc5m3DQcGu0cmnrMmcGGP2s+XoB+Dl2ZQlr/
 7C/yUfkXw31fcr34DAAZE59p9HnTv1z7gfniun+O+ikRr4UOSHEhI2qbko28yrXO9s73hD7l
 LM77dROZr3eHg9Oha8CUq2x96kaETKAL0x8GcBRxrsDRzzgSWvjyAq1Ch6Df+1WLKb36m6+M
 ctlI/xPWzmY1CqjqjM6B7YGE4RrncwGtcYzRbf2GVEo67evjCJlkJb1xBjMgGUGR9ZPk8FkJ
 LjBKBOEMGib3kVPl0H38cJrB2ufYPs/XjPa4tybyusyOqg4gLleSn1qirqQlFeJATRj5COR7
 V/iZbeJ7ulMyrZMvorLE4dYDjrpcN7YCfy59Viugo4fcfLOLsb8mAcHoXb3PwltHOUwWvYms
 Z+vodLIzEf+k7JuaF/gmr6FDLtsyfipeehqbvLMM3hRmBWdVP/W4xcs/36yLbpLmoh/4vaLa
 hSZaszqU/IoQPZYmWNobhZBHyYnC6jYarnqoQW/pa+uDjkfyQn2E8O1x0T2bG10dj46BLOmM
 1Xa482R39F/qJhAIDQmBPs8Wp9xHwLFaJscLtb0sWGVM3msjla8oYDdrBsH6w+aOkncRYy+q
 djASwPlfRu/hLDQwZsL+8ZutxkQFzBmjfN2YksZ/MVshiunCHIda94QKogCFooehxmaOEsUv
 90RRDBK5eTBsTV4ndHU5cS7V0LHXrUEYNuhf3ox50OTcDu7CMWLB74JGuKMJZtpUmOL8Q1lA
 Yh2Fr7M0tyZxpBvWPZV5/a+x+xgw5s2A1oWrFvlnZWa7wk2WN03Ob8IIOaJfSjGFdzd0kTBI
 C4+QmUsrIRXj6LuOZ4IRkO50y31cN8iI/vEoMtPLBviV12n8dB9
IronPort-HdrOrdr: A9a23:6Aluuq8M5apcmH0V6Ftuk+AtI+orL9Y04lQ7vn2ZhyYlFPBw8P
 re4sjztCWE9wr5PUtLpTnuAtj7fZqxz+8Q3WBVB8bbYOCEghrVEGgB1/qe/9SIIUSXnYMwus
 kAE9kceb+AaGSSz/yKmzVQeOxQueVvnprY4tv2/jNVVgdtZLhn7wBlTiimMmAefng3ObMJUK
 OG4MxJvjyhfmlSSP+aKD0qY8jvzue7564PR3Y9dmsaAc21/EGVAWnBYmml4is=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,276,1673910000"; 
   d="scan'208";a="50713274"
X-MGA-submission: =?us-ascii?q?MDFtf+fJZNuaqntbkyYkK89VWvueRegSMQ3Duz?=
 =?us-ascii?q?qKo50iMIfy9JsUzmD1zsk5fO4r/RnJhBsK4bjZE1QUhUkqI4+o3htfZo?=
 =?us-ascii?q?f/dN4In3YD7ZpJ2ed+8BYeMcdp+ISM+umFECWva8DiEpZJ2q5afK7SiA?=
 =?us-ascii?q?jnu4Yoyz+Is0Ytdc7thTF2Jg=3D=3D?=
Received: from mx0b-001b2d01.pphosted.com (HELO mx0a-001b2d01.pphosted.com) ([148.163.158.5])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 16:39:01 +0100
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KFHSFe022310;
	Mon, 20 Mar 2023 15:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=tF9DPR4BziRpIYNIxnHYz1rUjU1J1WPHeaPCtVN4Vy0=;
 b=H4ehmhdJR7vvqAhDkTDpDUy6pvdFwBfibNmi9y8msPYVIt6vt5PKMwfY2qgEkibBgjpV
 T054dBChtf7ChrcrxZttx/NZ3+0C8YB1hBetfc/+kr0tqm6A0N7sD7y2+3ZsBUcADfJN
 Vxl7AMy+EKN/JEuT6edr0R/wgjBvZ3GiIAfzpW1AB0cgnCBvAWM4Gp4z5WIAWilxKmW/
 KCakSYDRuuOiktmqvAoWjjGbtcN06/y6UybPhN260gFFE/OG/sNEDAaJ728BINJBPKXv
 Blu2Ekiz1sCWNaM+9bSDQ6jKX6hJkXAtR1j3Xc4aONug65o3JLselHC/4f66AItLXTb1 xA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pdqf3546u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Mar 2023 15:38:54 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32KENu8h008070;
	Mon, 20 Mar 2023 15:38:54 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pdqf3546m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Mar 2023 15:38:54 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
	by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32KF8i3C024217;
	Mon, 20 Mar 2023 15:38:53 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
	by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3pd4x70x2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Mar 2023 15:38:52 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32KFcppB63504820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Mar 2023 15:38:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87D7058043;
	Mon, 20 Mar 2023 15:38:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EA375805D;
	Mon, 20 Mar 2023 15:38:51 +0000 (GMT)
Received: from localhost (unknown [9.211.100.146])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Mar 2023 15:38:51 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
        Christophe Leroy
 <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Paul Moore <paul@paul-moore.com>,
        linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
In-Reply-To: <2f5a00f6-f3fb-9f00-676a-acdcbef90c6c@web.de>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de>
 <871qln8quw.fsf@linux.ibm.com>
 <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de>
 <87v8iz75ck.fsf@linux.ibm.com>
 <2f5a00f6-f3fb-9f00-676a-acdcbef90c6c@web.de>
Date: Mon, 20 Mar 2023 10:38:50 -0500
Message-ID: <87pm9377qt.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F9folt-ke6hPsK5kwyUnxRyoAE_QFa5l
X-Proofpoint-ORIG-GUID: oHG_wXOFkuavUcnxh9y4s7Bxzj34q6ny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_10,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=587 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200128
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] powerpc/pseries: Fix exception handling in
 pSeries_reconfig_add_node()
Reply-To: Nathan Lynch <nathanl@linux.ibm.com>
X-Loop: cocci@inria.fr
X-Sequence: 908
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/87pm9377qt.fsf%40linux.ibm.com>

Markus Elfring <Markus.Elfring@web.de> writes:
>>>>> The label =E2=80=9Cout_err=E2=80=9D was used to jump to another point=
er check despite of
>>>>> the detail in the implementation of the function =E2=80=9CpSeries_rec=
onfig_add_node=E2=80=9D
>>>>> that it was determined already that the corresponding variable contai=
ned
>>>>> a null pointer (because of a failed function call in two cases).
>>>>>
>>>>> 1. Thus return directly after a call of the function =E2=80=9Ckzalloc=
=E2=80=9D failed.
>>>>>
>>>>> 2. Use more appropriate labels instead.
>>>>>
>>>>> 3. Delete a redundant check.
>>>>>
>>>>> 4. Omit an explicit initialisation for the local variable =E2=80=9Cer=
r=E2=80=9D.
>>>>>
>>>>> This issue was detected by using the Coccinelle software.
>>>> Is there a correctness or safety issue here?
>>> I got the impression that the application of only a single label like =
=E2=80=9Cout_err=E2=80=9D
>>> resulted in improvable implementation details.
>> I don't understand what you're trying to say here.
>
> What does hinder you to understand the presented change description better
> at the moment?
>
>
>> It doesn't seem to answer my question.
>
>
> I hope that my answer will trigger further helpful considerations.

I don't consider this response constructive, but I want to get this back
on track. It's been brought to my attention that there is in fact a
crash bug in this function's error path:

	np->parent =3D pseries_of_derive_parent(path);
	if (IS_ERR(np->parent)) {
		err =3D PTR_ERR(np->parent);
		goto out_err;
	}
...
out_err:
	if (np) {
		of_node_put(np->parent);

np->parent can be an encoded error value, we don't want to of_node_put()
that.

I believe the patch as written happens to fix the issue. Will you please
write it up as a bug fix and resubmit?
