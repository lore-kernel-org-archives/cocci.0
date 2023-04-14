Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60E5C7619A
	for <cocci@archiver.kernel.org>; Sat, 15 Apr 2023 05:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=FPT7rHPeoZC8q3N+e8K8eC25WERHPS0zPtiNvYZ+tnI=;
  b=dRI9RzdqQojS8WjLejdUy2kQgU+nqIm7SDv6rhl/5qEIaWibE0pBCwzY
   5Gz81nxbKsD9bnejfGFEiCK6cVg5AjqFsQmy56psqgvNXVkSw5+tSb0xO
   qZurmphUYaDPEYAWs1WFQ4tRh4EjVoGN2ehpoYFPqe1WGgQRuBb/7hBhL
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@rice.edu
X-IronPort-AV: E=Sophos;i="5.99,199,1677538800"; 
   d="scan'208,217";a="103193601"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Apr 2023 07:10:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 69B90E0297; Sat, 15 Apr 2023 07:10:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 60775E00A8
	for <cocci@sympa.inria.fr>; Sat, 15 Apr 2023 00:36:37 +0200 (CEST)
IronPort-SDR: 6439d573_KMVfGbHVAo4evrBDv963vdLMc8SQFq/Vwpt94hSNkyp1eH/
 3sgNj0PUsEAb90A9IUHf18hkjPrNv03qEcPYxgQ==
X-IPAS-Result: =?us-ascii?q?A0EPAgAU1DlkmPSZo5RahDRSdYEFBAtGhFOIfYYPjgKLM?=
 =?us-ascii?q?4R4g1QGCQEDAQsBAUICBAEBAwSEfwKFPAIdBwEENBMBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIEBQECEAEBAQEBAQEBFQkZBRAOBSKFaA2CNyJ9gQgBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBFgIUcQIBAxIRHQEBOA8PAT0CAjQBBQEcO4JcA?=
 =?us-ascii?q?YJcAwGiERJyQm5AiQoBAQF4gTKBAYIIAQEGnTUBCYFrCRKBL4dMHlheAQGIG?=
 =?us-ascii?q?SeBGIEQgTyCUwEBgkCDPoMOgmeZa2mBNHaBIA6BPIEEAgkCEWuBEAhqW4EaB?=
 =?us-ascii?q?EACDWQLDm+BSYMqBAIUBT8OFgc2A0QdQAIBgQA+ATUJCyAGgS1CJAUDCxUqR?=
 =?us-ascii?q?wQIOAYbNBECCA8SDyxEDEIhFjMTBnkNCw4RA040gRMEggoGS58YhDtTAQEBk?=
 =?us-ascii?q?XGDTI0roAABBgKEAAWKS5YiBlWWdpI5l3WiXYUZAgQBAQEDBQIGECOBVyOBX?=
 =?us-ascii?q?DMaJYFsgUlPAxkPjjmEQ48tJDM9AgcBCgEBAwmFaYVcAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:i8LrRK1ZIj5zphRYZh1cdQqjBA8kLtp133Aq2lEZdPUMSL39qy
 ncpoV96faUskdrZJhEo7q90ca7MBHhHPJOjrX5Xo3SJjUO2lHYSb2KhLGKq1aMdxEWndQ96U
 4USdkcNDSGNzhHZKjBjjWQIpIO6uWjtIShheLlxX9rSg1wApsQkDtRO0K1OHFSAC1PBZ8CHp
 Ka4cZd4xW6f3B/VLXEOlA1G8fom/iOsJrnZCQNDxkh5BLLrR7A0s+HLzGomjg1bxYK5b8j9F
 LOmwv/6r7mk/a1zATZ33LS6ZM+oqqd9jIJPr3rtiFcEESUtu+3XvURZ1SthkFMnN2S
X-Talos-CUID: 9a23:H0iDvWPLPxb7ye5DVw1+8UUeF/sca2Ts9H7vI26AVlpyR+jA
X-Talos-MUID: 9a23:lk9C5QrL1TV/sMvl8bcez2BiK5lju633MR0AlKU4ppm+KX0pKw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,198,1677538800"; 
   d="scan'208,217";a="53405494"
