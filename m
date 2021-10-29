Return-Path: <SRS0=V3/9=PR=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488C2C433EF
	for <cocci@archiver.kernel.org>; Fri, 29 Oct 2021 19:12:14 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C4360F9B
	for <cocci@archiver.kernel.org>; Fri, 29 Oct 2021 19:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 59C4360F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AXCDvjK2YAiofPmEAN/bD5cNwkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ1Whx0zwOmzcaXjvSPfqPNjHweNFzaomxpk8DvpDVydE2QQE+nZ1PZyIT+?=
 =?us-ascii?q?JCdXbx1DW+pYnjMdpWbJK5fAnR3huDodKjYdVeB4EfyWlTdhSMkj/jRHuCtULS?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YDdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?+g7PjewsLRKTTNE6AkBK6WYD72EgE93d0i/hhcqNCMS+7iB3Q9zx14N5KvpexD?=
 =?us-ascii?q?AA2OKDWsOUbSRhRVS9kVUFD0OadeCHv6Zb7I0ruNiGEL+9VJEoxNoYZ0u9tCmF?=
 =?us-ascii?q?P6/ECbjMAdBaOg6Sx2r3TYuNtnd8yIsfDM4YWu3UmxjbcZd4tRp3FTqPi6tpR3?=
 =?us-ascii?q?TN2jcdLdd7Sbsxfa3xwbRDEYhRKIX8YDZs/mKGjgXyXWzFRtlOZvq0x72bcyCR?=
 =?us-ascii?q?+1bHsNJzefdnibclY2F2fu3DPuW/+GBwcKN2Z4TWA+3OowOTImEvTU5kPELmp3?=
 =?us-ascii?q?vFth1KXyyoYDxh+fVG2p/S1i02ic9JSKkoZvDAppqspnGSgSt76RDW6oHWAuRk?=
 =?us-ascii?q?HHdFXFoUS5AiLy6fQpQKUFGMNSDlpbN0gvdUxAzsw2TehlNPzBCdzt6WVD3ia+?=
 =?us-ascii?q?7eRsjq2NSUPBWsDYyUFUU0O5NyLnW2ZpnojVf57Cqm5y9n0Ai392C3T/G4/ga8?=
 =?us-ascii?q?ShIgFzc2GEZn8q2rEjvD0osQdv1y/srqZ0z5E?=
X-IronPort-AV: E=Sophos;i="5.87,193,1631570400"; 
   d="scan'208";a="1211802"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Oct 2021 21:05:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7F5CEE02D4; Fri, 29 Oct 2021 21:05:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C2329E0072
	for <cocci@sympa.inria.fr>; Fri, 29 Oct 2021 21:05:04 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=mcgrof@infradead.org; spf=None smtp.mailfrom=mcgrof@infradead.org; spf=None smtp.helo=postmaster@bombadil.infradead.org
