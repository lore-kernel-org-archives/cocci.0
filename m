Return-Path: <SRS0=V3/9=PR=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B3FC433EF
	for <cocci@archiver.kernel.org>; Fri, 29 Oct 2021 18:49:59 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BAC60FF2
	for <cocci@archiver.kernel.org>; Fri, 29 Oct 2021 18:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D2BAC60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AZLK5QqLwLzTocE+pFE+RwJQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHDogT13gjZWx2NLX2+CbKuDZ2DyLoslPIy+oEhTu5TWy4NqS1BcGVNFHysb8?=
 =?us-ascii?q?5KdbTi6Bh6tZH3KdpWroHqKXqzyU/GYRCwPZiKa9kjF3oTJ9yEmjPjQHOukUoY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWHULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIsi?=
 =?us-ascii?q?0l67yNEwMWL/bewaU4pZUc/H40l4T/WprjPx9baREAatUo2zhc9RZw9JGvp31T?=
 =?us-ascii?q?hgvM7fkmeIHUhAeHTsW0ahuoeWeeCDh76R/yGWDKRMA2c5GB0Y9Noww8/x8AWB?=
 =?us-ascii?q?Q+OZeKz0XaB2HweWsz9qTQOh3ndUtIuHkOYoevjdryjSxJf0hTJbORY3F4NZZ2?=
 =?us-ascii?q?HE7gcUmNfrXYYwbLyVuaBDBahhUElgSAZM62uyvgxHXfzRGqV6Ooqw77WfX5AN?=
 =?us-ascii?q?02bnpdtHSf7SiScgThUGFtGuA9GPjDxcGNdq3xj+M83bqjejK9QvwQ58WEKyQ+?=
 =?us-ascii?q?fltj1megGcUDXU+X1a9rPW4iVKWW99eLUFS4C0lrrNa3EevSd7mdx+4q3qDuQV?=
 =?us-ascii?q?aUN1Ve8U24QeMx66S5wuLDWECSRZFadovrshwQiYlvneCn8noHiBoqL3TQ3WQ9?=
 =?us-ascii?q?rKLpDe+NDI9KW4Eby4YCwAC5rHeTCsb5v7UZs55F6LwitzuBTzr3mna6ik4nbQ?=
 =?us-ascii?q?ay8ARv5hXNGvv21qEzqUlhCZojukPYl+Y0w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,193,1631570400"; 
   d="scan'208";a="1211066"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Oct 2021 20:49:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1F32BE0220; Fri, 29 Oct 2021 20:49:57 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7F2BAE0072
	for <cocci@sympa.inria.fr>; Fri, 29 Oct 2021 20:49:52 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=mcgrof@kernel.org; spf=None smtp.mailfrom=mcgrof@infradead.org; spf=None smtp.helo=postmaster@bombadil.infradead.org