X-MGA-submission: =?us-ascii?q?MDHOpQKWq9LY+kWdXaxYj5HZDceWz+awUmZzXP?=
 =?us-ascii?q?vQryo5EDE9VZcr72qdb8wIycWVQgUqjVAuvAV4hk+tgJvb6WqiFTX8cn?=
 =?us-ascii?q?vN4JaFFMHPHBbSxVvpyMESC3VOCcft59gOVlbLSipG8VOsvxBsqm6qnb?=
 =?us-ascii?q?uHMbUU4wskD47ZEHmBf7sxHg=3D=3D?=
Received: from mx0b-0010f301.pphosted.com ([148.163.153.244])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2023 00:36:35 +0200
Received: from pps.filterd (m0102858.ppops.net [127.0.0.1])
	by mx0b-0010f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EJtxm6031838
	for <cocci@inria.fr>; Fri, 14 Apr 2023 17:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rice.edu; h=date : from : to :
 message-id : in-reply-to : references : subject : mime-version :
 content-type; s=ricemail; bh=FPT7rHPeoZC8q3N+e8K8eC25WERHPS0zPtiNvYZ+tnI=;
 b=gAvUciITQxbGzGYiCNCXQynvwvBk4z3gJE2U3zdZxs1Gf9qDmFC7u0O2C+QZv1F8DVqB
 ouHkBpPM6isYusJvEX/uV5Zvkj3tclKxhIAIJ+/3RxmJKOPZ/ePauNAV6oc3PJCxFZ/O
 vu9hs1SDTiNDTAMq7o8qAIQPvtD3MbVq1RglS513BqNyQ08BzM5y/AnfJzg02R1tB5uG
 fESBRQxRDacHj/s5IQKotOVuo+wQi51cLha53M3D1b9/kNLjWDssSVdJIq9/0zlT+jXu
 KoJXore6TaPhZkuWfd2fkYUuEYfnkIgGOHICyvWTVQ4f8NXv7+GSCBXoMY9wjxzBZr7i uA== 
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0b-0010f301.pphosted.com (PPS) with ESMTPS id 3pyc7p8d8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <cocci@inria.fr>; Fri, 14 Apr 2023 17:36:33 -0500
Received: by mail-ot1-f69.google.com with SMTP id m3-20020a9d4c83000000b006a43b3b568eso1492937otf.1
        for <cocci@inria.fr>; Fri, 14 Apr 2023 15:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681511792; x=1684103792;
        h=mime-version:subject:references:in-reply-to:message-id:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPT7rHPeoZC8q3N+e8K8eC25WERHPS0zPtiNvYZ+tnI=;
        b=h1tf4OxETzbqao0NmW4iFNvyeCpYUXRBh2xR1YLgmwcOj07msso/iNlwNOniyfdlGN
         p2V4IPLjxHmFcAsDH8nzcFk/RpdJyKAjKcLcQE45Z9q29PfMN8hCwodwd4Txhc8qduA1
         Bqzeu/xrJXsHLpJ/CjPY2LXKbyTvB3HsFYYI4QIP7qEdWicbDpSvvjiXmDDviP2FeEFK
         TzuooyA8gxIdb4nkeyfIg0qW1UJ0SEQ62Qsnmz5JVdP9HR8osZdcY/CZYuwqNkf2bU62
         J0y8h6dNSc8ceGonE/MKkoKW2+Q3l4wR5F5mmf8o7cVCuiAWzuAjphk57bPRpK+bDpYe
         sZvQ==
X-Gm-Message-State: AAQBX9cNalOlWuGuVFMm5yGsD2KMpfp71X9XzfXTdfFxk0zvoJTmzjmu
	XDx0NkKUtMEy+ta6onZSr8KwcZuUEzD/PIVcrU5YJSg7dIMLAJHd1q1MKI02EXZTaaS+5/0jptL
	dT2/fdC0szgefFncDL6ccrBA7DYLMAED0vaycGo++