IronPort-PHdr: =?us-ascii?q?A9a23=3A3gBxchMldn/HKUXtjD0l6nbtDRdPi9zP1u491JM?=
 =?us-ascii?q?rhvp0f7i5+Ny6ZQqDv60r3QaCANqTwskHotKei7rnV20E7MTJm1E5W7sIaSU4j?=
 =?us-ascii?q?94LlRcrGs+PBB6zBvfraysnAJYKDwc9rDm0PkdPBcnxeUDZrGGs4j4OABX/Mhd?=
 =?us-ascii?q?+KvjoFoLIgMm7yfy+94fXbglVizawYbF/JwiqoAvMscUbnZFsIbsrxBvTpXtId?=
 =?us-ascii?q?eVWxWd2Kl+Wgh3x+MS+8oN9/ipJo/4u+NJOXqv8f6QjULxXFy8mPHwv5M3qrhb?=
 =?us-ascii?q?MUw2C7WYBX2oMkxpIBw/F7AzmXpr0ryD3uPZx1DWcMMbrS70/RDas4LpxSBLwh?=
 =?us-ascii?q?ikJNyA3/nzUhMN/kK1UvQmhqgdjw4LIfI2ZKOZycr/Dcd4cWGFPXtxRVytEAo6?=
 =?us-ascii?q?kaYUPEusBPf1FpITjp1sBtx6+ChKyC+P1zj9HnH723asn2OkmFAHJwAMgH8gJs?=
 =?us-ascii?q?HTat9j1N7kdUfqzzKbWyTXPdfRW2S3y6IXRdB0qvP6DU65qf8XL1UkvCx3Kjk+?=
 =?us-ascii?q?WqYH9Oz6Y1PgAv3aV4eZ+WuyhhXArpgFyrzWuyckhiIjEi4wIxl7E8Sh0wYg7K?=
 =?us-ascii?q?NmlRUNnYNOpDZReuiCHOoV4X84sTWdlszs0xL0BvJ60ZikKyJI/yh7cdfOHaY6?=
 =?us-ascii?q?I7QznVOqLJjd4nn1ldbSijBix6Uit0vDwW8233VpQsyZInNvBumoT2xDP9MSLU?=
 =?us-ascii?q?OZx80mv1DuJygvd8PtLIVoumqreM5MhwqA/lp4UsUnbBSD2n0D2g7SMeUo5++i?=
 =?us-ascii?q?o7/7rYrTgpp+SLY97kBzxPbo0lcOiG+g4NRIOX2eD9eS90r3s41H5Ta1XgvAyk?=
 =?us-ascii?q?aTVqo3WKMoZq6KjHQNZzpgv5wyiAzqo3tkUhXwHI0hEeBKDgYjpIVbOIPXgAPe?=
 =?us-ascii?q?6n1usny1rx/fIPrD6A5XNKHbDkK37crlg9UFT0hc8wcpY55JOBbENOOjzVVPpt?=
 =?us-ascii?q?NzEEh85NBS5zPrgCNphyoweWHmCArSZMaPXqV+H/PgjI+iKZI8PuTbyMeIp5/D?=
 =?us-ascii?q?0jSxxpVhIdq6i1po/aXaiH/0gLV/KT2Drh4IlDGYR9iE+RenghUeGWD9VLyK3V?=
 =?us-ascii?q?K0m4T8TC4+8C4rHAIe3j+rSj2+AApRKazUeWRi3GnDyetDcMx/jQCOULNVonjE?=
 =?us-ascii?q?NWf6mUYBzjXlGVSfwzL9tJ+bV/msZs5z53dR47uGVkgs9p2Qc5yG10meDVWh4k?=
 =?us-ascii?q?2oEATgs0/InyXE=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ANBJgf6B1RqSx/zDlHem955DYdb4zR+YMi2TD?=
 =?us-ascii?q?83oBKyC9E/bo9PxG+c5x6faaslsssR0b9exoW5PhfZq/z/9ICOAqVN/JYODIgh?=
 =?us-ascii?q?rMEGgI1+XfKlPbdBHDyg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CaAAASaxphmIXKicZagQmBWYMiVjsxh?=
 =?us-ascii?q?AGQD1MKBoEkGopxhlGKLIIHAQMBDTUMBAEBh04CHQYGMAkOAQIEFQEBBQEBAQI?=
 =?us-ascii?q?BAwMEARMBAQEBAQEBAQkLEAY6JIVoDYI1IoQsBgEBOBA+Iiw0gnEBgmEmD6dqg?=
 =?us-ascii?q?TOBAYIHAQEGgT4BAwOGPQMGgTqOGhx9gRCBS4I4B4stgyaCACwgNIExkgmMdII?=
 =?us-ascii?q?MmwmCEoMyBYo4lECmdaJPmQeBYIIUfQiDJBM9GQ6NdgEBAYkthWokLwIBNQIGC?=
 =?us-ascii?q?wEBAwmJdQEB?=
X-IPAS-Result: =?us-ascii?q?A0CaAAASaxphmIXKicZagQmBWYMiVjsxhAGQD1MKBoEkGop?=
 =?us-ascii?q?xhlGKLIIHAQMBDTUMBAEBh04CHQYGMAkOAQIEFQEBBQEBAQIBAwMEARMBAQEBA?=
 =?us-ascii?q?QEBAQkLEAY6JIVoDYI1IoQsBgEBOBA+Iiw0gnEBgmEmD6dqgTOBAYIHAQEGgT4?=
 =?us-ascii?q?BAwOGPQMGgTqOGhx9gRCBS4I4B4stgyaCACwgNIExkgmMdIIMmwmCEoMyBYo4l?=
 =?us-ascii?q?ECmdaJPmQeBYIIUfQiDJBM9GQ6NdgEBAYkthWokLwIBNQIGCwEBAwmJdQEB?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397783730"
X-MGA-submission: =?us-ascii?q?MDHZb5U1ehAiol4anQboL+hWJ2al9EUi77rUmW?=
 =?us-ascii?q?LGPYMtHKNEc8ONJCKTY9frjwsNWtOkaN1RnzlbP5JCPVl03pnQRK/GGp?=
 =?us-ascii?q?iYRv1shdMGsWED5VDSJZWg2bx86QQpSW7+kY7GP2H4eD7EvrL+qwAoaQ?=
 =?us-ascii?q?RA2Qd9BeDwMT0tpVS8BZMcNQ=3D=3D?=
