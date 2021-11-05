Return-Path: <SRS0=AtCD=PY=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10333C433F5
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 21:33:06 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569C361101
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 21:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 569C361101
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AvgIYSaKTuA/Mj+N5FE+RwJQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHDshzon1GRRzjFKW2qHPPeOMDf2cotwOdvj/UlXu5HXnINqS1BcGVNFHysb8?=
 =?us-ascii?q?5KdbTi6Bh6tZH3KdpWroHqKXqzyU/GYRCwPZiKa9kjF3oTJ9yEmjPjRHuekU4Y?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWHULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIsi?=
 =?us-ascii?q?0l67yNEwMWL/bewaU4pZUc/H40l4T/WprjPx9baREAatUo2zhc9RZw9JGvp31T?=
 =?us-ascii?q?hgvM7fkmeIHUhAeHTsW0ahuouWaeiXv4KR/yGWDKRMA2c5GB0Y9Noww8/x8AWB?=
 =?us-ascii?q?Q+OZeKz0XaB2HweWsz9qTQOh3ndUtIuHkOYoevjdryjSxJf0hTJbORY3F4NZZ2?=
 =?us-ascii?q?HE7gcUmNfrXYYwbLyVuaBDBahhUElgSAZM62uyvgxHXfzRGqV6Ooqw77WfX5AN?=
 =?us-ascii?q?02bnpdtHSf7SiScgThUGFtGuA9GPjDxcGNdq3xj+M83bqjejK9QvwQ58WEKyQ+?=
 =?us-ascii?q?fltj1megGcUDXU+X1a9rPW4iVKWW99eLUFS4C0lrrNa3EevSd7mdx+4q3qDuQV?=
 =?us-ascii?q?aUN1Ve8U24QeMx66S5wuLDWECSRZFadovrshwQiYlvneCn8noHiBoqL3TQ3WQ9?=
 =?us-ascii?q?rKLpDe+NDI9KW4Eby4YCwAC5rHeTCsb5v7UZs55F6LwitzuBTzr3mna6ik4nbQ?=
 =?us-ascii?q?ay8ARv5hXNGvv21qEzqUlhCZsjukPYl+Y0w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="2253589"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2021 22:33:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C371FE02AF; Fri,  5 Nov 2021 22:33:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0C8A6E004C
	for <cocci@sympa.inria.fr>; Fri,  5 Nov 2021 22:33:00 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=vbabka@suse.cz; spf=Pass smtp.mailfrom=vbabka@suse.cz; spf=None smtp.helo=postmaster@smtp-out1.suse.de
