Return-Path: <SRS0=h9ga=P2=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40095C433F5
	for <cocci@archiver.kernel.org>; Sun,  7 Nov 2021 17:51:37 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36ADC613B3
	for <cocci@archiver.kernel.org>; Sun,  7 Nov 2021 17:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 36ADC613B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,216,1631570400"; 
   d="scan'208";a="2393688"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2021 18:51:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E6EECE006A; Sun,  7 Nov 2021 18:51:33 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 77979E004C
	for <cocci@sympa.inria.fr>; Sun,  7 Nov 2021 18:51:30 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=vbabka@suse.cz; spf=Pass smtp.mailfrom=vbabka@suse.cz; spf=None smtp.helo=postmaster@smtp-out1.suse.de
IronPort-PHdr: =?us-ascii?q?A9a23=3AKzuPVBZ+EzyRonvg03+6TP7/LTFh14qcDmcuAno?=
 =?us-ascii?q?PtbtCf+yZ8oj4OwSHvLMx1gaPBN2QuqsMy7KP9fy6ASpYudfJmUtBWaQEbwUCh?=
 =?us-ascii?q?8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV?=
 =?us-ascii?q?6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+Mgi6oR/MusUKjodvLrs9wQbNrndUZ?=
 =?us-ascii?q?uha32xlKUyPkxrm+su84Jtv+DlMtvw88MJNTb/0dLkiQ7xCCzQmPWE15Mn1uhT?=
 =?us-ascii?q?GUACC+HgSXHgInxRRGwTK4w30UZn3sivhq+pywzKaMtHsTbA1Qjut8aFmQwL1h?=
 =?us-ascii?q?SgdNj459GbXitFsjK9evRmsqQBzz5LSbYqIL/d1YL/Tcs0GSmpARsZRVjJOAoW?=
 =?us-ascii?q?gb4sUEuENOf9Uo5Thq1cSqBezAxSnCuHyxT9SnnL43qM03OsvHg/bwgIgEdIAv?=
 =?us-ascii?q?3bIo9v6L6oSTeK4wbPUwTnfYf5b2zHw45XIfBA7pvGMWKp9fsXVyUY1DAPFklS?=
 =?us-ascii?q?QqYnkPzORy+8ArnKU4PFjVe21lmUqrB9xrSO1ycg3iYnGnJkYykvZ9SVi3ok5P?=
 =?us-ascii?q?8G3SU9ibNOiDZBfuD2UOZFsTcM+X2Fnpjw6yrsetJKmeCUHzJYqyh/fZvCbd4W?=
 =?us-ascii?q?E/A7uWPuNLDtmmH5reLKyihSy/EW+xePyVtW43EpLoydLltTCuWwB2RLc5MWZV?=
 =?us-ascii?q?vdw+Fqq1ziI1wDW8O5EIEY0mLLaK54n2L4wl4AcvV7NHi/sgEn2j7GZdl8i+ue?=
 =?us-ascii?q?27+TreLLmpoWTN4JylwrwMbwul9SiDek8MgUCRXWX9Oq82bH540H1XqlGgucon?=
 =?us-ascii?q?qTatp3RON4VqbSjAwBP14Yu8xa/ACmi0NQfhXQHN1dFeA6fj4TwPFHOPez4Aeq?=
 =?us-ascii?q?lj1S3jTdr3O7JMqf8DZrTNnTDkbHhcqhh60NE1QY+ydBS64hJBrwPIP//QFH9u?=
 =?us-ascii?q?MLEAhMjLQC5wP7rCNBn2YMfXWKPDLWZMKTXsVKQ+OIgOPODa5QWuDnnMPUl/OP?=
 =?us-ascii?q?ujWQnllMHYaao3IMbaGqkEfR+P0WZfX3sj88dHmcNogUxUO3qhUaZUT9TYnayR?=
 =?us-ascii?q?7gz6is6CIKgF4fDR5qijKaP3CehBpdWfHxJCkiQEXf0cIWJQ/MMZzicI8B7ljw?=
 =?us-ascii?q?EUaOsSo4g1RGrrwD60aBoIvDV+i0er5Lj1cJ66/fdlREopnRICJG42nuOUno8s?=
 =?us-ascii?q?2cGXT4w0+grhEVnyUqYl4V8jeZZE9N7+P5DFAs3Y9qU7fF+Ctm6fgved9ONAAK?=
 =?us-ascii?q?kX9GnCHc1R804x9smYkBnGtzkgAqVjASwBLpAqbiCH4A196PYl1L4LcV0gyLY3?=
 =?us-ascii?q?qArjFAOWdZUOCutlPgspEDoG4fVnhDBxO6RfqMG0XuIrT/bpYJhlFpFSwM2Wre?=
 =?us-ascii?q?XBBj3h2PNqMjho0TfU+boEqk8P01NxJzaQkOvQsb0llgAT+WxYLzj?=