Received: from bombadil.infradead.org ([198.137.202.133])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 21:05:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rJhTNv0glWcupbiFG2dydx99CKXAdoECtzIvxJos1WM=; b=0REIjk6fOqM9olqyi4tdTrVy1o
	nubOuzbUNZ5w+g/KIChP+EcIJy9b49hrN6qgAzg+rSNphWEsh62j5a5IWuG3WPVnWcEEfSS+K/X01
	mKxSC0I9IQsKLbhhDCTqrawojaQRUQC2T0fIX/CL5feSQ9GH3apzVkxJMC6EkYSxIxXw85f9fgUj/
	uf4L5d3flE96BAdu6P4rkJpwucX3SCGWEF3bUd6TmBEXM52mIwYbwj6XYjjIy1wPtzV8baU4ZrEhn
	k7Qj6lsQJGusI7rO1oyidnxKN8yYTR4wrC7djWdW0Di4UDZxQhKnI+mxzxM06FqQHxIJx9PnhogwM
	uffafaPQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mgXBV-00BuyL-Mc
	for cocci@inria.fr; Fri, 29 Oct 2021 19:05:01 +0000
Date: Fri, 29 Oct 2021 12:05:01 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: cocci@inria.fr
Message-ID: <YXxF3dpLb8M0aZoI@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: cocci-request@inria.fr
Subject: [cocci] Python iteration to look for possible sysfs deadlocks
 (resend)
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 49
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/YXxF3dpLb8M0aZoI%40bombadil.infradead.org>

It is possible to deadlock the kernel if the same lock is used
on module exit and syfs ops. I've proposed a way to fix this [0],
however it not clear how wide spread this issue is, and so it would
be best to avoid the fix so to avoid the complexity the fix requires.

[0] https://lkml.kernel.org/r/20210927163805.808907-10-mcgrof@kernel.org

A full hunt would involve using any lock, and iteration on module exit
and also on the sysfs ops, as each could have indirect calls which do
use a lock.

An attempt to just look for the deadlock candidates with 2 level of
indirection follows:

@ finds_module_exit @
identifier exit_fn;
declarer name module_exit;
@@

module_exit(exit_fn);

@ exit_fn_locks @
identifier finds_module_exit.exit_fn;
identifier mutex, spinlock;
@@

exit_fn(...)
{
	...
(
	mutex_lock(&mutex);
|
	spin_lock(&spinlock);
)
	...
}

@ exit_indirect_call_level_1 @
identifier finds_module_exit.exit_fn;
identifier indirect_fn;
@@

exit_fn(...)
{
	...
	indirect_fn(...)
	...
}

@ ind_call_level_1 @
identifier exit_indirect_call_level_1.indirect_fn;
identifier ind_mutex, ind_spinlock;
@@

indirect_fn(...)
{
	...
(
	mutex_lock(&ind_mutex);
|
	spin_lock(&ind_spinlock);
)
	...
}

@ indirect_call_level_2 @
identifier exit_indirect_call_level_1.indirect_fn;
identifier indirect_fn_2;
@@

indirect_fn(...)
{
	...
	indirect_fn_2(...)
	...
}

@ ind_call_level_2 @
identifier indirect_call_level_2.indirect_fn_2;
identifier ind_mutex_2, ind_spinlock_2;
@@

indirect_fn_2(...)
{
	...
(
	mutex_lock(&ind_mutex_2);
|
	spin_lock(&ind_spinlock_2);
)
	...
}


@ any_store @
identifier fn_store;
identifier exit_fn_locks.mutex, exit_fn_locks.spinlock;
identifier dev, attr, buf, len;
identifier ind_call_level_1.ind_mutex, ind_call_level_1.ind_spinlock;
identifier ind_call_level_2.ind_mutex_2, ind_call_level_2.ind_spinlock_2;
@@

ssize_t fn_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t len)
{
	...
(
-	mutex_lock(&mutex);
+	mutex_lock_deadlock(&mutex);
|
-	mutex_lock(&ind_mutex);
+	mutex_lock_deadlock(&ind_mutex);
|
-	spin_lock(&spinlock);
+	spin_lock_deadlock(&spinlock);
|
-	spin_lock(&ind_spinlock);
+	spin_lock_deadlock(&ind_spinlock);
|
-	mutex_lock(&ind_mutex_2);
+	mutex_lock_deadlock(&ind_mutex_2);
|
-	spin_lock(&ind_spinlock_2);
+	spin_lock_deadlock(&ind_spinlock_2);
)
	...
}

