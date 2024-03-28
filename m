Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820F0CD11DF
	for <cocci@archiver.kernel.org>; Thu, 28 Mar 2024 21:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TXinUJCx8J9Wjt6zqO61zhNClFhIlIK8xWvVnUxEkEo=;
  b=E7o4Kz1Z2bF+ijAQ2Q45AMcJMxyCX5Qb/fFkntMezBVMUJWEe9GUpiWE
   uEQ5aH88siCTCGMwnCl5agGic2Ms/DOkckYuDiajV4rYY0nTAG0cvaiFM
   ZSTKHhW29ZGuKyQoo+8mNmzY8tjBuQqbcYHe7IsyZGxz+gh2ducY1bjRE
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@embeddedor.com
X-IronPort-AV: E=Sophos;i="6.07,162,1708383600"; 
   d="scan'208";a="159012616"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2024 22:33:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9A6FCE0157; Thu, 28 Mar 2024 22:33:49 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DF403E0131
	for <cocci@sympa.inria.fr>; Thu, 28 Mar 2024 22:33:41 +0100 (CET)
IronPort-SDR: 6605e234_LUgVtGv3jslCMOHCWai2Dg1ZRPqqkNIez7JRpdhugWBRU28
 sfns98DZguvcEu6TaRklVgjkbrSll9xRRtfTF/g==
X-IPAS-Result: =?us-ascii?q?A0FyOwBk4QVmfyMsWSNaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U8Cgjd6BVQxBAtIgVEBgwSROjCEO4FVliGDPhYPAQMBDUQEAQEDAQMNhHICi?=
 =?us-ascii?q?AYCHgcBBDUFDQECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEiG?=
 =?us-ascii?q?QcOCgEDKYVtDYJnATOCECyBCQEBAQMjFQgBATgPCxgCAiYCAlYGARQBAYJ8g?=
 =?us-ascii?q?mADAgECAbItgTKBAYIKAQEGswEJFoEELgGIDBoBBWWFDYQ9PAaCBQiBPAuCe?=
 =?us-ascii?q?D6IHoJohU2BI4hGghgBlE1UfhwDgQUEWg0bEB43ERATDQMIbh0CMToDBQMEM?=
 =?us-ascii?q?goSDAsfBRJCA0MGSAsDAhoFAwMEgS4FCxoCEBoGDCgDAxJJAhAUAzgDAwYDC?=
 =?us-ascii?q?jEuT0EMUANkHzEJFiYPDBoCGxQNJCMCLD4DCQoQAhYDHRYEMhEJCyYDKgY5A?=
 =?us-ascii?q?hIMBgYGXCAWCQQjAwgEA1ADIHARAwQaBAsHdoIAgT0EE0cQgTKKFgyDM4F5K?=
 =?us-ascii?q?YQ4S3QEA0QdQAIBC209NQkLGwYiAR2pVaY6aaBoBwOEE6EuBhMvg3IBEpNFk?=
 =?us-ascii?q?maYYiCCNKBfhVCBfCKBXHAVgyJPAxkPjiCDepxcJTQ7AgcLAQEDCYkiaGABA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vVALpTw6Ilp6Kyc5VFO9Tg0xg==
IronPort-HdrOrdr: A9a23:yc8cBq82mjSFWXRi0CVuk+BaI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re58jztCWE8Ar5PUtNpTnuAsi9qB/nhPhICMwqTM6ftWrd2FdATrsN0WKK+VSJcEeQygce79
 YGT0EUMqyTMbEVt7ef3OD1KadC/DGjmJrY/5aivgsdMnAVV0nihD0VNu5Qf3cGNTWuJqBJWK
 Z1FKd81nKdkYp7VLXIOpFiNdKz6uHjpdbBehBuPW9t1OG95QnYnYITJXCjr2Mju8Yj+8ZqzY
 A5/jaJrJlKhJmAu2jhP1m/1eUnpDMop+Ezd/BlcKUuW0PRtjo=
