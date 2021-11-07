Return-Path: <SRS0=h9ga=P2=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C1FC433EF
	for <cocci@archiver.kernel.org>; Sun,  7 Nov 2021 23:08:11 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FBFD613B3
	for <cocci@archiver.kernel.org>; Sun,  7 Nov 2021 23:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1FBFD613B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,217,1631570400"; 
   d="scan'208";a="2407653"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2021 00:08:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2CC69E006B; Mon,  8 Nov 2021 00:08:08 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 90683E004C
	for <cocci@sympa.inria.fr>; Mon,  8 Nov 2021 00:08:03 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=vbabka@suse.cz; spf=Pass smtp.mailfrom=vbabka@suse.cz; spf=None smtp.helo=postmaster@smtp-out1.suse.de
IronPort-PHdr: =?us-ascii?q?A9a23=3Ahcxk6Bw5I65yKRfXCzLTylBlVkEcU1XcAAcZ59I?=
 =?us-ascii?q?dhq5Udez7ptK+ZhWZvK0m1QSWFcWDsrQY0bKQ6/ihEUU7or+5+EgYd5JNUxJXw?=
 =?us-ascii?q?e43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgR?=
 =?us-ascii?q?pOOv1BpTSj8Oq3Oyu5pHfeQpFiCSgbb9oMRm6sQrdutQYjIZgN609zgfFrmZSd?=
 =?us-ascii?q?+lZ229kOUifkwrg6su14ZVu7zlet/U9+sBaTK70Zb44TbtWDDQnN2A6+sjmvgT?=
 =?us-ascii?q?dQAWM+3URTHwYngJHDAbZ4h76WIzxsjbhuepmxCaaJ8z2QqsqVjmk8qxmVQXni?=
 =?us-ascii?q?CYDNz4+7WHXlsl9h79VrR69uxByxZPfbYeIP/R8Y6zdZ8sXS2lPUMleWSNPH52?=
 =?us-ascii?q?yb4UPAeUDIelWoJLwp0cMoBakGQWgGO3ixz1Oi3Tr3aM6yeMhEQTe0QMvG9IBq?=
 =?us-ascii?q?m/UrMn0NKcXUOC1yLTDwCjZYPxN2jfy8pXDfxc/of6XR71/asnRxlM0GgPek1W?=
 =?us-ascii?q?QspLqMymJ2eUMqmWW6fdrWu2zhWA9sQ5xviSvydk2ionPno8Y1k3J+CpnzIg7O?=
 =?us-ascii?q?NG2RkB2b9GqHpVfuSyXKop7T8c/Tmxstys3174LtJq0cSYF1ZkqyALTZ+KJfoW?=
 =?us-ascii?q?G4x/vSeafLDFlj3xmYLKynwu+/Eygx+HmS8W53lZHojBbntXSqnwBzQLf58uBR?=
 =?us-ascii?q?/Bg5EmuwyyP2BrW6uxcIUA7i67bK5k5z74rk5oTrVzDEjbxmEXrkK+aa18o+vO?=
 =?us-ascii?q?16+T8fLrqvIKTOJFshgH/NKQhhNC/DPwlPgUKX2WX4/mw2bPj8EHjXrlGkOE6n?=
 =?us-ascii?q?rPHvJ3ZPcgbo7S2Aw5R0oYt8Ra/CDKm3cwGnXYcNl1KYxGHgJLyNlHVPfD4Fum?=
 =?us-ascii?q?wj06wnzZq3/zGJKHuAo3RLnjfl7fsZapy60lAxwUvzNBS/IlUC7EEIPLrQED9r?=
 =?us-ascii?q?t3YDhkjMwy12enrEtt91plNEV6IV4uEMbiaml+B4+giOe2FZYld7DP2JOIi6db?=
 =?us-ascii?q?tgGU/lFtberOmi8g5cne9S8piKl6FYH/thp8rGG0Jt0JqUubjgl6LeSVOfHv0V?=
 =?us-ascii?q?LBqtWJzM56vEYqWHtPlu7eGxiruRvW+iUhdF0uBV3z6JdzssxYkcyeOOopmjyB?=
 =?us-ascii?q?dE6O8UIJn2Rz87GcSLpJ8M/HZvCYK58qL6Q=3D=3D?=
