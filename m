Return-Path: <SRS0=AtCD=PY=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D374C433EF
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 16:20:27 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A4A6120E
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 16:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 26A4A6120E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AsCFl5q2t/Y1XYivx8PbD5cJwkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ1mh21jUGmmVLXmqAO67YZGKmfYwkadu/9hxV6Mfcx982QQE+nZ1PZyIT+?=
 =?us-ascii?q?JCdXbx1DW+pYnjMdpWbJK5fAnR3huDodKjYdVeB4EfyWlTdhSMkj/jRH+KhULW?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YDdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?+g7PjewsLRKTTNE6AkBK6WYD72EgE93d0i/hhcqNCMS+7iB3Q9zx14N5KvpexD?=
 =?us-ascii?q?AA2OKDWsOUbSRhRVS9kVUFD0OWdeyTk65f7I0ruNiGEL+9VJEoxNoYZ0u9tCmF?=
 =?us-ascii?q?P6/ECbjMAdBaOg6Sx2r3TYuNtnd8yIsfDM4YWu3UmxjbcZd4tRp3FTqPi6tpR3?=
 =?us-ascii?q?TN2jcdLdd7Sbsxfa3xwbRDEYhRKIX8YDZs/mKGjgXyXWzFRtlOZvq0x72bcyCR?=
 =?us-ascii?q?+1bHsNJzefdnibclY2F2fu3DPuW/+GBwcKN2Z4TWA+3OowOTImEvTU5kPELmp3?=
 =?us-ascii?q?vFth1KXyyoYDxh+fVG2p/S1i02ic9JSKkoZvDAppqspnGSgSt76RDW6oHWAuRk?=
 =?us-ascii?q?HHdFXFoUS5AiLy6fQpQKUFGMNSDlpbN0gvdUxAzsw2TehlNPzBCdzt6WVD3ia+?=
 =?us-ascii?q?7eRsjq2NSUPBWsDYyUFUU0O5NyLnW2ZpnojVf57Cqm5y9n0Ai392C3T/G4/ga8?=
 =?us-ascii?q?ShIgFzc2GEZn8q2rEjvD0osQdv207hl6Y0z4=3D?=
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="2224323"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2021 17:20:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 178E8E006B; Fri,  5 Nov 2021 17:20:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 607A7E004C
	for <cocci@sympa.inria.fr>; Fri,  5 Nov 2021 17:20:19 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=mcgrof@infradead.org; spf=None smtp.mailfrom=mcgrof@infradead.org; spf=None smtp.helo=postmaster@bombadil.infradead.org
IronPort-PHdr: =?us-ascii?q?A9a23=3ApWBfPhRlGIjSNATNzZ6QGeAG2dpsonyfAWYlg6H?=
 =?us-ascii?q?Pa5pwe6iut67vIFbYra00ygOTBcOKsrkZ1KL/iOPJYSQ4+5GPsXQPItRndiQur?=
 =?us-ascii?q?oEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZ?=
 =?us-ascii?q?vJuTyB4Xek9m72/q99pHNfwlEnj6wba59IBi2rwjaq9Ubj5ZlJqst0BXCv2FGe?=
 =?us-ascii?q?/5RxWNmJFKTmwjz68Kt95N98Cpepuws+ddYXar1Y6o3Q7pYDC87M28u/83kqQP?=
 =?us-ascii?q?DTQqU6XQCVGgdjwdFDBLE7BH+WZfxrzf6u+9g0ySUIcH6UbY5Uim54qx1VBHnl?=
 =?us-ascii?q?jsINz8h8GHWlMNwir5boAm8rBB72oLYfZ2ZOOZ7cq7bYNgUR3dOXtxJWiJPAo2?=
 =?us-ascii?q?ycZYBAekPPelXs4byulkBrQClCAmwGO/j1iNEimPq0aEk1ekqDAHI3BYnH9ILq?=
 =?us-ascii?q?Hnaqsj1NKYJUeuo0qTIzS/Mb/ZN1jjj8ojIdgouofCKXbltdsfRzFUgFwzfjlW?=
 =?us-ascii?q?Xp4zoJDCV2foXs2id8eVgUfiji2k9qwF+uzWiwNonhYbViIwP0F/E6Tl5z5gvJ?=
 =?us-ascii?q?d2+UEN2fcOoHZpeuS2HK4d7QM0vTmB1tSs+1LALpZ61cSsLxZg52xPSaPOJfYe?=
 =?us-ascii?q?H7BzsWuufLjV1iXZ7db+iiBu/80mtx+vhXce3yFZHtjdJn93Pu3wXyhDe5MqKR?=
 =?us-ascii?q?uFj8ku9xzqDzR3f5+9KLE0yiKHVMYQuwqQqmZoWqUnDHjH5mEHxjKKObUok/e2?=
 =?us-ascii?q?o5P/9bbr7p5+cM5V4igD4MqQggMywG/k3PRYUUGeG4+i806fj/ULhTLVLiP05j?=
 =?us-ascii?q?LXZvYjHKckfpaO1GRJZ34gh5hqlETuqzMoUkWMaIF9Ldh+Ll43pNEvPIPD8A/e?=
 =?us-ascii?q?/mVOskDJzyvDDIrLhDY/NLn/NkLr6fLZ97UBcyBApwt9C+Z1bEKwOLOj0Wk/ru?=
 =?us-ascii?q?9zUFgU5PBCsw+b7FNV90ZsTVn6IAqCFLKzSsESF5vkvIumJfI8aoizxK/kj5/7?=
 =?us-ascii?q?0jH82g0URfaez3chfVHftIPBvOFmYZHvoyv0IG2QD9l4gRuXgi1SqSiNIajC5T?=
 =?us-ascii?q?fRvyCs8DdeCEIbYDqutibmL0T2/F5xQLjRDAV+WFnnAdIieXfoILiWILZkywXQ?=
 =?us-ascii?q?/SbG9Rtp5hlmVvwjgxu8id7KMksX9nZPl2sJ86+DamVc17zMmV6x1MkmHSGR+l?=
 =?us-ascii?q?28JQ3k32q5lqEBww1vF1rJ30aQw/TN75vVHSA42OJfQietgBIKqMj8=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AOx1nLqzsS+jtT6gPbNeiKrPwkr1zdoMgy1kn?=
 =?us-ascii?q?xilNoENuA6ulfpGV7ZAmPEHP+VMssREb6Ku90ci7MAfhHPtOkPUs1NiZLXfbUQ?=
 =?us-ascii?q?GTTb2KgbGSsgEIYheOgdK1jJ0QBZSWa+eAeGSS7/yKnzVQeuxIqLLmgdnY+Nsy?=
 =?us-ascii?q?100dNT2CDZsQnzuRYjzrdDwNeOAsP+tKKHPz3Ls1m9J1EU5nJvhSGRE+Lqn+T8?=
 =?us-ascii?q?yiruOuXfYZbyRXozVmhwnYpoITC3OjsCv3plh0rovKMlKpr+U63M+eWj2Au3zh?=
 =?us-ascii?q?Phfont5rcRLapqogOCTQ4vJlZwkFkm6TFchcs6brhkF7nN2S?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AMAAASaxphl4XKicZaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgUcFAQELAYN3OzGEAZAPUwoGgSQaBoprkH2CBwEDAQ1BBAEBhFe?=
 =?us-ascii?q?CdwIdBgYyBw4BAgQVAQEFAQEBAgEDAwQBEwEBAQEBAQEBCQkSBjokhWgNgjUpA?=
 =?us-ascii?q?YNkAQU6BgEBNwEPAQoOChwSECwbBoMEgmImp3mBM4EBggcBAQaIAgmBOgGNcic?=
 =?us-ascii?q?cfYEQgRU2gm8+ij+GaoFfoBedG4Mynn2DUwGjIbtWgWcMggF9CIMkUBkOjiCJB?=
 =?us-ascii?q?oVqJC84AgYLAQEDCYl1AQE?=
