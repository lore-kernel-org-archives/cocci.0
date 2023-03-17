Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB28C74A5B
	for <cocci@archiver.kernel.org>; Fri, 17 Mar 2023 13:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cBajXBLq8/VUEPMwLBL8moIAxIKvDhD2Pdx3nTDmURc=;
  b=nAJBgiITmmTGrcy4gpDL+0XmSARJyHcW6w9wBs1CfgH+R70xFWXd7zmw
   vdYm1HjtMatEjnJ8HjVEblcg1O+9p7zbefAM5q5NifMrEsKYIFiSoJk2P
   DJNLD5CdfzSy8AXdVuygkUBZJ1ZbscAZ0dTWJ1e2LJkC2r5lyFJAJ87fu
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@ibm.com
X-IronPort-AV: E=Sophos;i="5.98,268,1673910000"; 
   d="scan'208";a="97769300"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2023 14:18:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E09A8E00DA; Fri, 17 Mar 2023 14:18:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 04651E0010
	for <cocci@sympa.inria.fr>; Fri, 17 Mar 2023 14:11:49 +0100 (CET)
IronPort-SDR: 64146713_rJDTE4QOzv5wTdr9b6Nabg6sKmV0IQ5p9lS5LXcszSjvzsi
 H+qsbXFehX5ruzEs2/IcMPFEpJuTeLPo11jn6Cw==
X-IPAS-Result: =?us-ascii?q?A0HCAgAwZhRkhwGco5RQChwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IFPgi6BegQLRoRTiH6IMZd9hxg+DwEDAQsBAUICBAEBAwSCC4JzAoU1Ah0HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBAQEZCRcHD?=
 =?us-ascii?q?gULBSKFaA2CNykBdT0NPgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBDwIIU?=
 =?us-ascii?q?l0BAR4CAQMSER0BATcBDwsaAgUhAgIPAUcGEyKCXIIpAzEDA6Y3giJAiQkBA?=
 =?us-ascii?q?QF4gTKBAYIIAQEGnFUiU4FeCYEULJE0JxuBSUSBS4J0PoFTgkQtFYNDgmeCK?=
 =?us-ascii?q?YdfjnoKgTR2gSAOgT2BBAIJAhFrgRIIa4F9QQINZQsOdoFMAoFaNwNEHUADC?=
 =?us-ascii?q?zs6PzUUIV6BGiQFAwsVKkcECDkGGzQRAggPEg8GJkMOQjc0EwZcASkLDhEDT?=
 =?us-ascii?q?4FHBC+BXQYBJiSdC1KBByaBWpMCgyONbYEwnkKEBIFZny0ylxSSKy6HLZAPp?=
 =?us-ascii?q?3ECBAIEBQIVAYF5I4FcMxoIGxWDIk8DGQ+OIBkegzuQFyUyOwIHAQoBAQMJh?=
 =?us-ascii?q?UMmE4VHAQE?=
IronPort-PHdr: A9a23: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
 zl2dgVGqbjCtEtl
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:k7BOGKPeAjVYQ8BcTjSjsMiBIKoaSvp037Dk7TEWdfUzSL3nqy
 nOpoVl6faQslwssR4b6Kq90cW7MBfhHNtOkPEs1NSZLXXbUQmTXfxfBOLZqlWKdkGQmI88pM
 QQEdkaNDSzNykAsS+Q2njALz9P+qjhzImYwd7EyXFjVAdrbLwlwTtYJ2+gYz5LbTgDPIE+Ep
 WE4MpBun6HQlQ4KuqGJlRtZZmymzXs/KiWFCLuwyRXmjVmWgnYmYLHLw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,268,1673910000"; 
   d="scan'208";a="97768113"
X-MGA-submission: =?us-ascii?q?MDH4iLXWjKA4vaGzeVJZSTnF5m0Wn1dqjUByzN?=
 =?us-ascii?q?Mv05bSZnrcZqBOHp0YnPNay7aoqIAo1Hj8p7gJ8h40isRMzoFlnccZV5?=
 =?us-ascii?q?h92wTDlIZFjo+5aYT9xPpvNZb667nloqjwFXXiWWctRfNqZ71RvQw8Jd?=
 =?us-ascii?q?flfvpv2Ig5LulqDiQ5S2Ff1Q=3D=3D?=
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 14:11:47 +0100
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HCEdXO012947;
	Fri, 17 Mar 2023 13:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=cBajXBLq8/VUEPMwLBL8moIAxIKvDhD2Pdx3nTDmURc=;
 b=H8it6CGTMKUIuTlm1cHMIR5IJcVgem6noQAuIZlWkjT68bXD560MNm5qab2YXGwtoErf
 tvnyK7IH+38hBsnghbfjtgO7baMPwjfDj+rJ1TV9inJkP7gbKaPZoRlKQ27Hm874OsN4
 JViR1jQ6gBib20f9GGILfZRhvT0PKg+JczAu6eL3snEPbagTvdqUYmPCNkLCrvuDm5hS
 KU9P1RMpQDWiLxKgL9sJAf3Q4G4a2wqclHqXE0aAO9/ghn4avYqazyFBRQS/gZA0ZZ6s
 rSzXJl1/6CA2nAHSxp3GqIWFz6DtLkoVoO5C4LaJjMGa8XwNqUn+/JRh+oZssZAGGUXz mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcr1ssg54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Mar 2023 13:11:39 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32HCExZS013907;
	Fri, 17 Mar 2023 13:11:38 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcr1ssg4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Mar 2023 13:11:38 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
	by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32HCmqxg000650;
	Fri, 17 Mar 2023 13:11:37 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
	by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3pbs7ytpu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Mar 2023 13:11:37 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32HDBa9g7930606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Mar 2023 13:11:36 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 253F158059;
	Fri, 17 Mar 2023 13:11:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF93A5804B;
	Fri, 17 Mar 2023 13:11:35 +0000 (GMT)
Received: from localhost (unknown [9.163.4.251])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Mar 2023 13:11:35 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Christophe
 Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Paul Moore
 <paul@paul-moore.com>
In-Reply-To: <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de>
Date: Fri, 17 Mar 2023 08:11:35 -0500
Message-ID: <871qln8quw.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tmrLSXm7zbLrVyypCe7wlAIuSgHwYVvq
X-Proofpoint-GUID: wzHeKmL7981nZweQa5nW4uFjXbeeQ5aJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_08,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=886
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0 phishscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170089
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] powerpc/pseries: Fix exception handling in
 pSeries_reconfig_add_node()
Reply-To: Nathan Lynch <nathanl@linux.ibm.com>
X-Loop: cocci@inria.fr
X-Sequence: 892
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/871qln8quw.fsf%40linux.ibm.com>

Markus Elfring <Markus.Elfring@web.de> writes:
>
> The label =E2=80=9Cout_err=E2=80=9D was used to jump to another pointer c=
heck despite of
> the detail in the implementation of the function =E2=80=9CpSeries_reconfi=
g_add_node=E2=80=9D
> that it was determined already that the corresponding variable contained
> a null pointer (because of a failed function call in two cases).
>
> 1. Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=
=80=9D failed.
>
> 2. Use more appropriate labels instead.
>
> 3. Delete a redundant check.
>
> 4. Omit an explicit initialisation for the local variable =E2=80=9Cerr=E2=
=80=9D.
>
> This issue was detected by using the Coccinelle software.

Is there a correctness or safety issue here? The subject uses the word
"fix" but the commit message doesn't seem to identify one.

Can you share how Coccinelle is being invoked and its output?