X-Talos-CUID: 9a23:y7+6Um4KfSUcC3EfH9ssqQ0tE+Icb3Tm0G7uIk+mG3x0eKzMYArF
X-Talos-MUID: =?us-ascii?q?9a23=3AzWQDTA1WssRwSBO9xVDzkZG11jUjyp6ADFsPg5Y?=
 =?us-ascii?q?8gtCcEC5vamrCiiyVe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,162,1708383600"; 
   d="scan'208";a="83383121"
X-MGA-submission: =?us-ascii?q?MDEgOvRnL/IzMkI0V22bsY6UrLZAXlkol/LQGG?=
 =?us-ascii?q?/99xUlOgeEx1KsSSQEh+mStk20nDkpjizdgMLx+IEb/RPUYZzRuNs28S?=
 =?us-ascii?q?DDFQzfwk4vF4LfVCcNKsLcyMuV/vREzv+nrErhl0MWVkWRbaopbB0C9P?=
 =?us-ascii?q?pDgDWcYJ25/yDDBbk7SmhLcw=3D=3D?=
Received: from omta36.uswest2.a.cloudfilter.net ([35.89.44.35])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 22:33:40 +0100
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id pWKlrLIIhtf2QpxNRrGqbp; Thu, 28 Mar 2024 21:33:38 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pxNQrNiCU3g73pxNQrHPnY; Thu, 28 Mar 2024 21:33:37 +0000
X-Authority-Analysis: v=2.4 cv=esUUzZpX c=1 sm=1 tr=0 ts=6605e231
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10
 a=hnA9GfvOmALhJaRmeA0A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TXinUJCx8J9Wjt6zqO61zhNClFhIlIK8xWvVnUxEkEo=; b=xPuQF6txwuzBNuY8taSHXXo/5F
	cCMPJ6CxQXWxPzNWlkLjyUM9xG9QtdDyh2tEW4a7NEgrsz4ZAa1Efx2ToUb/AW7hLuNitp+aCgySY
	07udPjGWQEuVOMmYfbbOKmM0QsGoo8VNyww5a68RwYHcxAPG/SXwg36ptKlniO+WHoHDjSXJ0Z1GA
	xnuUK13oGbPwp7z5/s7sPvkcIXgwW8L7QG916G2M9p7V9AUdZ3aRltPwAKYDhfMUfZJVsdMlq44W5
	fqcY6qWfqStl0GjaSJvv5MeOhIRYwwlMci4RVjrRs0S3CKaLXLyiHH3AhRwyLnkt37H96no0phhZ9
	2QEfJC8w==;
Received: from [201.172.173.147] (port=45966 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <garsilva@embeddedor.com>)
	id 1rpxNQ-001NjG-0l;
	Thu, 28 Mar 2024 16:33:36 -0500
Message-ID: <0b75676b-75a0-4302-a9ba-c4a5a2d0290b@embeddedor.com>
Date: Thu, 28 Mar 2024 15:33:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
In-Reply-To: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - inria.fr
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1rpxNQ-001NjG-0l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:45966
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfC2SX7UImVC/4Lya+qTh+uF5Ajr0czNxEL7NKiohwhaBBi5bThynIXJPEtHwU0SxnosgpxuZ2AnJ0k4FU6ZolAQdF17mRJUmZhv+4J3btEWHdNSK+5Lm
 i99VxP+1CeyH8zw1uomcA9vLDrhGHhyA25XyOLZGI/Z9WoRdam3QD8K370PXy58N/5pgorHXSkNCXrKHvdu64mPJL1R6kFWTlGg=
Subject: Re: [cocci] new version 1.2
Reply-To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
X-Loop: cocci@inria.fr
X-Sequence: 1631
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/0b75676b-75a0-4302-a9ba-c4a5a2d0290b%40embeddedor.com>



On 3/28/24 15:05, Julia Lawall wrote:
> Hello,
> 
> There is a new version, 1.2.
> 
> For the moment, I am unable to update the web page due to a CI issue, but
> the new version can be retrieved from github.

Awesome. :)

Thanks!
--
Gustavo
