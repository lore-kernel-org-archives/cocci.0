Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D597CCF9EA
	for <cocci@archiver.kernel.org>; Mon, 27 Oct 2025 12:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IbLm1tSTg8XJYn4yAXU7f0hmK6A2TDlOseJPf+n0YsU=;
  b=gXuyW8QPHnIA6qM8WP+O4LjFfn57+FslHZCgCRcUdgFc0VPvnGERhH2q
   HWl+g+vNfZwE3asI+vEUDZd5oA/Plp2W24zV1EKnKiZVMrT/eN6aLUDab
   KQRBEjCslrAGQABn4T2tn7NIdh/LF/p5VsBD1zKXekbQXKjI87esX6mhk
   A=;
X-CSE-ConnectionGUID: WsIpDER0SquKeUBFWw+lzA==
X-CSE-MsgGUID: o4bQ4z4zQa2vNGwPRt2OHA==
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
X-IronPort-AV: E=Sophos;i="6.19,258,1754949600"; 
   d="scan'208";a="246304337"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2025 13:03:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 978DBE0172; Mon, 27 Oct 2025 13:03:19 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0759FE0171
	for <cocci@sympa.inria.fr>; Mon, 27 Oct 2025 13:03:17 +0100 (CET)
X-CSE-ConnectionGUID: /Bw8fOXsQ42PmpwpwK2CjA==
X-CSE-MsgGUID: kI5sdgd9Tg6dKJn5vLnqFA==
IronPort-SDR: 68ff5f84_VyisY1x3C+TWG+o904LuS5K68lrGnyq7ZQS6TEGEM+Eb8ES
 QhTlkMkohF+nR7fRRNUjWdJXV+sHKSZRPy8EPTQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FzAADtXv9ogAwR49RaHQEBAQEJARIBBQUBQIE9BwELA?=
 =?us-ascii?q?YI/ZSNYMwQLSYRVj1KGX4c8h1WIeYFVgX0CDwEDAQ1OAQIEAQEDBIUAAoxOA?=
 =?us-ascii?q?h4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBO?=
 =?us-ascii?q?wcOCjGGTw2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAIBAyMdAQERJw8LGgImA?=
 =?us-ascii?q?gJWBgEUAQGCfoIjAQYQAQM2B7IMgTKBAYIMAQEG2l8fLCJZgWQJgRwuAYVsg?=
 =?us-ascii?q?mQBhieEPScPgVVEgTyCUjE+iB6CaYImgQ6GKZFtUngcA1ksAVUTFwsHBYEgQ?=
 =?us-ascii?q?wMqNC0jDzwFLR2BJyIfGBNgPRdAg0kbBmgPBoESGUkCAgIFAkI6gWgiBh8SA?=
 =?us-ascii?q?gMBAgI6Vw2BdwICBIIefoIHGA+EQoEFgj8CAQttPTcJCxsGPZN+hmVGpD6hR?=
 =?us-ascii?q?TQHgjiBZ4FkDJ9sBhMvg3EBk2AOBpMFmQYiqR+BagE3gVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?YQzxxRCNTwCBwsBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 EZetw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ac3TXaFyjWXy/wkTpLqENseALOsnbusQ8zAXPjNKOHlom6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK5yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4xgPM
 xbE5SWZueAbmRSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: =?us-ascii?q?9a23=3APQXbqWijdXI+/Ho3btLHUqZAMzJuNVfCnHn3E1S?=
 =?us-ascii?q?BVTxRTaWKUUCzoohmup87?=
X-Talos-MUID: 9a23:7ZxGzQScmJec6w+9RXTvpWx5OMhkspihVkwus5Nbpe2CLAJZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,258,1754949600"; 
   d="scan'208";a="246304330"
X-MGA-submission: =?us-ascii?q?MDH+0BZaeXX6IZ2WIab2p0qJJDvAFlDutS3XYU?=
 =?us-ascii?q?JayLiS0b9yLpcWC1cLEc08ZWIwjJ3crloUcUZG77xxsfNSalmIz3araS?=
 =?us-ascii?q?lV1x1oRnlUno+ncM10lTQYlLa+aSVUJ1trgX9uC6uz/IeTBXzmCzUkgR?=
 =?us-ascii?q?KN/qZyfbiSm9+4rQMS7HXiuQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 13:03:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761566595; x=1762171395; i=markus.elfring@web.de;
	bh=IbLm1tSTg8XJYn4yAXU7f0hmK6A2TDlOseJPf+n0YsU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JtiE5QjZIVVcqwL5ZRWcC7ruvuIYUuG30Es3JbcitUhHULkrEhkHcb60rW3VcCYu
	 tj0CzuKO0J5rNuDoBgwtxvAQPN48Xc66ZJf+gHYsvwiWprV9GeH3B8us/ziuQQhDZ
	 SM7tVdticCN7ejzOqurA5vjHgyfIIBmlJCKhUhuJnu7bG4mnby8LOVprhFfMg9O91
	 lXaBiUbu1GlvuILckcgS77yEwOrKMDGF5O2+oX5dG8cpXE0eyjGeoXPtgEMaZH+kl
	 uz4Uf6o5q0pCNZGTrQWIskKF7SYXMuEsSlwxX7NJVPquNe9g82m5L06CO5tSU1pkX
	 m/unml+RX5ZKlQt7Lg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.179]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCol0-1v4aW33AfY-002EHE; Mon, 27
 Oct 2025 13:03:15 +0100
Message-ID: <d0112ed2-0cb9-4fb2-a8e6-0f94e8424d0e@web.de>
Date: Mon, 27 Oct 2025 13:03:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <67c4f12a-5b58-459f-b02d-cfa5e6275693@web.de>
 <ade38bd-6997-b95-cce1-74944218af1e@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ade38bd-6997-b95-cce1-74944218af1e@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rgzeuV186gQxqYCJhLrlSTLMqlMznPyvxHL++tKi2ueFNpeVVF7
 KAshMiLzF4fMkgBG10nViifdaEV7Lrwhwi6Tz7F0jrF1wnfL0vmnpZOGlPfIsSSpghLsMvb
 yYi0VdNnoyL0D9LQ4knCz5f86yGfppXlQqBk3sG0vmRKxFF3ting6xlXi7bX6sd1deeXOOZ
 UUwNk+WlpHR8cKwqcwMmQ==
UI-OutboundReport: notjunk:1;M01:P0:4hTn0bMxZjQ=;4SCvpMZr3mM+x5TdaqAyVKbzYgi
 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
 l+/lRvF5GUn0sQ==
Subject: Re: [cocci] Searching for selected function declarations with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3101
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/d0112ed2-0cb9-4fb2-a8e6-0f94e8424d0e%40web.de>

>> @display@
>> identifier i;
>> @@
>>  my_type
>> *i(...)
>>  ;
> It would work properly if my_type were declared as a typedef.

Can such a source code search pattern become supported also with an indicated fixed information
(without moving it to a constraint for an extra metavariable)?

Regards,
Markus