@ any_show @
identifier fn_show;
identifier exit_fn_locks.mutex, exit_fn_locks.spinlock;
identifier dev, attr, buf;
identifier ind_call_level_1.ind_mutex, ind_call_level_1.ind_spinlock;
identifier ind_call_level_2.ind_mutex_2, ind_call_level_2.ind_spinlock_2;
@@

ssize_t fn_show(struct device *dev, struct device_attribute *attr, const char *buf)
{
	...
(
-	mutex_lock(&mutex);
+	mutex_lock_deadlock(&mutex);
|
-	mutex_lock(&ind_mutex);
+	mutex_lock_deadlock(&ind_mutex);
|
-	spin_lock(&spinlock);
+	spin_lock_deadlock(&spinlock);
|
-	spin_lock(&ind_spinlock);
+	spin_lock_deadlock(&ind_spinlock);
|
-	mutex_lock(&ind_mutex_2);
+	mutex_lock_deadlock(&ind_mutex_2);
|
-	spin_lock(&ind_spinlock_2);
+	spin_lock_deadlock(&ind_spinlock_2);
)
	...
}


And so obviously this can go on forever. It doesn't address indirect
uses of a lock on the sysfs ops either. An attempt to use iteration
follows, however this seems to fall short of what I want, any
recommendations?

virtual after_start

@initialize:python@
@@

seen = set()

@ finds_module_exit @
identifier exit_fn;
declarer name module_exit;
@@

module_exit(exit_fn);

@ exit_fn_locks @
identifier finds_module_exit.exit_fn;
identifier mutex, spinlock;
@@

exit_fn(...)
{
	...
(
	mutex_lock(&mutex);
|
	spin_lock(&spinlock);
)
	...
}

@ exit_indirect_fn depends on finds_module_exit && after_start exists @
identifier finds_module_exit.exit_fn;
identifier virtual.fn;
position p;
@@

exit_fn(...)
{
	...
	fn@p(...)
	...
}

@ ind_call depends on finds_module_exit @
identifier indirect_fn;
identifier ind_mutex, ind_spinlock;
position p;
@@

indirect_fn@p(...)
{
	...
(
	mutex_lock(&ind_mutex);
|
	spin_lock(&ind_spinlock);
)
	...
}

@ any_store depends on finds_module_exit && (exit_fn_locks || ind_call) @
identifier fn_store;
identifier exit_fn_locks.mutex, exit_fn_locks.spinlock;
identifier dev, attr, buf, len;
identifier ind_call.ind_mutex, ind_call.ind_spinlock;
@@

ssize_t fn_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t len)
{
	...
(
-	mutex_lock(&mutex);
+	mutex_lock_deadlock(&mutex);
|
-	mutex_lock(&ind_mutex);
+	mutex_lock_deadlock(&ind_mutex);
|
-	spin_lock(&spinlock);
+	spin_lock_deadlock(&spinlock);
|
-	spin_lock(&ind_spinlock);
+	spin_lock_deadlock(&ind_spinlock);
)
	...
}

@ any_show depends on finds_module_exit && (exit_fn_locks || ind_call) @
identifier fn_show;
identifier exit_fn_locks.mutex, exit_fn_locks.spinlock;
identifier dev, attr, buf;
identifier ind_call.ind_mutex, ind_call.ind_spinlock;
@@

ssize_t fn_show(struct device *dev, struct device_attribute *attr, const char *buf)
{
	...
(
-	mutex_lock(&mutex);
+	mutex_lock_deadlock(&mutex);
|
-	mutex_lock(&ind_mutex);
+	mutex_lock_deadlock(&ind_mutex);
|
-	spin_lock(&spinlock);
+	spin_lock_deadlock(&spinlock);
|
-	spin_lock(&ind_spinlock);
+	spin_lock_deadlock(&ind_spinlock);
)
	...
}

@script:python depends on exit_indirect_fn @
indirect_fn << ind_call.indirect_fn;
p << ind_call.p;
@@

if fn not in seen:
    seen.add(indirect_fn)
    it = Iteration()
    it.set_files([p[0].file])
    it.add_virtual_rule(after_start)
    it.add_virtual_identifier(fn, indirect_fn)
    it.register()

@script:python@
p << exit_indirect_fn.p;
@@

cocci.print_main("indirect call shares lock with sysfs store or show", p)