IronPort-Data: =?us-ascii?q?A9a23=3A5RwXeK5GZ3+2dCwYOuYq3wxRtHvGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENSgzMEzTYcXWyBaP6PZ2PyKtBxOdu18x4HvMLUmIRkGgUd+CA2RRqmi?=
 =?us-ascii?q?+KVXIXDdh+Y0wC6d5CYEho/t63yUjRxRSwNZie0SiyFb/6x8hGQ6YnSHuClUbe?=
 =?us-ascii?q?cZXgrLeNZYH5JZSxLy7ZRbrFA2oDR7zOl4bsekuWHULOX82Yc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTaUgWWvvVIBTXzGFLQKXkjhUqSi4ai/dmcqNHNAEN0W3PxYAZJNZl7fRcT?=
 =?us-ascii?q?S83NKTGm+01SARDHmd1L8Wq/ZedfSDg75DLp6HBWyCwnaUwVhxe0Zcj0u1wCmp?=
 =?us-ascii?q?P3ecJLSgEKBGFneO/hryhItSALOw3dJyxetgL4yQ4i2nNV6N+B8uaEvTevooAm?=
 =?us-ascii?q?mok2ZVnA9D1Yuw1aR9OZTL8eTtbYw9CUNZniI9EnVHkdiFA7VWIufNx+HXIwUp?=
 =?us-ascii?q?93dDQ3BPuUoTiba1ocoyw/woqPlgVAy328PSEzCadt3WxmraJhj7gVcQeGdVUM?=
 =?us-ascii?q?9YCbEK7ngQu5N8+DDNXYsVVTmalRslSbUcGksbrhbZn71SlF7ERQDXhyENpfXc?=
 =?us-ascii?q?gtx54CPAh5UeG2MI4Ji7x6ncsFlZ8VTDtiCP6qfHGGLNEcxMFyAGDaIGodE8?=
 =?us-ascii?q?=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AY9ioRa5qe1uiDga3cQPXwNPXdLJyesId70hD?=
 =?us-ascii?q?6qkXc3xom62j9vxG885w6faZskdyZJhCo7690de7MBDhHPdOiOF7AV7IZmXbUQ?=
 =?us-ascii?q?WTQb2KobGM/wHd?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BNAACeW4hhexzch8NaGgEBAQEBAQEBA?=
 =?us-ascii?q?QEDAQEBARIBAQEBAgIBAQEBQIFZg3cBAQE4MYRHjm+CKJ4sCwEDAQ1BBAEBhQI?=
 =?us-ascii?q?CglMCHQcBBDQTAQIEFQEBBQEBAQIBAwMEARMBAQ8LDwc6JIVoDYI1IoNsAQIDI?=
 =?us-ascii?q?x0BATcBDwsOCgICJgICVwYNCAEBgm2DDKtlgTGBAYIIAQEGhWkcgVoJgRAqAY0?=
 =?us-ascii?q?ueiccgUlEgRUnDIJ3PoddgmWQJBOBAESBX6Agnh2DQoNamw8GDwIDLZVkDpE2l?=
 =?us-ascii?q?hCmLIF4gX0zGggwgyRRGQ+OIIQaijdAAQEBMDgCBgsBAQMJkHUBAQ?=
X-IPAS-Result: =?us-ascii?q?A0BNAACeW4hhexzch8NaGgEBAQEBAQEBAQEDAQEBARIBAQE?=
 =?us-ascii?q?BAgIBAQEBQIFZg3cBAQE4MYRHjm+CKJ4sCwEDAQ1BBAEBhQICglMCHQcBBDQTA?=
 =?us-ascii?q?QIEFQEBBQEBAQIBAwMEARMBAQ8LDwc6JIVoDYI1IoNsAQIDIx0BATcBDwsOCgI?=
 =?us-ascii?q?CJgICVwYNCAEBgm2DDKtlgTGBAYIIAQEGhWkcgVoJgRAqAY0ueiccgUlEgRUnD?=
 =?us-ascii?q?IJ3PoddgmWQJBOBAESBX6Agnh2DQoNamw8GDwIDLZVkDpE2lhCmLIF4gX0zGgg?=
 =?us-ascii?q?wgyRRGQ+OIIQaijdAAQEBMDgCBgsBAQMJkHUBAQ?=