IronPort-PHdr: =?us-ascii?q?A9a23=3AV1e6sRBTOo5jVGOWm+wLUyQUgkMY04WdBeb1wqQ?=
 =?us-ascii?q?uh78GSKm/5ZOqZBWZua81yg6QFtiEo9t/yMPu+5j6XmIB5ZvT+FsjS7drEyE/t?=
 =?us-ascii?q?MMNggY7C9SEA0CoZNTjbig9AdgQHAQ9pyLzPkdaAtvxaEPPqXOu8zESBg//NQ1?=
 =?us-ascii?q?oLejpB4Lelcu62/6u95HJZwhEmTWxbLNwIR6rsQjfq84ajJd4JK0s0BXJuHxIe?=
 =?us-ascii?q?+pXxWNsO12emgv369mz8pB+7Sleouot+MFcX6r0eaQ4VqFYAy89M28p/s3rtAL?=
 =?us-ascii?q?MQhWJ63ABT2gZiBtIAwzC7BHnQpf8tzbxu+Rh1CWGO8D9ULY5Uimg4ah2Uh/lk?=
 =?us-ascii?q?CkJOT4n/m/KicJ/g75Urw+6pxFk347YfJ2ZOOZicq/BY98XQ3dKUMZLVyxGB4O?=
 =?us-ascii?q?xd40BD/cAPeZDsoLwuVsOogG7BQa3Guzv0DtIiWX33a08zu8sFgTG0xAvH9IUt?=
 =?us-ascii?q?3TUos74NKQMXuCvyqnH0zHDY+lR2Tfn54jFaxYsquyDUrxsa8Te01UvFx/bgVW?=
 =?us-ascii?q?Kr4zoJzeY2+YRvmSF4eRsS+2hhWA5pwxxoTWix8gih4vIi48b11zK9SF0zYc7K?=
 =?us-ascii?q?9C8VUN2fd+pHYZfuSybKoZ4TN4vTW9utS0nxLMGvpu7czILyJQh3xPfaOKIc5K?=
 =?us-ascii?q?O4h39UOadOzB4hGhqeL+5mh288lCgx/XhWsSw01tGtDdJn9fOu3wXyRDf9taLR?=
 =?us-ascii?q?uFg8kqv1zuC0R3Y5PteLkAuj6XbLoYswr4umZoXtkTOBjT5mELzjKCNbEor5+m?=
 =?us-ascii?q?o6+D9brXnoJ+cOZV0hRvjPaswgMOwHP40Mg8UX2iU4ei81bvj8lPlQLhSk/E7l?=
 =?us-ascii?q?qrUvIrHKckVpKO1GRFZ3po95xqlEjur3toVkWECLF1feRKHi4bpO0vJIPD9Ffq?=
 =?us-ascii?q?/hkijkDhxx/DBML3sGZTNLn7NkLf7Z7ly9lBTxxAuwtxF4JJUEL4BLOrpWkDtr?=
 =?us-ascii?q?NzYEgM5Mwuszun7D9Vyyp8RWWOUD6+CMKLStEeI6fg1L+mNYo8Vojf9JOI/6/7?=
 =?us-ascii?q?gl39q0WMaKKKu1pAWQGupBehrJkjfZXv03JEPCzQkpA07Gcj3iUbKej5aYny/R?=
 =?us-ascii?q?aY15zdzXIetAp3ESKiujaaH0SP9GYdZMDMVQmuQGGvlIt3XE8wHbzifd5cJet0?=
 =?us-ascii?q?sX7+kQYYt1BXotQn00bNrI+PYvCoCusC7vDCaz+zVmws7+TF9A4KayW7fFwmce?=
 =?us-ascii?q?0sLSiUw0aQ5plZymA/r7A=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AimigVqqMOnpC8sj2rTAR6RQaV5tZL9V00zEX?=
 =?us-ascii?q?/kB9WHVpW+SCncGvg/gXkTfo4QxhKk3IV+rwd5VoJkmstKKdgLNhc4tKOTON11?=
 =?us-ascii?q?dAQ7sSkbcKqQeAJ8TBzJ8c6U4NSdkFNDS0NykGsS4ViDPIWOrJ7rG8ge2VbM3l?=
 =?us-ascii?q?vj5QpTgDUdAr0++SYjzrXnGePTM2TabRaqDsmPav1gDQAkj/Nf7LcEXtNtKrz7?=
 =?us-ascii?q?am9OOBEGd2fyLPqjP+/A9Ax4SKUCRwtS1uJg+nr41SgVQsUmTCl9GemsD+7hfd?=
 =?us-ascii?q?0mTU/tBymNzso+EvOCX1sLlnFt1i4jzYE7hJavmntDZwhvqu5lYsmNyJhQs8Mc?=
 =?us-ascii?q?Jy7H2UXmzdm2qT5+CM6lgTApLZuD2laGHY0KjEbQN/MdNIgcZieB3D5yMbzbRB?=
 =?us-ascii?q?ObxwrgWkXkVsfHD9oBg=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AJAAASaxphmIXKicZaHQEBAQEJARIBB?=
 =?us-ascii?q?QUBQIFFCAELAYIjAX1YOTGMa4clXQaBJIsLhlGKLIIHAQMBDTUMBAEBh04CHQY?=
 =?us-ascii?q?GMAkOAQIEFQEBBQEBAQIBAwMEARMBAQEBAQEBAQkLEAY6JIVoDYI1IoQsBgEBN?=
 =?us-ascii?q?wEQYCw0gnEBgmEmBQqnaoEzgQGCBwEBBgQCgTgBAwOGPQMGgToBjhkcfYEQgUu?=
 =?us-ascii?q?COAcBAYsrgyaCACwgNIExkgmMdIIMmwmCEoMyBYo4lECmdaJPmQeBYIIUfQiDJ?=
 =?us-ascii?q?BM9GQ6OIIkGhWoiMQIBNQIGCwEBAwmJdQEB?=