X-Received: by 2002:a05:6870:f21e:b0:187:8b2e:a756 with SMTP id t30-20020a056870f21e00b001878b2ea756mr4554419oao.17.1681511792187;
        Fri, 14 Apr 2023 15:36:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350b8hL/yG5SV+f9ErAkce7q+GwAOCL7/ZiGgqpIuIBjX+S3k0mA3OhEnZaALrC7B/nJKzB65VA==
X-Received: by 2002:a05:6870:f21e:b0:187:8b2e:a756 with SMTP id t30-20020a056870f21e00b001878b2ea756mr4554409oao.17.1681511791932;
        Fri, 14 Apr 2023 15:36:31 -0700 (PDT)
Received: from [2600:1700:d00:6760:e094:1451:f87f:0] ([2600:1700:d00:6760:24d9:82c2:900:162])
        by smtp.gmail.com with ESMTPSA id zh16-20020a0568716b9000b0017255c79736sm2257403oab.43.2023.04.14.15.36.31
        for <cocci@inria.fr>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Apr 2023 15:36:31 -0700 (PDT)
Date: Fri, 14 Apr 2023 17:36:25 -0500
From: Yudi Yang <jy103@rice.edu>
To: cocci@inria.fr
Message-ID: <bea8e057-44b0-4ae4-a6cc-b23bd0837270@Spark>
In-Reply-To: <eccc2924-6657-4776-84f1-3d8413904cf2@Spark>
References: <eccc2924-6657-4776-84f1-3d8413904cf2@Spark>
X-Readdle-Message-ID: bea8e057-44b0-4ae4-a6cc-b23bd0837270@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="6439d56f_d9633e0_1df"
X-Proofpoint-DLP: Gmail-Outbound
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_14,2023-04-14_01,2023-02-09_01
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Match and print size of allocation
Reply-To: Yudi Yang <jy103@rice.edu>
X-Loop: cocci@inria.fr
X-Sequence: 1052
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/bea8e057-44b0-4ae4-a6cc-b23bd0837270%40Spark>

--6439d56f_d9633e0_1df
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I would like to match the size of allocation, I am wondering if I write t=
he following:

=40print=40
expression N, SIZE;
=40=40

(
=C2=A0=C2=A0malloc(SIZE);
=7C
=C2=A0=C2=A0calloc(N, SIZE);
)
+ printf(=E2=80=9CAllocation: %d=5Cn=22, (N) * (SIZE));

I am not sure if I could set the default value for N in the malloc case, =
or is there anything I should do to make it correct.

Best,
Yudi


--6439d56f_d9633e0_1df
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22><span style=3D=22font-family:Courier New=22>Hello,<=
/span><br />
<br />
<span style=3D=22font-family:Courier New=22>I would like to match the siz=
e of allocation, I am wondering if I write the following:</span><br />
<br />
<span style=3D=22font-family:Courier New=22>=40print=40</span><br />
<span style=3D=22font-family:Courier New=22>expression N, SIZE;</span><br=
 />
<span style=3D=22font-family:Courier New=22>=40=40</span><br />
<br />
<span style=3D=22font-family:Courier New=22>(</span><br />
<span style=3D=22font-family:Courier New=22>&=23160;&=23160;malloc(SIZE);=
</span><br />
<span style=3D=22font-family:Courier New=22>=7C</span><br />
<span style=3D=22font-family:Courier New=22>&=23160;&=23160;calloc(N, SIZ=
E);</span><br />
<span style=3D=22font-family:Courier New=22>)</span><br />
<span style=3D=22font-family:Courier New=22>+ printf(=E2=80=9CAllocation:=
 %d=5Cn=22, (N) * (SIZE));</span><br />
<br />
<span style=3D=22font-family:Courier New=22>I am not sure if I could set =
the default value for N in the malloc case, or is there anything I should=
 do to make it correct.</span></div>
</div>
<div name=3D=22messageSignatureSection=22><br />
<div class=3D=22match=46ont=22><font face=3D=22Courier New=22>Best,</font=
>
<div dir=3D=22auto=22><font face=3D=22Courier New=22>Yudi</font></div>
<div dir=3D=22auto=22><br /></div>
</div>
</div>
</body>
</html>

--6439d56f_d9633e0_1df--