IronPort-PHdr: =?us-ascii?q?A9a23=3AaDQm9xQdokz4TE1noLF4vhfQc9psonefAWYlg6H?=
 =?us-ascii?q?Pa5pwe6iut67vIFbYra00ygOTBcOKsrkZ1KL/iOPJYSQ4+5GPsXQPItRndiQur?=
 =?us-ascii?q?oEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZ?=
 =?us-ascii?q?vJuTyB4Xek9m72/q99pHNfwlEnj6wba59IBi2rwjaq9Ubj5ZlJqst0BXCv2FGe?=
 =?us-ascii?q?/5RxWNmJFKTmwjz68Kt95N98Cpepuws+ddYXar1Y6o3Q7pYDC87M28u/83kqQP?=
 =?us-ascii?q?DTQqU6XQCVGgdjwdFDBLE7BH+WZfxrzf6u+9g0ySUIcH6UbY5Uim54qx1VBHnl?=
 =?us-ascii?q?jsINz8h8GHWlMNwir5boAm8rBB72oLYfZ2ZOOZ7cq7bYNgUR3dOXtxJWiJCDI2?=
 =?us-ascii?q?zYIUAAfcfM+ZWr4fypUcBoxSlCAmwBu7i0CNEimP40KA41ekqDAHI3BYnH9ILq?=
 =?us-ascii?q?Hnbo9H1O70JUeCpzanIyDTDb/dL0jrg8ofHaRMhruuRVr93b8re0lMgGBjGjlq?=
 =?us-ascii?q?KsoHlJC6V1v8TvGSB8+VhVPuihmg6oA5+vjah3N0jipXVho0L0FDE8z10zZooK?=
 =?us-ascii?q?NC3VkJ1b8OoHpVeui+VOYV4Tc0vTnxptSs+17ALvZG2cTUJxZkjyBPRZOGKfoe?=
 =?us-ascii?q?U7h79WuucLzZ1iG9ldr+5mh288lCgx/XhWsSw0FtGtDdJn9fMu3wXyRDf9NSLR?=
 =?us-ascii?q?uFj8kqi3zuEyhrd5fteIU8ukKrWM54hzaA0lpoUqUnDBSr2mFnujKOPcUUk5/S?=
 =?us-ascii?q?o5/n9brX9u5+cLJF7hhvjPaswgsC/AOI4PRYSX2WD5Oix0L3u8VfkTLhEjvA6i?=
 =?us-ascii?q?LfVvI7GKcgBuKK0ABdZ0oM55Ba+Czem3s4YnX4CLF9dZhKIlJLmNErNIP/iFvq?=
 =?us-ascii?q?/mEmskCx1yPzcIrLgA43BLmLfn7f5YbZ990lcxRIvwtBY+51bFrABLenoWk7xs?=
 =?us-ascii?q?dzYFgU2Pxa1w+bhEtV915kRVXiBAq+DKKnSq0OH5vozI+mQY48YoDL9JOIr5vH?=
 =?us-ascii?q?0iX85nUQQfKio3ZsSc3+4BO5pL1+YYXrqmNcBEH0FshAwTOzw2xW+VmtxenKzV?=
 =?us-ascii?q?uoY7y4yDIbuWYXeQoGkxriIwy6/GrVXYHpHAxaCCyG7WZ+DXqIybCuJPs5kkzh?=
 =?us-ascii?q?Mf7GrSIZpgQ+kvQX5wpJ8M/HZvCYK48GwnONp7vHewElhvQd/CN6QhiTUFzkcd?=
 =?us-ascii?q?oIgXDoqxOV4vFAkjEyeyqU+j/EKTbS7AttSTxw3c5XOnbQS4z/aQR/ac5GCWgT?=
 =?us-ascii?q?/Kug=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Abq1OeahtY16a5Iyur/HaTw1YjnBQXuUji2hC?=
 =?us-ascii?q?6mlwRA09TyVXrbHIoB1p726QtN93YgBbpTngAtj6fZq4z/QZ3WB/B9aftWXdyR?=
 =?us-ascii?q?KVxcRZnPPfKl7bexEWlNQy6U4IScEXY7GeMbE5t7ed3ODSKadD/DDoytHNuQ6T?=
 =?us-ascii?q?9QYPcT1X?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0A+AAASaxphexzch8NaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgUcFAQELAYN3AQEBODGER49JgXcwhBiXUIF8CwEDAQ1BBAEBhGE?=
 =?us-ascii?q?CgmsCHQcBBDIHDgECBBUBAQUBAQECAQMDBAETAQEPCw8HOiSFaA2CNSkBg2QBA?=
 =?us-ascii?q?gMjHQEBNwEPCxgCAiYCAlcGDQgBAYJtgwynd4ExgQGCBwEBBoYMHIFaCYEQKgG?=
 =?us-ascii?q?MeHonHIFJRIE8gn4+h1uCZIcXPqAsnXqDMoNTmmoGDwUmg1ORdg6RHrtWgWYBg?=
 =?us-ascii?q?g0zGggwgyRQGQ6OIIQaijdAAQEBLzgCBgsBAQMJiXUBAQ?=