IronPort-Data: =?us-ascii?q?A9a23=3At6CS2qxtW6OKNmlC1E16t+dsxyrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApGwi0GACzmFLWmyHPP2KY2fxKt0lPNm0/EtSvZCAzoJkOVdlrnsFo1Bi+?=
 =?us-ascii?q?ZOUX4zBRqvTF3rPdZObFBoPA/3z27AsFehsJpPnjkrrYueJQUVUj/nSH+OlULG?=
 =?us-ascii?q?cY0ideCc9IMsfoUI78wIGqtUw6TSJK1vlVeLa+6UzCnf9s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kuq3+blVPRaPOZE6Vl2FbHaSv6vRAjnVjj+Bib6daMx0PzW/Z9zxy4I0lWZiYV?=
 =?us-ascii?q?w0gNK7FsP8ASBQeGDMW0ahuouSWeibv7qR/yGWdLyW8na8zZK0sBqUT/e18AEl?=
 =?us-ascii?q?V5PkAIXYMaAqCjqS42tqTTuBzj8AnBNvqOYkFszdhyyvYBLAoW/j+rw/i8YcNh?=
 =?us-ascii?q?nFrkpkbRbCGc5BMMXw0NUWRd0YaYhFKHM1rtfmOrXzZXz19iVuzmbAR9zGLmVQ?=
 =?us-ascii?q?1iayF3MH9YdmWXYBSg1rB4Hnb5Gm/DhxyCTBW8hLdmlrEuwMFtXqTtEMu+LyEG?=
 =?us-ascii?q?jpCm1iP3ikUFQFPE0CmuvT/hkPWtxd3Q6AL0nJGkETw3BXDohrBs9mQu2Ofs1g?=
 =?us-ascii?q?XSbK81sUkvRqVxPO8DxmxXwA5o/0oVDDinNQrXjFs3U3hcxbBbdBwmOX9dE9xP?=
 =?us-ascii?q?Yt4Yd9/1eb54IPCieI5odM53uTe?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A5NhRmK/ws0fWgfKn2VBuk+D4I+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlC/Bw+Pre/sjzuSWE6wr5HUtBpTniAse9qBHnhPpICOAqVN/INjUO+l?=
 =?us-ascii?q?HIEGgI1/qE/9SPIVyZygef78pdWpk7Jtn5DV0/q9377gm+G9Nl5NWc6qiniaP/?=
 =?us-ascii?q?4h5WPGRXgm1bgzuRwzz1LnFL?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0C7AABoEYhhexzch8NaGwEBAQEBAQEBB?=
 =?us-ascii?q?QEBARIBAQEDAwEBAUCBWYMhVgEBATgxA4REjm+Bdy4DniwLAQMBDTUMBAEBhQI?=
 =?us-ascii?q?CglMCHQcBBDQTAQIEFQEBBQEBAQIBAwMEARMBAQ8LDwc6JIVoDYI1KQGDZAECA?=
 =?us-ascii?q?yMdAQE3AQ8LGAICJgICVwYBDAYCAQEXglYBgwsLqzqBMYEBgggBAQaBPgEDAoQ?=
 =?us-ascii?q?lHIFaAwaBECoBjS56JxyBSUSBFScMgnc+gmMDhHeCZY5mQheBIgJ7gSRYkUoPj?=
 =?us-ascii?q?keeHYNCg1qGdJQbBg8FLZVkDpE2lhAfjFWZOIF4gX0zGggwgyRRGQ+OIIQagRa?=
 =?us-ascii?q?DVoVLQAEBATACATUCBgsBAQMJkHUBAQ?=
X-IPAS-Result: =?us-ascii?q?A0C7AABoEYhhexzch8NaGwEBAQEBAQEBBQEBARIBAQEDAwE?=
 =?us-ascii?q?BAUCBWYMhVgEBATgxA4REjm+Bdy4DniwLAQMBDTUMBAEBhQICglMCHQcBBDQTA?=
 =?us-ascii?q?QIEFQEBBQEBAQIBAwMEARMBAQ8LDwc6JIVoDYI1KQGDZAECAyMdAQE3AQ8LGAI?=
 =?us-ascii?q?CJgICVwYBDAYCAQEXglYBgwsLqzqBMYEBgggBAQaBPgEDAoQlHIFaAwaBECoBj?=
 =?us-ascii?q?S56JxyBSUSBFScMgnc+gmMDhHeCZY5mQheBIgJ7gSRYkUoPjkeeHYNCg1qGdJQ?=
 =?us-ascii?q?bBg8FLZVkDpE2lhAfjFWZOIF4gX0zGggwgyRRGQ+OIIQagRaDVoVLQAEBATACA?=
 =?us-ascii?q?TUCBgsBAQMJkHUBAQ?=