X-IPAS-Result: =?us-ascii?q?A0AJAAASaxphmIXKicZaHQEBAQEJARIBBQUBQIFFCAELAYI?=
 =?us-ascii?q?jAX1YOTGMa4clXQaBJIsLhlGKLIIHAQMBDTUMBAEBh04CHQYGMAkOAQIEFQEBB?=
 =?us-ascii?q?QEBAQIBAwMEARMBAQEBAQEBAQkLEAY6JIVoDYI1IoQsBgEBNwEQYCw0gnEBgmE?=
 =?us-ascii?q?mBQqnaoEzgQGCBwEBBgQCgTgBAwOGPQMGgToBjhkcfYEQgUuCOAcBAYsrgyaCA?=
 =?us-ascii?q?CwgNIExkgmMdIIMmwmCEoMyBYo4lECmdaJPmQeBYIIUfQiDJBM9GQ6OIIkGhWo?=
 =?us-ascii?q?iMQIBNQIGCwEBAwmJdQEB?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397783278"
X-MGA-submission: =?us-ascii?q?MDG2w4mfw/6O2uU4GYWUHCvUsteVXILebiUZjI?=
 =?us-ascii?q?iJP0psypxs5qvXVPBDOYNWMiDB4b92D1FYbgfx/rytzsd93oQzvn8UBU?=
 =?us-ascii?q?DbX0TNxW5sJl48YuUEt2iZXBfNFkdpl76Dlsfcb5W0PCLHHb+UITRPtF?=
 =?us-ascii?q?b1AVcjkI3BurMrJEPezAYaAQ=3D=3D?=
Received: from bombadil.infradead.org ([198.137.202.133])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 20:49:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Resent-Sender:Sender:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Resent-To:Resent-Message-ID:
	Resent-Date:Resent-From:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=rJhTNv0glWcupbiFG2dydx99CKXAdoECtzIvxJos1WM=; b=ch+L+8DyA5JPUff4XJZ79W1Zed
	gcxgEufuMAoN+yK2dYJ66pC+VHtblXuFqsRNHE44tyKt7ovhqQd1mLuOepm4WYLE5yGMXbfn+GZE3
	jnWwdjJ5XwkoKM+lfCtS6wbr4AYOOB3V9oFEk2xgUEZf3JIpyIh3STOe4Fxevp/VErJiihh8dlrKK
	98n1YLMCtvuqhvFvTSeF4l53AczJK0JBRVnsxbJ31w/3yN+UNDNhmAdElsQ8rhsFk/Q8C8VvX62kK
	sTggeMwQ2GLVsPK0MepdoFdPKbDw7ciWW4jSkQ84LO3rIyEvujoihMGgoO1Sw7LJ7TpFZe3E24XCj
	GskgjEQw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mgWwl-00Br9w-Tt
	for cocci@inria.fr; Fri, 29 Oct 2021 18:49:47 +0000
Resent-From: Luis Chamberlain <mcgrof@kernel.org>
Resent-Date: Fri, 29 Oct 2021 11:49:47 -0700
Resent-Message-ID: <YXxCSyvLM+5w9/NU@bombadil.infradead.org>
Resent-To: cocci@inria.fr
Received: from mail.kernel.org ([198.145.29.99])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1me3Xy-00C5be-FW
	for mcgrof@infradead.org; Fri, 22 Oct 2021 23:02:00 +0000
Received: by mail.kernel.org (Postfix)
	id 0BBA961039; Fri, 22 Oct 2021 23:01:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D955561037
	for <mcgrof@kernel.org>; Fri, 22 Oct 2021 23:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D955561037
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rJhTNv0glWcupbiFG2dydx99CKXAdoECtzIvxJos1WM=; b=SH2+KOObLbS4W/YbLCa3LPF0B7
	jokVe4tiUvWqEGIv6U7/dwKyCTmKUYrnDd69/1L4YX+UbTaq6erV0JdLiznyGKk5YF77ldW3bCvix
	ePjpe/Z6vIus5uhK3PLboii9q3/8B6zxwnI69o3NTfqgEtyyD53gnFWN9jj1aDrVnZjWtAVL3YvZw
	5RXmhLFNM/NEJkXDXB50iG7IegMxBoyCrhAkGIgdm4ndhcdRebBa5//izkt4ujqBomcwyqSJWK/2P
	VDvUj1cf6rCfX+xtc9ng1eHdz4n/PhVmJGleFXjSMSqBfvkSxoIsDjyxcwTJCxdsyR8pLpa4tgAcA
	kjVLm6mA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1me3Xv-00C5bU-2A; Fri, 22 Oct 2021 23:01:55 +0000
Date: Fri, 22 Oct 2021 16:01:55 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
Cc: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <YXNC447yogvNnVOW@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: cocci-request@inria.fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211022_160158_604271_2B8F3F9C 
X-CRM114-Status: GOOD (  11.80  )
Subject: [cocci] Python iteration to look for possible sysfs deadlocks
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 48
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/YXNC447yogvNnVOW%40bombadil.infradead.org>

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