X-IPAS-Result: =?us-ascii?q?A0A+AAASaxphexzch8NaHAEBAQEBAQcBARIBAQQEAQFAgUc?=
 =?us-ascii?q?FAQELAYN3AQEBODGER49JgXcwhBiXUIF8CwEDAQ1BBAEBhGECgmsCHQcBBDIHD?=
 =?us-ascii?q?gECBBUBAQUBAQECAQMDBAETAQEPCw8HOiSFaA2CNSkBg2QBAgMjHQEBNwEPCxg?=
 =?us-ascii?q?CAiYCAlcGDQgBAYJtgwynd4ExgQGCBwEBBoYMHIFaCYEQKgGMeHonHIFJRIE8g?=
 =?us-ascii?q?n4+h1uCZIcXPqAsnXqDMoNTmmoGDwUmg1ORdg6RHrtWgWYBgg0zGggwgyRQGQ6?=
 =?us-ascii?q?OIIQaijdAAQEBLzgCBgsBAQMJiXUBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398384492"
X-MGA-submission: =?us-ascii?q?MDE26fwDuoOJPKQY2qMllal7LUinsrDXLXfb23?=
 =?us-ascii?q?RhFZmmyQ12qsQLvcKT+mY3upBICE+6Nthwz9o5dlY5I0bkP7guKGJV3d?=
 =?us-ascii?q?F4vvZtBau5r7EVlAXUHEL6GB0YbxSLbzmMo1+NStjwufSDtxDPtqo8AQ?=
 =?us-ascii?q?gwSSaUYHVlQO2OnhXEl9ELXw=3D=3D?=
Received: from smtp-out1.suse.de ([195.135.220.28])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 22:32:59 +0100
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1FAAE212BF;
	Fri,  5 Nov 2021 21:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1636147979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYo9SZeW1/CQzxPEpDuMxEWujD7xz2XTt6c2pvQoJY8=;
	b=XedqmDU/blvQwMDY+yrpYZwpIXRndpnzMjHjtPu/+9YmpVKC+p1Fdj0oSqgDeec0DP3b3b
	Ak33EO/M5PSyCDh2AoUqUNxETcEV6pZyivYRxU5XrUOMZ+IyaN4mi1ZOWJUPD9CplBRjiM
	0TeL2DrvTWfEVHo1GGCc+BJpxcJ2VU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1636147979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYo9SZeW1/CQzxPEpDuMxEWujD7xz2XTt6c2pvQoJY8=;
	b=n2Es7RoXb+YLUEfYvlJTr01a/QQaz6hIlIGCkSjQUOMrKHCvbd/67hcr6DLKBl7dBmrUsl
	gsGZo6zi3UtNsxAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 045E514023;
	Fri,  5 Nov 2021 21:32:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id HDZzOwqjhWGqOwAAMHmgww
	(envelope-from <vbabka@suse.cz>); Fri, 05 Nov 2021 21:32:58 +0000
Message-ID: <790dd83b-9b89-c4db-6b2a-6ffd0dd27aac@suse.cz>
Date: Fri, 5 Nov 2021 22:32:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
 <alpine.DEB.2.22.394.2111052230480.3000@hadrien>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <alpine.DEB.2.22.394.2111052230480.3000@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Need some help with spatch
Reply-To: Vlastimil Babka <vbabka@suse.cz>
X-Loop: cocci@inria.fr
X-Sequence: 81
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/790dd83b-9b89-c4db-6b2a-6ffd0dd27aac%40suse.cz>

On 11/5/21 22:31, Julia Lawall wrote:
>> 3) eliminated whitespace including newlines
>>
>> This is stylistic but will require some postprocessing fixups if not solved.
>> There seem to be several cases like this where whitespace including newlines
>> is eliminated between two lines that are patched by the spatch:
>>
>> -       struct page *page;
>> -
>> -       page = container_of(h, struct page, rcu_head);
>> +       struct slab *slab;slab = container_of(h, struct page, rcu_head);
> 
> Which semantic patch causes this problem?

That's also 184d9494c1a4 slub.cocci