X-IronPort-AV: E=Sophos;i="5.87,217,1631570400"; 
   d="scan'208";a="2407640"
X-MGA-submission: =?us-ascii?q?MDF0byrCnxXkgxQnBtgDcS5pVNcOr/7e6jp5KN?=
 =?us-ascii?q?ix1d2O0bGz6zjQcL+ZB2To+eg66/ZF45ZWLhJauSOj29vQFsIoVYIkK9?=
 =?us-ascii?q?qlL/Sq5guopPS2HaBty2ZXxAws/YHKeS2AIPZqpINIL8tBDRGAO6phQQ?=
 =?us-ascii?q?tgoKSrF9pPI/X0xtrFMNAXsQ=3D=3D?=
Received: from smtp-out1.suse.de ([195.135.220.28])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 00:08:03 +0100
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 89252218CE;
	Sun,  7 Nov 2021 23:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1636326482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lt2wsfdczRHz09bt/j75jGeQfu534pv45EwY/q9Oy30=;
	b=mj0UY45cu/fZVSczzHmkqWKoIQeiMOnpgfGYZjoc4WepV4Avz0YKFkzJvw1XTC5jkUmp9G
	EIetZgZSWc33gRAu7wtAUurm/Gsm5Tt1tba0NAMWem4GPs/o3DCI9+qOoJ4f7qZGjjARS9
	XvwM600lJZj7yRq89oolHmd+IUN5yUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1636326482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lt2wsfdczRHz09bt/j75jGeQfu534pv45EwY/q9Oy30=;
	b=dbaD7heFsLclyIvcp3u/Vi7tpuwuHEk+WXENICGeR3RaNjwtn2llSaVwb4bxZYRmiAc+Nt
	SQ7TB+70DHtadPDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B3FF13479;
	Sun,  7 Nov 2021 23:08:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id CDN+HVJciGHgOgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Sun, 07 Nov 2021 23:08:02 +0000
Message-ID: <70748876-5df6-080b-f1da-1f94371001db@suse.cz>
Date: Mon, 8 Nov 2021 00:08:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: cocci@inria.fr
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
 <YYVZva1hfwanXdyB@bombadil.infradead.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YYVZva1hfwanXdyB@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Need some help with spatch
Reply-To: Vlastimil Babka <vbabka@suse.cz>
X-Loop: cocci@inria.fr
X-Sequence: 94
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/70748876-5df6-080b-f1da-1f94371001db%40suse.cz>

On 11/5/21 17:20, Luis Chamberlain wrote:
> On Fri, Nov 05, 2021 at 05:12:09PM +0100, Vlastimil Babka wrote:
>> 1) patching complex variable declarations;
>> 
>> I need to perform changes such as:
>> -struct page *page;
>> +struct slab *slab;
>> 
>> This I was able to somehow specify in the .cocci, but not for situations
>> where the original declarations looks like this:
>> 
>> struct page *page, *page2;
>> 
>> or
>> 
>> struct page *page = NULL;
> 
> For this, this seems to work well:
> 
> @@
> @@
> 
> -struct page
> +struct slab

Written exactly like above it works, but then it affects code in all
functions, and I need some exceptions.

But when I adjust it as below, I get
minus: parse error:
  File "slub-new.cocci", line 161, column 0, charpos = 3152
  around = '...>',
  whole content = ...>

@@
identifier fn !~
"nearest_obj|obj_to_index|objs_per_slab_page|__slab_(un)*lock|__free_slab|free_nonslab_page|kmalloc_large_node";
@@
fn(...)
{
<...
-struct page
+struct slab
...>
}