X-IronPort-AV: E=Sophos;i="5.87,216,1631570400"; 
   d="scan'208";a="2393687"
X-MGA-submission: =?us-ascii?q?MDFpCDFVB8mI2kuWzI7Ac27wxuTiUHGY+R14En?=
 =?us-ascii?q?hLwFkbyTpE5aRrC7neAEwDUX9tYHj61qjcYOwmsH5QligSWBnak3QNC/?=
 =?us-ascii?q?bYK0pEuQZYkvkzndfxMQJIPEZem1cCdXKuMDvaBE84Auiy7G5dNzC22w?=
 =?us-ascii?q?khbvVE4V6pMSRxutF0jq7pvg=3D=3D?=
Received: from smtp-out1.suse.de ([195.135.220.28])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2021 18:51:31 +0100
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49A98212C5;
	Sun,  7 Nov 2021 17:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1636307489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWfGSCZ3fo8zCgtnPSlqDCOyLlNEHovVYPqcd9oPh8s=;
	b=tjpG4hEzWJXNlROoGeEgWNQ7IUFlYVBnLKMYXYclgi/HisWKZ0dUjQSJIdZd98nQqWq7iT
	ne4J/4sbizRCrf0N0rLes75gsKeHi9IpxRMVKjG8HMDQUJbGZNI4sWldOvOaEIWRSJGyU+
	5AD9duiUc8rYpaEtGIDdvDteEPMOkkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1636307489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWfGSCZ3fo8zCgtnPSlqDCOyLlNEHovVYPqcd9oPh8s=;
	b=JZrFLGqX/V9iR5snOFiIHQRjqEoGzCmi3ki5nuUwfeUNKZoByBcNjWAfenjv98mrXMpubm
	2yIYdCeNvoOLSnCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A1DF13517;
	Sun,  7 Nov 2021 17:51:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id vxy6CCESiGF9agAAMHmgww
	(envelope-from <vbabka@suse.cz>); Sun, 07 Nov 2021 17:51:29 +0000
Message-ID: <89bb8f39-4527-a1b4-dab9-82929773e9d9@suse.cz>
Date: Sun, 7 Nov 2021 18:50:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>,
 Julia Lawall <julia.lawall@inria.fr>
Cc: Luis Chamberlain <mcgrof@kernel.org>, cocci@inria.fr
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
 <a02a8c42-011d-0f9c-6a2f-7d45a3f216a5@web.de>
 <alpine.DEB.2.22.394.2111071321530.2988@hadrien>
 <000e221f-1bac-6e29-8c68-2c1eab5b2128@web.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <000e221f-1bac-6e29-8c68-2c1eab5b2128@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] mm/slab: prepare for struct page conversion by spatch
Reply-To: Vlastimil Babka <vbabka@suse.cz>
X-Loop: cocci@inria.fr
X-Sequence: 92
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/89bb8f39-4527-a1b4-dab9-82929773e9d9%40suse.cz>

On 11/7/21 13:50, Markus Elfring wrote:
>>> * Will any guidance help to find nicer solutions?
>>
>> Luis already proposed a perfectly reasonable solution.
> 
> His proposal can look a bit too terse (for affected implementation details),
> can't it?
> https://sympa.inria.fr/sympa/arc/cocci/2021-11/msg00017.html
> https://lore.kernel.org/cocci/YYVZva1hfwanXdyB@bombadil.infradead.org/

I don't mind terse, I wasn't asking for complete fixup of my patches,
but for hints, and I got plenty from all of you, thanks! Will try to
apply everything tomorrow.

> @@
> @@
> -struct page
> +struct slab

The above is itself incomplete to go from "struct page *page" to "struct
slab *slab", but will results in "struct slab *page".

So my attempts included:
- struct page *page
+ struct slab *slab

But that for some reason resulted in spatch reporting (IIRC) syntax
errors, so I had to change it to this:

- struct page *page;
+ struct slab *slab;

And that worked in most cases, but didn't handle the multiple variables
being declared nor declaration+assignment.

But I assume Luis' suggestion is supposed to work together with the rule
that does simply -page +slab. I'll see how it works out, and also
Julia's suggestion "just have one rule to change all occurences of page
to slab, and then have individual rules to change eg page_address(slab)
to slab_address(slab)."

Thanks,
Vlastimil