X-IPAS-Result: =?us-ascii?q?A0AMAAASaxphl4XKicZaHAEBAQEBAQcBARIBAQQEAQFAgUc?=
 =?us-ascii?q?FAQELAYN3OzGEAZAPUwoGgSQaBoprkH2CBwEDAQ1BBAEBhFeCdwIdBgYyBw4BA?=
 =?us-ascii?q?gQVAQEFAQEBAgEDAwQBEwEBAQEBAQEBCQkSBjokhWgNgjUpAYNkAQU6BgEBNwE?=
 =?us-ascii?q?PAQoOChwSECwbBoMEgmImp3mBM4EBggcBAQaIAgmBOgGNciccfYEQgRU2gm8+i?=
 =?us-ascii?q?j+GaoFfoBedG4Mynn2DUwGjIbtWgWcMggF9CIMkUBkOjiCJBoVqJC84AgYLAQE?=
 =?us-ascii?q?DCYl1AQE?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398365261"
X-MGA-submission: =?us-ascii?q?MDGIi1ZLgtY5E0Dxq7ytz0wVTcYwvy3ct5ZZNB?=
 =?us-ascii?q?uVhwNLzd5PDhAe/NmRuOSIF1sQu2x8yqDrECdirTT7KYIWFnZrSo+UJF?=
 =?us-ascii?q?FMGGGhQFjl7/G5fUpCrSRrZMMFTLsLWPmTJNjFfwgstWZeEqWE2aGypY?=
 =?us-ascii?q?vmtSRJAItT0Xc/TbbKVpXDjQ=3D=3D?=
Received: from bombadil.infradead.org ([198.137.202.133])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 17:20:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pp8GRKo/94ds2ZTojD46jsjdKgQVkDTCAKozr7vsgLo=; b=lzNn/SWJh9eVlpEbLfqyv5fiQc
	1K93/3kobEhBYffu+yzquVqjFzeS2mVDkaFk71qPslbYoKssEO80xhbdcvHBDvPDy2ikkmbnlchF8
	aAmB/L/IdZ60TKAZd8A79umQksAl4DPTkNMgodrSc+jgDp4dlYhSvYVVjf8MLL7ZLhTq/KSAyitl6
	j2yNEOjvII+IeIrKodFTo/84NIT+FdcR21KnL465ttk1wYdue2BiBIVupdeCgfUrHL+lwQFVtSVJF
	H/DEuKEipsRa/pqEWG69VVJWtQ5Ci641JoZBRwujjs4JPZdv54mD1Hekhr46mlG5Iu/5l7jnHTtsI
	tCOcOIGQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mj1wr-00BwfQ-Eq; Fri, 05 Nov 2021 16:20:13 +0000
Date: Fri, 5 Nov 2021 09:20:13 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: cocci@inria.fr
Message-ID: <YYVZva1hfwanXdyB@bombadil.infradead.org>
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
Sender: cocci-request@inria.fr
Subject: Re: [cocci] Need some help with spatch
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 74
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/YYVZva1hfwanXdyB%40bombadil.infradead.org>

On Fri, Nov 05, 2021 at 05:12:09PM +0100, Vlastimil Babka wrote:
> 1) patching complex variable declarations;
> 
> I need to perform changes such as:
> -struct page *page;
> +struct slab *slab;
> 
> This I was able to somehow specify in the .cocci, but not for situations
> where the original declarations looks like this:
> 
> struct page *page, *page2;
> 
> or
> 
> struct page *page = NULL;

For this, this seems to work well:

@@
@@

-struct page
+struct slab
